package com.joongAng.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongAng.academy.dao.CodeDAO;

@Service
public class CodeService {

		@Autowired
		private CodeDAO codeDAO;
		
		public List<Map<String, Object>> list() {
			return codeDAO.list();
		}

		public List<Map<String, Object>> detaillist() {
			return codeDAO.detaillist();
		}

}
