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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.InstructorService;

@Controller
public class InstructorController {
	
	@Autowired
	private InstructorService instrService;
	
	@GetMapping("/instrmg")
	public ModelAndView instrmg() {
		ModelAndView mv = new ModelAndView("admin/InstrMG");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "/insListAjax", produces = "application/json;charset=UTF-8")
	public String estListAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String,Object> map = new HashMap<String, Object>();                                                                                                                                                                                  
		String name = request.getParameter("name");
		map.put("name", name);
		List<Map<String, Object>> insList = instrService.insList(map); 
		JSONArray insListJ = new JSONArray(insList);
		json.put("insList", insListJ);
		return json.toString();
	}
}
