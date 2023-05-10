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

import com.joongAng.academy.dto.LoginDTO;
import com.joongAng.academy.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	
	@GetMapping("/login")
	public String login() {
		return "/login/login";
	}
	@GetMapping("/")
	public String index() {
		return "portalIndex";
	}

	
	
	@PostMapping("/login")
	public String login(@RequestParam Map<String, Object> paramap, HttpSession session) {
		
		LoginDTO result = loginService.login(paramap);
		

		if(result.getCount() == 1 && result.getPSWD_ERR_NMTM() < 3) { //일치데이터확인
			String groupCD = result.getUSER_GROUP_CD();
		
			session.setAttribute("id", result.getUSER_ID());
			session.setAttribute("username", result.getKORN_FLNM());
			
			//비밀번호 시도횟수 초기화
			paramap.put("PSWD_ERR_NMTM", 0);
			loginService.loginTry(paramap);	
			
			if( groupCD.equals("0010")) {
				return "/student/stuIndex";

				
			} else if(groupCD.equals("0020")) {
				return "/instr/instrIndex";
				
			}  else if(groupCD.equals("0030")) {
				return "/admin/adminIndex";
		
			}
			
		} else if(result.getPSWD_ERR_NMTM() >=3){
			return "redirect:/login?error=4569";

		}else{
			//일치하지 않는다면// +1
			
			loginService.loginTry(paramap);	
			return "redirect:/login?error=1222";
		}
		
		
		return "redirect:/login";
	}
	
	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("id") != null) {
			session.removeAttribute("id");
		}
		if(session.getAttribute("username") != null) {
			session.removeAttribute("username");
		}
		//전체종료
		session.invalidate();
		
		
		return "/login/login";
	}
	
	
	@GetMapping("/findPW")
	public String findPW() {
		
		return "login/findPW";
	}
	
	//등록된 아이디확인
	@PostMapping("/ckid")
	public String ckid(@RequestParam("ckid") String ckid, Model model) {
		int result = loginService.ckid(ckid);
		if(result ==1) {
			 // login/setPW로 ckid 값을 전달하여 모델에 저장
	        model.addAttribute("ckid", ckid);
			return "login/setPW";
		}else {
			return "redirect:/findPW?error=1223";
			
		}
	}
	
	//인증번호 대조후 비밀번호 변경 화면이동
	@ResponseBody
	@PostMapping(value ="/ckTemp" , produces = "application/json;charset=UTF-8")
	public String ckTemp(@RequestParam Map<String, Object> paramap ) {
		int result = loginService.ckTemp(paramap);
		JSONObject json = new JSONObject();
		String changingID = (String) paramap.get("ckid");
		if(result==1) {
			json.put("changingID", changingID);
			json.put("result", result);
			return json.toString();
			//return "redirect:/changePW?id="+changingID;
		} else {
			json.put("result", result);
			return json.toString();
		}
		
	}
	
	@GetMapping("/changePW")
	public String changePW() {
		
		return "login/changePW";
	}
	
	//비밀번호 변경
	@PostMapping("/updatePW")
	public String updatePW(@RequestParam Map<String, Object> paramap, Model model) {
		int result = loginService.updatePW(paramap);
		model.addAttribute("result", result);
		return "/login/setPW";
	}
	
}
