package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AtndInstrDAO {

	List<Map<String, Object>> crclmList(Map<String, Object> map);

	List<Map<String, Object>> weekList(Map<String, Object> map);

	List<Map<String, Object>> stdntList(Map<String, Object> map);

}
