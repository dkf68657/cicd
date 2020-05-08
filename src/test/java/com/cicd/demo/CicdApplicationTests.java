package com.cicd.demo;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.net.URI;
import java.net.URISyntaxException;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;


class CicdApplicationTests {
    private String lb="http://cicd-nlb-5fdfd526214ac47c.elb.us-east-1.amazonaws.com/";
	@Autowired
    private RestTemplate restTemplate = new RestTemplate();
	@Test
	void contextLoads() throws Exception, URISyntaxException {
		ResponseEntity<String> response = restTemplate.getForEntity(new URI(lb +"helloworld"), String.class);
		assertTrue(response.getBody().startsWith("welcome to hello world for springboot"));
	}

}
