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
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.service.ApplyService;
import com.joongAng.academy.service.CrclmInfoService;

@Controller
public class ApplyADController {

	@Autowired
	private CrclmInfoService crclmInfoService;

	@Autowired
	private ApplyService applyService;

	@GetMapping("/adminApply")
	public String adminApply() {

		return "apply/adminApply";
	}

	@GetMapping("/adminApplyList")
	public String adminApplyList() {
		return "apply/adminApplyList";
	}

	@ResponseBody
	@PostMapping(value = "/stuListAjax", produces = "application/json;charset=UTF-8")
	public String stuListAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = applyService.list(map);
		List<Map<String, Object>> crclmlist = crclmInfoService.crclmNameList();
		JSONArray listJ = new JSONArray(list);
		JSONArray crclmlistJ = new JSONArray(crclmlist);
		json.put("list", listJ);
		json.put("crclmlist", crclmlistJ);

		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/stuinfoAjax", produces = "application/json;charset=UTF-8")
	public String stuinfoAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> info = applyService.info(map);
		JSONArray infoJ = new JSONArray(info);
		json.put("info", infoJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/estblSBJAjax", produces = "application/json;charset=UTF-8")
	public String estblSBJAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> estblSBJ = applyService.estblSBJ(map);
		List<Map<String, Object>> applySBJ = applyService.applySBJ(map);
		JSONArray EstblSBJ = new JSONArray(estblSBJ);
		JSONArray ApplySBJ = new JSONArray(applySBJ);
		json.put("estblSBJ", EstblSBJ);
		json.put("applySBJ", ApplySBJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/applyHistAjax", produces = "application/json;charset=UTF-8")
	public String applyHistAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> applyHist = applyService.applyHist(map);
		JSONArray ApplyHist = new JSONArray(applyHist);
		json.put("applyHist", ApplyHist);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/addApplyAjax", produces = "application/json;charset=UTF-8")
	public String addApplyAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int check = applyService.applyCheck(map);
		if (check != 1) { // 중복 과목 체크
			json.put("check", 0);
			int classTMChk = applyService.classTMChk(map);
			if (classTMChk == 0) { // 중복 시간 체크
				json.put("classTMChk", classTMChk);
				int result = applyService.addApply(map);
				int addHist = applyService.addHist(map);
				if (result == 1 && addHist == 1) {
					List<Map<String, Object>> applySBJ = applyService.applySBJ(map);
					json.put("result", result);
					JSONArray ApplySBJ = new JSONArray(applySBJ);
					json.put("applySBJ", ApplySBJ);
				} else {
					json.put("result", 0);
				}
			} else {
				json.put("classTMChk", 1);
			}
		} else {
			json.put("check", 1);
		}

		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/delApplyAjax", produces = "application/json;charset=UTF-8")
	public String delApplyAjax(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int esntl = applyService.esntl(map);
		if (esntl == 0) {
			json.put("esntl", esntl);
			int result = applyService.delApply(map);
			int delHist = applyService.delHist(map);
			if (result == 1 && delHist == 1) {
				List<Map<String, Object>> applySBJ = applyService.applySBJ(map);
				json.put("result", result);
				JSONArray ApplySBJ = new JSONArray(applySBJ);
				json.put("applySBJ", ApplySBJ);
			} else {
				json.put("result", 0);
			}
		} else {
			json.put("esntl", 1);
		}
		return json.toString();
	}

}
