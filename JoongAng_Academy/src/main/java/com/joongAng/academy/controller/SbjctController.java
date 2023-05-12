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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.SbjctService;

@Controller
public class SbjctController {

	@Autowired
	private SbjctService sbjctService;

	@GetMapping("/sbjctMG")
	public String sbjctMG() {
		return "admin/sbjctMG";
	}

	@ResponseBody
	@PostMapping(value = "/listAjax", produces = "application/json;charset=UTF-8")
	public String listAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, Object> search = new HashMap<String, Object>();
		String searchnm = request.getParameter("searchnm");
		String searchuse = request.getParameter("searchuse");
		String searchdel = request.getParameter("searchdel");
		search.put("searchnm", searchnm);
		search.put("searchuse", searchuse);
		search.put("searchdel", searchdel);
		List<Map<String, Object>> list = sbjctService.list(search);
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/addsbjAjax", produces = "application/json;charset=UTF-8")
	public String addsbjAjax(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		int result = sbjctService.addsbj(map);
		json.put("result", result);
		Map<String, Object> search = new HashMap<String, Object>();
		String searchnm = request.getParameter("searchnm");
		String searchuse = request.getParameter("searchuse");
		String searchdel = request.getParameter("searchdel");
		search.put("searchnm", searchnm);
		search.put("searchuse", searchuse);
		search.put("searchdel", searchdel);
		List<Map<String, Object>> list = sbjctService.list(search);
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/delsbjAjax", produces = "application/json;charset=UTF-8")
	public String delsbjAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int integrity = sbjctService.integrity(map);
		json.put("integrity", 1);
		if (integrity == 1) {
			int result = sbjctService.delsbj(map);
			json.put("result", result);
			List<Map<String, Object>> list = sbjctService.list(map);
			JSONArray listJ = new JSONArray(list);
			json.put("list", listJ);
		} else {
			json.put("integrity", 0);
		}
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/updatesbjAjax", produces = "application/json;charset=UTF-8")
	public String updatesbjAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int result = sbjctService.updatesbj(map);
		json.put("result", result);
		List<Map<String, Object>> list = sbjctService.list(map);
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}
}
