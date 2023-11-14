package kr.or.ddit.nurse.controller;


import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.FileVO;
import kr.or.ddit.common.vo.HospitalizationVO;
import kr.or.ddit.doctor.vo.ClinicVO;
import kr.or.ddit.doctor.vo.MedicalExaminationOrderVO;
import kr.or.ddit.doctor.vo.PrescriptionOrderVO;
import kr.or.ddit.nurse.ServiceResult;
import kr.or.ddit.nurse.service.IRoomservice;
import kr.or.ddit.nurse.vo.IoVO;
import kr.or.ddit.nurse.vo.MealVO;
import kr.or.ddit.nurse.vo.NurseExaminationVO;
import kr.or.ddit.nurse.vo.NurseRecordVO;
import kr.or.ddit.nurse.vo.NurseTreatmentOrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_NURSE','ROLE_ADMIN','ROLE_DOCTOR','ROLE_THERAPIST')")
@RequestMapping(value="/mediform/nurse/room")
public class NurseRoomController {

	@Inject
	private IRoomservice roomservice;
	
	// 환자 차트 리스트 조회
	@ResponseBody
	@PostMapping(value="/patntClnic/list", produces = "application/json")
	public List<ClinicVO> patntClnicList(@RequestBody Map<String, String> map ) {
		log.info("patntClnicList() 실행...!");
		List<ClinicVO> patntClnic = roomservice.patntClnicList(map);
		log.info(">>>>>>>>>>>>>>>>allRecordList : " + patntClnic);

		return patntClnic;
	}
	
	// 환자 상세 조회
	@ResponseBody
	@RequestMapping(value = "/patientHospital/list" ,method = RequestMethod.POST)
	public HospitalizationVO patientHospitaldetail(String clnicNo) {
		log.info("patientHospitaldetail() 실행...!");
		
		HospitalizationVO patientdetail = roomservice.patientHospitaldetail(clnicNo);
		
		return patientdetail;
	}
	
	
	// 인수인계 리스트 조회
		@ResponseBody
		@PostMapping(value="/takeOver/list", produces = "application/json")
		public List<NurseRecordVO> recordTakeOverList(@RequestBody Map<String, String> map) {
			log.info("recordTakeOverList() 실행...!");
			List<NurseRecordVO> takeOverList = roomservice.selectTakeOverList(map);
			log.info(">>>>>>>>>>>>>>>>allRecordList : " + takeOverList);

			return takeOverList;
		}
	
		// 인수인계 등록
		@ResponseBody
		@PostMapping(value="/takeOver/insert", produces = "application/json")
		public int recordTakeOverinsert(@RequestBody NurseRecordVO nurseRecord) {
			log.info("recordTakeOverinsert() 실행...!");

			return roomservice.takeOverinsert(nurseRecord);
		}
		
		//치료내용 조회
		@ResponseBody
		@PostMapping(value = "/treatment/list", produces = "application/json")
		public List<NurseTreatmentOrderVO> TreatmentList(@RequestBody Map<String, String> map ){
			log.info("TreatmentList() 실행...!");
			List<NurseTreatmentOrderVO> treatmentList = roomservice.selectTreatmentList(map);
			log.info("treatmentList>>>>>>>>>>ddd???????"+ treatmentList.size());
			return treatmentList;
		}
		
		//접수날짜에 따른 치료 내용 조회
		@ResponseBody
		@PostMapping(value = "/rceptDt/list", produces = "application/json")
		public List<NurseTreatmentOrderVO> DTTreatmentList(@RequestBody Map<String, Object> map ){
			log.info("mealList() 실행...!");
			List<NurseTreatmentOrderVO> dtTreatmentList = roomservice.detailTreatmentList(map);
			return dtTreatmentList;
		}
		
		//환자 검사 조회
		@ResponseBody
		@PostMapping(value = "/examination/list", produces = "application/json")
		public List<NurseExaminationVO> ExaminationList(@RequestBody Map<String, Object> map ){
			log.info("mealList() 실행...!");
			List<NurseExaminationVO> examinationList = roomservice.selectExaminationList(map);
			return examinationList;
		}
		
		//식이 조회
		@ResponseBody
		@PostMapping(value = "/meal/list", produces = "application/json")
		public List<MealVO> mealList(@RequestBody Map<String, String> map ){
			log.info("mealList() 실행...!");
			List<MealVO> mealList = roomservice.mealList(map);
			return mealList;
		}
		
		//IO 조회
		@ResponseBody
		@PostMapping(value = "/io/list", produces = "application/json")
		public List<IoVO> ioList(@RequestBody Map<String, String> map ){
			log.info("ioList() 실행...!");
			List<IoVO> ioList = roomservice.IoList(map);
			return ioList;
		}
		
		// meal 등록
		@ResponseBody
		@PostMapping(value="/meal/insert", produces = "application/json")
		public int mealInsert(@RequestBody MealVO meal) {
			log.info("mealInsert() 실행...!");

			return roomservice.mealInsert(meal);
		}
		
		// IO 등록
		@ResponseBody
		@RequestMapping(value="/io/insert",method = RequestMethod.POST, produces = "application/json")
		public int ioInsert(@RequestBody IoVO io) {
			log.info("ioInsert() 실행...!");

			return roomservice.ioInsert(io);
		}
		
		//간호기록 insert(ajax)
		@ResponseBody
		@RequestMapping(value="/nrecord/insert", method = RequestMethod.POST)
		public List<NurseRecordVO> nrecordInsert(@RequestBody  Map<String, String> map) {
			
			ServiceResult result = roomservice.nrecordInsert(map);
			
			if(result.equals(ServiceResult.OK)) {
				log.info("간호사 기록 인서트 성공~");
			} else {
				log.info("간호사 기록 인서트 실패");
				
			}
			
			List<NurseRecordVO> nrecordList = null;
			
			return nrecordList;
		}
		
		//입원환자 처방 조회 (ajax)
		@ResponseBody
		@RequestMapping(value= "/pres/list", produces = "application/json" )
		public List<PrescriptionOrderVO> presList(@RequestBody Map<String, String> map ){
			log.info("presList() 실행...!");
			List<PrescriptionOrderVO> presList = roomservice.selectpresList(map);
			return presList;
		}
		
		
		//입원환자 검사 조회 (ajax)
		@ResponseBody
		@RequestMapping(value= "/exam/list", produces = "application/json" )
		public List<MedicalExaminationOrderVO> examList(@RequestBody Map<String, String> map ){
			log.info("examList() 실행...!");
			List<MedicalExaminationOrderVO> examList = roomservice.selectexamList(map);
			return examList;
		}
		
		// xray 파일 조회
		@ResponseBody
		@RequestMapping(value="/filemaster/select")
		public List<FileVO> fileList(
									@RequestBody Map<String, String> map
									){
			
			log.info("fileList() 실행!!!");
			
			List<FileVO> fileList = roomservice.fileList(map);
			
			
			return fileList;
		}
		
		
		
}
