package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.AdminInfoDAO;

@Service
public class AdminInfoService {


	@Autowired
	private AdminInfoDAO adminInfoDAO;

	
	public List<Map<String, Object>> admininfoAjax(Map<String, Object> map) {
		return adminInfoDAO.admininfoAjax(map);
	}


	public int adminInfoUpdate(Map<String, Object> map) {
		return adminInfoDAO.adminInfoUpdate(map);
	}

	
	
	
}
