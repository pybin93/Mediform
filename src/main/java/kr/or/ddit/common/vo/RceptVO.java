package kr.or.ddit.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RceptVO {

	private String rceptNo; // 접수번호
	private String patntNo; // 환자번호
	private String patntNm; // 환자이름
	private String patntRrno1; // 환자생년월일
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date rceptDt; // 접수일시
	private String rceptReason; // 내원사유
	private int rceptSttus; // 접수상태
	private String rceptPriort; // 우선순위 여부
	private String rceptClnc; // 진료실
	private String rceptClnicAt; // 진료여부
	
	
	
}
