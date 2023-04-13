package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.StudentRecordDAO;
import com.joongAng.academy.dto.StudentRecordDTO;

@Service
public class StudentRecordService {
	
	@Resource(name = "studentRecordDAO")
	private StudentRecordDAO studentRecordDAO;

	public List<Map<String, Object>> studentInfo(Map<String, Object> map) {
		return studentRecordDAO.studentInfo(map);
	}

	public List<Map<String, Object>> depInfo(StudentRecordDTO search) {
		return studentRecordDAO.depInfo(search);
	}

}
