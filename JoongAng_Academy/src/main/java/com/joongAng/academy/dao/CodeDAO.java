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

	boolean isCodeExist2(List<Map<String, Object>> updateData);
	
	int code_update(List<Map<String, Object>> updateData);

	int code_delete(List<Map<String, Object>> deleteData);


}
