package kr.or.ddit.administration.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.vo.SickbedVO;
import kr.or.ddit.mapper.administration.HoslitalizationMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HospitalizationImpl implements IHospitalizationService {

	@Inject
	private HoslitalizationMapper hospitalizationMapper;
	
	@Override
	public List<SickbedVO> selectSickbedList() {
		
		log.info("서비스까지 넘어옴!!!");
		
		return hospitalizationMapper.selectSickbedList();
	}

	@Override
	public ServiceResult hospitalizationInsert(Map<String, Object> map) {
		
		ServiceResult result = null;
				
		int status = hospitalizationMapper.hospitalizationInsert(map);
		
		if(status > 0) {
			result = ServiceResult.OK;
			hospitalizationMapper.sickBedUpdate(map);
			hospitalizationMapper.patientUpdate(map);
			
			log.info("일수 >>>>> " + map.get("hosptDay"));
			
			char num = ((String) map.get("hsptlzSckrm")).charAt(0);
			
			String numStr = String.valueOf(num);
			
			String price = "";
			
			if(numStr.equals("5")) {
				log.info("6인실");
				map.put("price", 40000);
			}else if(numStr.equals("6")) {
				log.info("4인실");
				map.put("price", 60000);
			}
			
			hospitalizationMapper.receiveDetailUpdate(map);
			
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public SickbedVO hospitalizationSelect(Map<String, String> map) {
		return hospitalizationMapper.hospitalizationSelect(map);
	}

	@Override
	public ServiceResult hospitalizationUpdate(Map<String, Object> map) {
		
		ServiceResult result = null;
		
		int status = hospitalizationMapper.hospitalizationUpdate(map);
		
		if(status > 0) {
			result = ServiceResult.OK;
			hospitalizationMapper.hospitalizationBedUpdate(map);
			hospitalizationMapper.patientOutUpdate(map);
			
			log.info("일수 >>>>> " + map.get("hosptDay"));
			
			char num = ((String) map.get("hsptlzSckrm")).charAt(0);
			
			String numStr = String.valueOf(num);
			
			String price = "";
			
			if(numStr.equals("5")) {
				log.info("6인실");
				map.put("price", 40000);
			}else if(numStr.equals("6")) {
				log.info("4인실");
				map.put("price", 60000);
			}
			
			hospitalizationMapper.receiveDetailUpdate2(map);
			
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public String hospitalizationCheck(Map<String, Object> map) {
		return hospitalizationMapper.hospitalizationCheck(map);
	}

	
	
	
}
