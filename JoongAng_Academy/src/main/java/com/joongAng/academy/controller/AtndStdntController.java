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

import com.joongAng.academy.service.AtndStdntService;


@Controller
public class AtndStdntController {
	
	@Autowired
	private AtndStdntService atndStdntService;
	
	//@Autowired
	//private AtndStdntDTO atndStdntDTO;

	@GetMapping("/atndStdnt")
	public String admin() {
		
		return "student/attendanceStdnt";
	}
	
	@ResponseBody
	@PostMapping("/atndStdnt-stdntInfo")
	public String stndtInfo(@RequestParam(value="id") String id) {
		
		Map<String, Object> stdntInfo = atndStdntService.stdntInfo(id);
		//System.err.println(stdntInfo);
		
		JSONObject json = new JSONObject();
		json.put("stdntInfo", stdntInfo);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndStdnt-sbjctList")
	public String crclmList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> sbjctList = atndStdntService.sbjctList(map);
		//System.err.println(sbjctList);
		
		JSONObject json = new JSONObject();
		json.put("sbjctList", sbjctList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndStdnt-atndList")
	public String atndList(@RequestParam Map<String, Object> map) {
		
		//System.err.println(atndStdntDTO);
		
		List<Map<String, Object>> atndList = atndStdntService.atndList(map);
		//System.err.println(atndList);
		
		JSONObject json = new JSONObject();
		json.put("atndList", atndList);
		
		return json.toString();
	}

	
}
