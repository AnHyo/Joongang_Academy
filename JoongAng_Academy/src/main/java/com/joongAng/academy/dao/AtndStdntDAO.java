package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AtndStdntDAO {
	
	Map<String, Object> stdntInfo(String id);

	List<Map<String, Object>> sbjctList(Map<String, Object> map);

	List<Map<String, Object>> atndList(Map<String, Object> map);

}
