package kr.or.ddit.patient.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.administration.vo.POAdminVO;
import kr.or.ddit.common.vo.PaginationInfoVO;
import kr.or.ddit.mapper.patient.PatientMapper;
import kr.or.ddit.patient.ServiceResult;
import kr.or.ddit.patient.service.IPatientService;
import kr.or.ddit.patient.vo.PatientVO;

@Service
public class PatientImpl implements IPatientService{

	@Inject
	private PatientMapper patientMapper;

	@Override
	public List<PatientVO> selectPatientList() {
		return patientMapper.selectPatientList();
	}

	// 환자 리스트 ajax
	@Override
	public List<PatientVO> patientSearch(Map<String, String> map) {
		return patientMapper.patientSearch(map);
	}
	// 환자 리스트 ajax
	@Override
	public List<PatientVO> patientHsptlzListSearch(Map<String, String> map) {
		return patientMapper.patientHsptlzListSearch(map);
	}
	
	// 입원환자 리스트 ajax
	@Override
	public List<PatientVO> selectHsptlzList() {
		return patientMapper.selectHsptlzList();
	}

	// 환자 조회 ajax
	@Override
	public PatientVO selectPatient(Map<String, String> map) {
		return patientMapper.selectPatient(map);
	}

	// 신규 환자 등록
	@Override
	public ServiceResult patientInsert(PatientVO patientVO) {
		ServiceResult result = null;
		
		int status = patientMapper.patientInsert(patientVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	// 환자 상세 정보
	@Override
	public PatientVO selectPatientOne(String patntNo) {
		return patientMapper.selectPatientOne(patntNo);
	}
	
	// 환자 정보 수정
	@Override
	public ServiceResult patientUpdate(PatientVO patientVO) {
		ServiceResult result = null;
		
		int status = patientMapper.patientUpdate(patientVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	// 페이징 카운트
	@Override
	public int selectPatientCount(PaginationInfoVO<PatientVO> pagingVO) {
		return patientMapper.selectPatientCout(pagingVO);
	}

	// 페이징 환자 list 조회
	@Override
	public List<PatientVO> selectPatientPagingList(PaginationInfoVO<PatientVO> pagingVO) {
		return patientMapper.selectPatientPagingList(pagingVO);
	}

	// 페이징 환자 list 조회, 필터링
	@Override
	public List<PatientVO> selectPatientPagingList(PaginationInfoVO<PatientVO> pagingVO, List<String> checkFilter) {
		return patientMapper.selectPatientPagingList(pagingVO, checkFilter);
	}

	//차트번호에 따른 환자상세조회
	@Override
	public PatientVO clnicPatientList(String clnicNo) {
		return patientMapper.clnicPatientList(clnicNo);
	}

	//진료 차트에 따른 약 리스트
	@Override
	public List<POAdminVO> pOPatientList(Map<String, String> map) {
		return patientMapper.pOPatientList(map);
	}
	
	
}
