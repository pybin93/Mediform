package kr.or.ddit.common.service;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.common.vo.EmployeeVO;

public interface IMypageService {

	ServiceResult employeeUpdate(HttpServletRequest req, EmployeeVO employeeVO);

	EmployeeVO selectInfo(String id);

}
