package com.joongAng.academy.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.dto.CrclmInfoDTO;
import com.joongAng.academy.service.CrclmInfoService;

@Controller
public class CrclmInfoController {
	@Autowired
	private CrclmInfoService crclmInfoService;

	@GetMapping("/crclmInfo")
	public ModelAndView crclmInfo() {
		ModelAndView mv = new ModelAndView("admin/crclmInfo");
		// 훈련과정정보 - 훈련과정명 select
		List<Map<String, Object>> list = crclmInfoService.crclmNameList();
		mv.addObject("crclmName", list);
		
		//공통코드(과정현황) 출력위한 데이터 불러오기
		List<Map<String, Object>> scheduleName = crclmInfoService.scheduleName();
		mv.addObject("scheduleName", scheduleName);
		return mv;
	}

	@ResponseBody
	@PostMapping(value = "/listCrclmAjax", produces = "application/json;charset=UTF-8")
	public String listCrclmAjax(@RequestBody CrclmInfoDTO crclmInfoDTO) {

		JSONObject json = new JSONObject();
		List<Map<String, Object>> list = crclmInfoService.listCrclmAjax(crclmInfoDTO);
		json.put("listCrclm", list);

		return json.toString();
	}

	// 신규 저장
	@ResponseBody
	@PostMapping(value = "/newCrclmAjax", produces = "application/json;charset=UTF-8")
	public String newCrclmAjax(@RequestBody CrclmInfoDTO crclmInfoDTO) {

		JSONObject json = new JSONObject();
		// DB에 중복갯수 검사
		int ck = crclmInfoService.checkCrclmAjax(crclmInfoDTO);

		if (ck != 1) {
			int result = crclmInfoService.newCrclmAjax(crclmInfoDTO);
			List<Map<String, Object>> list2 = crclmInfoService.listCrclmAjax(crclmInfoDTO);
			json.put("saveResult", result);
			json.put("saveAfter", list2);
			
			//훈련과정 신규저장시 과정일정설정(CRCLM_SCHDL)에 데이터 생성
			//1.공통데이터상에 과정일정 코드 갯수 확인
			int codeNumber = crclmInfoService.countCodeNum();
			//2. RCLM_SCHDL에 과정일정 데이터 생성
			CrclmInfoDTO crclmInfoDTO2 = new CrclmInfoDTO();
			for (int i = 1; i < codeNumber+1; i++) {
				crclmInfoDTO2.setCcd(crclmInfoDTO.getCcd());
				crclmInfoDTO2.setChalf(crclmInfoDTO.getChalf());
				crclmInfoDTO2.setCyear(crclmInfoDTO.getCyear());
				crclmInfoDTO2.setSchedule("00"+i+"0");
				crclmInfoService.newSchedule(crclmInfoDTO2);
			}

		} else {
			//중복이 있음을 jsp단으로 전송
			json.put("ck", "dup");
		}

		return json.toString();
	}

	// 수정 저장
	@ResponseBody
	@PostMapping(value = "/saveCrclmAjax", produces = "application/json;charset=UTF-8")
	public String saveCrclmAjax(@RequestBody CrclmInfoDTO crclmInfoDTO) {

		JSONObject json = new JSONObject();
		int result = crclmInfoService.saveCrclmAjax(crclmInfoDTO);
		List<Map<String, Object>> list2 = crclmInfoService.listCrclmAjax(crclmInfoDTO);

		json.put("updateResult", result);
		json.put("updateAfter", list2);

		return json.toString();
	}

	// 강사명 검색모달
	@ResponseBody
	@PostMapping(value = "/instrSearchM", produces = "application/json;charset=UTF-8")
	public String instrSearchM(@RequestParam Map<String, String> paramap) {
		// System.err.println(paramap);
		JSONObject json = new JSONObject();

		List<Map<String, Object>> list2 = crclmInfoService.instrSearchM(paramap);
		// System.err.println(list2);
		json.put("list2", list2);

		return json.toString();
	}

	// 과정일정설정 리스트 출력
	@ResponseBody
	@PostMapping(value = "/crclmSchdl", produces = "application/json;charset=UTF-8")
	public String crclmSchdl(@RequestBody CrclmInfoDTO crclmInfoDTO) {
		JSONObject json = new JSONObject();

		List<Map<String, Object>> sList = crclmInfoService.crclmSchdl(crclmInfoDTO);
		// System.err.println(sList);
		json.put("sList", sList);

		return json.toString();

	}
	
	//과정일정설정 저장(수정)
	@ResponseBody
	@PostMapping(value = "/updateSchedule", produces = "application/json;charset=UTF-8")
	public String updateSchedule(@RequestBody List<Map<String, Object>> updateRow) {
		JSONObject json = new JSONObject();
		System.err.println(updateRow);
		int result = crclmInfoService.updateSchedule(updateRow);
		//System.err.println("결과 : "+ result);
		// System.err.println(sList);
		//json.put("sList", sList);

		return json.toString();

	}
}
