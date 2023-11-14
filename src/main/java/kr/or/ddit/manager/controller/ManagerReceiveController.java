package kr.or.ddit.manager.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.common.vo.PaginationInfoVO;
import kr.or.ddit.manager.service.IManagerReceiveService;
import kr.or.ddit.manager.vo.ManagerReceiveVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 수납내역 관리 컨트롤러
 * @author PC-20
 *
 */
@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_DIRECTOR')")
@RequestMapping(value="/mediform/manager")
public class ManagerReceiveController {
	
	@Inject
	private IManagerReceiveService receiveService;
	
	/**
	 * 수납 내역 조회
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/receive/list/select")
	public String receiveMainHome(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
	        @RequestParam(required = false, defaultValue = "all") String searchType,
	        @RequestParam(required = false) String searchWord,
	        @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
	        @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			Model model) {
		
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
	    
		model.addAttribute("endDate", endDate);
	    recPaginationInfoSettings(currentPage, searchType, searchWord, startDate, endDate, model);
	    
	    // 메뉴바 선택 CSS를 위한 model
	    model.addAttribute("menuSelected", "receive");
	    
		return "manager/receiveList";
	}
	
	/**
	 * 수납 내역 페이징 처리를 위한 메소드
	 * @param page
	 * @param searchType
	 * @param searchWord
	 * @param startDate
	 * @param endDate
	 * @param model
	 */
	private void recPaginationInfoSettings(
			int page, 
			String searchType, 
			String searchWord,
			Date startDate, 
			Date endDate, 
			Model model) {
		PaginationInfoVO<ManagerReceiveVO> pagingVO = new PaginationInfoVO<ManagerReceiveVO>();
		
		// searchType 처리
		pagingVO.setSearchType(searchType);
		model.addAttribute("searchType", searchType);
		
		// searchWord 처리
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		
		ManagerReceiveVO managerReceiveVO = new ManagerReceiveVO();
		
		pagingVO.setStartDate(startDate);
		pagingVO.setEndDate(endDate);
		pagingVO.setSearchVO(managerReceiveVO);
		pagingVO.setCurrentPage(page);
		
		int totalRecord = 0;
		List<ManagerReceiveVO> dataList = new ArrayList<ManagerReceiveVO>();
		
		if(searchType != null && searchType.equals("unpaid")) {
			// 미수납 조회시 
			totalRecord = receiveService.unpaidCount(pagingVO);
			dataList = receiveService.unpaidList(pagingVO);
			
		}else {
			// 그 외의 조회시
			totalRecord = receiveService.receiveCount(pagingVO);
			dataList = receiveService.receiveList(pagingVO);
		}
		
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);		
		
	}
	
	/**
	 * 수납 내역 상세 조회 ajax
	 * @param map
	 * @return
	 */
	@PostMapping(value="/receive/detail")
	public ResponseEntity<ManagerReceiveVO> getReceive(@RequestBody Map<String, String>map){
		
		String rciptNo = map.get("rciptNo");
		ManagerReceiveVO receiveVO = receiveService.getReceive(rciptNo);
		
		return new ResponseEntity<ManagerReceiveVO>(receiveVO, HttpStatus.OK);
	}
	
	/**
	 * 미수납 내역 상세 조회 ajax
	 * @param map
	 * @return
	 */
	@PostMapping(value="/unpaid/detail")
	public ResponseEntity<ManagerReceiveVO> getUnpaid(@RequestBody Map<String, String>map){
		
		String rcivNo = map.get("rcivNo");
		ManagerReceiveVO unpaidVO =  receiveService.getUnpaid(rcivNo);
		
		return new ResponseEntity<ManagerReceiveVO>(unpaidVO, HttpStatus.OK);
	}
	
	/**
	 * 미수납 내역 조회
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/unpaidList/list/select")
	public String unpaidList(Model model) {
		
		return "manager/unpaidList";
	}
	
}
