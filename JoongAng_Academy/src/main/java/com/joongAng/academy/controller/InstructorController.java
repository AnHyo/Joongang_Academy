package com.joongAng.academy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.joongAng.academy.service.InstructorService;

@Controller
public class InstructorController {
	
	@Autowired
	private InstructorService instrService;
	
	@GetMapping("/instrmg")
	public ModelAndView instrmg() {
		ModelAndView mv = new ModelAndView("admin/InstrMG");
		
		List<StudentAllInfoDTO> gender = instrService.gender();
		List<StudentAllInfoDTO> endst = instrService.endst();
		
		mv.addObject("gender",gender);
		mv.addObject("endst",endst);
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "/insListAjax", produces = "application/json;charset=UTF-8")
	public String estListAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		System.err.println(map);
		
		List<Map<String, Object>> insList = instrService.insList(map); 
		JSONArray insListJ = new JSONArray(insList);
		
		json.put("insList", insListJ);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/teacherUnregList", produces = "application/json;charset=UTF-8")
	public String teacherUnregList() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> teacherUnreg = instrService.teacherUnreg(); 
		
		JSONArray listA = new JSONArray(teacherUnreg);
		//System.err.println(listA);
		
		json.put("unreglist", listA);
	
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/teacherInfoUpdate", produces = "application/json;charset=UTF-8")
	public String teacherInfoUpdate(@RequestParam Map<String, Object> map) {
		//System.err.println(map);
		int result = instrService.teacherInfoUpdate(map);
		//System.err.println(result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/teacherNewRegist", produces = "application/json;charset=UTF-8")
	public String teacherNewRegist(@RequestParam Map<String, Object> map) {
		//System.err.println(map);
		int result = instrService.teacherNewRegist(map);
		result = instrService.teacherUserUpdate(map);
		//System.err.println(result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "/telChenck", produces = "application/json;charset=UTF-8")
	public String telChenck(@RequestParam(value="inst_no", required=false) String inst_no) {
		//System.err.println(inst_no);
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> telcheck = instrService.telcheck(inst_no); 
		//System.err.println(telcheck);
		JSONArray listJ = new JSONArray(telcheck);
		json.put("telList", listJ);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/instrFoCheck", produces = "application/json;charset=UTF-8")
	public String instrFoCheck(@RequestParam(value="instrNo", required=false) String instrNo) {
		//System.err.println(instrNo);
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> foCheck = instrService.foCheck(instrNo); 
		//System.err.println(foCheck);
		JSONArray listJ = new JSONArray(foCheck);
		json.put("foCheck", foCheck);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/instrDel", produces = "application/json;charset=UTF-8")
	public String instrDel(@RequestParam(value="instrNo", required=false) String instrNo) {
		int result = instrService.instrDel(instrNo); 
		//System.err.println(result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();

	}
	
	@ResponseBody
	@PostMapping(value = "/instrDelCen", produces = "application/json;charset=UTF-8")
	public String instrDelCen(@RequestParam(value="instrNo", required=false) String instrNo) {
		int result = instrService.instrDelCen(instrNo); 
		//System.err.println(result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();

	}
	
	@GetMapping("/admin")
	public String adminIndex() {
		return "admin/adminIndex";
	}
	
	
}
