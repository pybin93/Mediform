package kr.or.ddit.therapist.service;

import java.util.List;

import kr.or.ddit.common.vo.RceptVO;
import kr.or.ddit.therapist.vo.MedicalTreatmentRecordVO;
import kr.or.ddit.therapist.vo.OccupationalTherapyVO;
import kr.or.ddit.therapist.vo.PhysicalClinicRoomVO;
import kr.or.ddit.therapist.vo.TherapistPatientVO;

public interface ITherapistIReceiptService {

	List<RceptVO> waitingList();

	List<PhysicalClinicRoomVO> roomList();

	TherapistPatientVO getPatient(String rceptNo);

	List<MedicalTreatmentRecordVO> medicalTreatmentRecordList(String rceptNo);

	int medicalTreatmentRecordUpdate(MedicalTreatmentRecordVO mtrVO);

	int physicalClinicRoomRegistration(PhysicalClinicRoomVO roomVO);

	int rceptSttusUpdate(PhysicalClinicRoomVO roomVO);

	int updateRceptSttusCp(PhysicalClinicRoomVO roomVO);

	int updateRceptSttusOt(PhysicalClinicRoomVO roomVO);

	int therapyRoomRoomRegistration(PhysicalClinicRoomVO roomVO);

	int rceptTherapySttusUpdate(PhysicalClinicRoomVO roomVO);

	List<OccupationalTherapyVO> therapyingList();

	int ocMedicalTreatmentRecordUpdate(PhysicalClinicRoomVO roomVO);

	int updateReceptSttusOc(PhysicalClinicRoomVO roomVO);

	int deletePcr(PhysicalClinicRoomVO roomVO);

	int mtrCheck(PhysicalClinicRoomVO roomVO);



}
