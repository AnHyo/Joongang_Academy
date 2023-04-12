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

import com.joongAng.academy.service.CrclmInfoService;

@Controller
public class CrclmInfoController {
	@Autowired
	private CrclmInfoService crclmInfoService;

	@GetMapping("/crclmInfo")
	public String crclmInfo() {
		return "admin/crclmInfo";
	}
	
	@ResponseBody
	@PostMapping(value = "/listCrclmAjax", produces = "application/json;charset=UTF-8")
	public String listCrclmAjax() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = crclmInfoService.listCrclmAjax();
		//System.err.println(list);
		//JSONArray listCrclm = new JSONArray(list);
		json.put("listCrclm", list);
		
		return json.toString();
	}

}
