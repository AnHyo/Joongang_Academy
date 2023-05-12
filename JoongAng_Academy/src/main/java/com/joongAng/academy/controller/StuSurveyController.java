package com.joongAng.academy.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.dto.StuSurveyDTO;
import com.joongAng.academy.service.StuSurveyService;

@Controller
public class StuSurveyController {

	@Autowired
	private StuSurveyService stuSurveyService;

	@GetMapping("/stuSuv")
	public String stuinfoMod() {
		return "student/stuSurvey";
	}
	
	@ResponseBody
	@PostMapping(value = "surveySjList", produces = "application/json;charset=UTF-8")
	public String surveySjList(@RequestParam(value="student_ID", required=false) String student_ID) {
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> surveySbj = stuSurveyService.surveySbj(student_ID); 
		JSONArray list = new JSONArray(surveySbj);
		json.put("ssList", list);
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "suvTIs", produces = "application/json;charset=UTF-8")
	public String suvTI(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		
		StuSurveyDTO stuSuvTI = new StuSurveyDTO();
		stuSuvTI.setStudent_ID(request.getParameter("student_ID"));
		stuSuvTI.setSbjctNo(request.getParameter("sbjctNo"));
		stuSuvTI.setCYear(request.getParameter("cYear"));
		stuSuvTI.setCCd(request.getParameter("cCd"));
		stuSuvTI.setCHalf(request.getParameter("cHalf"));
		

		List<StuSurveyDTO> surveyTI = stuSurveyService.surveyTI(stuSuvTI);
		List<StuSurveyDTO> surveyIn = stuSurveyService.surveyIn(stuSuvTI);
		List<StuSurveyDTO> surveyIn2 = stuSurveyService.surveyIn2(stuSuvTI);
		List<StuSurveyDTO> code = stuSurveyService.code();
		
		
		JSONArray suvlist = new JSONArray(surveyTI);
		JSONArray suvIn = new JSONArray(surveyIn);
		JSONArray suvIn2 = new JSONArray(surveyIn2);
		JSONArray codelist = new JSONArray(code);
		
		
		json.put("suvlist", suvlist);
		json.put("surveyIn", suvIn);
		json.put("surveyIn2", suvIn2);
		json.put("codelist", codelist);
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "svSave", produces = "application/json;charset=UTF-8")
	public String svSave(@RequestBody List<Map<String, Object>> dataArr) {
		JSONObject json = new JSONObject();
		List<StuSurveyDTO> svList = new ArrayList<>();
		for (Map<String, Object> dataMap : dataArr) {
			StuSurveyDTO stuSuvDTO = new StuSurveyDTO();
			stuSuvDTO.setStudent_ID((String) dataMap.get("student_ID"));
			stuSuvDTO.setSbjctNo((String) dataMap.get("sbjctNo"));
			stuSuvDTO.setCYear((String) dataMap.get("cYear"));
			stuSuvDTO.setCCd((String) dataMap.get("cCd"));
			stuSuvDTO.setCHalf((String) dataMap.get("cHalf"));
			stuSuvDTO.setDGSTFN_NO((int) dataMap.get("DGSTFN_NO"));
			stuSuvDTO.setInnm((String) dataMap.get("innm"));
			stuSuvDTO.setTxnm((String) dataMap.get("txnm"));
			svList.add(stuSuvDTO);
			
			
		}
		//System.err.println(svList);
		int result = 0;
		for (StuSurveyDTO dto : svList) {
			result += stuSurveyService.svSave(dto);
			result += stuSurveyService.svUpdate(dto);
		}

		json.put("result", result);
		
		return json.toString();
	}


}
