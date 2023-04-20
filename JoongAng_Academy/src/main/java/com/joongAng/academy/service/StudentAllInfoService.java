package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.StudentAllInfoDAO;
import com.joongAng.academy.dto.StudentAllInfoDTO;

@Service
public class StudentAllInfoService {
	
	@Resource(name = "studentAllInfoDAO")
	private StudentAllInfoDAO studentAllInfoDAO;

	public List<StudentAllInfoDTO> studentstatus() {
		return studentAllInfoDAO.studentstatus();
	}

	public List<Map<String, Object>> studentSearch(Map<String, Object> map) {
		return studentAllInfoDAO.studentSearch(map);
	}

	public List<StudentAllInfoDTO> studentDeInfo(StudentAllInfoDTO student) {
		return studentAllInfoDAO.studentDeInfo(student);
	}

	public List<StudentAllInfoDTO> relationship() {
		return studentAllInfoDAO.relationship();
	}

	public List<StudentAllInfoDTO> studentDetail(StudentAllInfoDTO student) {
		return studentAllInfoDAO.studentDetail(student);
	}

	public int studentUpdate(Map<String, Object> map) {
		return studentAllInfoDAO.studentUpdate(map);
	}
	
	

}
