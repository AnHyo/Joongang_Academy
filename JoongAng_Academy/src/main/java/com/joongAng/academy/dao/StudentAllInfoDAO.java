package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.StudentAllInfoDTO;

@Repository
@Mapper
public interface StudentAllInfoDAO {

	public List<StudentAllInfoDTO> studentstatus();

	public List<Map<String, Object>> studentSearch(Map<String, Object> map);

	public List<StudentAllInfoDTO> studentDeInfo(StudentAllInfoDTO student);

	public List<StudentAllInfoDTO> relationship();

	public List<StudentAllInfoDTO> studentDetail(StudentAllInfoDTO student);

	public int studentUpdate(Map<String, Object> map);



}
