package com.joongAng.academy.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SMSRequestDTO {
	
	String type, contentType, countryCode, from, content;
	List<SMSDTO> messages;


}
