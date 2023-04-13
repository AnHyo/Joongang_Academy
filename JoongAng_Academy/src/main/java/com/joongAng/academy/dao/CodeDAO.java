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


}
