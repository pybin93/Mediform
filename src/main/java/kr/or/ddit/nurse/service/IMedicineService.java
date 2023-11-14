package kr.or.ddit.nurse.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.nurse.vo.MedicineVO;

public interface IMedicineService {

	// 약품 list 조회
	public List<MedicineVO> selectMedicineList();
		
	// 약품 list ajax
	public List<MedicineVO> medicineSearch(Map<String, String> map);

	// 약품 조회 ajax
	public MedicineVO selectMedicine(Map<String, String> map);

}
