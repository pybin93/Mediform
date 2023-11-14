package kr.or.ddit.administration.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUpload;
import org.springframework.stereotype.Service;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.administration.vo.NoticeBoardVO;
import kr.or.ddit.common.vo.FileVO;
import kr.or.ddit.common.vo.PaginationInfoVO;
import kr.or.ddit.mapper.administration.BoardMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements IBoardService{

	@Inject
	private BoardMapper boardMapper;
	
	@Override
	public int selectBoardCount(PaginationInfoVO<NoticeBoardVO> pagingVO) {
		
		return boardMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<NoticeBoardVO> selectBoardList(PaginationInfoVO<NoticeBoardVO> pagingVO) {
		
		return boardMapper.selectBoardList(pagingVO);
	}

	@Override
	public NoticeBoardVO selectBoard(String ntbdNo) {
		
		boardMapper.incrementHit(ntbdNo);
		
		return boardMapper.selectBoard(ntbdNo);
	}

	
	
	@Override
	public ServiceResult insertBoard(HttpServletRequest req, NoticeBoardVO noticeBoardVO) {
		
		ServiceResult result = null;
		
		
		
		int status = boardMapper.insertBoard(noticeBoardVO);
		if(status > 0) {
			log.info("일단 일반 텍스트 게시물 업로드 성공!!!");
			// 파일 업로드 추가
			
			List<FileVO> fileList = noticeBoardVO.getFileList();
			
			log.info("파일 사이즈 >>> " + fileList.size());
			
			
			try {
				log.info("서비스 - 파일업로드 직전 두근!!");
				fileUpload(fileList, noticeBoardVO.getNtbdNo(), req);
			} catch (Exception e) {
				log.info("서비스 - catch에 잡힘 ㄲㅂ,,,!!");
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
			log.info("게시물 등록 성공!!!");
		}else {
			result = ServiceResult.FAILED;
			log.info("게시물 등록 실패!!!");
		}
		
		return result;
	}

	
	private void fileUpload(
							List<FileVO> fileList
							, String ntbdNo
							, HttpServletRequest req
							) throws IllegalStateException, IOException {
		
		String savePath = "/resources/notice/";
		
		if(fileList != null && fileList.size() > 0) {
			log.info("파일이 있음!!!service에 파일 처리 메소드까지 넘어옴");
			
			for(FileVO fileVO : fileList) {
				// 파일 업로드 처리 시작
				String saveName = UUID.randomUUID().toString(); // UUID의 랜던 파일명 생성
				saveName = saveName + "_" + fileVO.getFileNm().replaceAll(" " , "_");
//				String endFileName = noticeFileVO.getFileName().split("\\.")[1]; // 디버깅 및 확장자 추출 참고
				
				// .../resources/notice/15 경로
				String saveLocate = req.getServletContext().getRealPath(savePath + ntbdNo);
				File file = new File(saveLocate);
				if(!file.exists()) { // 업로드를 하기 위한 폴더 구조가 존재하지 않을 때 
					file.mkdirs(); // 폴더 생성
				}
				
				// /resources/notice/15/UUID_원본파일명
				saveLocate += "/" + saveName;
				fileVO.setFileOrigin(ntbdNo); //게시글 번호 설정
				fileVO.setFileFlpth(saveLocate); // 파일 업로드 경로 설정
				boardMapper.insertNoticeFile(fileVO); // 공지사항 게시글 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				fileVO.getItem().transferTo(saveFile); // 파일 복사
			}
		}
		
		
	}

	@Override
	public FileVO noticeDownload(String fileNo) {
		
		FileVO fileVO = boardMapper.download(fileNo);
		if(fileVO == null) {
			throw new RuntimeException();
		}
		
		
		return fileVO;
	}

	@Override
	public ServiceResult deleteNotice(HttpServletRequest req, String ntbdNo) {
		ServiceResult result = null;
		// 공지사항 파일 데이터를 삭제하기 위한 준비
		NoticeBoardVO notice = boardMapper.selectBoard(ntbdNo); // 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기
		boardMapper.deleteNoticeFileByBoNo(ntbdNo); // 게시글 번호에 해당하는 파일 데이터 삭제
		
		int status = boardMapper.deleteNotice(ntbdNo);
		if(status > 0) {
			List<FileVO> fileList = notice.getFileList(); // 공지사항 게시글 정보에서 파일 목록 가져오기
			try {
				if(fileList != null && fileList.size() > 0) {
					// [0] = D:\99.Class\02.SPRING2\workspace_spring2\.metadata\...\
					// [1] = aaf123w2f3a21sf-asf1wa23f2w-fawf2132aw-f1w23fa2f1_원본파일명.jpg
					String[] filePath = fileList.get(0).getFileFlpth().split("/");
					
					String path = filePath[0];
					deleteFolder(req, path);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	
	@Override
	public ServiceResult updateBoard(HttpServletRequest req, NoticeBoardVO noticeBoardVO) throws IllegalStateException, IOException {
		
		ServiceResult result = null;
		
		int status = boardMapper.updateBoard(noticeBoardVO);
		
		if(status > 0) {
			List<FileVO> fileList = noticeBoardVO.getFileList();
			fileUpload(fileList, noticeBoardVO.getNtbdNo(), req);
			try {
				log.info("서비스 - 파일업로드 직전 두근!!");
				fileUpload(fileList, noticeBoardVO.getNtbdNo(), req);
				String[] delNoticeNo = noticeBoardVO.getDelNoticeNo();
				if(delNoticeNo != null) {
					for(int i = 0; i < delNoticeNo.length; i++) {
						FileVO noticeFileVO = boardMapper.selectNoticeFile(delNoticeNo[i]);
						boardMapper.deleteNoticeFile(delNoticeNo[i]); // 파일번호에 해당하는 파일데이터를 삭제
						File file = new File(noticeFileVO.getFileFlpth());
						file.delete(); // 기존 파일이 업로드되어 있던 경로에 파일 삭제
					}
				}
				
				
			} catch (Exception e) {
				log.info("서비스 - catch에 잡힘 ㄲㅂ,,,!!");
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	
	private void deleteFolder(HttpServletRequest req, String path) {
		
		// UUID_원본파일명 전 폴더경로를 folder 파일객체로 잡아준다
		File folder = new File(path);
		
		try {
			if(folder.exists()) { // 경로가 존재한다면
				File[] folderList = folder.listFiles(); // 폴더 안에 있는 파일들의 목록을 가져온다
			
				for(int i = 0; i < folderList.length; i++) {
					if(folderList[i].isFile()) { // 폴더 안에 있는 파일이 파일일 때
						folderList[i].delete(); // 폴더 안에 파일을 차례대로 삭제
					}else {
						// 폴더 안에 있는 파일이 폴더일 때 재귀함수 호출(폴더 안으로 들어가서 다시 이행)
						deleteFolder(req, folderList[i].getPath());
					}
				}
				folder.delete(); // 폴더 삭제
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
	
	
	
}
