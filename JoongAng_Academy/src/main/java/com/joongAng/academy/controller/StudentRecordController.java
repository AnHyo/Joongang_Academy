package com.joongAng.academy.controller;

import java.util.List; 
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.dto.StudentRecordDTO;
import com.joongAng.academy.service.StudentRecordService;



@Controller
public class StudentRecordController {
	
	@Resource(name = "studentRecordService")
	private StudentRecordService studentRecordService;
	

	@GetMapping("/studentRecord")
	public String studentRecord() {
		return "admin/studentRecord";
	}
	
	@ResponseBody
	@PostMapping(value = "/studentSearch", produces = "application/json;charset=UTF-8")
	public String studentSearch(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> studentInfo = studentRecordService.studentInfo(map); 		
		JSONArray listA = new JSONArray(studentInfo);
		json.put("list", listA);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/depsearch", produces = "application/json;charset=UTF-8")
	public String depsearch(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		
		StudentRecordDTO search = new StudentRecordDTO();
		search.setDepsearchs(request.getParameter("depsearchs"));
		
		List<Map<String, Object>> depInfo = studentRecordService.depInfo(search); 	
		JSONArray listA = new JSONArray(depInfo);
		json.put("list2", listA);
		
		return json.toString();
	}
	
	
}
