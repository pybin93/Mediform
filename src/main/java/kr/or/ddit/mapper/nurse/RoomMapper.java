package kr.or.ddit.mapper.nurse;


import java.util.List;
import java.util.Map;

import kr.or.ddit.common.vo.FileVO;
import kr.or.ddit.common.vo.HospitalizationVO;
import kr.or.ddit.doctor.vo.ClinicVO;
import kr.or.ddit.doctor.vo.MedicalExaminationOrderVO;
import kr.or.ddit.doctor.vo.PrescriptionOrderVO;
import kr.or.ddit.nurse.ServiceResult;
import kr.or.ddit.nurse.vo.IoVO;
import kr.or.ddit.nurse.vo.MealVO;
import kr.or.ddit.nurse.vo.NurseExaminationVO;
import kr.or.ddit.nurse.vo.NurseRecordVO;
import kr.or.ddit.nurse.vo.NurseTreatmentOrderVO;


public interface RoomMapper {

	public HospitalizationVO patientHospitaldetail(String clnicNo);

	public List<NurseRecordVO> selectTakeOverList(Map<String, String> map);

	public int takeOverinsert(NurseRecordVO nurseRecord);

	public List<MealVO> selectmealList(Map<String, String> map);

	public List<IoVO> selectIoList(Map<String, String> map);

	public int mealInsert(MealVO meal);

	public int ioInsert(IoVO io);

	public List<ClinicVO> patntClnicList(Map<String, String> map);

	public List<NurseTreatmentOrderVO> selectTreatmentList(Map<String, String> map);

	public List<NurseTreatmentOrderVO> detailTreatmentList(Map<String, Object> map);

	public List<NurseExaminationVO> selectExaminationList(Map<String, Object> map);

	public int nrecordInsert(Map<String, String> map);

	public List<PrescriptionOrderVO> selectpresList(Map<String, String> map);

	public List<MedicalExaminationOrderVO> selectexamList(Map<String, String> map);

	public void mealpayInset(MealVO meal);

	public List<FileVO> fileList(Map<String, String> map);



}
