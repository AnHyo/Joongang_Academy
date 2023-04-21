package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.SbjctDAO;

@Service
public class SbjctService {

	@Autowired
	private SbjctDAO sbjctDAO;
	
	public List<Map<String, Object>> list(Map<String, Object> search) {
		return sbjctDAO.list(search);
	}

	public int addsbj(Map<String, Object> map) {
		return sbjctDAO.addsbj(map);
	}

	public int delsbj(Map<String, Object> map) {
		return sbjctDAO.delsbj(map);
	}

	public int updatesbj(Map<String, Object> map) {
		return sbjctDAO.updatesbj(map);
	}

	public int integrity(Map<String, Object> map) {
		return sbjctDAO.integrity(map);
	}

}
