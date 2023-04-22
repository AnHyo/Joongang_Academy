package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface StdntNumberDAO {

	List<Map<String, Object>> getCrclmList(Map<String, Object> map);

	List<Map<String, Object>> getStuList(Map<String, Object> map);

	String stdntCount(Map<String, Object> map);

	String crclmCount(Map<String, Object> map);

	List<Map<String, Object>> createStdntNo(Map<String, Object> map);

	int updateStdntNo(List<Map<String, Object>> setNoList);

	int updateUserIdPw(Map<String, Object> map);

	List<Map<String, Object>> radioList(Map<String, Object> map);

}
