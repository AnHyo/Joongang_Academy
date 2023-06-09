package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SbjctDAO {

	public List<Map<String, Object>> list(Map<String, Object> search);

	public int addsbj(Map<String, Object> map);

	public int delsbj(Map<String, Object> map);

	public int updatesbj(Map<String, Object> map);

	public int integrity(Map<String, Object> map);

}
