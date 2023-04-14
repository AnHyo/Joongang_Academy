package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.InstructorDAO;

@Service
public class InstructorService {
	@Autowired
	private InstructorDAO instrDAO;

	public List<Map<String, Object>> insList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return instrDAO.insList(map);
	}
}
