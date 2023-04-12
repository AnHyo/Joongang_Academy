package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class surveyController {

	@GetMapping("/survey")
	public String survey() {
		return "survey";
	}
	


}
