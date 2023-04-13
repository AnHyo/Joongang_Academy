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

import com.joongAng.academy.service.StdntNumberService;

@Controller
public class StdntNumberController {
	
	@Autowired
	public StdntNumberService numberService;

	@GetMapping("/stdnt_number")
	public String admin() {
		
		return "admin/studentNumber";
	}
	
	@ResponseBody
	@PostMapping("/getCrclmList")
	public String getCrclmList(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		List<Map<String, Object>> list = numberService.getCrclmList(map);
		System.out.println(list);
		
		JSONObject json = new JSONObject();
		json.put("list", list);
		
		return json.toString();
	}
	
}
