package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SubjectPlanDAO {

	Map<String, Object> getPlan(Map<String, Object> map);

	int savePlan(Map<String, Object> map);

	List<Map<String, Object>> getPlanDetail(Map<String, Object> map);

	int estOn(Map<String, Object> map);

	int saveDetail(Map<String, Object> map);

}
