package kr.or.ddit.mapper.common;

import java.util.List;
import java.util.Map;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.common.vo.PaginationInfoVO;
import kr.or.ddit.common.vo.ReservationVO;

public interface ReservationMapper {

	List<ReservationVO> selectList(Map<String, String> map);

	int reservationInsert(Map<String, String> map);

	List<ReservationVO> selectListAll(PaginationInfoVO<ReservationVO> pagingVO);

	int selectReservationCount(PaginationInfoVO<ReservationVO> pagingVO);

	ReservationVO reservationSelect(Map<String, String> map);

	int reservationDelete(Map<String, String> map);

	int reservationUpdate(Map<String, Object> map);

	List<ReservationVO> selectDateList(Map<String, String> map);

	List<ReservationVO> reservationSchedulerList();



}
