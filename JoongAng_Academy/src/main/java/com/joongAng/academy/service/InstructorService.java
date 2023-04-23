package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.InstructorDAO;
import com.joongAng.academy.dto.StudentAllInfoDTO;

@Service
public class InstructorService {
	@Autowired
	private InstructorDAO instrDAO;

	public List<Map<String, Object>> insList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return instrDAO.insList(map);
	}

	public List<Map<String, Object>> teacherUnreg() {
		return instrDAO.teacherUnreg();
	}

	public List<StudentAllInfoDTO> gender() {
		return instrDAO.gender();
	}

	public List<StudentAllInfoDTO> endst() {
		return instrDAO.endst();
	}

	public int teacherInfoUpdate(Map<String, Object> map) {
		return instrDAO.teacherInfoUpdate(map);
	}

	public int teacherNewRegist(Map<String, Object> map) {
		return instrDAO.teacherNewRegist(map);
	}

	public List<Map<String, Object>> telcheck(String inst_no) {
		return instrDAO.telcheck(inst_no);
	}

	public int teacherUserUpdate(Map<String, Object> map) {
		return instrDAO.teacherUserUpdate(map);
	}

	public List<Map<String, Object>> foCheck(String instrNo) {
		return instrDAO.foCheck(instrNo);
	}

	public int instrDel(String instrNo) {
		return instrDAO.instrDel(instrNo);
	}

	public int instrDelCen(String instrNo) {
		return instrDAO.instrDelCen(instrNo);
	}
}
