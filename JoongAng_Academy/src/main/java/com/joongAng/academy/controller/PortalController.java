package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PortalController {

	
	@GetMapping("/portal")
	public String portal() {
		return "portalIndex";
	}
	@GetMapping("/stuIndex")
	public String stuIndex() {
		return "student/stuIndex";
	}
	@GetMapping("/instrIndex")
	public String instrIndex() {
		return "instr/instrIndex";
	}
}
