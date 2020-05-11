package com.cicd.demo.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

	@GetMapping("/helloworld")
	public String helloWorld() {
		String ip = null;
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
			System.out.println("get ip [" + ip + "]");
		} catch (UnknownHostException e) {
			System.out.println("error occur")
		}
		return "the private ip for the ec2 is " + ip;
	}
	
	@GetMapping("/cicd")
	public String cicd() {
		return "this is cicd demo ";
	}
	
}
