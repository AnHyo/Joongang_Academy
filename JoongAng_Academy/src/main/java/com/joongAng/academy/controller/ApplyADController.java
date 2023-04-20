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

import com.joongAng.academy.service.ApplyService;
import com.joongAng.academy.service.CrclmInfoService;

@Controller
public class ApplyADController {

	@Autowired
	private CrclmInfoService crclmInfoService;
	
	@Autowired
	private ApplyService applyService;
	
	@GetMapping("/adminApply")
	public String adminApply() {
	
		return "apply/adminApply";
	}
	@GetMapping("/adminApplyList")
	public String adminApplyList() {
		return "apply/adminApplyList";
	}
	
	@ResponseBody
	@PostMapping(value = "/stuListAjax", produces = "application/json;charset=UTF-8")
	public String stuListAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = applyService.list(map); 
		List<Map<String, Object>> crclmlist = crclmInfoService.crclmNameList();
		JSONArray listJ = new JSONArray(list);
		JSONArray crclmlistJ = new JSONArray(crclmlist);
		json.put("list", listJ);
		json.put("crclmlist", crclmlistJ);
		
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/stuinfoAjax", produces = "application/json;charset=UTF-8")
	public String stuinfoAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		System.err.println(map);
		List<Map<String, Object>> info = applyService.info(map); 
		JSONArray infoJ = new JSONArray(info);
		json.put("info", infoJ);		
		return json.toString();
	}
	
}
