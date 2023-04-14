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
		System.out.println(hlf);
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
	@PostMapping(value = "/estSaveAjax", produces = "application/json;charset=UTF-8")
	public String estSaveAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String crc = request.getParameter("crc");
		String year = request.getParameter("year");
		String hlf = request.getParameter("hlf");
		String sbjcd = request.getParameter("sbjcd");
		String sbjnm = request.getParameter("sbjnm");
		String sbjxp = request.getParameter("sbjxp");
		String hrs = request.getParameter("hrs");
		String room = request.getParameter("room");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("crc", crc);
		map.put("year", year);
		map.put("hlf", hlf);
		map.put("sbjcd", sbjcd);
		map.put("sbjnm", sbjnm);
		map.put("sbjxp", sbjxp);
		map.put("hrs", hrs);
		map.put("room", room);
		int result = estService.estSave(map);
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/estDelete", produces = "application/json;charset=UTF-8")
	public String estDelete(HttpServletRequest request, @RequestBody List<Map<String,Object>> checkedRows) {
		JSONObject json = new JSONObject();
		System.out.println(checkedRows.toString());
//		json.put("estRoomList", row);
		return json.toString();
	}
}
