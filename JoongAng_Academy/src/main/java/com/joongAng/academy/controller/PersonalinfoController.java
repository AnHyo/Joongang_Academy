package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.dto.StudentAllInfoDTO;
import com.joongAng.academy.service.ApplyService;
import com.joongAng.academy.service.PesonalInfoService;
import com.joongAng.academy.service.StudentAllInfoService;

@Controller
public class PersonalinfoController {

	@Autowired
	private StudentAllInfoService studentAllInfoService;
	@Autowired
	private PesonalInfoService pesonalInfoService;

	@GetMapping("/stuinfoMod")
	public ModelAndView stuinfoMod() {
		ModelAndView mv = new ModelAndView("student/stuinfoMod");
		
		List<StudentAllInfoDTO> studentstatus = studentAllInfoService.studentstatus();
		List<StudentAllInfoDTO> relationship = studentAllInfoService.relationship();
		
		mv.addObject("studentstatus",studentstatus);
		mv.addObject("relationship",relationship);
		
		return mv;
	}
	@GetMapping("/instrinfoMod")
	public String instrinfoMod() {
		return "instr/instrinfoMod";
	}
	@ResponseBody
	@PostMapping(value = "/instrinfoAjax", produces = "application/json;charset=UTF-8")
	public String stuinfoAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> info = pesonalInfoService.info(map);
		JSONArray infoJ = new JSONArray(info);
		json.put("info", infoJ);
		return json.toString();
	}
	
	@GetMapping("/pwCheckMod")
	public String pwCheckMod(HttpSession session) {
		String userID = (String) session.getAttribute("id");
		String grade = pesonalInfoService.gradeCheck(userID);
		if(grade == "0010") {
			return "student/pwCheckMod";
		}else {
			return "instr/pwCheckMod";	
		}
	}
	
	
	@ResponseBody
	@PostMapping(value = "/pwCheckAjax", produces = "application/json;charset=UTF-8")
	public String pwCheckAjax(@RequestParam Map<String, Object> map) {
		int result = pesonalInfoService.pwCheckAjax(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/pwChangeAjax", produces = "application/json;charset=UTF-8")
	public String pwChangeAjax(@RequestParam Map<String, Object> map) {
		int result = pesonalInfoService.pwChangeAjax(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/instrInfoUpdate", produces = "application/json;charset=UTF-8")
	public String instrInfoUpdate(@RequestParam Map<String, Object> map) {
		
		int result = pesonalInfoService.instrInfoUpdate(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

}
