package kr.or.ddit.nurse.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.administration.service.IRceptService;
import kr.or.ddit.administration.vo.POAdminVO;
import kr.or.ddit.common.service.IAlarmService;
import kr.or.ddit.common.vo.AlarmVO;
import kr.or.ddit.common.vo.PaginationInfoVO;
import kr.or.ddit.common.vo.RceptVO;
import kr.or.ddit.patient.ServiceResult;
import kr.or.ddit.patient.service.IPatientService;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_NURSE','ROLE_ADMIN','ROLE_DOCTOR','ROLE_THERAPIST')")
@RequestMapping("/mediform/nurse")
public class NursePatientController {

	@Inject
	private IPatientService patientService;
	
	@Inject
	private IRceptService receiptService;
	
	@Inject
	private IAlarmService alarmService;
	
	// 환자 list 조회
	@RequestMapping(value = "/patient/list")
	public String patientList(
							Authentication authentication,
							@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
							@RequestParam(required = false, defaultValue = "patntnm") String searchType,
							@RequestParam(required = false) String searchWord,
							PatientVO patientVO,
							Model model) {
		log.info("patientPagingList() 실행...!");
		
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		log.info("구분 : " + customUser.getEmployee().getEmpSe());
		String goPage = "";
		
		if(customUser.getEmployee().getEmpSe().equals("a")) {
			goPage = "admin/patient";
		}else if(customUser.getEmployee().getEmpSe().equals("n")) {
			goPage = "nurse/patient";
		}else if(customUser.getEmployee().getEmpSe().equals("d")) {
			goPage = "doctor/patient";
		}else if(customUser.getEmployee().getEmpSe().equals("t")) {
			goPage = "therapist/patient";
		}
		
		PaginationInfoVO<PatientVO> pagingVO = new PaginationInfoVO<PatientVO>();
		
		 // 진료실 대기환자  가져오기
	    List<RceptVO> waitingList = receiptService.watingAllList();
	    model.addAttribute("waitingList", waitingList);
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 검색 필터 적용시
		if(patientVO != null && patientVO.isFilterFlag()) {
			pagingVO.setSearchVO(patientVO);
			model.addAttribute("patientVO", patientVO);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = patientService.selectPatientCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<PatientVO> dataList = patientService.selectPatientPagingList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("menuSelected", "patient");
		
		return goPage;
	}
	
		// 접수 대기 리스트 컨트롤러
		@RequestMapping(value="/rcept/list", method=RequestMethod.GET)
		public String receiptWaitingList(Model model) {
		
			log.info("receiptWaitingList() 실행!!!");
			
			
			List<RceptVO> waitingList = receiptService.watingList();
			
			model.addAttribute("waitingList", waitingList);
			
			log.info("waitingList" + waitingList);
			
			log.info("waitingListSize" + waitingList.size());
			
			return "waitingList";
		}
		
		
		// 환자 검색(ajax)
		@ResponseBody
		@PostMapping("/search")
		public List<PatientVO> patientSearch(@RequestBody Map<String, String> map) {
			
			List<PatientVO> patientList = patientService.patientSearch(map);
			
			log.info("patientList : "+ patientList);
			return patientList;
		}
		
		// 환자 정보 조회(ajax)
		@ResponseBody
		@PostMapping("/info")
		public PatientVO patientInfo(@RequestBody Map<String, String> map) {
			
			PatientVO patientInfo = patientService.selectPatient(map);
			
			log.info("patientInfo : "+ patientInfo);
			return patientInfo;
		}
		
		// 환자 전체 정보 조회(ajax)
		@ResponseBody
		@PostMapping("/searchList")
		public List<PatientVO> patientSearchList() {
			
			List<PatientVO> patientList = patientService.selectPatientList();
			
			log.info("patientList : "+ patientList);
			return patientList;
		}
		
		
		// 신규 환자 등록
		@RequestMapping(value="/patient/insert", method = RequestMethod.POST)
		public String patientInsert(PatientVO patientVO, Model model, RedirectAttributes ra, Authentication authentication) {
			log.info("patientInsert() 실행중...!");
			
			String goPage = "";
			
			ServiceResult result = patientService.patientInsert(patientVO);
			if(result.equals(ServiceResult.OK)) {
				log.info("환자등록 성공");
				
				// 로그인 정보
				CustomUser customUser = (CustomUser) authentication.getPrincipal();
			    String empNo = customUser.getEmployee().getEmpNo();
						
				// 박유빈 : 환자등록 성공 시, 알람 등록
				// 1) DB예 알람 정보 insert
				// 2) WebSocket 접속한 사용자에게 알림 발송
				AlarmVO alarmVo = new AlarmVO();
				alarmVo.setAlarmWriter(empNo);
				alarmVo.setAlarmCn("NEW_PATIENT|신규 환자가 등록되었습니다. [" + patientVO.getPatntNm() + "]");
				alarmService.insertAlarm(alarmVo);
				
				ra.addFlashAttribute("insertPatient", "insertPatient");
				goPage = "redirect:/mediform/nurse/patient/list";
			}else {
				log.info("환자등록 실패");
				goPage = "/mediform/nurse/patient/list";
				model.addAttribute("patientVO", patientVO);
			}
			
			return goPage;
		}
		
		// 환자 상세 정보
		@ResponseBody
		@RequestMapping("/updateForm")
		public PatientVO patientUpdateForm(@RequestBody String patntNo) {
			log.info("patientUpdateForm() 실행...!");
			
			PatientVO patientList = patientService.selectPatientOne(patntNo);
			
			return patientList;
		}
		
		// 환자 정보 수정
		@RequestMapping(value = "/patient/update", method = RequestMethod.POST)
		public String patientUpdate(PatientVO patientVO, Model model) {
			log.info("patientUpdate() 실행중...!");
		
			String goPage = null;
			String msg = null;
			
			ServiceResult result = patientService.patientUpdate(patientVO);
			if(result.equals(ServiceResult.OK)) {
				log.info("환자 정보 수정 성공");
				msg = "정상적으로 수정되었습니다.";
				goPage = "redirect:/mediform/nurse/patient/list";
			}else {
				log.info("환자 정보 수정 실패");
				msg = "환자 정보 수정에 실패하였습니다.";
				model.addAttribute("patientVO", patientVO);
				goPage = "/mediform/nurse/patient/list";
			}
			
			return goPage;
		}
		
		
		// 차트 번호에 따른 환자 정보 조회(ajax)
		@ResponseBody
		@PostMapping("/clnicInfo/list")
		public PatientVO clnicPatientInfo(@RequestBody String clnicNo) {
			log.info("환자 clnicPatientInfo ()...! 실행!");
			PatientVO patientInfo = patientService.clnicPatientList(clnicNo);
			
			return patientInfo;
		}
		
		
		// 차트번호에 따른 약 조회(ajax)
		@ResponseBody
		@PostMapping(value = "/clnic/medicine/list", produces = "application/json")
		public List<POAdminVO> medicinePatientList(@RequestBody Map<String, String> map) {
			
			List<POAdminVO> patientPO = patientService.pOPatientList(map);
			
			log.info("patientInfo : "+ patientPO);
			return patientPO;
		}


		
		
		
}
