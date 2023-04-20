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
		
		public List<Map<String, Object>> list(String code_search) {
			return codeDAO.list(code_search);
		}

		public List<Map<String, Object>> detaillist(String CD_CLSFValue) {
			return codeDAO.detaillist(CD_CLSFValue);
		}

		public int code_create(Map<String, Object> map) {
			return codeDAO.code_create(map);
		}

		public boolean isCodeExist(Map<String, Object> map) {
			return codeDAO.isCodeExist(map);
		}

		public boolean isCodeExist2(List<Map<String, Object>> updateData) {
			return codeDAO.isCodeExist2(updateData);
		}

		public int code_update(List<Map<String, Object>> updateData) {
			return codeDAO.code_update(updateData);
		}

		public int code_delete(List<Map<String, Object>> deleteData) {
			return codeDAO.code_delete(deleteData);
		}


}
