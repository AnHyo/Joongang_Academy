package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CrclmInfoDAO {

	public List<Map<String, Object>> listCrclmAjax(Map<String, String> paramap);

	public int saveCrclmAjax(Map<String, String> paramap);	

	public List<Map<String, Object>> crclmNameList();

	public int newCrclmAjax(Map<String, String> paramap);

	public List<Map<String, Object>> saveAfter();

	public int checkCrclmAjax(Map<String, String> paramap);

	public List<Map<String, Object>> instrSearchM(Map<String, String> paramap);
}
