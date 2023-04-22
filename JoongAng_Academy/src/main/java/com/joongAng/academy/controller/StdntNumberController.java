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
	@PostMapping("/getCrclmList")
	public String getCrclmList(@RequestParam Map<String, Object> map) {
		//System.out.println(map);
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		//System.out.println(crclmList);
		
		String crclmCount = numberService.crclmCount(map);
		
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		json.put("crclmCount", crclmCount);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/getStuList")
	public String getStuList(@RequestParam Map<String, Object> map) {
		//System.err.println(map);
		
		List<Map<String, Object>> stuList = numberService.getStuList(map);
		//System.err.println("stuList" + stuList);
		
		String stdntCount = numberService.stdntCount(map);
		
		JSONObject json = new JSONObject();
		json.put("stuList", stuList);
		json.put("stdntCount", stdntCount);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/searchName")
	public String searchName(@RequestParam Map<String, Object> map) {
		
		//System.err.println(map);
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		List<Map<String, Object>> stuList = numberService.getStuList(map);
		//System.err.println("stuList" + stuList);
		
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		json.put("stuList", stuList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/setStdntNo")
	public String setStdntNo(@RequestParam Map<String, Object> map) {
		//System.err.println(map);
		
		List<Map<String, Object>> setNoList = numberService.createStdntNo(map);
		//System.err.println(setNoList);
		
		int setNoResult = numberService.updateStdntNo(setNoList);
		//System.err.println(setNoResult);
		
		JSONObject json = new JSONObject();
		json.put("setNoResult", setNoResult);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("setStdntIdPw")
	public String setStdntId(@RequestParam Map<String, Object> map) {
		
		int setIdResult = numberService.updateUserIdPw(map);
		
		JSONObject json = new JSONObject();
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/chooseRadio")
	public String getAllStdntNo(@RequestParam Map<String, Object> map) {
		
		//System.err.println(map); //{year=2023, half=0010, radioVal=all}
		
		List<Map<String, Object>> crclmList = numberService.getCrclmList(map);
		//List<Map<String, Object>> stuList = numberService.getStuList(map);
		List<Map<String, Object>> radioList = numberService.radioList(map);
		
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		//json.put("stuList", stuList);
		json.put("radioList", radioList);
		
		return json.toString();
	}
	
}
