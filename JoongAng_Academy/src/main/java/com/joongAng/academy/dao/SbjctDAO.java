package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SbjctDAO {

	public List<Map<String, Object>> list();

	public int addsbj(Map<String, Object> map);

	public int delsbj(int rowcnt);

	public int updatesbj(Map<String, Object> map);

}
