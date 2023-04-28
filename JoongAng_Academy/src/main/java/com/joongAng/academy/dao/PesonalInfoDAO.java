package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface PesonalInfoDAO {

	int pwCheckAjax(Map<String, Object> map);

	int pwChangeAjax(Map<String, Object> map);

	String gradeCheck(String userID);

	List<Map<String, Object>> info(Map<String, Object> map);

	int instrInfoUpdate(Map<String, Object> map);

}
