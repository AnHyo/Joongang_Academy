package com.joongAng.academy.dto;

import lombok.Data;

@Data
public class StuSurveyDTO {
	private String student_ID, sbjctNo, cYear, cCd, cHalf, txnm, innm;
	private String DGSTFN_TITLE , DGSTFN_INTRO;
	
	/* APPL_DGSTFN_ITEM */
	private String SBJCT_NO, DGSTFN_CN, QITEM_CD, DGSTFN_ANS_N, DGSTFN_NM, CRCLM_YEAR, CRCLM_CD, CRCLM_HALF;
	private int DGSTFN_NO, SORT_SN;
	
	/* CODE_INFO */
	private String CD, CD_NM;
	
}
