package com.joongAng.academy.dto;

import lombok.Data;

@Data
public class InstrDTO {
	private String INSTR_NO, USER_NO, KORN_FLNM, USER_BRDT, EML_ADDR, TELNO;
	
	//-- CODE_INFO 테이블
	private String CD, CD_NM;
	
	// -- ENDST_INFO 테이블
	private String ENDST_NO , ENDST_NM;
}


