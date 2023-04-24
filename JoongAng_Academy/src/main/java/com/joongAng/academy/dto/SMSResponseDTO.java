package com.joongAng.academy.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SMSResponseDTO {

	String requestId;
	LocalDateTime requestTime;
	String statusCode;
	String statusName;
	int smsConfirmNum;

}
