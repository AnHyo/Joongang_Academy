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
		return estDAO.estSave(map);
	}

	public List<Map<String, Object>> estSubjectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estSubjectList(map);
	}

	public int estDelete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estDelete(map);
	}

	public int estPlan(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estPlan(map);
	}

	public List<Map<String, Object>> estInstructorList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estInstructorList(map);
	}

	public int estInst(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estInst(map);
	}

	public Map<String, Object> estGetInstr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estGetInstr(map);
	}

	public List<Map<String, Object>> estHalfList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estHalfList(map);
	}

	public int estDgst(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estDgst(map);
	}

	public int estTime(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estTime(map);
	}

	public List<Map<String, Object>> estTimeInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estTimeInfo(map);
	}

	public int estTimeConfirm(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return estDAO.estTimeConfirm(map);
	}
	
}
