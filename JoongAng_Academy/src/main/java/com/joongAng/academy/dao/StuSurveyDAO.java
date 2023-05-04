package com.joongAng.academy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.StuSurveyDTO;

@Repository
@Mapper
public interface StuSurveyDAO {

	List<Map<String, Object>> surveySbj(String student_ID);

	List<StuSurveyDTO> surveyTI(StuSurveyDTO stuSuvDTO);

	List<StuSurveyDTO> surveyIn(StuSurveyDTO stuSuvTI);

	List<StuSurveyDTO> surveyIn2(StuSurveyDTO stuSuvTI);

	List<StuSurveyDTO> code();

	int svSave(StuSurveyDTO dto);

	int svUpdate(StuSurveyDTO dto);


}
