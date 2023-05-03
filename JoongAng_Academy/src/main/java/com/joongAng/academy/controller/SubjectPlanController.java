package com.joongAng.academy.controller;

import java.net.http.HttpRequest;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.SubjectPlanService;

@Controller
public class SubjectPlanController {
	
	@Autowired
	private SubjectPlanService planService;
	
	@GetMapping("/planmg")
	public ModelAndView planmg() {
		ModelAndView mv = new ModelAndView("admin/SbjctPlanMG");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "/estPlan", produces = "application/json;charset=UTF-8")
	public String estPlan(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String crc = request.getParameter("crc");
		String year = request.getParameter("year");
		String hlf = request.getParameter("hlf");
		String sbj = request.getParameter("sbj");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("crc",crc);
		map.put("year",year);
		map.put("hlf",hlf);
		map.put("sbj",sbj);
		Map<String, Object> subjectPlan = planService.getPlan(map);
		json.put("subjectPlan", subjectPlan);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estPlanDetail", produces = "application/json;charset=UTF-8")
	public String estPlanDetail(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String crc = request.getParameter("crc");
		String year = request.getParameter("year");
		String hlf = request.getParameter("hlf");
		String sbj = request.getParameter("sbj");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("crc",crc);
		map.put("year",year);
		map.put("hlf",hlf);
		map.put("sbj",sbj);
		List<Map<String, Object>> subjectPlanDetail = planService.getPlanDetail(map);
		JSONArray detailListJ = new JSONArray(subjectPlanDetail);
		json.put("detailList", detailListJ);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estPlanSave", produces = "application/json;charset=UTF-8")
	public String estPlanSave(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
		      String[] values = reqmap.get(key);
		      for (String value : values) {
		        System.out.println(key + " = " + value);
		        map.put(key.toString(), value);
		      }
		}
		int resultPlan = planService.savePlan(map);
		int resultPlanYN = planService.planYN(map);
		int resultEstOn = planService.estOn(map);
		json.put("result", resultPlan);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estDetailUpdate", produces = "application/json;charset=UTF-8")
	public String estDetailUpdate(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				map.put(key.toString(), value);
			}
		}
		System.out.println(map);
		int result = planService.updatePlanDetail(map);
		json.put("result", result);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estDetailSave", produces = "application/json;charset=UTF-8")
	public String estDetailSave(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				System.out.println(key + " = " + value);
				map.put(key.toString(), value);
			}
		}
		int resultDetail = planService.saveDetail(map);
		json.put("result", resultDetail);
		return json.toString();
	}
	@ResponseBody
	@PostMapping(value = "/estDetailDelete", produces = "application/json;charset=UTF-8")
	public String estDetailDelete(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqmap = request.getParameterMap();
		Map<String,Object> map = new HashMap<String, Object>();
		for (String key : reqmap.keySet()) {
			String[] values = reqmap.get(key);
			for (String value : values) {
				System.out.println(key + " = " + value);
				map.put(key.toString(), value);
			}
		}
		int resultDetail = planService.deleteDetail(map);
		json.put("result", resultDetail);
		return json.toString();
	}
	
	@GetMapping("/insSubPlan")
	public ModelAndView insSubPlan(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/instr/SbjctPlan");
		return mv;
	}
}
