package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.SubjectPlanDAO;

@Service
public class SubjectPlanService {
	
	@Autowired
	SubjectPlanDAO planDAO;

	public Map<String, Object> getPlan(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return planDAO.getPlan(map);
	}

	public int savePlan(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return planDAO.savePlan(map);
	}

	public List<Map<String, Object>> getPlanDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return planDAO.getPlanDetail(map);
	}
	
	
}
