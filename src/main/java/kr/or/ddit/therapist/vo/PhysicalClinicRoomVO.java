package kr.or.ddit.therapist.vo;

import lombok.Data;

@Data
public class PhysicalClinicRoomVO {
	private int physicalSckrm;		// 방번호
	private String physicalSttus;	// 사용여부
	private String patntNo;			// 환자번호
	private String patntNm;			// 환자명
	private String patntRrno1;		// 생년월일
	
	private String rceptNo; // 접수번호
	private String rceptClnc; // 작업치료실 번호
	private String mdlrtCurer; // 치료사
	private String empNm; // 직원이름
	
	
}
