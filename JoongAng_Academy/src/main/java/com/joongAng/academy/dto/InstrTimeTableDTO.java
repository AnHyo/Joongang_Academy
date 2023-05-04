package com.joongAng.academy.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class InstrTimeTableDTO { 
	private String instrNo, selectHalf, inputYear, sbjctNo;
	private String INSTR_NO, INSTR_NM, CRCLM_YEAR, CRCLM_HALF, SBJCT_NM, DAYS, BGNGt, ENDt, ROOM_NM;
	private String STDNT_NO, KORN_FLNM, USER_BRDT, GENDER_CD, EML_ADDR, TELNO, REG_CD, SBJCT_NO;
}

