package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class sbjctController {

	@GetMapping("/sbjctMG")
	public String list() {
		return "admin/sbjctMG";
	}
}
