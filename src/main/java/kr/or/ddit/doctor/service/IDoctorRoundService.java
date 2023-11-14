package kr.or.ddit.doctor.service;

import java.util.List;

import kr.or.ddit.doctor.vo.DoctorRoundClinicVO;
import kr.or.ddit.doctor.vo.DoctorRoundInpatientRecordVO;
import kr.or.ddit.doctor.vo.DoctorRoundMedicalExamOrderVO;
import kr.or.ddit.doctor.vo.DoctorRoundNurseRecordVO;
import kr.or.ddit.doctor.vo.DoctorRoundOtptRecordVO;
import kr.or.ddit.doctor.vo.DoctorRoundPrescriptionOrderVO;
import kr.or.ddit.doctor.vo.DoctorRoundSickAndWoundedVO;
import kr.or.ddit.doctor.vo.DoctorRoundVO;
import kr.or.ddit.nurse.vo.VitalVO;
import kr.or.ddit.patient.vo.PatientVO;

public interface IDoctorRoundService {

	/**
	 * 회진 내역 날짜 List
	 * @return
	 */
	public List<DoctorRoundInpatientRecordVO> getInpatientRecordDateList(DoctorRoundVO roundVO);

	/**
	 * 진료 내역 날짜 List
	 * @return
	 */
	public List<DoctorRoundClinicVO> getClinicDateList(DoctorRoundVO roundVO);

	/**
	 * 치료기록지 날짜 List
	 * @return
	 */
	public List<DoctorRoundOtptRecordVO> getOtptRecordDateList(DoctorRoundVO roundVO);

	/**
	 * 간호기록지 날짜 List
	 * @return
	 */
	public List<DoctorRoundNurseRecordVO> getNurseRecordDateList(DoctorRoundVO roundVO);

	/**
	 * 진료 내역 상세 조회
	 * @param clinicVO
	 * @return
	 */
	public DoctorRoundClinicVO getClinicVO(DoctorRoundClinicVO clinicVO);

	/**
	 * 진료 내역 출력시 첨부할 상병 목록
	 * @param clinicVO
	 * @return
	 */
	public List<DoctorRoundSickAndWoundedVO> roundSickAndWoundedList(DoctorRoundClinicVO clinicVO);

	/**
	 * 진료 내역 출력시 첨부할 처방 오더
	 * @param clinicVO
	 * @return
	 */
	public List<DoctorRoundPrescriptionOrderVO> prescriptionOrderList(DoctorRoundClinicVO clinicVO);

	/**
	 * 회진 기록 등록
	 * @param inpatientRecordVO
	 * @return
	 */
	public int insertRound(DoctorRoundInpatientRecordVO inpatientRecordVO);

	/**
	 * 회진 내역 상세 조회
	 * @param inpatientRecordVO
	 * @return
	 */
	public DoctorRoundInpatientRecordVO getInpatientRecord(DoctorRoundInpatientRecordVO inpatientRecordVO);

	/**
	 * NurseRecord 상세 조회
	 * @return nurseRecordVO
	 */
	public DoctorRoundNurseRecordVO getNurseRecord(DoctorRoundNurseRecordVO nurseRecordVO);

	/**
	 * 치료기록지 상세 조회
	 * @param otptRecordVO
	 * @return
	 */
	public DoctorRoundOtptRecordVO getOtptRecord(DoctorRoundOtptRecordVO otptRecordVO);

	/**
	 * 입원날짜 조회
	 * @param roundVO
	 * @return
	 */
	public DoctorRoundVO doctorRoundDate(DoctorRoundVO roundVO);

	/**
	 * 환자 정보 조회
	 * @param roundVO
	 * @return
	 */
	public PatientVO doctorRoundPatient(DoctorRoundVO roundVO);

	/**
	 * 환자 바이탈 정보 조회
	 * @param roundVO
	 * @return
	 */
	public VitalVO doctorRoundPatientVital(DoctorRoundVO roundVO);

	/**
	 * 환자 검사 내역 조회
	 * @param clinicVO
	 * @return
	 */
	public List<DoctorRoundMedicalExamOrderVO> medicalExamOrderList(DoctorRoundClinicVO clinicVO);

}
