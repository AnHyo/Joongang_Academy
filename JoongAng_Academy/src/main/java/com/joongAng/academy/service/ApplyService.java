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
	public List<Map<String, Object>> estblSBJ(Map<String, Object> map) {
		return applyDAO.estblSBJ(map);
	}
	public int addApply(Map<String, Object> map) {
		return applyDAO.addApply(map);
	}
	public List<Map<String, Object>> applySBJ(Map<String, Object> map) {
		return applyDAO.applySBJ(map);
	}
	public int delApply(Map<String, Object> map) {
		return applyDAO.delApply(map);
	}
	public int applyCheck(Map<String, Object> map) {
		return applyDAO.applyCheck(map);
	}
	public int addHist(Map<String, Object> map) {
		return applyDAO.addHist(map);
	}
	public int delHist(Map<String, Object> map) {
		return applyDAO.delHist(map);
	}
	public List<Map<String, Object>> applyHist(Map<String, Object> map) {
		return applyDAO.applyHist(map);
	}
	public int classTMChk(Map<String, Object> map) {
		return applyDAO.classTMChk(map);
	}
	public int esntl(Map<String, Object> map) {
		return applyDAO.esntl(map);
	}
	public List<Map<String, Object>> planAjax(Map<String, Object> map) {
		return applyDAO.planAjax(map);
	}
	public List<Map<String, Object>> timetableAjax(Map<String, Object> map) {
		return applyDAO.timetableAjax(map);
	}
	public List<Map<String, Object>> schedule(Map<String, Object> map) {
		return applyDAO.schedule(map);
	}

}
