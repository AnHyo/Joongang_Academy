package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.CodeService;


@Controller
public class CodeController {

	@Autowired
	private CodeService codeService;
	
	@ResponseBody
	@PostMapping(value = "/codeListAjax", produces = "application/json;charset=UTF-8")
	public String codeListAjax() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = codeService.list(); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
		
	}
	
}
