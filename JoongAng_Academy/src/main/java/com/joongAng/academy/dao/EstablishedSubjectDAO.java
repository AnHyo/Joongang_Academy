package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.EstablishedSubjectDTO;

@Repository
@Mapper
public interface EstablishedSubjectDAO {
	public List<Map<String, Object>> estList(Map<String, Object> map);

	public List<Map<String, Object>> estCrcList();

	public List<Map<String, Object>> estCodeList(String division);

	public List<Map<String, Object>> estYearList(String crc);

	public List<Map<String, Object>> estRoomList();

	public int estSave(Map<String, Object> map);

	public List<Map<String, Object>> estSubjectList(Map<String, Object> map);

	public int estDelete(Map<String, Object> map);

	public int estPlan(Map<String, Object> map);

	public List<Map<String, Object>> estInstructorList(Map<String, Object> map);

	public int estInst(Map<String, Object> map);

	public Map<String, Object> estGetInstr(Map<String, Object> map);

	public List<Map<String, Object>> estHalfList(Map<String, Object> map);

	public int estDgst(Map<String, Object> map);

	public int estTime(Map<String, Object> map);

	public List<Map<String, Object>> estTimeInfo(Map<String, Object> map);

	public int estTimeConfirm(Map<String, Object> map);

	public Map<String, Object> integCheck(Map<String, Object> map);

	public int estClsBgngCheck(Map<String, Object> map);
}
