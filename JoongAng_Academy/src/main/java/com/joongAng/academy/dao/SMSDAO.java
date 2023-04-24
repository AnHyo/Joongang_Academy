package com.joongAng.academy.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface SMSDAO {

	public int checkUser(Map<String, String> paramap);


	public void saveTmepNo(Map<String, String> paramap);

}
