package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongAng.academy.service.AttendanceService;

@Controller
public class AttendanceController {
	
	@Autowired
	private AttendanceService atndService;

	@GetMapping("/atnd")
	public String admin() {
		
		return "admin/attendance";
	}

// ---- 강의목록 ----
	@ResponseBody
	@PostMapping("/atndCrclmList")
	public String getCrclmList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> crclmList = atndService.crclmList(map);
		
		JSONObject json = new JSONObject();
		json.put("crclmList", crclmList);
		
		return json.toString();
	}

// ---- 출석부리스트 ----
	@ResponseBody
	@PostMapping("/atndList")
	public String getAtndList(@RequestParam Map<String, Object> map) {
		
		// ---- 강의날짜리스트----
		List<Map<String, Object>> dayList = atndService.dayList(map);
		
		// ---- 학생리스트 ----
		List<Map<String, Object>> stdntList = atndService.stdntList(map);
		
		// ---- 학생별 일자별 출첵 ----
		List<Map<String, Object>> dayAtndList = atndService.dayAtndList(map);
		
		JSONObject json = new JSONObject();
		json.put("dayList", dayList);
		json.put("stdntList", stdntList);
		json.put("dayAtndList", dayAtndList);
		
		return json.toString();
	}

// ---- 학생개인 일자별 출결 ----
	@ResponseBody
	@PostMapping("/stuAtndList")
	public String stuAtndList(@RequestParam Map<String, Object> map) {
		
		List<Map<String, Object>> stuAtndList = atndService.stuAtndList(map);
		
		JSONObject json = new JSONObject();
		json.put("stuAtndList", stuAtndList);
		
		return json.toString();
	}

// ---- 출결저장 ----
	@ResponseBody
	@PostMapping("/stuAtnd")
	public String setStuAtnd(@RequestBody List<Map<String, Object>> stuAtndArr) {
		
		atndService.setStuAtnd(stuAtndArr);
		
		JSONObject json = new JSONObject();
		
		return json.toString();
	}
		
// ---- 수강신청기간확인 ----
	@ResponseBody
	@PostMapping("/crclmSchdlYN")
	public String checkSchdlYN(@RequestParam Map<String, Object> map) {
		
		JSONObject json = new JSONObject();

		Map<String, Object> check = atndService.checkSchdlYN(map);
		
		String countCrclm = String.valueOf(check.get("countCrclm")) ;
		String countY = String.valueOf(check.get("countY"));
		
		if(countCrclm.equals(countY)) {
			json.put("checkYN", "1");
		} else {
			json.put("checkYN", "0");
		}
		
		return json.toString();
	}
	
// ---- 수강신청내역으로 출석부생성 ----
	@ResponseBody
	@PostMapping("/sbjctAtndList")
	public String createAtnd(@RequestParam Map<String, Object> map ) {
		
		atndService.createAtnd(map);
		
		JSONObject json = new JSONObject();
		
		return json.toString();
	}
	
}
