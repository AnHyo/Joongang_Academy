package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.dto.InstrTimeTableDTO;
import com.joongAng.academy.service.InstrTimeService;

@Controller
public class InstrTimeController {
	@Autowired
	private InstrTimeService instrService;

	//강사 시간표페이지 출력
	@GetMapping("/instrTime")
	public String instrTime() {
		return "/instr/instrTimeTable";
	}
	//강사 시간표 출력
	@ResponseBody
	@PostMapping(value ="/instrTimeTableAjax", produces = "application/json;charset=UTF-8")
	public String instrTimeTableAjax(@RequestBody InstrTimeTableDTO instrDTO) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = instrService.instrTimeTableAjax(instrDTO);
		json.put("list", list);
		return json.toString();
	}
	//메뉴 : 강사 학생정보 조회
	@GetMapping("/instrSearchStu")
	public String instrSearchStu() {
		return "/instr/instrSearchStu";
	}
	
	//1.강사 과목 조회
	@ResponseBody
	@PostMapping(value="/sbjSearchAjax", produces ="application/json;charset=UTF-8")
	public String sbjSearchAjax(@RequestBody InstrTimeTableDTO instrDTO) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> sbjList = instrService.sbjSearchAjax(instrDTO);
		json.put("list", sbjList);
		
		return json.toString();
	}
	
	//2.과목 선택시 학생 출력
	@ResponseBody
	@PostMapping(value="/stuAjax", produces ="application/json;charset=UTF-8")
	public String stuAjax(@RequestBody InstrTimeTableDTO instrDTO) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> stuList = instrService.stuAjax(instrDTO);
		json.put("list", stuList);
		
		return json.toString();
	}
	
	
	
	
	
}
