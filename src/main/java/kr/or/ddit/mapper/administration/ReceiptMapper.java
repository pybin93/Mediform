package kr.or.ddit.mapper.administration;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.vo.RceptVO;

public interface ReceiptMapper {

	int receiptInsert(Map<String, Object> map);

	List<RceptVO> watingList();

	List<RceptVO> watingAllList();

	int receiptSelect(Map<String, Object> map);

}

