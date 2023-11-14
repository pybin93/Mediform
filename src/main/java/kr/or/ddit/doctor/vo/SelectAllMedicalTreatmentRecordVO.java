package kr.or.ddit.doctor.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

// 치료 오더 전처방 조회용
@Data
public class SelectAllMedicalTreatmentRecordVO {
	
	private String clnicNo;		// 진료 번호(식별)  
	private String rceptNo;		// 접수 번호(식별)   
	private String mdlrtCd;     // 치료 코드(식별)  
	private String mdlrtrdCd;	// 치료오더 코드(기본키)
	private String mdlrtCurer;	// 치료사(Null)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Date mdlrtDt;		// 치료 시간(Null)
	private String bodyCd;		// 환부 코드(비식별)(Null)
	
	// 진료에서 받아온 치료코드 리스트
	private List<String> mdlrtCdList;
	
	// 물리치료 가격 합
	private int mmTotalPrice;
	// 도수치료 가격 합
	private int zzTotalPrice;

	private String mdlrtNm;	 // 치료명(NotNull)
	private int mdlrtAmount; // 치료 금액(NotNull)
	private String mllwncAt; // 급여 유무(NotNull)('N')
	private String mdlrtCl;	 // 물리/작업 구분(NotNull)
	
	private String mdlrtNmList; // 치료명 리스트
	private String mdlrtAmountList; // 치료금액 리스트
	private String mdlrtClList; // 물리/작업 구분 리스트
}
