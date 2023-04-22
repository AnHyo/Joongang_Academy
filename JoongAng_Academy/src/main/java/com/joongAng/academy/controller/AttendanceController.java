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
public class AttendanceController {
	
	@Autowired
	private AttendanceService atndService;

	@GetMapping("/atnd")
	public String admin() {
		
		return "admin/attendance";
	}
	
	@ResponseBody
	@PostMapping("/atndCrclmList")
	public String getCrclmList(@RequestParam Map<String, Object> map) {
		//System.err.println(map);
		
		List<Map<String, Object>> crclmList = atndService.crclmList(map);
		//System.err.println(crclmList);
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndList")
	public String getAtndList(@RequestParam Map<String, Object> map) {
		System.err.println("강의목록파람 : " +map);
		
		// ---- 강의날짜리스트----
		List<Map<String, Object>> dayList = atndService.dayList(map);
		System.err.println("dayList : " + dayList);
		
		// ---- 학생리스트 ----
		List<Map<String, Object>> stdntList = atndService.stdntList(map);
		System.err.println("stdntList : " +stdntList);
		
		JSONObject json = new JSONObject();
		json.put("dayList", dayList);
		json.put("stdntList", stdntList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/stuAtndList")
	public String stuAtndList(@RequestParam Map<String, Object> map) {
		System.err.println("출석정보파람 : " + map);
		
		List<Map<String, Object>> stuAtndList = atndService.stuAtndList(map);
		System.err.println("stuAtndList : " + stuAtndList);
		
		JSONObject json = new JSONObject();
		json.put("stuAtndList", stuAtndList);
		
		return json.toString();
	}
	
}
