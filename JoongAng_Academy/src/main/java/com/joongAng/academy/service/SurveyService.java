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
	
	public List<Map<String, Object>> list(String survey_search) {
		return surveyDAO.list(survey_search);
	}

}
