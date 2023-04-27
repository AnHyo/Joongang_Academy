package com.joongAng.academy.dto;

import lombok.Data;

@Data
public class StudentAllInfoDTO {
	private String CD, CD_NM;
	
	private String REG_CD_NAME, CRCLM_CD_NAME, CRCLM_CD, CRCLM_YEAR, CRCLM_HALF_NAME, CRCLM_HALF, APPL_NO, KORN_FLNM, KORN_FLNM_S,
				   USER_BRDT, GENDER_CD_NAME, GENDER_CD, EML_ADDR, TELNO, REL_TELNO, REL_CD_NAME, REL_CD, ZIP, ADDR, FNL_PASS_YN, REG_CD, USER_NO;
	
	private int AGE;
	
	private String student_ID, STDNT_NO, SBJCT_NO, SBJCT_NM, ESNTL_YN, CLASSTM, ROOM_NM,ESNTL_TYPE;

}

