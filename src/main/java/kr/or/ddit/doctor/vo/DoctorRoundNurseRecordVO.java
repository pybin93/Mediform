package kr.or.ddit.doctor.vo;

import java.util.Date;

import lombok.Data;

/**
 * 회진 시 사용할 NurseRecord
 * @author PC-20
 *
 */
@Data
public class DoctorRoundNurseRecordVO {
	private String nrsRcordCd;			// 간호기록코드
	private Date nrsRcordDe;			// 간호기록 작성일
	private String nrsRcordWrter;		// 간호기록 작성자 사번
	private String empNm;				// 작성자명
	private String nrsRcordCn;			// 인수인계내용
	private String nrsRcordMemo;		// 긴호기록내역
	private String clnicNo;				// 진료번호
	private String rceptNo;				// 접수번호
	private String patntNo;				// 환자번호
	private String patntNm;				// 환자명
}
