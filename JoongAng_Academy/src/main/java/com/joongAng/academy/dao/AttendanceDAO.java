package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AttendanceDAO {

	List<Map<String, Object>> crclmList(Map<String, Object> map);

	List<Map<String, Object>> dayList(Map<String, Object> map);

	List<Map<String, Object>> stdntList(Map<String, Object> map);

	List<Map<String, Object>> stuAtndList(Map<String, Object> map);

	void setStuAtnd(Map<String, Object> map);

	List<Map<String, Object>> dayAtndList(Map<String, Object> map);

	Map<String, Object> checkSchdlYN(Map<String, Object> map);

	int createAtnd(Map<String, Object> map);


}
