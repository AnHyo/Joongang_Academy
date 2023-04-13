package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CrclmInfoDAO {

	List<Map<String, Object>> listCrclmAjax(Map<String, String> paramap);

	int saveCrclmAjax(Map<String, String> paramap);
	//수정
}
