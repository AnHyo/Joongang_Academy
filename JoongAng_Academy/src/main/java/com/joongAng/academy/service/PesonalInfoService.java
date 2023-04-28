package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.PesonalInfoDAO;

@Service
public class PesonalInfoService {

	
	@Autowired
	private PesonalInfoDAO pesonalInfoDAO;

	public int pwCheckAjax(Map<String, Object> map) {
		return pesonalInfoDAO.pwCheckAjax(map);
	}

	public int pwChangeAjax(Map<String, Object> map) {
		return pesonalInfoDAO.pwChangeAjax(map);
	}

	public String gradeCheck(String userID) {
		return pesonalInfoDAO.gradeCheck(userID);
	}

	public List<Map<String, Object>> info(Map<String, Object> map) {
		return pesonalInfoDAO.info(map);
	}

	public int instrInfoUpdate(Map<String, Object> map) {
		return pesonalInfoDAO.instrInfoUpdate(map);
	}
}
