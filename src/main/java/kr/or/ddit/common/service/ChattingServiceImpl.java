package kr.or.ddit.common.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.common.vo.ChattingRoomVO;
import kr.or.ddit.common.vo.ChattingVO;
import kr.or.ddit.common.vo.EmployeeVO;
import kr.or.ddit.common.vo.FileVO;
import kr.or.ddit.doctor.vo.MedicalExaminationOrderVO;
import kr.or.ddit.mapper.common.ChattingMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChattingServiceImpl implements IChattingService {

	@Inject
	private ChattingMapper chattingMapper;
	
	@Override
	public List<EmployeeVO> friendList() {
		
		List<EmployeeVO> friendList = chattingMapper.friendList();
		
		log.info("친구 목록 : " + friendList);
		
		return friendList;
	}

	@Override
	public ServiceResult insertChattMember(String roomName, List<String> selectedFriendValues) {
		
		ServiceResult result = null;
		
		int status = chattingMapper.createRoom(roomName);
		
		if(status > 0) {
			for(String chattingEmployeerId : selectedFriendValues) {
				ChattingRoomVO chattingRoomVO = new ChattingRoomVO();
				
				chattingRoomVO.setEmpNo(chattingEmployeerId);
				chattingRoomVO.setChttRoomNm(roomName);
				
				
				chattingMapper.insertChattMember(chattingRoomVO);
				result = ServiceResult.OK;
			}
			chattingMapper.insertFirstInvite();
			
		}else {
			result = ServiceResult.FAILED;
		}
		
		
		
		return result;
	}

	@Override
	public List<ChattingRoomVO> selectChattingRoomList(Map<String, String> map) {
		
		List<ChattingRoomVO> chattingRoomList = chattingMapper.selectChattingRoomList(map);
		
		return chattingRoomList;
	}

	@Override
	public ServiceResult chattingInsert(Map<String, String> map) {
		
		ServiceResult result = null;
		
		int status = chattingMapper.chattingInsert(map);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<ChattingVO> chattingList(Map<String, Object> map) {
	
		List<ChattingVO> chattingList = chattingMapper.chattingList(map);
		
		return chattingList;
	}

	@Override
	public int chatReadUpdate(Map<String, String> map) {
		
		return chattingMapper.chatReadUpdate(map);
	}

	@Override
	public ChattingRoomVO roomInfo(Map<String, String> map) {
		return chattingMapper.roomInfo(map);
	}

	@Override
	public ServiceResult fileInsert(HttpServletRequest req, ChattingVO chattingVO) {
		
		ServiceResult result = null;
		
		log.info("일단  업데이트 업로드 성공!!!");
		
		List<FileVO> fileList = chattingVO.getFileList();
		
		log.info("보낸 파일 개수 >>> " + fileList.size());
		
		try {
			log.info("서비스 - 파일업로드 직전 두근!!");
			fileUpload(fileList, chattingVO, req);
		} catch (Exception e) {
			log.info("서비스 - catch에 잡힘 ㄲㅂ,,,!!");
			e.printStackTrace();
		}
		
		result = ServiceResult.OK;
		log.info("성공!!!");
		result = ServiceResult.FAILED;
		log.info("실패는 성공의 어머니!!!");
	
	return result;
	}

	
	private void fileUpload(List<FileVO> fileList, ChattingVO chattingVO, HttpServletRequest req)
			throws IllegalStateException, IOException {

		
		log.info("파일 업로드 메소드까지 넘어옴!");
		
		
		String savePath = "/resources/chatting/";
		
		
		String uploadPath =  req.getServletContext().getRealPath("/resources/chatting");
		
		
		if (fileList != null && fileList.size() > 0) {
			log.info("파일이 있음!!!service에 파일 처리 메소드까지 넘어옴");

			
			for (FileVO fileVO : fileList) {
				
				MultipartFile chatFile = fileVO.getItem();
				
				String img = "";
				
				// 파일 업로드 처리 시작
				String saveName = UUID.randomUUID().toString(); // UUID의 랜던 파일명 생성
				saveName = saveName + "_" + chatFile.getOriginalFilename();
				//String endFileName = noticeFileVO.getFileName().split("\\.")[1]; // 디버깅 및 확장자 추출 참고
				uploadPath += "/" + saveName;
				// .../resources/notice/15 경로
				chatFile.transferTo(new File(uploadPath));
				img = "/resources/chatting/" + saveName;
				String saveLocate = req.getServletContext().getRealPath(savePath + chattingVO.getEmpNo());
				
				
				File file = new File(saveLocate);
				if (!file.exists()) { // 업로드를 하기 위한 폴더 구조가 존재하지 않을 때
					file.mkdirs(); // 폴더 생성
				}

				// /resources/notice/15/UUID_원본파일명
				saveLocate += "/" + saveName;
//				fileVO.setFileOrigin(chattingVO.getEmpNo()); // 게시글 번호 설정
//				fileVO.setFileFlpth(img); // 파일 업로드 경로 설정
//				
//				fileVO.setFilePatntNo(meoVO.getClnicNo());
//				fileVO.setFileRceptNo(meoVO.getRceptNo());
				chattingVO.setChttAtchmnfl(img);
				chattingVO.setChttExtsn(fileVO.getFileExtsn());
				chattingVO.setChttFileNm(chatFile.getOriginalFilename());
				chattingMapper.fileInsert(chattingVO); // 공지사항 게시글 파일 데이터 추가

				File saveFile = new File(saveLocate);
				fileVO.getItem().transferTo(saveFile); // 파일 복사
			}
		}

	}

	@Override
	public ChattingVO chattingDownload(String chttIndx) {
		
		ChattingVO chattingVO = chattingMapper.downloadChat(chttIndx);
		
		if(chattingVO == null) {
			throw new RuntimeException();
		}
		return chattingVO;
	}

}
