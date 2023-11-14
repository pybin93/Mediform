package kr.or.ddit.doctor.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.administration.service.IHospitalizationService;
import kr.or.ddit.common.vo.SickbedVO;
import kr.or.ddit.doctor.service.IDoctorRoundService;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasRole('ROLE_DOCTOR')")
@RequestMapping("/mediform/doctor/round")
public class DoctorWardRoundController {

	// 입원 환자 관련 service
	@Inject
	private IHospitalizationService hospitalization;
	
	// 회진 관련 service
	@Inject
	private IDoctorRoundService roundService;
	
	@RequestMapping(value="/main")
	public String doctorWardRoundMain(Model model) {
		
		List<SickbedVO> sickbedList = hospitalization.selectSickbedList();
		model.addAttribute("sickbedList", sickbedList);
		model.addAttribute("menuSelected", "round");
		
		log.info("병상 수 : " + sickbedList.size());
		for(SickbedVO sickbedVO : sickbedList) {
			log.info("병상 번호 : " + sickbedVO.getSckbdNo());
		}
		
		return "doctor/roundMain";
	}
	
	@PostMapping(value="/patient/detail")
	public ResponseEntity<DoctorRoundVO> getPatientList(@RequestBody DoctorRoundVO roundVO){
		
		// 회진 내역 날짜 List
		List<DoctorRoundInpatientRecordVO> inpatientRecordList = roundService.getInpatientRecordDateList(roundVO);
		
		// 진료 내역 날짜 List
		// 진료 일시와 진료번호만 가져옴
		List<DoctorRoundClinicVO> clinicList = roundService.getClinicDateList(roundVO);
		
		// 치료기록지 날짜 List
		List<DoctorRoundOtptRecordVO> otptRecordList = roundService.getOtptRecordDateList(roundVO);
		
		// 간호기록지 날짜 List
		List<DoctorRoundNurseRecordVO> nurseRecordList = roundService.getNurseRecordDateList(roundVO);
		
		DoctorRoundVO roundDateVO = roundService.doctorRoundDate(roundVO);
		
		PatientVO patient = roundService.doctorRoundPatient(roundVO);
		VitalVO vital = roundService.doctorRoundPatientVital(roundVO);
		
		DoctorRoundVO responseRoundVO = new DoctorRoundVO();
		responseRoundVO.setInpatientRecordList(inpatientRecordList);
		responseRoundVO.setClinicList(clinicList);
		responseRoundVO.setOtptRecordList(otptRecordList);
		responseRoundVO.setNurseRecordList(nurseRecordList);
		responseRoundVO.setHsptlzDe(roundDateVO.getHsptlzDe());
		responseRoundVO.setPrarndeLhstl(roundDateVO.getPrarndeLhstl());
		responseRoundVO.setPatientVO(patient);
		responseRoundVO.setVitalVO(vital);
		
		return new ResponseEntity<DoctorRoundVO>(responseRoundVO, HttpStatus.OK);
	}
	
	@PostMapping(value="/clinic/detail")
	public ResponseEntity<DoctorRoundClinicVO> getClinic(@RequestBody DoctorRoundClinicVO clinicVO){
		
		
//		log.info("clinicVO.getClnicNo() : " + clinicVO.getClnicNo());
		
		DoctorRoundClinicVO responseClinicVO = roundService.getClinicVO(clinicVO);
		List<DoctorRoundSickAndWoundedVO> roundSickAndWoundedList = roundService.roundSickAndWoundedList(clinicVO);
		List<DoctorRoundPrescriptionOrderVO> prescriptionOrderList = roundService.prescriptionOrderList(clinicVO);
		List<DoctorRoundMedicalExamOrderVO> medicalExamOrderList = roundService.medicalExamOrderList(clinicVO);
		
		responseClinicVO.setRoundSickAndWoundedList(roundSickAndWoundedList);
		responseClinicVO.setPrescriptionOrderList(prescriptionOrderList);
		responseClinicVO.setMedicalExamOrderList(medicalExamOrderList);
		
		return new ResponseEntity<DoctorRoundClinicVO>(responseClinicVO, HttpStatus.OK);
	}
	
	@PostMapping(value="/inpatientRecord/detail")
	public ResponseEntity<DoctorRoundInpatientRecordVO> getInpatientRecord(@RequestBody DoctorRoundInpatientRecordVO inpatientRecordVO){
		
//		log.info("getInptntNo : " + inpatientRecordVO.getInptntNo());
		DoctorRoundInpatientRecordVO responseInpatientRecordVO = roundService.getInpatientRecord(inpatientRecordVO);
		
		return new ResponseEntity<DoctorRoundInpatientRecordVO>(responseInpatientRecordVO, HttpStatus.OK);
	}
	
	@PostMapping(value="/nurseRecord/detail")
	public ResponseEntity<DoctorRoundNurseRecordVO> getNurseRecord(@RequestBody DoctorRoundNurseRecordVO nurseRecordVO){
		
		log.info("getNrsRcordCd : " + nurseRecordVO.getNrsRcordCd());
		DoctorRoundNurseRecordVO responseNurseRecord = roundService.getNurseRecord(nurseRecordVO);
		
		return new ResponseEntity<DoctorRoundNurseRecordVO>(responseNurseRecord, HttpStatus.OK);
	}
	
	@PostMapping(value="/otptRecord/detail")
	public ResponseEntity<DoctorRoundOtptRecordVO> getOtptRecord(@RequestBody DoctorRoundOtptRecordVO otptRecordVO){
		
		log.info("getOtptCd() : " + otptRecordVO.getOtptCd());
		DoctorRoundOtptRecordVO responseOtptRecord = roundService.getOtptRecord(otptRecordVO);
		
		return new ResponseEntity<DoctorRoundOtptRecordVO>(responseOtptRecord, HttpStatus.OK);
	}
	
	@PostMapping(value="/insert")
	public String insertRound(DoctorRoundInpatientRecordVO inpatientRecordVO, RedirectAttributes ra) {
		
		log.info("getHsptlzCd : " + inpatientRecordVO.getHsptlzCd());
		log.info("getDoctrEmpno : " + inpatientRecordVO.getDoctrEmpno());
		log.info("getInptntRcord : " + inpatientRecordVO.getInptntRcord());
		 
		int cnt = roundService.insertRound(inpatientRecordVO);
		String msg = "";
		if(cnt > 0) {
			msg = "y";
		}else {
			msg = "n";
		}
		
		ra.addFlashAttribute("msg", msg);
		return "redirect:/mediform/doctor/round/main";
	}
}
