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

import com.joongAng.academy.service.SurveyService;

@Controller
public class surveyController {

	@Autowired
	private SurveyService surveyService;
	
	@GetMapping("survey")
	public String survey() {
		return "admin/survey";
	}
	
	//디테일리스트
	@ResponseBody
	@PostMapping(value = "/surveyListAjax", produces = "application/json;charset=UTF-8")
	public String surveyListAjax(@RequestParam(value="survey_search", required=false) String survey_search) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = surveyService.list(survey_search); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		
		//System.err.println(detaillist); //ok
		return json.toString();
	}


}
