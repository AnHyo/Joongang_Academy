package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.CrclmInfoService;

@Controller
public class CrclmInfoController {
	@Autowired
	private CrclmInfoService crclmInfoService;

	@GetMapping("/crclmInfo")
	public ModelAndView crclmInfo() {
		ModelAndView mv = new ModelAndView("admin/crclmInfo");
		List<Map<String, Object>> list = crclmInfoService.crclmNameList();
		mv.addObject("crclmName", list);
		
		return mv;
	}
	
	
	@ResponseBody
	@PostMapping(value = "/listCrclmAjax", produces = "application/json;charset=UTF-8")
	public String listCrclmAjax(@RequestParam Map<String, String> paramap) {
		
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = crclmInfoService.listCrclmAjax(paramap);
		json.put("listCrclm", list);
		
		return json.toString();
	}
	
	//신규 저장
	@ResponseBody
	@PostMapping(value="/newCrclmAjax",produces = "application/json;charset=UTF-8")
	public String newCrclmAjax(@RequestParam Map<String, String> paramap) {
		
		JSONObject json  = new JSONObject();
		int result = crclmInfoService.newCrclmAjax(paramap);
		List<Map<String, Object>> list = crclmInfoService.saveAfter();
		json.put("saveResult", result);
		json.put("saveAfter", list);
		
		return json.toString();
	}
	
	
	//수정 저장
	@ResponseBody
	@PostMapping(value="/saveCrclmAjax" ,produces = "application/json;charset=UTF-8")
	public String saveCrclmAjax(@RequestParam Map<String, String> paramap) {
		
		JSONObject json = new JSONObject();
		int result = crclmInfoService.saveCrclmAjax(paramap);
		List<Map<String, Object>> list = crclmInfoService.saveAfter();
		json.put("updateResult", result);
		json.put("saveAfter", list);

		return json.toString();
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
