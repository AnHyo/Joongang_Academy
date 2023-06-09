package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface AdminInfoDAO {

	List<Map<String, Object>> admininfoAjax(Map<String, Object> map);

	int adminInfoUpdate(Map<String, Object> map);

}
