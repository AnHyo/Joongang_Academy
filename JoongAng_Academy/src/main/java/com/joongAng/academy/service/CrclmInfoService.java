package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.CrclmInfoDAO;
import com.joongAng.academy.dao.SbjctDAO;
import com.joongAng.academy.dto.CrclmInfoDTO;

@Service
public class CrclmInfoService {

	@Autowired
	private CrclmInfoDAO crclmInfoDAO ;

	public List<Map<String, Object>> listCrclmAjax(CrclmInfoDTO crclmInfoDTO) {
		return crclmInfoDAO.listCrclmAjax(crclmInfoDTO);
	}

	public int saveCrclmAjax(CrclmInfoDTO crclmInfoDTO) {
		
		return crclmInfoDAO.saveCrclmAjax(crclmInfoDTO);
	}

	public List<Map<String, Object>> crclmNameList() {
		return crclmInfoDAO.crclmNameList();
	}

	public int newCrclmAjax(CrclmInfoDTO crclmInfoDTO) {
		return crclmInfoDAO.newCrclmAjax(crclmInfoDTO);
	}

	public List<Map<String, Object>> saveAfter() {
		return crclmInfoDAO.saveAfter();
	}

	public int checkCrclmAjax(CrclmInfoDTO crclmInfoDTO) {
		// TODO Auto-generated method stub
		return crclmInfoDAO.checkCrclmAjax(crclmInfoDTO);
	}

	public List<Map<String, Object>> instrSearchM(Map<String, String> paramap) {
		return crclmInfoDAO.instrSearchM(paramap);
	}

	public List<Map<String, Object>> crclmSchdl(CrclmInfoDTO crclmInfoDTO) {
		return crclmInfoDAO.crclmSchdl(crclmInfoDTO);
	}

	public int countCodeNum() {
		return crclmInfoDAO.countCodeNum();
	}

	public void newSchedule(CrclmInfoDTO crclmInfoDTO2) {
		crclmInfoDAO.newSchedule(crclmInfoDTO2);
	}

	public List<Map<String, Object>> scheduleName() {
		return crclmInfoDAO.scheduleName();
	}

	public int updateSchedule(List<Map<String, Object>> updateRow) {
		return crclmInfoDAO.updateSchedule(updateRow);
	}

	
	

}
