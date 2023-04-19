package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApplyADController {

	@GetMapping("/adminApply")
	public String adminApply() {
		return "apply/adminApply";
	}
	@GetMapping("/adminApplyList")
	public String adminApplyList() {
		return "apply/adminApplyList";
	}
}
