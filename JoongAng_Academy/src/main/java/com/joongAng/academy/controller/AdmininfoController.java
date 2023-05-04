package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.AdminInfoService;

@Controller
public class AdmininfoController {

	@Autowired
	private AdminInfoService adminInfoService;

	@ResponseBody
	@PostMapping(value = "/admininfoAjax", produces = "application/json;charset=UTF-8")
	public String admininfoAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> info = adminInfoService.admininfoAjax(map);
		JSONArray admininfo = new JSONArray(info);
		json.put("info", admininfo);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/adminInfoUpdate", produces = "application/json;charset=UTF-8")
	public String instrInfoUpdate(@RequestParam Map<String, Object> map) {
		
		int result = adminInfoService.adminInfoUpdate(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
}
