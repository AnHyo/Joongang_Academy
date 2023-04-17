package com.joongAng.academy.controller;

import java.util.HashMap;
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
	
	//grid1 (전체리스트 + 검색)
	@ResponseBody
	@PostMapping(value = "/codeListAjax", produces = "application/json;charset=UTF-8")
	public String codeListAjax(@RequestParam(value="code_search", required=false) String code_search) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = codeService.list(code_search); 
		JSONArray listJ = new JSONArray(list);
		json.put("list", listJ);
		return json.toString();
	}
	
	//grid2 (디테일)
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
	
	@ResponseBody
	@PostMapping(value = "/codeCreate", produces = "application/json;charset=UTF-8")
	public String codeCreate(@RequestParam Map<String, Object> map,HttpServletRequest request){
		JSONObject json = new JSONObject();
		if (codeService.isCodeExist(map)) { // 중복된 값이 있을 경우
			int result = 2;
			json.put("result", result);
			//System.err.println(result);
		} 
		else {
			int result = codeService.code_create(map); 
			//System.err.println(map.get("CD_CLSF"));
			json.put("result", result);
			//System.err.println(result);
			//추가 저장후 다시 전체리스트 조회페이지로 가야함(전체조회+검색) 
			String code_search = request.getParameter("code_search");
			List<Map<String, Object>> list = codeService.list(code_search); 
			JSONArray listJ = new JSONArray(list);
			json.put("list", listJ);
		}
	return json.toString();
	}
	
	//수정
	@ResponseBody
	@PostMapping(value = "/codeUpdate", produces = "application/json;charset=UTF-8")
	public String codeUpdate(@RequestParam Map<String, Object> map,HttpServletRequest request){
		JSONObject json = new JSONObject();
		if (codeService.isCodeExist(map)) { // 중복된 값이 있을 경우
			int result = 2;
			json.put("result", result);
			System.err.println(result);//ok
		} 
		else {
			int result = codeService.code_update(map); 
			//System.err.println(map.get("CD_CLSF")); //ok
			//System.err.println(map);//ok
			System.err.println(map.get("old_CD_CLSF"));//ok
			json.put("result", result);
			System.err.println(result);//0
			
			//추가 저장후 다시 전체리스트 조회페이지로 가야함(전체조회+검색) 
			String code_search = request.getParameter("code_search");
			List<Map<String, Object>> list = codeService.list(code_search); 
			JSONArray listJ = new JSONArray(list);
			json.put("list", listJ);
		}
//		Map<String, Object> search = new HashMap<String, Object>();
//		String CD_CLSF = request.getParameter("CD_CLSF");
//		String CD = request.getParameter("CD");
//		String CD_NM = request.getParameter("CD_NM");
//		String CD_USE_YN = request.getParameter("CD_USE_YN");
//		String CD_EXPLN = request.getParameter("CD_EXPLN");
//		String CD_SORT_SN = request.getParameter("CD_SORT_SN");
//		search.put("CD_CLSF",CD_CLSF);
//		search.put("CD",CD);
//		search.put("CD_NM",CD_NM);
//		search.put("CD_USE_YN",CD_USE_YN);
//		search.put("CD_EXPLN",CD_EXPLN);
//		search.put("CD_SORT_SN",CD_SORT_SN);
//		System.err.println(search);
		
//		List<Map<String, Object>> create_list = codeService.create_list(code_create); 
//		JSONArray listJ = new JSONArray(create_list);
//		json.put("create_list", listJ);
		return json.toString();
	}
}


















