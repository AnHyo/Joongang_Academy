package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.InstrTimeTableDTO;

@Repository
@Mapper
public interface InstrTimeTableDAO {

	public List<Map<String, Object>> instrTimeTableAjax(InstrTimeTableDTO instrDTO);

	public List<Map<String, Object>> sbjSearchAjax(InstrTimeTableDTO instrDTO);

	public List<Map<String, Object>> stuAjax(InstrTimeTableDTO instrDTO);


	}
