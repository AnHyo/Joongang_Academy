package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.CrclmInfoDAO;
import com.joongAng.academy.dao.SbjctDAO;

@Service
public class CrclmInfoService {

	@Autowired
	private CrclmInfoDAO crclmInfoDAO ;

	public List<Map<String, Object>> listCrclmAjax(Map<String, String> paramap) {
		return crclmInfoDAO.listCrclmAjax(paramap);
	}

	public int saveCrclmAjax(Map<String, String> paramap) {
		
		return crclmInfoDAO.saveCrclmAjax(paramap);
	}
	
	
	//무슨일일까...?....?

}
