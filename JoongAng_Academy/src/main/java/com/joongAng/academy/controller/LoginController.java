package com.joongAng.academy.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
	@GetMapping("/index")
	public String index() {
		return "index";
	}
	@GetMapping("/index2")
	public String index2() {
		return "index2";
	}
	
	
	@PostMapping("/login")
	public String login(@RequestParam Map<String, Object> paramap, HttpSession session) {
		System.err.println(paramap);
		
		//ModelAndView mv = new ModelAndView();
		
		LoginDTO result = loginService.login(paramap);
		
		System.err.println(result.getCount());

		if(result.getCount() == 1 && result.getPSWD_ERR_NMTM() < 3) { //일치데이터확인
			System.err.println("로그인성공");
			System.err.println(result.getUSER_GROUP_CD());
			String groupCD = result.getUSER_GROUP_CD();
		
			session.setAttribute("id", result.getUSER_ID());
			session.setAttribute("username", result.getKORN_FLNM());
			
			//비밀번호 시도횟수 초기화
			paramap.put("PSWD_ERR_NMTM", 0);
			System.err.println("에러횟수" +paramap.get("PSWD_ERR_NMTM"));
			loginService.loginTry(paramap);	
			
			if( groupCD.equals("0010")) {
				System.err.println("학생");
			//	mv.addObject("result", result); 
			//	mv.setViewName("/admin/sbjctMG");
				return "redirect:/crclmInfo";

				
			} else if(groupCD.equals("0020")) {
				System.err.println("강사");
			//	mv.addObject("result", result);
			//	mv.setViewName("/admin/crclmInfo");
				return "redirect:/crclmInfo";
			}
			
		} else if(result.getPSWD_ERR_NMTM() >=3){
			System.err.println("로그인 횟수 초과");
			return "redirect:/login?error=4569";

		}else{
			//일치하지 않는다면// +1
			System.out.println("로그인 실패");
			
			loginService.loginTry(paramap);	
			return "redirect:/login?error=1222";
		}
		
		
		
		/* String id = paramap.get("userid");
		 * if(id.indexOf("l") != -1) { System.err.println("선생");
		 * //System.err.println(result); mv.addObject("result", result);
		 * mv.setViewName("/admin/crclmInfo");
		 * 
		 * }else if(id.indexOf("A") != -1) { System.err.println("학생"); LoginDTO result =
		 * loginService.login(paramap); //System.err.println(result);
		 * mv.addObject("result", result); mv.setViewName("/admin/sbjctMG");
		 * 
		 * 
		 * 
		 * }
		 */
		return "";
	}
	
	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("id") != null) {
			session.removeAttribute("id");
		}
		if(session.getAttribute("username") != null) {
			session.removeAttribute("username");
		}
		//전체종료 session.invalidate();
		
		
		return "/login/login";
	}
	
	
	@GetMapping("/findPW")
	public String findPW() {
		
		return "login/findPW";
	}
	
	//등록된 아이디확인
	@PostMapping("/ckid")
	public String ckid(@RequestParam("ckid") String ckid) {
		int result = loginService.ckid(ckid);
		System.err.println("아이디 확인:"+result);
		if(result ==1) {
			return "login/setPW";
		}else {
			return "redirect:/findPW?error=1223";
			
		}
	}
	
	@PostMapping("/resetPW")
	public String resetPW(@RequestParam("phNo") String phNo) {
		//등록된 휴대폰번호
		//int result = loginService.phNo(phNo);  
		return "";
	}
	
	
	
	
}
