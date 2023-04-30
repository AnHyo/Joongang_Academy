package com.joongAng.academy.dto;

import lombok.Data;

@Data
public class SurveyDTO {
	
	private String CRCLM_CD, CRCLM_YEAR , CRCLM_HALF, SBJCT_NO, APPL_NO,
	DGSTFN_NO, CHC_ANS_CD, EXPR_ANS, DGSTFN_YMD, DGSTFN_SDATE, DGSTFN_FDATE,
	DGSTFN_TITLE, DGSTFN_CN, QITEM_CD, SORT_SN, CRCLM_NM, survey_search,
	DGSTFN_OP_YN, DGSTFN_INTRO;
	;  
	
	private String s_CRCLM_YEAR, s_CRCLM_HALF, s_SBJCT_NM, s_CRCLM_CD;
}
