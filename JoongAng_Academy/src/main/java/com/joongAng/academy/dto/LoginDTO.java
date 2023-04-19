package com.joongAng.academy.dto;

import lombok.Data;

@Data
public class LoginDTO { 
	private String USER_ID,PSWD, KORN_FLNM ,USER_NO, USER_GROUP_CD, PSWD_CHG_YN;
	private int count, PSWD_TEMPNUM, PSWD_ERR_NMTM;
}
