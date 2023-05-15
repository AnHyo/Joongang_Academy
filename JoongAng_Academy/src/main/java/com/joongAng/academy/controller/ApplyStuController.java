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

import com.joongAng.academy.service.ApplyService;

@Controller
public class ApplyStuController {

	@Autowired
	private ApplyService applyService;

	@GetMapping("/stuApply")
	public String adminApply() {
		return "student/stuApply";
	}
	
	@GetMapping("/timetable")
	public String timetable() {
		return "student/timetable";
	}

	@ResponseBody
	@PostMapping(value = "/planAjax", produces = "application/json;charset=UTF-8")
	public String planAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> plan = applyService.planAjax(map);
		JSONArray planList = new JSONArray(plan);
		json.put("planList", plan);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/plandetailAjax", produces = "application/json;charset=UTF-8")
	public String plandetailAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> plan = applyService.planDTLAjax(map);
		JSONArray plandetail = new JSONArray(plan);
		json.put("plandetail", plandetail);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/timetableAjax", produces = "application/json;charset=UTF-8")
	public String timetableAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> TT = applyService.timetableAjax(map);
		JSONArray timetable = new JSONArray(TT);
		json.put("timetable", timetable);
		return json.toString();
	}

}
