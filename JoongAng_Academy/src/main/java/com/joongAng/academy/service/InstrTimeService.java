package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.CrclmInfoDAO;
import com.joongAng.academy.dao.InstrTimeTableDAO;
import com.joongAng.academy.dao.SbjctDAO;
import com.joongAng.academy.dto.CrclmInfoDTO;
import com.joongAng.academy.dto.InstrTimeTableDTO;

@Service
public class InstrTimeService {

	@Autowired
	private  InstrTimeTableDAO instrDAO ;


	public List<Map<String, Object>> instrTimeTableAjax(InstrTimeTableDTO instrDTO) {
		return instrDAO.instrTimeTableAjax(instrDTO);
	}


	public List<Map<String, Object>> sbjSearchAjax(InstrTimeTableDTO instrDTO) {
		// TODO Auto-generated method stub
		return instrDAO.sbjSearchAjax(instrDTO);
	}


	public List<Map<String, Object>> stuAjax(InstrTimeTableDTO instrDTO) {
		// TODO Auto-generated method stub
		return instrDAO.stuAjax(instrDTO);
	}


	
	

}
