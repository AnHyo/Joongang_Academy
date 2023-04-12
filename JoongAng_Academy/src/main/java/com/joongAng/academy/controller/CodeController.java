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

import com.joongAng.academy.service.CodeService;


@Controller
public class CodeController {

	@Autowired
	private CodeService codeService;
	
	@GetMapping("/code")
	public String code() {
		
		return "code";
	}
	
	@ResponseBody
	@PostMapping(value = "/codeListAjax", produces = "application/json;charset=UTF-8")
	public String codeListAjax(@RequestParam(value="code_search", required=false) String code_search,
								@RequestParam(value="CD_CLSFValue", required=false) String CD_CLSFValue
			) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = codeService.list(); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/codeListAjax2", produces = "application/json;charset=UTF-8")
	public String codeListAjax2() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> detaillist = codeService.detaillist(); 
		JSONArray listJ = new JSONArray(detaillist);
		json.put("list", listJ);
		return json.toString();
	}
	
//	@ResponseBody
//	@PostMapping(value = "/codeSeachAjax", produces = "application/json;charset=UTF-8")
//	public String codeSeachAjax(@RequestParam("code_search") String code_search) {
//		JSONObject json = new JSONObject();
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("code_search", code_search);
//		
//		List<Map<String, Object>> searchlist = codeService.searchlist();
//		JSONArray listJ = new JSONArray(searchlist);
//		json.put("list", listJ);
//		return json.toString();
//	}
	
}
