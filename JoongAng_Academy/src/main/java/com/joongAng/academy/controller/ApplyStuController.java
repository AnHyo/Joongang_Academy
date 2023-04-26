package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApplyStuController {

//	@Autowired
//	private ApplyService applyService;
	
	@GetMapping("/stuApply")
	public String adminApply() {
		return "student/stuApply";
	}


}
