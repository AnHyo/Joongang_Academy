package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SurveyDAO {

	public List<Map<String, Object>> list(Map<String, String> searchcmap);

//	public List<Map<String, Object>> surveyList();

}
