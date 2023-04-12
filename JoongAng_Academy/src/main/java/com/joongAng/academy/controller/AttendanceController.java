package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AttendanceController {

	@GetMapping("/attendance_admin")
	public String admin() {
		
		return "attendance/attendance_admin";
	}
}
