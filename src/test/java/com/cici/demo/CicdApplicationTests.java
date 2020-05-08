package com.cici.demo;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.net.URI;
import java.net.URISyntaxException;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = CicdApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)

class CicdApplicationTests {
    private String lb="http://cicd-nlb-5fdfd526214ac47c.elb.us-east-1.amazonaws.com/";
	@Autowired
    private TestRestTemplate restTemplate;
	@Test
	void contextLoads() throws Exception, URISyntaxException {
		
		ResponseEntity<String> response =restTemplate.getForEntity(new URI(lb +"helloworld"), String.class);
		assertTrue("hello".equals(response.getBody()));
	}

}
