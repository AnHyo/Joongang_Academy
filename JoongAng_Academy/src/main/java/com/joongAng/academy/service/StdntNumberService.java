package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.StdntNumberDAO;

@Service
public class StdntNumberService {
	
	@Autowired
	public StdntNumberDAO numberDAO;

	public List<Map<String, Object>> getCrclmList(Map<String, Object> map) {
		return numberDAO.getCrclmList(map);
	}

	public List<Map<String, Object>> getStuList(Map<String, Object> map) {
		return numberDAO.getStuList(map);
	}

	public String stdntCount(Map<String, Object> map) {
		return numberDAO.stdntCount(map);
	}

	public String crclmCount(Map<String, Object> map) {
		return numberDAO.crclmCount(map);
	}

	public List<Map<String, Object>> createStdntNo(Map<String, Object> map) {
		return numberDAO.createStdntNo(map);
	}

	public int updateStdntNo(List<Map<String, Object>> setNoList) {
		return numberDAO.updateStdntNo(setNoList);
	}

	public int updateUserIdPw(Map<String, Object> map) {
		return numberDAO.updateUserIdPw(map);
	}

	public List<Map<String, Object>> radioList(Map<String, Object> map) {
		return numberDAO.radioList(map);
	}

}
