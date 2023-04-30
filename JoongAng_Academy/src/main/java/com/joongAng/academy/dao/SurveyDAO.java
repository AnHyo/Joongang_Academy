package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SurveyDAO {

	public List<Map<String, Object>> list(Map<String, String> map);

	public int update(Map<String, String> map);

	public List<Map<String, Object>> detaillist(Map<String, String> map);

	public List<Map<String, Object>> anslist();

	public int ITEMCreate(Map<String, Object> map);

	public int ITEMUpdate(List<Map<String, Object>> updateData);

	public int ITEMdelete(List<Map<String, Object>> deleteData);

	public List<Map<String, Object>> stdntlist(Map<String, String> map);

}
