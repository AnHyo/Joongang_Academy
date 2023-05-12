package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.AtndInstrService;


@Controller
public class AtndInstrController {
	
	@Autowired
	private AtndInstrService atndInstService;

	@GetMapping("/atndInstr")
	public String atndInstr() {
		
		return "instr/attendanceInstr";
	}
	
	@ResponseBody
	@PostMapping("/atndInstr-crclmList")
	public String crclmList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> crclmList = atndInstService.crclmList(map);
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndInstr-weekList")
	public String lectureWeekList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> weekList = atndInstService.weekList(map);
		
		JSONObject json = new JSONObject();
		json.put("weekList", weekList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndInstr-stdntList")
	public String stdntList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> stdntList = atndInstService.stdntList(map);
		
		JSONObject json = new JSONObject();
		json.put("stdntList", stdntList);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/atndInstr-stuAtnd")
	public String setStuAtnd(@RequestBody List<Map<String, Object>> stuAtndArr) {
		
		atndInstService.updateStuAtnd(stuAtndArr);
		
		JSONObject json = new JSONObject();
		
		return json.toString();
	}
	
}
