package kr.or.ddit.mapper.manager;

import java.util.List;

import kr.or.ddit.common.vo.PatientStatisticsVO;
import kr.or.ddit.manager.vo.StatisticsVO;

// 매니저 통계 매퍼
public interface ManagerStatisticsMapper {

	public List<StatisticsVO> dayAuditList();

	public List<StatisticsVO> weekAuditList();

	public List<StatisticsVO> monthAuditList();

	public List<StatisticsVO> yearAuditList();

	public List<StatisticsVO> accessAuditList();

	public List<StatisticsVO> genderSumList();

	public List<StatisticsVO> ageSumList();

	public List<StatisticsVO> addrList();

	public List<StatisticsVO> timeList();

	public List<StatisticsVO> revisitList();

	public List<StatisticsVO> doctorStatisticsList();

	public List<StatisticsVO> dayReceiveList();

	public List<StatisticsVO> weekReceiveList();

	public List<StatisticsVO> monthReceiveList();

	public List<StatisticsVO> yearReceiveList();

	public List<StatisticsVO> avgDayList();

	public List<StatisticsVO> sickStatisticsList();

	public PatientStatisticsVO getPatientStatistics();


}
