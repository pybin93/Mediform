package kr.or.ddit.doctor.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 회진 진료 내역 출력 VO
 * @author PC-20
 *
 */
@Data
public class DoctorRoundClinicVO {

	// 진료 내역
	private String clnicNo;					// 진료번호
	private String rceptNo;					// 접수번호
	private String patntNo;					// 환자번호
	private String patntNm;					// 환자명
	private String patntSexdstn;			// 성별
	private String patntAge;				// 나이
	private String empNo;					// 담당의사사번
	private String empNm;					// 담당의사명
	private Date clnicTime;					// 진료일시
	private String clnicCn;					// 진단내역
	private String clnicAt;					// 진료여부
	private String beforeClnicNo;			// 이전 진료 번호
	private String hsptlzAt;				// 입원 여부
	private String clnicMemo;				// 메모사항
	private Date atfssDt;					// 발병일
	private int clnicFe;					// 진료비
	
	// 입원 내역
	private String hsptlzCd;				// 입원코드
	private String hsptlzSckrm;				// 배정병실
	private String hsptlzSckbd;				// 배정병상
	private Date hsptlzDe;					// 입원날짜
	private Date prarndeLhstl;				// 예정 퇴원 일시
	private Date realLhstl;					// 실 퇴원일
	
	// 상병 목록
	private List<DoctorRoundSickAndWoundedVO> roundSickAndWoundedList;
	
	// 처방 오더 목록
	private List<DoctorRoundPrescriptionOrderVO> prescriptionOrderList;
	
	// 검사 오더 목록
	private List<DoctorRoundMedicalExamOrderVO> medicalExamOrderList;
	
}
