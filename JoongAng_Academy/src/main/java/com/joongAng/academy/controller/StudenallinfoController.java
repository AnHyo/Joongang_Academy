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
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.dto.StudentAllInfoDTO;
import com.joongAng.academy.dto.StudentRecordDTO;
import com.joongAng.academy.service.StudentAllInfoService;


@Controller
public class StudenallinfoController {
	
	@Resource(name = "studentAllInfoService")
	private StudentAllInfoService studentAllInfoService;

	@GetMapping("/studentallinfo")
	public ModelAndView studentallinfo() {
		
		ModelAndView mv = new ModelAndView("admin/studentallinfo");
		
		List<StudentAllInfoDTO> studentstatus = studentAllInfoService.studentstatus();
		List<StudentAllInfoDTO> relationship = studentAllInfoService.relationship();
		
		mv.addObject("studentstatus",studentstatus);
		mv.addObject("relationship",relationship);
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "studentInfoSearch", produces = "application/json;charset=UTF-8")
	public String studentInfoSearch(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> studentSearch = studentAllInfoService.studentSearch(map); 
		
		JSONArray listA = new JSONArray(studentSearch);
		json.put("stulist", listA);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "studentDeInfo", produces = "application/json;charset=UTF-8")
	public String studentDeInfo(HttpServletRequest request) {
		
		JSONObject json = new JSONObject();
		
		StudentAllInfoDTO student = new StudentAllInfoDTO();
		student.setStudent_ID(request.getParameter("student_ID"));
		
		List<StudentAllInfoDTO> studentDeInfo = studentAllInfoService.studentDeInfo(student);
		//System.err.println(studentDeInfo);
		List<StudentAllInfoDTO> studentDetail = studentAllInfoService.studentDetail(student);
		List<StudentAllInfoDTO> elist = studentAllInfoService.elist(student);
		
		JSONArray listA = new JSONArray(studentDeInfo);
		JSONArray listB = new JSONArray(studentDetail);
		JSONArray listC = new JSONArray(elist);
		
		json.put("list", listA);
		json.put("list2", listB);
		json.put("elist", listC);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "studentInfoUpdate", produces = "application/json;charset=UTF-8")
	public String studentInfoUpdate(@RequestParam Map<String, Object> map) {
		
		int result = studentAllInfoService.studentUpdate(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
}
