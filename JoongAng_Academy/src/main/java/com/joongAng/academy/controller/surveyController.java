package com.joongAng.academy.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.CrclmInfoService;
import com.joongAng.academy.service.SurveyService;

@Controller
public class surveyController {

	@Autowired
	private SurveyService surveyService;
	@Autowired
	private CrclmInfoService crclmInfoService;

	// 커리큘럼 select option 생성
	@GetMapping("survey")
	public ModelAndView survey() {
		ModelAndView mv = new ModelAndView("admin/survey");
		List<Map<String, Object>> list = crclmInfoService.crclmNameList();
		mv.addObject("crclmName", list);
		return mv;
	}

	// 설문리스트 + 검색
	@ResponseBody
	@PostMapping(value = "/surveyListAjax", produces = "application/json;charset=UTF-8")
	public String surveyListAjax(@RequestParam Map<String, String> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = surveyService.list(map);
		json.put("list", list);

		return json.toString();
	}

	// 수정 + 리스트
	@ResponseBody
	@PostMapping(value = "/surveyUpdate", produces = "application/json;charset=UTF-8")
	public String surveyUpdate(@RequestParam Map<String, String> map) {
		JSONObject json = new JSONObject();
		int result = surveyService.update(map);
		json.put("result", result);

		List<Map<String, Object>> list = surveyService.list(map);
		json.put("list", list);

		return json.toString();
	}

	// 문항정보
	@ResponseBody
	@PostMapping(value = "/surveyDetail", produces = "application/json;charset=UTF-8")
	public String surveyDetail(@RequestParam Map<String, String> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> detaillist = surveyService.detaillist(map);
		json.put("detaillist", detaillist);

		return json.toString();
	}

	// 문항정보 신규
	@ResponseBody
	@PostMapping(value = "/ITEMCreate", produces = "application/json;charset=UTF-8")
	public String ITEMCreate(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		JSONObject json = new JSONObject();

		boolean noExists = surveyService.checknoExists(map);
		// 중복문항번호 검사
		if (noExists) {
			json.put("result", "exist");
			return json.toString();
		} else {
			int result = surveyService.ITEMCreate(map);
			json.put("result", result);
			
			return json.toString();
		}
	}

	// 문항정보 수정
	@ResponseBody
	@PostMapping(value = "/ITEMUpdate", produces = "application/json;charset=UTF-8")
	public String ITEMUpdate(@RequestBody List<Map<String, Object>> updateData, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		int result = surveyService.ITEMUpdate(updateData);
		json.put("result", result);

		return json.toString();
	}

	// 문항정보 삭제
	@ResponseBody
	@PostMapping(value = "/ITEMDelete", produces = "application/json;charset=UTF-8")
	public String codeDelete(@RequestBody List<Map<String, Object>> deleteData, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		int result = surveyService.ITEMdelete(deleteData);
		json.put("result", result);
		
		return json.toString();
	}

	// 답변정보
	@ResponseBody
	@PostMapping(value = "/surveyANS", produces = "application/json;charset=UTF-8")
	public String surveyANS() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> anslist = surveyService.anslist();
		json.put("anslist", anslist);
		
		return json.toString();
	}

	// 참석자정보
	@ResponseBody
	@PostMapping(value = "/surveyStdnt", produces = "application/json;charset=UTF-8")
	public String surveyStdnt(@RequestParam Map<String, String> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> stdntlist = surveyService.stdntlist(map);
		json.put("stdntlist", stdntlist);
		
		return json.toString();
	}

//--------------------------------------

	// 강사조회 페이지
	@GetMapping("/surveyResult")
	public String surveyResult() {
		
		return "instr/surveyResult";
	}

	@ResponseBody
	@PostMapping(value = "surveyResultAjax", produces = "application/json;charset=UTF-8")
	public String surveyResultAjax(@RequestParam(value = "loginID", required = false) String loginID) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> surveySbj = surveyService.surveySbj(loginID);
		JSONArray list = new JSONArray(surveySbj);
		json.put("list", list);

		return json.toString();
	}

	// 강사조회_디테일 페이지
	@GetMapping("/surveyResultDetail")
	public String surveyResultDetail() {

		return "instr/surveyResultDetail";
	}

	@ResponseBody
	@PostMapping(value = "ResultDetailAjax", produces = "application/json;charset=UTF-8")
	public String ResultDetailAjax(@RequestParam Map<String, String> map) {
		JSONObject json = new JSONObject();
		// 설문조사결과
		List<Map<String, Object>> resultDetail = surveyService.ResultDetailAjax(map);
		json.put("resultDetail", resultDetail);

		// 총계표
		List<Map<String, Object>> resultDetail2 = surveyService.ResultDetailAjax2(map);
		json.put("resultDetail2", resultDetail2);

		return json.toString();
	}

}
