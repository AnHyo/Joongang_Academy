package com.joongAng.academy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.LoginDAO;
import com.joongAng.academy.dto.LoginDTO;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;

	
	public LoginDTO login(Map<String, Object> paramap) {
		return loginDAO.login(paramap);
	}
	public LoginDTO loginCK(Map<String, Object> paramap) {
		return loginDAO.loginCK(paramap);
	}

	public void loginTry( Map<String, Object> paramap) {
		loginDAO.loginTry(paramap);
	}

	public int ckid(String ckid) {
		return loginDAO.ckid(ckid);
	}

	public int ckTemp(Map<String, Object> paramap) {
		return loginDAO.ckTemp(paramap);
	}

	public int updatePW(Map<String, Object> paramap) {
		return loginDAO.updatePW(paramap);
	}

	




}
