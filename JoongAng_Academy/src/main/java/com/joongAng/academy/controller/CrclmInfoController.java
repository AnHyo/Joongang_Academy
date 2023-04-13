package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String listCrclmAjax(@RequestParam Map<String, String> paramap) {
		//System.err.println(paramap);
		
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = crclmInfoService.listCrclmAjax(paramap);
		json.put("listCrclm", list);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value="/saveCrclmAjax" ,produces = "application/json;charset=UTF-8")
	public String saveCrclmAjax(@RequestParam Map<String, String> paramap) {
		System.err.println(paramap);
		//System.err.println(paramap.get("cno"));
		//System.err.println(paramap.get("chalf"));		
		int result = crclmInfoService.saveCrclmAjax(paramap);
		System.err.println(result);
		return "";
	}

	
	
	
	//올라가야해
	
	
	
	
	
	
	
	
	
	
	
	
}
