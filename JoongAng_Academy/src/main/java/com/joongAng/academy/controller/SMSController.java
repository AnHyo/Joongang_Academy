package com.joongAng.academy.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joongAng.academy.dto.LoginDTO;
import com.joongAng.academy.dto.SMSDTO;
import com.joongAng.academy.dto.SMSResponseDTO;
import com.joongAng.academy.service.LoginService;
import com.joongAng.academy.service.SMSService;

@Controller
public class SMSController {
	@Autowired
	private SMSService smsService;
	
	
	@ResponseBody
	@PostMapping(value ="/sendSms" , produces = "application/json;charset=UTF-8")
	public String sendSms(@RequestParam Map<String, String> paramap, SMSDTO smsDTO) throws Exception {
		//등록된 휴대폰번호+이름찾기
		System.err.println(paramap);
		int result = smsService.checkUser(paramap);  
		System.err.println("유저 결과 :"+result);
		
		JSONObject json = new JSONObject();
		if(result ==1 ) {
			//문자 전송
			System.err.println();
			smsDTO.setTo(paramap.get("phNo"));
			SMSResponseDTO response = smsService.sendSms(smsDTO,paramap);
			String code = response.getStatusCode();
			json.put("result",code);
			return json.toString();
			
		}else{
			json.put("result", result);
			return json.toString();
		}
		
	}
	
	
	
}
