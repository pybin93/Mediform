package kr.or.ddit.administration.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.administration.service.IRceptService;
import kr.or.ddit.common.vo.RceptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mediform/admin")
public class RceptController {

	@Inject
	private IRceptService receiptService;
	
	// 접수 대기 리스트 컨트롤러
	@RequestMapping(value="/rcept/list", method=RequestMethod.GET)
	public String receiptMain(Model model) {
	
		log.info("receiptMain() 실행!!!");
		
		
		List<RceptVO> waitingList = receiptService.watingList();
		
		model.addAttribute("waitingList", waitingList);
		model.addAttribute("menuSelected", "receipt");
		
		log.info("waitingList" + waitingList);
		
		log.info("waitingListSize" + waitingList.size());
		
		return "admin/receiptMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/rcept/insert", method=RequestMethod.POST)
	public List<RceptVO> receiptInsert(
										@RequestBody Map<String, Object> map
										) {
	
		log.info("receiptInsert() 실행!!!");
		
		
		
		ServiceResult result = receiptService.receiptInsert(map);
		
		if(result.equals(ServiceResult.OK)) {
			log.info("접수 인서트 성공!!!!!");
			
		}else {
			log.info("접수 인서트 실패");
		}
		
		List<RceptVO> reciptList = null;
		
		return reciptList;

	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/rcept/select", method=RequestMethod.POST)
	public int receiptSelect(
										@RequestBody Map<String, Object> map
										) {
	
		log.info("receiptSelect() 실행!!!");
		
		
		
		int sttatus = receiptService.receiptSelect(map);
		
	
		
		return sttatus;

	}
	
	
	
	
}
