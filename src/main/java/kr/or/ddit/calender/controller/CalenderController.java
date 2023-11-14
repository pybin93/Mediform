package kr.or.ddit.calender.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.calender.service.ICalenderService;
import kr.or.ddit.calender.vo.CalenderVO;
import kr.or.ddit.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mediform/calender")
public class CalenderController {
	
	@Inject
	private ICalenderService calenderService;
	
	@RequestMapping("/main")
	public String main() {
		return "calender/calender";
	}
	
	// list 조회
	@ResponseBody
	@GetMapping("/list")
	public List<Map<String, Object>> calenderList(){
		log.info("calenderList() 실행중...!");
		
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		List<CalenderVO> calenderList = calenderService.calenderList();
		
		for(CalenderVO calender : calenderList) {
			map.put("id", calender.getSchdlCd()); 								// 코드
			map.put("title", calender.getSchdlNm()); 							// 일정명
			map.put("description", calender.getSchdlCn());						// 일정내용
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
			map.put("pstgDt", sdf.format(calender.getPstgDt()));				// 게시일시
			
			if(calender.getSchdlUpdDt() != null) {
				map.put("schdlUpdDt", sdf.format(calender.getSchdlUpdDt()));	// 수정일시
			}
			
			map.put("start", calender.getSchdlBgngDt()); 						// 일정시작
			map.put("end", calender.getSchdlEndDt()); 							// 일정끝
			
			map.put("className", calender.getSchdlColor());						// 색깔
			map.put("schdlAllDay", calender.getSchdlAllDay());					// 하루종일
			
			jsonObj = new JSONObject(map);
			jsonArr.add(jsonObj);
		}
		log.info("제이슨 배열", jsonArr);
		
		return jsonArr;
	}
	
	// 일정 추가
	@PostMapping(value = "/insert")
	public String calenderInsert(CalenderVO calenderVO) {
		log.info("calenderInsert() 실행중...!");
		
		String result = null;
		
		ServiceResult status = calenderService.calenderInsert(calenderVO);
		if(status.equals(ServiceResult.OK)) {
			log.info("등록 성공!!!");
			result = "OK";
		}else {
			log.info("등록 실패!!!");
			result = "FAILED";
		}
		
		return result;
	}
	
	// 일정 수정 (폼)
	@PostMapping("/update")
	public String calenderUpdate(CalenderVO calenderVO) {
		log.info("calenderUpdate() 실행중...!");
		
		String goPage = null;
		ServiceResult result = calenderService.calenderUpdate(calenderVO);
		
		if(result.equals(ServiceResult.OK)) {
			log.info("수정 성공!!!");
			goPage = "redirect:/mediform/calender/main";
		}else {
			log.info("수정 실패!!!");
			goPage = "calender/main";
		}
		
		return goPage;
	}
	
	// 일정 삭제
	@PostMapping("/delete")
	public String calenderDelete(String schdlCd) {
		log.info("calenderDelete() 실행중...!");

		String goPage = null;
		ServiceResult result = calenderService.calenderDelete(schdlCd);
		
		if(result.equals(ServiceResult.OK)) {
			log.info("삭제 성공!!!");
			goPage = "redirect:/mediform/calender/main";
		}else {
			log.info("삭제 실패!!!");
			goPage = "calender/main";
		}
		
		return goPage;
	}
	
	
	
	
	
}
