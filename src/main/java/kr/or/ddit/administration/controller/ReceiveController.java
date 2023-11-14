package kr.or.ddit.administration.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.administration.service.IReceiveService;
import kr.or.ddit.administration.vo.MEOAdminVO;
import kr.or.ddit.administration.vo.MTRAdminVO;
import kr.or.ddit.administration.vo.POAdminVO;
import kr.or.ddit.administration.vo.ReceiptVO;
import kr.or.ddit.administration.vo.ReceiveDetailVO;
import kr.or.ddit.administration.vo.ReceiveVO;
import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mediform/admin")
public class ReceiveController {

	@Inject
	private IReceiveService receiveService;
	
	@RequestMapping(value="/receive/list")
	public String receiveList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
	        @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			Model model) {
		
		log.info("receiveList()실행!!!");
		
		if (startDate == null) {
		    Calendar calendar = Calendar.getInstance();
		    calendar.set(Calendar.YEAR, 0);
		    calendar.set(Calendar.MONTH, 0);
		    calendar.set(Calendar.DAY_OF_MONTH, 0);
		    calendar.set(Calendar.HOUR_OF_DAY, 0);
		    calendar.set(Calendar.MINUTE, 0);
		    calendar.set(Calendar.SECOND, 0);
		    calendar.set(Calendar.MILLISECOND, 0);
		    startDate = calendar.getTime();
		}else {
			model.addAttribute("startDate", startDate);
		}
		
		// endDate는 null이면 안됨
		// 빈값이면 현재 날짜로 초기화 
	    if (endDate == null) {
	        endDate = new Date(); 
	    }
	    
	    log.info("시작일 >>>> " + startDate);
	    log.info("시작일 >>>> " + endDate);
	    
		model.addAttribute("endDate", endDate);
		model.addAttribute("menuSelected", "receive");
		recPaginationInfoSettings(currentPage, searchType, searchWord, startDate, endDate, model);
		
		
		
		
		return "admin/receiveMain";
		
	}
	
	private void recPaginationInfoSettings(
			int currentPage, 
			String searchType, 
			String searchWord,
			Date startDate, 
			Date endDate, 
			Model model) {
		PaginationInfoVO<ReceiveVO> pagingVO = new PaginationInfoVO<ReceiveVO>();
		
		// searchType 처리
		pagingVO.setSearchType(searchType);
		model.addAttribute("searchType", searchType);
		
		// searchWord 처리
		if(StringUtils.isNotBlank(searchWord)) {
//			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
//			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		ReceiveVO receiveVO = new ReceiveVO();
		
		pagingVO.setStartDate(startDate);
		pagingVO.setEndDate(endDate);
		pagingVO.setSearchVO(receiveVO);
		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage가 결정
	
		
		List<ReceiveVO> receiveList = new ArrayList<ReceiveVO>();
		
		int totalRecord = receiveService.selectReceiveCount(pagingVO); // 총게시글 수
		receiveList = receiveService.receiveList(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord); // totalpage 결정
		pagingVO.setDataList(receiveList);
		
		model.addAttribute("pagingVO", pagingVO);	
		
	}
	
	@ResponseBody
	@RequestMapping(value="/receive/select", method=RequestMethod.POST)
	public ReceiveVO receiveSelect(
								@RequestBody Map<String, String> map
								) {
		
		log.info("receiveSelect() 실행!!!!");
		
		ReceiveVO receiveVO = receiveService.receiveSelect(map);
		
		return receiveVO;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/receipt/list", method=RequestMethod.POST)
	public List<ReceiptVO> receiptList(
									@RequestBody Map<String, String> map
									){
		
		log.info("receiptVO() 실행!!!");
		
		
		List<ReceiptVO> receiptList = receiveService.receiptList(map);
		
		return receiptList;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/receiptDetail/list", method=RequestMethod.POST)
	public ReceiveDetailVO receiveDetaiList(
									@RequestBody Map<String, String> map
									){
		
		log.info("receiveDetaiList() 실행!!!");
		
		
		ReceiveDetailVO receiveDetailList = receiveService.receiveDetaiList(map);
		
		return receiveDetailList;
	}
	
	@ResponseBody
	@RequestMapping(value="/receiptDetail/medicalExaminationOrder/list", method=RequestMethod.POST)
	public List<MEOAdminVO> mEOList(
									@RequestBody Map<String, String> map
									){
		
		log.info("MEOList() 실행!!!");
		
		List<MEOAdminVO> mEOList = receiveService.mEOList(map);
		
		return mEOList;
	}
	
	@ResponseBody
	@RequestMapping(value="/receiptDetail/medicalTreatmentRecord/list", method=RequestMethod.POST)
	public List<MTRAdminVO> mTRList(
									@RequestBody Map<String, String> map
									){
		
		log.info("MTRList() 실행!!!");
		
		List<MTRAdminVO> mTRList = receiveService.mTRList(map);
		
		return mTRList;
	}
	
	@ResponseBody
	@RequestMapping(value="/receiptDetail/prescriptionOrder/list", method=RequestMethod.POST)
	public List<POAdminVO> pOList(
									@RequestBody Map<String, String> map
									){
		
		log.info("pOList() 실행!!!");
		
		List<POAdminVO> pOList = receiveService.pOList(map);
		
		return pOList;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/receive/update", method=RequestMethod.POST)
	public String pay(
					@RequestBody Map<String, Object> map
					) {
		
		log.info("pay() 실행!!!");
		
		
		
		ServiceResult result = receiveService.pay(map);
		
		String stattus = "";
		
		if(result.equals(ServiceResult.OK)) {
			log.info("업데이트 성공!!!!");
			stattus = "success";
		}else {
			log.info("업데이트 실패!!!");
			stattus = "fail";
		}
		
		return stattus;
	}
	
	@ResponseBody
	@RequestMapping(value="/receipt/select", method=RequestMethod.POST)
	public ReceiptVO receiptSelect(
								@RequestBody Map<String, String> map
									) {
		
		log.info("receiptSelect() 실행!!!");

		ReceiptVO receiptVO = receiveService.receiptSelect(map);
		
		return receiptVO;
	}
	
	
	
}
