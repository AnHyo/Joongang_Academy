package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.SbjctService;

@Controller
public class sbjctController {

	@Autowired
	private SbjctService sbjctService;
	
	@GetMapping("/sbjctMG")
	public String sbjctMG() {
		
		return "admin/sbjctMG";
	}
	
	@ResponseBody
	@PostMapping(value = "/listAjax", produces = "application/json;charset=UTF-8")
	public String listAjax() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = sbjctService.list(); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}
}
