package com.joongAng.academy.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CrclmInfoDTO { 
	private String year, half, radioVal, crclmName;
	private String cyear, bgYMD, chalf, endYMD, ecost, econtent, instrName ,schedule, efnYN, insName, crName, ccd;
	private int cno, epeople;
	//private String schdlCode, schdlBegin, schdlEnd, schdlEx, schdlFin;
	//private List<rows> updateRow;
	private String schdlCode, schdlBegin, schdlEnd, schdlEx, schdlFin;
	
}

