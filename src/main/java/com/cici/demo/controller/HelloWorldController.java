package com.cici.demo.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

	@GetMapping("/helloworld")
	public static String helloWorld() {
		String ip = null;
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			
		}
		return "welcome to hello world for springboot, the ip for the machine is " + ip;
	}
	
	
	public static void main(String[] args) {
		System.out.println(helloWorld());
	}
}
