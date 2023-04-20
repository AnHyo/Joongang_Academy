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
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.CrclmInfoService;
import com.joongAng.academy.service.SurveyService;

@Controller
public class surveyController {

	@Autowired
	private SurveyService surveyService;
	@Autowired
	private CrclmInfoService crclmInfoService;
	
	//커리큘럼 목록조회
	@GetMapping("survey")
	public ModelAndView survey() {
		ModelAndView mv = new ModelAndView("admin/survey");
		List<Map<String, Object>> list = crclmInfoService.crclmNameList();
		mv.addObject("crclmName", list);
		return mv;
	}
	
	//설문리스트
	@ResponseBody
	@PostMapping(value = "/surveyListAjax", produces = "application/json;charset=UTF-8")
	public String surveyListAjax(@RequestParam Map<String, String> searchcmap) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = surveyService.list(searchcmap); 
		//JSONArray listJ = new JSONArray(list);
		json.put("list", list);
		
		//System.err.println(detaillist); //ok
		return json.toString();
	}


}
