package com.joongAng.academy.controller;

import java.util.Map; 

import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class StudentRecordController {

	@GetMapping("/studentRecord")
	public String studentRecord() {
		return "admin/studentRecord";
	}
	
	@ResponseBody
	@PostMapping("/studentSearch")
	public String studentSearch(@RequestParam Map<String, Object> map) {
		
		
		
		
		return "";
	}
	
	
}
