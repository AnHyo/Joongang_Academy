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
	
	public List<Map<String, Object>> list(Map<String, String> map) {
		return surveyDAO.list(map);
	}

	public int update(Map<String, String> map) {
		return surveyDAO.update(map);
	}

	public List<Map<String, Object>> detaillist(Map<String, String> map) {
		return surveyDAO.detaillist(map);
	}

	public List<Map<String, Object>> anslist() {
		return surveyDAO.anslist();
	}

	public int ITEMCreate(Map<String, Object> map) {
		return surveyDAO.ITEMCreate(map);
	}

	public boolean checknoExists(Map<String, Object> map) {
		return surveyDAO.checknoExists(map);
	}
	
	public int ITEMUpdate(List<Map<String, Object>> updateData) {
		return surveyDAO.ITEMUpdate(updateData);
	}

	public int ITEMdelete(List<Map<String, Object>> deleteData) {
		return surveyDAO.ITEMdelete(deleteData);
	}

	public List<Map<String, Object>> stdntlist(Map<String, String> map) {
		return surveyDAO.stdntlist(map);
	}

	public List<Map<String, Object>> surveySbj(String loginID) {
		return surveyDAO.surveySbj(loginID);
	}

	public List<Map<String, Object>> ResultDetailAjax(Map<String, String> map) {
		return surveyDAO.ResultDetailAjax(map);
	}

	public List<Map<String, Object>> dgstfnNo(Map<String, String> map) {
		return surveyDAO.dgstfnNo(map);
	}

	public List<Map<String, Object>> ResultDetailAjax2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return surveyDAO.ResultDetailAjax2(map);
	}

	
}
