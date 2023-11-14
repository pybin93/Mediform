package kr.or.ddit.manager.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kr.or.ddit.common.vo.PatientStatisticsVO;
import kr.or.ddit.manager.service.IManagerStatisticsService;
import kr.or.ddit.manager.vo.StatisticsVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 통계 컨트롤러
 * @author PC-20
 *
 */
@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_DIRECTOR')")
@RequestMapping(value="/mediform/manager")
public class ManagerStatisticsController {
	
	@Inject
	private IManagerStatisticsService statisticsService;
	
	/**
	 * 환자 통계 조회
	 * @param model
	 * @return
	 */
	@GetMapping(value="/patient/statistics/select")
	public String patientStatistics(Model model) {
		Gson gson = new Gson();
		
		// 성비율
		List<StatisticsVO> genderSumList = statisticsService.genderSumList();
		String genderSumJsonList = gson.toJson(genderSumList);
		model.addAttribute("genderSumJsonList", genderSumJsonList);
		
		// 나이대별
		List<StatisticsVO> ageSumList = statisticsService.ageSumList();
		String ageSumJson = gson.toJson(ageSumList);
		model.addAttribute("ageSumJson", ageSumJson);
		
		// 지역별 통계
		List<StatisticsVO> addrList = statisticsService.addrList();
		String addrJson = gson.toJson(addrList);
		model.addAttribute("addrJson", addrJson);
		
		// 시간대별 통계
		List<StatisticsVO> timeList = statisticsService.timeList();
		String timeJson = gson.toJson(timeList);
		model.addAttribute("timeJson", timeJson);
		
		// 재방문 통계
		List<StatisticsVO> revisitList = statisticsService.revisitList();
		String revisitJson = gson.toJson(revisitList);
		model.addAttribute("revisitJson", revisitJson);
		
		// 의사별 일주일간 환자 수
		List<StatisticsVO> doctorStatisticsList = statisticsService.doctorStatisticsList();
		String doctorJson = gson.toJson(doctorStatisticsList);
		model.addAttribute("doctorJson", doctorJson);
		
		// 상병 통계
		List<StatisticsVO> sickStatisticsList = statisticsService.sickStatisticsList();
		String sickJson = gson.toJson(sickStatisticsList);
		model.addAttribute("sickJson", sickJson);
		
		// 메뉴바 선택 CSS를 위한 model
	    model.addAttribute("menuSelected", "statistics");
		model.addAttribute("subMenuSelected", "patientStatisticsBtn");
		
		
		return "manager/patientStatistics";
	}
	
	
	
	
	/**
	 * 매출 통계 조회
	 * @param model
	 * @return
	 */
	@GetMapping(value="/revenue/statistics/select")
	public String revenueStatistics(Model model) {
		
		// 요일, 주, 월, 년 별 목록
		List<StatisticsVO> dayReceiveList = statisticsService.dayReceiveList();
		List<StatisticsVO> weekReceiveList = statisticsService.weekReceiveList();
		List<StatisticsVO> monthReceiveList = statisticsService.monthReceiveList();
		List<StatisticsVO> yearReceiveList = statisticsService.yearReceiveList();
		Gson gson = new Gson();
		String dayJsonList = gson.toJson(dayReceiveList);
		String weekJsonList = gson.toJson(weekReceiveList);
		String monthJsonList = gson.toJson(monthReceiveList);
		String yearJsonList = gson.toJson(yearReceiveList);
		
		model.addAttribute("dayJsonList", dayJsonList);
		model.addAttribute("weekJsonList", weekJsonList);
		model.addAttribute("monthJsonList", monthJsonList);
		model.addAttribute("yearJsonList", yearJsonList);
		
		// 요일 평균 매출
		List<StatisticsVO> avgDayList = statisticsService.avgDayList();
		String avgJsonList = gson.toJson(avgDayList);
		model.addAttribute("avgJsonList", avgJsonList);
		
		// 메뉴바 선택 CSS를 위한 model
		model.addAttribute("menuSelected", "statistics");
		model.addAttribute("subMenuSelected", "revenueStatisticsBtn");
		return "manager/revenueStatistics";
	}

	
	
	
	
	
	
	
	
	/**
	 * 감사 통계 조회
	 * @param model
	 * @return
	 */
	@GetMapping(value="/audit/statistics/select")
	public String auditStatistics(Model model) {
		
		// 전체 최다 조회 uri top5(일, 주, 월, 연별)
		List<StatisticsVO> dayAuditList = statisticsService.dayAuditList();
		List<StatisticsVO> weekAuditList = statisticsService.weekAuditList();
		List<StatisticsVO> monthAuditList = statisticsService.monthAuditList();
		List<StatisticsVO> yearAuditList = statisticsService.yearAuditList();
		
		Gson gson = new Gson();
		
		// json형태로 변환
		String dayJsonList = gson.toJson(dayAuditList);
		String weekJsonList = gson.toJson(weekAuditList);
		String monthJsonList = gson.toJson(monthAuditList);
		String yearJsonList = gson.toJson(yearAuditList);
		
		model.addAttribute("dayJsonList", dayJsonList);
		model.addAttribute("weekJsonList", weekJsonList);
		model.addAttribute("monthJsonList", monthJsonList);
		model.addAttribute("yearJsonList", yearJsonList);
		
		// 접속률
		List<StatisticsVO> accessAuditList = statisticsService.accessAuditList();
		
		String accessAuditJsonList = gson.toJson(accessAuditList);
		
		model.addAttribute("accessAuditJsonList", accessAuditJsonList);
		// 메뉴바 선택 CSS를 위한 model
		model.addAttribute("menuSelected", "statistics");
		model.addAttribute("subMenuSelected", "auditStatisticsBtn");
		
		return "manager/auditStatistics";
	}
}
