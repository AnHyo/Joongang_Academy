package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.AtndInstrDAO;
import com.joongAng.academy.dao.AtndStdntDAO;
import com.joongAng.academy.dao.AttendanceDAO;

@Service
public class AtndStdntService {
	
	@Autowired
	private AtndStdntDAO atndStdntDAO;

	public Map<String, Object> stdntInfo(String id) {
		return atndStdntDAO.stdntInfo(id);
	}
	
	public List<Map<String, Object>> sbjctList(Map<String, Object> map) {
		return atndStdntDAO.sbjctList(map);
	}

	public List<Map<String, Object>> atndList(Map<String, Object> map) {
		return atndStdntDAO.atndList(map);
	}


}
