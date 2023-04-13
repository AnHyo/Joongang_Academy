package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

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
		
		return "/admin/code";
	}
	
	//전체리스트 + 검색
	@ResponseBody
	@PostMapping(value = "/codeListAjax", produces = "application/json;charset=UTF-8")
	public String codeListAjax(@RequestParam(value="code_search", required=false) String code_search) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = codeService.list(code_search); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}
	
	//디테일리스트
	@ResponseBody
	@PostMapping(value = "/codeListAjax2", produces = "application/json;charset=UTF-8")
	public String codeListAjax2(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String CD_CLSFValue = request.getParameter("CD_CLSFValue");
		//System.err.println(CD_CLSFValue); //ok
		//파라미터 값 1개여서 Map에 굳이 put안하고 바로 List에 넣기
		List<Map<String, Object>> detaillist = codeService.detaillist(CD_CLSFValue); 
		JSONArray listJ = new JSONArray(detaillist);
		json.put("detaillist", listJ);
		
		//System.err.println(detaillist); //ok
		return json.toString();
	}
	
}
