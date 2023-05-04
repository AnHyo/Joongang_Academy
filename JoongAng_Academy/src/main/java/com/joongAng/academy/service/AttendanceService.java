package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.AttendanceDAO;

@Service
public class AttendanceService {
	
	@Autowired
	private AttendanceDAO atndDAO;

	public List<Map<String, Object>> crclmList(Map<String, Object> map) {
		return atndDAO.crclmList(map);
	}

	public List<Map<String, Object>> dayList(Map<String, Object> map) {
		return atndDAO.dayList(map);
	}

	public List<Map<String, Object>> stdntList(Map<String, Object> map) {
		return atndDAO.stdntList(map);
	}

	public List<Map<String, Object>> stuAtndList(Map<String, Object> map) {
		return atndDAO.stuAtndList(map);
	}

	public void setStuAtnd(Map<String, Object> map) {
		atndDAO.setStuAtnd(map);
	}

	public List<Map<String, Object>> dayAtndList(Map<String, Object> map) {
		return atndDAO.dayAtndList(map);
	}

	public Map<String, Object> checkSchdlYN(Map<String, Object> map) {
		return atndDAO.checkSchdlYN(map);
	}

	public int createAtnd(Map<String, Object> map) {
		return atndDAO.createAtnd(map);
	}


}
