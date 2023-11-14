package kr.or.ddit.common.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.doctor.controller.DoctorHomeController;
import kr.or.ddit.doctor.service.IDoctorClinicService;
import kr.or.ddit.doctor.service.IDoctorService;
import kr.or.ddit.doctor.vo.ClinicVO;
import kr.or.ddit.manager.service.IManagerService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mediform/doctor")
public class DoctorHomeCommonController {
	
	@Inject
	private IDoctorService doctorService;
	
	 @Inject
	 private IManagerService managerService;
	 
	 @Inject
	 private IDoctorClinicService doctorClinicService;
	 
	// 환자 이전 진료 기록 전체 조회(ajax)
		@ResponseBody
		@PostMapping("/allClinic")
		public List<ClinicVO> allClinic(@RequestBody Map<String, String> map) {
			
			List<ClinicVO> allClinicList = doctorService.selectClinicList(map);
				
			log.info("allClinicList : "+ allClinicList);
			
			return allClinicList;
		}
		// 환자 검사오더 등록한 진료 조회(ajax)
		@ResponseBody
		@PostMapping("/clinic/select")
		public ClinicVO selectClinic(@RequestBody Map<String, String> map) {
			
			ClinicVO selectClinic = doctorService.selectClinic(map);
			
			log.info("selectClinic : "+ selectClinic);
			
			return selectClinic;
		}
}
