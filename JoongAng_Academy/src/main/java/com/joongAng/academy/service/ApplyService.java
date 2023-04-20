package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.ApplyDAO;

@Service
public class ApplyService {

	@Autowired
	private ApplyDAO applyDAO;
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return applyDAO.list(map);
	}
	public List<Map<String, Object>> info(Map<String, Object> map) {
		return applyDAO.info(map);
	}

}
