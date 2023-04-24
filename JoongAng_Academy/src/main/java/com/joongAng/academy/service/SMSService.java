package com.joongAng.academy.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.joongAng.academy.dao.SMSDAO;
import com.joongAng.academy.dto.SMSDTO;
import com.joongAng.academy.dto.SMSRequestDTO;
import com.joongAng.academy.dto.SMSResponseDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@PropertySource("classpath:application.properties")
@Slf4j
@RequiredArgsConstructor
@Service
public class SMSService {
	   @Autowired
		private SMSDAO smsDAO;
	   
	   //휴대폰 인증 번호
	    private final String smsConfirmNum = createSmsKey();
	   

		@Value("${naver-cloud-sms.accessKey}")
		private String accessKey;
		
		@Value("${naver-cloud-sms.secretKey}")
		private String secretKey;
		
		@Value("${naver-cloud-sms.serviceId}")
		private String serviceId;
	 
		@Value("${naver-cloud-sms.senderPhone}")
		private String phone;
    
    
    public String getSignature(Long time) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeyException {
        String space = " ";
        String newLine = "\n";
        String method = "POST";
        String url = "/sms/v2/services/"+ this.serviceId+"/messages";
        String accessKey = this.accessKey;
        String secretKey = this.secretKey;

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(time)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        String encodeBase64String = Base64.encodeBase64String(rawHmac);

        return encodeBase64String;
    }
  
 

	public int checkUser(Map<String, String> paramap) {
		return smsDAO.checkUser(paramap);
	}
	
	
	public SMSResponseDTO sendSms(SMSDTO smsDTO, Map<String, String> paramap) throws InvalidKeyException, NoSuchAlgorithmException, UnsupportedEncodingException, JsonProcessingException, RestClientException, URISyntaxException {
		Long time = System.currentTimeMillis();
		
		org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
		headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
		headers.set("x-ncp-apigw-timestamp", time.toString());
		headers.set("x-ncp-iam-access-key", accessKey);
		headers.set("x-ncp-apigw-signature-v2", getSignature(time));
		
		List<SMSDTO> messages = new ArrayList<>();
		messages.add(smsDTO);
		
		SMSRequestDTO request = SMSRequestDTO.builder()
				.type("SMS")
				.contentType("COMM")
				.countryCode("82")
				.from(phone)
				.content("[중앙정보처리학원] 인증번호 [" + smsConfirmNum + "]를 입력해주세요.")
				.messages(messages)
				.build();
		
		ObjectMapper objectMapper = new ObjectMapper();
		String body = objectMapper.writeValueAsString(request);
		HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
		
		RestTemplate restTemplate = new RestTemplate();
	    restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
	    SMSResponseDTO response = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+ serviceId +"/messages"), httpBody, SMSResponseDTO.class);
	    
	    paramap.put("tempno", smsConfirmNum);
	    smsDAO.saveTmepNo(paramap);
	    return response;	
	}
    // 인증코드 만들기
    public static String createSmsKey() {
        StringBuffer key = new StringBuffer();
        Random rnd = new Random();

        for (int i = 0; i < 6; i++) { // 인증코드 6자리
            key.append((rnd.nextInt(10)));
        }
        return key.toString();
    }

    
    
}

