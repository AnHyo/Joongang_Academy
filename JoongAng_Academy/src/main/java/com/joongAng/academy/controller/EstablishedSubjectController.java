package com.joongAng.academy.controller;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.dto.EstablishedSubjectDTO;
import com.joongAng.academy.service.EstablishedSubjectService;

@Controller
public class EstablishedSubjectController {
	
	@Autowired
	private EstablishedSubjectService estService;
	
	@GetMapping("/estmg")
	public ModelAndView estmg() {
		ModelAndView mv = new ModelAndView("admin/EstblSbjctMG");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "/estListAjax", produces = "application/json;charset=UTF-8")
	public String estListAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String crc = request.getParameter("crc");
		String year = request.getParameter("year");
		String hlf = request.getParameter("hlf");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("crc", crc);
		map.put("year",year);
		map.put("hlf", hlf);
		List<Map<String, Object>> estList = estService.estList(map); 
		JSONArray estListJ = new JSONArray(estList);
		json.put("estList", estListJ);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estSubjectListAjax", produces = "application/json;charset=UTF-8")
	public String estSubjectListAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String,Object> map = new HashMap<String, Object>();
		String searchWord = request.getParameter("searchWord");
		map.put("searchWord", searchWord);
		List<Map<String, Object>> estSubjectList = estService.estSubjectList(map); 
		JSONArray estSubjectListJ = new JSONArray(estSubjectList);
		json.put("estSubjectList", estSubjectListJ);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/estInstructorListAjax", produces = "application/json;charset=UTF-8")
	public String estInstructorListAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String,Object> map = new HashMap<String, Object>();
		String searchWord = request.getParameter("searchWord");
		map.put("searchWord", searchWord);
		List<Map<String, Object>> estInstructorList = estService.estInstructorList(map); 
		JSONArray estInstructorListJ = new JSONArray(estInstructorList);
		json.put("estInstructorList", estInstructorListJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estCrclmList", produces = "application/json;charset=UTF-8")
	public String estCrclmList() {
		JSONObject json = new JSONObject();
		String division = "교육과정구분";
		List<Map<String, Object>> estCrcList = estService.estCodeList(division); 
		JSONArray estCrcListJ = new JSONArray(estCrcList);
		json.put("estCrcList", estCrcListJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estHourList", produces = "application/json;charset=UTF-8")
	public String estHourList() {
		JSONObject json = new JSONObject();
		String division = "교시구분";
		List<Map<String, Object>> estHourList = estService.estCodeList(division); 
		JSONArray estHourListJ = new JSONArray(estHourList);
		json.put("estHourList", estHourListJ);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estMethodList", produces = "application/json;charset=UTF-8")
	public String estMethodList() {
		JSONObject json = new JSONObject();
		String division = "강의방법";
		List<Map<String, Object>> estMethodList = estService.estCodeList(division); 
		JSONArray estMethodListJ = new JSONArray(estMethodList);
		json.put("estMethodList", estMethodListJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estRoomList", produces = "application/json;charset=UTF-8")
	public String estRoomList() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> estRoomList = estService.estRoomList(); 
		JSONArray estRoomListJ = new JSONArray(estRoomList);
		json.put("estRoomList", estRoomListJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estYearList", produces = "application/json;charset=UTF-8")
	public String estYearList(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String crc = request.getParameter("crc");
		List<Map<String, Object>> estYearList = estService.estYearList(crc);
		JSONArray estYearListJ = new JSONArray(estYearList);
		json.put("estYearList", estYearListJ);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estHalfList", produces = "application/json;charset=UTF-8")
	public String estHalfList(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		List<Map<String, Object>> estHalfList = estService.estHalfList(map);
		JSONArray estHalfListJ = new JSONArray(estHalfList);
		json.put("estHalfList", estHalfListJ);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estSaveAjax", produces = "application/json;charset=UTF-8")
	public String estSaveAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
		      String[] values = reqmap.get(key);
		      for (String value : values) {
		        map.put(key.toString(), value);
		      }
		}
		int resultSave = estService.estSave(map);
		int resultPlan = estService.estPlan(map);
		int resultInst = estService.estInst(map);
		int resultDgst = estService.estDgst(map);
		json.put("result", resultSave);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estSaveTime", produces = "application/json;charset=UTF-8")
	public String estSaveTime(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		int result = estService.estTime(map);
		json.put("result", result);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estInstrAjax", produces = "application/json;charset=UTF-8")
	public String estInstrAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		Map<String,Object> instr = estService.estGetInstr(map);
		json.put("instr", instr);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estTimeTable", produces = "application/json;charset=UTF-8")
	public String estTimeTable(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		List<Map<String,Object>> timeInfo = estService.estTimeInfo(map);
		json.put("timeInfo", timeInfo);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estTimeConfirm", produces = "application/json;charset=UTF-8")
	public String estTimeConfirm(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		int result = estService.estTimeConfirm(map);
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/estDelete", produces = "application/json;charset=UTF-8")
	public String estDelete(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		Map<String, Object> integrityChecker = estService.integCheck(map);
		byte[] rsltStrBytes = (byte[]) map.get("RSLT_STR");
		String rsltStr = new String(rsltStrBytes, StandardCharsets.UTF_8);
		map.put("RSLT_STR", rsltStr);
		json.put("result", map);
		int result = estService.estDelete(map);
		json.put("delResult", result);
		return json.toString();
	}
}
