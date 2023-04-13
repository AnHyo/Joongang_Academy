package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.StdntNumberDAO;

@Service
public class StdntNumberService {
	
	@Autowired
	public StdntNumberDAO numberDAO;

	public List<Map<String, Object>> getCrclmList(Map<String, Object> map) {
		return numberDAO.getCrclmList(map);
	}

}
