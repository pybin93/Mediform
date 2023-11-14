package kr.or.ddit.nurse.vo;

import java.util.Date;

import lombok.Data;

//바이탈
@Data
public class VitalVO {
	
	private String vitalCd; //바이탈 구분 코드
	private int hghrkHhprs;// 최고 혈압
	private int lwtrkHhprs; // 최저혈압
	private double bdheat;     // 체온
	private Date vitalDate;  //작성일시 
	
	private String empNo;  //직원번호
	private String patntNo;   //환자번호

}


