package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController { // new HelloController()

	@RequestMapping("/hello")
	public String hello() {
		return "Hello Spring Boot~";
	}
}