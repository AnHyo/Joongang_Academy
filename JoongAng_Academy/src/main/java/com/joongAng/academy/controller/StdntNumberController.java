package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.StdntNumberService;

@Controller
public class StdntNumberController {
	
	@Autowired
	public StdntNumberService numberService;

	@GetMapping("/stdntNo")
	public String admin() {
		
		return "admin/studentNumber";
	}
	
	@ResponseBody
	@PostMapping("/stdntNo-crclmList")
	public String getCrclmList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		
		String crclmCount = numberService.crclmCount(map);
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		json.put("crclmCount", crclmCount);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/stdntNo-stdntList")
	public String getStuList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> stuList = numberService.getStuList(map);
		
		String stdntCount = numberService.stdntCount(map);
		
		JSONObject json = new JSONObject();
		json.put("stuList", stuList);
		json.put("stdntCount", stdntCount);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/searchName")
	public String searchName(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		List<Map<String, Object>> stuList = numberService.getStuList(map);
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		json.put("stuList", stuList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/stdntNo")
	public String setStdntNo(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> setNoList = numberService.createStdntNo(map);
		
		int setNoResult = numberService.updateStdntNo(setNoList);
		
		JSONObject json = new JSONObject();
		json.put("setNoResult", setNoResult);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/stdntIdPw")
	public String setStdntId(@RequestParam Map<String, Object> map) {
		
		int setIdResult = numberService.updateUserIdPw(map);
		
		JSONObject json = new JSONObject();
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/selectedRadio")
	public String getAllStdntNo(@RequestParam Map<String, Object> map) {
		
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		List<Map<String, Object>> radioList = numberService.radioList(map);
		
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		json.put("radioList", radioList);
		
		return json.toString();
	}
	
}
