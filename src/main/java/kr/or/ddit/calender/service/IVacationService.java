package kr.or.ddit.calender.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.calender.vo.VacationVO;
import kr.or.ddit.common.ServiceResult;

public interface IVacationService {

	// 캘린더 리스트
	public List<VacationVO> vacationMapList();

	// 휴가 신청
	public ServiceResult vacationInsert(VacationVO vacationVO);
	
	// 직원 상세
	public List<VacationVO> vacationDetailEmp(String searchEmpWord);

	// 휴가 상세 정보 조회
	public List<VacationVO> vacationDetail(VacationVO vacationVO);

	// 휴가 1차 승인
	public ServiceResult vacationUpdate(Map<String, String> map);

	// 휴가 최종 승인
	public ServiceResult vacationUpdateLast(Map<String, String> map);
	
	// 휴가 반려
	public ServiceResult vacationUpdateReject(Map<String, String> map);
	
	// 휴가 리스트
	public List<VacationVO> selectVacationList(VacationVO vacationVO);

	// 휴가 신청 리스트 조회
	public List<VacationVO> selectSignupList(VacationVO vacationVO);

	// 휴가 승인 리스트 조회
	public List<VacationVO> selectApprovalList(VacationVO vacationVO);

	// 휴가 반려 리스트 조회
	public List<VacationVO> selectRejectList(VacationVO vacationVO);
	
	
}
