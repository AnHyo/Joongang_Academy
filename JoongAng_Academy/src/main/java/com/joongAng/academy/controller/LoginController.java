package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

	@GetMapping("/")
	public String login() {
		return "login";
	}
	@GetMapping("/index")
	public String index() {
		return "index";
	}
	@GetMapping("/index2")
	public String index2() {
		return "index2";
	}
}
