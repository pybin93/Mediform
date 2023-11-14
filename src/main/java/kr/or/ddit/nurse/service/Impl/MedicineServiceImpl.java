package kr.or.ddit.nurse.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.nurse.MedicineMapper;
import kr.or.ddit.nurse.service.IMedicineService;
import kr.or.ddit.nurse.vo.MedicineVO;

@Service
public class MedicineServiceImpl implements IMedicineService{

	@Inject
	private MedicineMapper medicineMapper;

	@Override
	public List<MedicineVO> selectMedicineList() {
		return medicineMapper.selectMedicineList();
	}

	// 약품 리스트 ajax
	@Override
	public List<MedicineVO> medicineSearch(Map<String, String> map) {
		return medicineMapper.medicineSearch(map);
	}

	// 약품 조회 ajax
	@Override
	public MedicineVO selectMedicine(Map<String, String> map) {
		return medicineMapper.selectMedicine(map);
	}
	
}
