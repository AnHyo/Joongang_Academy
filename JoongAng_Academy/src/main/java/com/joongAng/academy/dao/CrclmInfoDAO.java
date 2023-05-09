package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.CrclmInfoDTO;

@Repository
@Mapper
public interface CrclmInfoDAO {

	public List<Map<String, Object>> listCrclmAjax(CrclmInfoDTO crclmInfoDTO);

	public int saveCrclmAjax(CrclmInfoDTO crclmInfoDTO);	

	public List<Map<String, Object>> crclmNameList();

	public int newCrclmAjax(CrclmInfoDTO crclmInfoDTO);

	public List<Map<String, Object>> saveAfter();

	public int checkCrclmAjax(CrclmInfoDTO crclmInfoDTO);

	public List<Map<String, Object>> instrSearchM(Map<String, String> paramap);

	public List<Map<String, Object>> crclmSchdl(CrclmInfoDTO crclmInfoDTO);

	public int countCodeNum();

	public void newSchedule(CrclmInfoDTO crclmInfoDTO2);

	public List<Map<String, Object>> scheduleName();

	public int updateSchedule(List<Map<String, Object>> updateRow);

	public int deleteCrclmAjax(CrclmInfoDTO crclmInfoDTO);

	public int integrity1(CrclmInfoDTO crclmInfoDTO);
	public int integrity2(CrclmInfoDTO crclmInfoDTO);
}
