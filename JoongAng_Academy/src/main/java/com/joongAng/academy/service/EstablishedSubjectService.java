package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.EstablishedSubjectDAO;
import com.joongAng.academy.dto.EstablishedSubjectDTO;

@Service
public class EstablishedSubjectService {
	
	@Autowired
	private EstablishedSubjectDAO estDAO;
	
	public List<Map<String, Object>> estList(Map<String, Object> map) {
		
		return estDAO.estList(map);
	}

	public List<Map<String, Object>> estCrcList() {
		return estDAO.estCrcList();
	}

	public List<Map<String, Object>> estCodeList(String division) {
		// TODO Auto-generated method stub
		return estDAO.estCodeList(division);
	}

	public List<Map<String, Object>> estYearList(String crc) {
		// TODO Auto-generated method stub
		return estDAO.estYearList(crc);
	}

	public List<Map<String, Object>> estRoomList() {
		// TODO Auto-generated method stub
		return estDAO.estRoomList();
	}

	public int estSave(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estSave(map);
	}
	
}
