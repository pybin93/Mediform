package kr.or.ddit.common.vo;

import java.util.Date;

import lombok.Data;

// 입퇴원 VO
@Data
public class HospitalizationVO {

	private String hsptlzCd;	// 입원 코드(기본키)
	private String clnicNo;     // 진료 번호(식별)
	private String rceptNo;     // 접수 번호(식별)
	private String patntNo;     // 환자 번호(식별)
	private int hsptlzSckrm;    // 배정 병실(NotNull)
	private String hsptlzSckbd;    // 배정 병상(NotNull)
	private Date hsptlzDe;      // 입원 날짜(NotNull)
	private Date prarndeLhstl;  // 예정 퇴원날짜(NotNull)
	private Date realLhstl;     // 실제 퇴원일(Null)
	private String patntIdntfc; // 환자 식별 바코드(NotNull)
	
	private String empNm;       //담당의사 이름을 가져오기 위해
	private String patntNm;       //수진자명 이름을 가져오기 위해
}
