package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.EstablishedSubjectDTO;

@Repository
@Mapper
public interface EstablishedSubjectDAO {
	public List<Map<String, Object>> estList(Map<String, Object> map);

	public List<Map<String, Object>> estCrcList();

	public List<Map<String, Object>> estCodeList(String division);

	public List<Map<String, Object>> estYearList(String crc);
}
