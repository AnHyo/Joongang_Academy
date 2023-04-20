package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.SurveyDAO;

@Service
public class SurveyService {

	@Autowired
	private SurveyDAO surveyDAO;
	
	public List<Map<String, Object>> list(Map<String, String> searchcmap) {
		return surveyDAO.list(searchcmap);
	}

//	public List<Map<String, Object>> surveyList() {
//		return surveyDAO.surveyList();
//	}

}
