package kr.or.ddit.doctor.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.FileVO;
import lombok.Data;

// 검사오더 컬럼들
@Data
public class MedicalExaminationOrderVO {
	
	private String mecCd;			// 검사 번호(기본키)
	private String clnicNo;			// 진료 번호(식별)
	private String rceptNo;			// 접수 번호(식별)
	private String hlthchkpCd;		// 검사 코드(식별)
	private Date hlthchkpDt;		// 검사 일시(Null)
	private String hlthchkpResult;	// 검사 결과(Null)
	private String bodyCd;			// 환부 코드(비식별)(NotNull)
	
	// 검사 테이블의 컬럼
	private String hlthchkpNm;  // 검사명(NotNull)
	private int hlthchkpAmount; // 가격(NotNull)
	private String mllwncAt;    // 급여/비급여여부(NotNull)('N')
	
	private List<String> hlthchkpCdList;		// 검사 코드 List
	private List<String> hlthchkpResultList;		// 검사 결과 List

	private List<String> mecCdList;
	// 일반 검사 총합 금액
	private int hcTotalPrice;
	// 엑스레이 총합 금액
	private int xcTotalPrice;
	
	private MultipartFile[] atchXrayFile; 
	private List<FileVO> xRayList;
	
	
	public void setAtchXrayFile(MultipartFile[] atchXrayFile) {
		
		this.atchXrayFile = atchXrayFile;
		if(atchXrayFile != null) {
			
			List<FileVO> xRayList = new ArrayList<FileVO>();
			
			for(MultipartFile item : atchXrayFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				FileVO fileVO = new FileVO(item);
				xRayList.add(fileVO);
			}
			this.xRayList = xRayList;
		}
		
	}
	
}
