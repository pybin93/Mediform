package kr.or.ddit.patient.vo;

import java.util.Date;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class PatientVO {

	private String patntNo;			// 환자번호
	private String patntNm;			// 환자명
	
	@Size(max = 6)
	private int patntRrno1;			// 주민등록번호 앞자리
	@Size(max = 7)
	private int patntRrno2;			// 주민등록번호 뒷자리
	
	@Pattern(regexp = "^\\d{2,3}\\d{3,4}\\d{4}$", message = "정확한 핸드폰 번호를 입력하세요.")
	private String patntTelno;		// 환자 핸드폰 번호
	
	@Size(max = 5)
	private int patntZip;			// 우편번호
	private String patntAdres1;		// 주소1
	private String patntAdres2;		// 주소2
	private int patntAge;			// 환자 만 나이
	private String patntSexdstn;	// 환자 성별
	
	@Size(max = 3)
	private int patntHeight;		// 환자 키
	
	@Size(max = 3)
	private int patntBdwgh;			// 환자 몸무게
	private String patntBdp;		// 환자 혈액형
	private String patntHlthinsAt;	// 건강보험 유무
	private String patntHsptlzAt;	// 입원여부
	
	private String prtctorNm;		// 보호자 이름
	
	@Pattern(regexp = "^\\d{2,3}\\d{3,4}\\d{4}$", message = "정확한 핸드폰 번호를 입력하세요.")
	private String prtctorTelno;	// 보호자 핸드폰 번호
	private String patntAgre;		// 개인정보 동의
	
	private String patntMemo;		// 메모사항
	
	// 필터조건
	private boolean filterFlag;		// 필터 적용 유무
	private String filter1;			// 입원
	private String filter2;			// 외래
	private String filter3;			// 남자
	private String filter4;			// 여자
	private String filter5;			// 보험 유
	private String filter6;			// 보험 무
	
	//진료번호에 따른 환자 조회시
	private String clnicNo;
	private String empNo; 
	private String empNm;
	private String empDoctrLcnsNo;
	private Date hsptlzDe;
	private Date realLhstl;
}
