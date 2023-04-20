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
import org.springframework.web.bind.annotation.RequestBody;
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
	//public String codeUpdate(@RequestParam Map<String, Object> map,HttpServletRequest request){
	public String codeUpdate(@RequestBody List<Map<String, Object>> updateData,HttpServletRequest request){
		JSONObject json = new JSONObject();
//		if (codeService.isCodeExist2(updateData)) { // CD_CLSF, CD는 수정불가이므로, 필요없음!
//			int result2 = 2;
//			json.put("result2", result2);
//			System.err.println("result2:"+result2);//ok
//			System.err.println(updateData);//ok
//		} 
//		else {
			int result = codeService.code_update(updateData); 
			//System.err.println(updateData.get(0).get("CD_CLSF")); //ok
			//System.err.println(updateData);//ok
			json.put("result", result);
			//System.err.println(result);//0
			
			//추가 저장후 다시 전체리스트 조회페이지로 가야함(전체조회+검색) 
			String code_search = request.getParameter("code_search");
			List<Map<String, Object>> list = codeService.list(code_search); 
			JSONArray listJ = new JSONArray(list);
			json.put("list", listJ);
//		}
		return json.toString();
	}
	//삭제
	@ResponseBody
	@PostMapping(value = "/codeDelete", produces = "application/json;charset=UTF-8")
	public String codeDelete(@RequestBody List<Map<String, Object>> deleteData, HttpServletRequest request){
		    JSONObject json = new JSONObject();
		    int result = codeService.code_delete(deleteData);
		    System.err.println(deleteData.get(0).get("CD_CLSF"));//ok
		    System.err.println(deleteData); //[{CD_CLSF=1, CD=1, CD_NM=1, CD_USE_YN=, CD_EXPLN=1, CD_SORT_SN=1}, {CD_CLSF=1, CD=2, CD_NM=1, CD_USE_YN=, CD_EXPLN=1, CD_SORT_SN=1}]
		    json.put("result", result);
		    System.err.println("result:"+result);//삭제된 행 갯수
			
		    
		    
			//삭제 저장후 다시 전체리스트 조회페이지로 가야함(전체조회+검색) 
			String code_search = request.getParameter("code_search");
			List<Map<String, Object>> list = codeService.list(code_search); 
			JSONArray listJ = new JSONArray(list);
			json.put("list", listJ);
		return json.toString();
	}
}


















