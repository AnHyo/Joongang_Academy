package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.AtndInstrDAO;
import com.joongAng.academy.dao.AttendanceDAO;

@Service
public class AtndInstrService {
	
	@Autowired
	private AtndInstrDAO atndInstrDAO;

	public List<Map<String, Object>> crclmList(Map<String, Object> map) {
		return atndInstrDAO.crclmList(map);
	}

	public List<Map<String, Object>> weekList(Map<String, Object> map) {
		return atndInstrDAO.weekList(map);
	}

	public List<Map<String, Object>> stdntList(Map<String, Object> map) {
		return atndInstrDAO.stdntList(map);
	}


}
