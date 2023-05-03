package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.AttendanceService;


@Controller
public class AtndStdntController {
	
	@Autowired
	private AttendanceService atndService;

	@GetMapping("/atndStdnt")
	public String admin() {
		
		return "student/attendanceStdnt";
	}

	
}
