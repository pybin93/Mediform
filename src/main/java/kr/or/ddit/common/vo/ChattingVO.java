package kr.or.ddit.common.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ChattingVO {

	private int chttIndx; // 채팅 자체 index
	private int chttRoomIndx; // 채팅방 별 채팅 index
	private String empNo; // 채팅 보낸 사원 번호
	private String empNm; // 채팅 보낸 사원 이름
	private String empProfile; // 채팅 보낸 사원 프로필 이미지
	private String chttCn; // 채팅 내용
	private String chttAtchmnfl; // 첨부파일
	private Date chttDe; // 채팅 날짜
	private String chttRoomNo; // 채팅 방 번호
	private String chttExtsn; 
	private String chttFileNm;
	
	private MultipartFile[] atchFile;
	private List<FileVO> fileList;
	
	
	public void setAtchFile(MultipartFile[] atchFile) {
		
		this.atchFile = atchFile;
		if(atchFile != null) {
			
			List<FileVO> fileList = new ArrayList<FileVO>();
			
			for(MultipartFile item : atchFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				FileVO fileVO = new FileVO(item);
				fileList.add(fileVO);
			}
			this.fileList = fileList;
		}
	}
	
	
}
