package com.joongAng.academy.dao;


import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;



@Repository
@Mapper
public interface CodeDAO {

	List<Map<String, Object>> list(String code_search);

	List<Map<String, Object>> detaillist(String CD_CLSFValue);

	int code_create(Map<String, Object> map);

	boolean isCodeExist(Map<String, Object> map);

	int code_update(Map<String, Object> map);

}
