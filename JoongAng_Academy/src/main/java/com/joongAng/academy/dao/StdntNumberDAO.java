package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface StdntNumberDAO {

	List<Map<String, Object>> getCrclmList(Map<String, Object> map);

}
