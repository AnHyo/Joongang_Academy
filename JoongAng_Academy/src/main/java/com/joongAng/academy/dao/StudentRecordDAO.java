package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.StudentRecordDTO;

@Repository
@Mapper
public interface StudentRecordDAO {

	public List<Map<String, Object>> studentInfo(Map<String, Object> map);

	public List<Map<String, Object>> depInfo(StudentRecordDTO search);


}
