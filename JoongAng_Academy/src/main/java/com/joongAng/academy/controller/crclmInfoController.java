package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class crclmInfoController {

	@GetMapping("/crclmInfo")
	public String crclmInfo() {
		return "admin/crclmInfo";
	}
	


}
