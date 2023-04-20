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

}
