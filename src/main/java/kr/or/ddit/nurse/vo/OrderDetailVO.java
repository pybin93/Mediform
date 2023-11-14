package kr.or.ddit.nurse.vo;

import lombok.Data;

@Data
public class OrderDetailVO {

	private String podetailCd;
	private String porderCd;
	private String podetailNm;
	private String podetailMfbiz;
	private String podetailUnit;
	private int podetailAmount;
	private int podetailTotal;
	private String podetailMemo;
	
	private String medcinCd;
}
