package com.joongAng.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EstablishedSubjectController {
	
	@GetMapping("/estmg")
	public ModelAndView estmg() {
		ModelAndView mv = new ModelAndView("admin/EstblSbjctMG");
		return mv;
	}
}
