package com.cicd.demo;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;


class CicdApplicationTests {
    private String lb="http://cicd-nlb-5fdfd526214ac47c.elb.us-east-1.amazonaws.com/";
	@Autowired
    private RestTemplate restTemplate = new RestTemplate();
	@Test
	void contextLoads(){
		 int count = 0;
		 boolean success =true;
		while(true) {
			if(count >= 10) {
				return;
			}
			try {
				ResponseEntity<String> response = restTemplate.getForEntity(new URI(lb +"helloworld"), String.class);
				assertTrue(response.getBody().startsWith("welcome to hello world for springboot"));
			}catch(Exception e) {
				count ++;
				success = false;
			}
			if(success) {
				return;
			}
			
			try {
				TimeUnit.SECONDS.sleep(30);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

}
