package kr.or.ddit.nurse.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.administration.vo.NoticeBoardVO;
import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.vo.FileVO;
import kr.or.ddit.doctor.service.IDoctorClinicService;
import kr.or.ddit.doctor.vo.ClinicAssignmentVO;
import kr.or.ddit.doctor.vo.ClinicVO;
import kr.or.ddit.doctor.vo.MedicalExaminationOrderVO;
import kr.or.ddit.nurse.service.IActingService;
import kr.or.ddit.nurse.vo.VitalVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasRole('ROLE_NURSE')")
@RequestMapping(value = "/mediform/nurse/acting")
public class NurseActingController {

	@Inject
	private IDoctorClinicService doctorClinicService;

	@Inject
	private IActingService actingService;

	// 진료 메인 페이지
	@RequestMapping("/main")
	public String clinicMain(Model model) {
		log.info("clinicMain() 실행중...!");

		// 로그인 정보
		String doctorNo = "d20230085";
		ClinicAssignmentVO clinicAssignmentVO = doctorClinicService.selectclinicAssigment(doctorNo);
		String clinicNo = clinicAssignmentVO.getClnicNo().substring(1, 2);

		model.addAttribute("clinicNo", clinicNo);
		model.addAttribute("menuSelected", "order");
		return "nurse/acting";
	}

	// 대기환자 리스트 (의사 번호)
	@ResponseBody
	@RequestMapping("/list")
	public List<ClinicVO> selectwaitingList() {
		log.info("receiptList() 실행중...!");

		// 로그인 정보
		String doctorNo = "d20230085";
		List<ClinicVO> waitingList = doctorClinicService.selectwaitingList(doctorNo); // 대기환자정보

		return waitingList;
	}

	// 바이탈 결과 insert
	@ResponseBody
	@RequestMapping(value = "/vital/insert", method = RequestMethod.POST)
	public List<VitalVO> vitalResultInsert(@RequestBody Map<String, String> map) {
		
		ServiceResult result = actingService.vitalResultInsert(map);

		if (result.equals(ServiceResult.OK)) {
			log.info("바이탈 인서트 성공 인서트 성공");
		} else {
			log.info("바이탈 실패ㅠㅠㅠ");
		}

		List<VitalVO> vitalList = null;

		return vitalList;
	}
	
	
	// 검사결과 조회
	@ResponseBody
	@RequestMapping(value = "/exam/select", method = RequestMethod.POST)
	public List<MedicalExaminationOrderVO> vitalResultselect(@RequestBody Map<String, String> map) {
			
		List<MedicalExaminationOrderVO> meoList  = actingService.vitalResultselect(map);

		if (meoList.equals(ServiceResult.OK)) {
			log.info("바이탈 셀렉  성공 인서트 성공");
		} else {
			log.info("바이탈 실패ㅠㅠㅠ");
		}

		return meoList;
	}
	
	
	

	// 검사결과 업데이트
	@ResponseBody
	@RequestMapping(value = "/exam/update", method = RequestMethod.POST)
	public List<MedicalExaminationOrderVO> examResultInsert(@RequestBody Map<String, String> map) {

		ServiceResult result = actingService.examResultInsert(map);

		log.info("맵에서 받아온 정보 >>>> " + map.get("mecCd"));
		
		if (result.equals(ServiceResult.OK)) {
			log.info("검사결과 업데이트 성공");
		} else {
			log.info("검사결과 업데이트 실패ㅠㅠㅠ");
		}

		List<MedicalExaminationOrderVO> examList = null;

		return examList;
	}

	// 환자 바이탈 조회 (ajax)
	@ResponseBody
	@PostMapping("/vital")
	public List<VitalVO> vital(@RequestBody Map<String, String> map) {

		List<VitalVO> vitalList = actingService.selectVitalList(map);

		return vitalList;
	}
	

	
	// 엑스레이 업로드
	@ResponseBody
	@RequestMapping(value = "/xray/insert", method = RequestMethod.POST)
	public void xrayInsert(
						HttpServletRequest req,
						HttpSession session,
						RedirectAttributes ra,
						MultipartFile[] uploadFile,
						@RequestParam("mecCd") String mecCd,
						@RequestParam("rceptNo") String rceptNo,
						Model model
						) {

		log.info("xrayInsert() 실행!!!");

		log.info(">>>>> ##### mecCd ##### <<<<< " + mecCd);
		log.info(">>>>> ##### xrayRceptNo ##### <<<<< " + rceptNo);
		
		String success = "";

		MedicalExaminationOrderVO meoVO = new MedicalExaminationOrderVO();
		
		for(MultipartFile multipartFile : uploadFile) {
			
			meoVO.setAtchXrayFile(uploadFile);
			
		}
		
		meoVO.setMecCd(mecCd);
		meoVO.setRceptNo(rceptNo);
		
		ServiceResult result = actingService.insertXray(req, meoVO);
		if (result.equals(ServiceResult.OK)) {
			success = "성공!! 성공도 습관이다";
		} else {
			model.addAttribute("message", "서버에러, 다시시도해주세요");
			success = "실패! 실패는 성공의 어머니!";
		}

		log.info(success);

	}
	
	
	// 엑스레이 업로드
//	@RequestMapping(value="/xray/insert", method=RequestMethod.POST)
//	public void xrayInsert(
//						HttpServletRequest req,
//						HttpSession session,
//						RedirectAttributes ra,
//						MedicalExaminationOrderVO meoVO, Model model) {
//					
//		log.info("xrayInsert() 실행!!!");
//		
//		String success = "";
//				
//		ServiceResult result = actingService.insertXray(req, meoVO);
//		if(result.equals(ServiceResult.OK)) {
//			success = "성공!! 성공도 습관이다";
//		}else {
//			model.addAttribute("message", "서버에러, 다시시도해주세요");
//			success = "실패! 실패는 성공의 어머니!";
//		}
//		
//		log.info(success);
//		
//	}
	
	
	
	
	
	
	
//	@PostMapping("/uploadXRay")
//	public String uploadFile(FileVO fileVO, HttpServletRequest req) {
//	    MultipartFile multipartFile = fileVO.getItem();
//	    
//	    if(multipartFile != null && !multipartFile.isEmpty()) {
//	        // 파일 저장 로직
//	        String uploadPath = req.getServletContext().getRealPath("/resources/uploads");
//	        String originalFileName = multipartFile.getOriginalFilename();
//	        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
//	        String savedFileName = UUID.randomUUID().toString() + extension;
//	        
//	        File savedFile = new File(uploadPath, savedFileName);
//	        if(!savedFile.getParentFile().exists()) {
//	            savedFile.getParentFile().mkdirs();
//	        }
//	        
//	        try {
//	            multipartFile.transferTo(savedFile);
//	            
//	            fileVO.setFileNM(originalFileName);
//	            fileVO.setFileExtsn(extension);
//	            fileVO.setFileFlpth(savedFile.getAbsolutePath());
//
//	            
//	            
//	        } catch(IOException e) {
//	            e.printStackTrace();
//	        }
//	    }
//	    return null;
//	}
    
    
}