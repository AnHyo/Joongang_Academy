package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.StuSurveyDAO;
import com.joongAng.academy.dto.StuSurveyDTO;


@Service
public class StuSurveyService {

	@Autowired
	private StuSurveyDAO stuSurveyDAO;

	public List<Map<String, Object>> surveySbj(String student_ID) {
		return stuSurveyDAO.surveySbj(student_ID);
	}

	public List<StuSurveyDTO> surveyTI(StuSurveyDTO stuSuvDTO) {
		return stuSurveyDAO.surveyTI(stuSuvDTO);
	}

	public List<StuSurveyDTO> surveyIn(StuSurveyDTO stuSuvTI) {
		return stuSurveyDAO.surveyIn(stuSuvTI);
	}

	public List<StuSurveyDTO> surveyIn2(StuSurveyDTO stuSuvTI) {
		return stuSurveyDAO.surveyIn2(stuSuvTI);
	}

	public List<StuSurveyDTO> code() {
		return stuSurveyDAO.code();
	}

	public int svSave(StuSurveyDTO dto) {
		return stuSurveyDAO.svSave(dto);
	}

	public int svUpdate(StuSurveyDTO dto) {
		return stuSurveyDAO.svUpdate(dto);
	}
	

}
