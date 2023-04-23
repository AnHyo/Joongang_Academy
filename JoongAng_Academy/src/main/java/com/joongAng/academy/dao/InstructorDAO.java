package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.StudentAllInfoDTO;

@Repository
@Mapper
public interface InstructorDAO {

	List<Map<String, Object>> insList(Map<String, Object> map);

	List<Map<String, Object>> teacherUnreg();

	List<StudentAllInfoDTO> gender();

	List<StudentAllInfoDTO> endst();

	int teacherInfoUpdate(Map<String, Object> map);

	int teacherNewRegist(Map<String, Object> map);

	List<Map<String, Object>> telcheck(String inst_no);

	int teacherUserUpdate(Map<String, Object> map);

	List<Map<String, Object>> foCheck(String instrNo);

	int instrDel(String instrNo);

	int instrDelCen(String instrNo);

}
