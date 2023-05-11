package com.joongAng.academy.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.joongAng.academy.dto.LoginDTO;

@Repository
@Mapper
public interface LoginDAO {


	public void loginTry(Map<String, Object> paramap);


	public LoginDTO login(Map<String, Object> paramap);


	public int ckid(String ckid);


	public int ckTemp(Map<String, Object> paramap);


	public int updatePW(Map<String, Object> paramap);


	public LoginDTO loginCK(Map<String, Object> paramap);


}
