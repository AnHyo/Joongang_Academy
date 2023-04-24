package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ApplyDAO {

	List<Map<String, Object>> list(Map<String, Object> map);

	List<Map<String, Object>> info(Map<String, Object> map);

	List<Map<String, Object>> estblSBJ(Map<String, Object> map);

	int addApply(Map<String, Object> map);

	List<Map<String, Object>> applySBJ(Map<String, Object> map);

	int delApply(Map<String, Object> map);

	int applyCheck(Map<String, Object> map);

	int addHist(Map<String, Object> map);

	int delHist(Map<String, Object> map);

	List<Map<String, Object>> applyHist(Map<String, Object> map);

	int classTMChk(Map<String, Object> map);

	int esntl(Map<String, Object> map);

}
