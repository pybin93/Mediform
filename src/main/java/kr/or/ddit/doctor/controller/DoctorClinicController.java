package kr.or.ddit.doctor.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.velocity.runtime.directive.Parse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.administration.service.IRceptService;
import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.vo.EmployeeVO;
import kr.or.ddit.common.vo.RceptVO;
import kr.or.ddit.doctor.service.IDoctorClinicService;
import kr.or.ddit.doctor.vo.ClinicAssignmentVO;
import kr.or.ddit.doctor.vo.ClinicVO;
import kr.or.ddit.manager.service.IManagerService;
import kr.or.ddit.patient.service.IPatientService;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mediform/doctor/room")
@PreAuthorize("hasRole('ROLE_DOCTOR')")
@Controller
public class DoctorClinicController {
	
	@Inject
	private IDoctorClinicService doctorClinicService;
	
	@Inject
	private IManagerService managerService;
	
	@Inject
	private IRceptService receiptService;
	
	@Inject
	private IPatientService patientService;
	
	// 진료 메인 페이지
	@RequestMapping("/main")
	public String clinicMain(Model model, Authentication authentication) {
		log.info("clinicMain() 실행중...!");
		
		// 로그인 정보
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
	    String doctorNo = customUser.getEmployee().getEmpNo();
		
	    EmployeeVO empVO = managerService.getEmployee(doctorNo);
		ClinicAssignmentVO clinicAssignmentVO = doctorClinicService.selectclinicAssigment(doctorNo);
		String clinicNo = clinicAssignmentVO.getClnicNo().substring(1,2);
		
		model.addAttribute("empVO", empVO);
		model.addAttribute("clinicNo", clinicNo);
//		model.addAttribute("menuSelected", "room");
		
		return "doctor/room";
	}
	
	// 대기환자 리스트 (의사 번호)
	@ResponseBody
	@RequestMapping("/list")
	public List<ClinicVO> selectwaitingList(Authentication authentication) {
		log.info("receiptList() 실행중...!");
		
		// 로그인 정보
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
	    String doctorNo = customUser.getEmployee().getEmpNo();
		List<ClinicVO> waitingList = doctorClinicService.selectwaitingList(doctorNo);	// 대기환자정보
		
		return waitingList;
	}
	
}
