package kr.or.ddit.common.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.administration.ServiceResult;
import kr.or.ddit.common.service.IChattingService;
import kr.or.ddit.common.vo.ChattingRoomVO;
import kr.or.ddit.common.vo.ChattingVO;
import kr.or.ddit.common.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mediform/common")
public class ChatController {

	@Inject
	private IChattingService chattingService;
	

	@ResponseBody
	@RequestMapping(value="/chatting/file/insert", method=RequestMethod.POST)
	public String fileInsert(
							HttpServletRequest req,
							HttpSession session,
							RedirectAttributes ra,
							MultipartFile[] uploadFile,
							@RequestParam("empNo") String empNo,
							@RequestParam("chttCn") String chttCn,
							@RequestParam("chttRoomNo") String chttRoomNo,
							Model model
							) {
		
		log.info("fileInsert() 실행 !!!");
		
		
		log.info(">>>>> ##### empNo ##### <<<<< " + empNo);
		log.info(">>>>> ##### chttCn ##### <<<<< " + chttCn);
		log.info(">>>>> ##### chttRoomNo ##### <<<<< " + chttRoomNo);
		
		ChattingVO chattingVO = new ChattingVO();
		
//		chattingVO.setAtchFile(uploadFile);
		chattingVO.setEmpNo(empNo);
		chattingVO.setChttCn(chttCn);
		chattingVO.setChttRoomNo(chttRoomNo);
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			chattingVO.setAtchFile(uploadFile);
			
		}
		
		ServiceResult result = chattingService.fileInsert(req, chattingVO);
		
		String sttatus = "";
		
		if(result.equals(ServiceResult.OK)) {
			log.info("인서트 성공!!!!");
			sttatus = "success";
		}else {
			log.info("인서트 실패!!!");
			sttatus = "fail";
		}
		
		return sttatus;
	}
	
	
	
	/**
	 * ajax 친구 목록
	 * @return 친구 목록
	 */
	@ResponseBody
	@RequestMapping(value="/chatting/friend/list", method=RequestMethod.POST)
	public List<EmployeeVO> friendList(){
		
		log.info("friendList() 실행");
		
		List<EmployeeVO> friendList = chattingService.friendList();
		
		log.info("친구리스트 : " + friendList);
		
		
		return friendList;
	}
	
	@ResponseBody
	@RequestMapping(value="/chattingMember/select", method=RequestMethod.POST)
	public ChattingRoomVO roomInfo(
										@RequestBody Map<String, String> map
										){
		
		log.info("memberList() 실행!!!");
		
		
		ChattingRoomVO roomInfo = chattingService.roomInfo(map);
		
		return roomInfo;
		
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/chattingMember/update", method=RequestMethod.POST)
	public String chatReadUpdate(
								@RequestBody Map<String, String> map
								) {
		
		log.info("chatReadUpdate() 실행!!!");
		
		int status = chattingService.chatReadUpdate(map);
		
		return "";
	}
	
	
	/**
	 * ajax 채팅방 생성 insert : 채팅방 생성 & 채팅방 멤버 insert 
	 * @param roomName
	 * @param selectedFriendValues
	 * @return insert 상태 리턴
	 */
	@ResponseBody
	@RequestMapping(value="/chattingroom/insert", method=RequestMethod.POST)
	public String insertRoom(
			@RequestParam("roomname") String roomName, 
			@RequestBody List<String> selectedFriendValues
							) {
		
		log.info("방이름 : " + roomName);
		
		log.info("선택된 사람 : " + selectedFriendValues);
		
		ServiceResult result = chattingService.insertChattMember(roomName, selectedFriendValues);
		
		String stattus = "";
		
		if(result.equals(ServiceResult.OK)) {
			log.info("인서트 성공!!!!");
			stattus = "success";
		}else {
			log.info("인서트 실패!!!");
			stattus = "fail";
		}
		
		
		return stattus;
	}
	
	/**
	 * ajax로 채팅 방 리스트 가져오는 메서드
	 * @param map
	 * @return 채팅방 목록
	 */
	@ResponseBody
	@RequestMapping(value="/chatting/room/list", method=RequestMethod.POST)
	public List<ChattingRoomVO> chattingRoom(
										@RequestBody Map<String, String> map
											){
		
		log.info("chattingRoom() 실행!!");
		
		List<ChattingRoomVO> chattingRoomList = chattingService.selectChattingRoomList(map);
		
		return chattingRoomList;
	}
	
	/**
	 * 채팅 
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/chatting/insert", method=RequestMethod.POST)
	public String chattingInsert(
								@RequestBody Map<String, String> map
								) {
		log.info("chattingInsert() 실행");
		
		ServiceResult result = chattingService.chattingInsert(map);
		
		String sttatus = "";
		
		if(result.equals(ServiceResult.OK)) {
			log.info("인서트 성공!!!!");
			sttatus = "success";
		}else {
			log.info("인서트 실패!!!");
			sttatus = "fail";
		}
		
		return sttatus;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/chatting/select", method=RequestMethod.POST)
	public List<ChattingVO> chattingSelect(
										@RequestBody Map<String, Object> map
										) {
		
		List<ChattingVO> chattingList = chattingService.chattingList(map);
			
		
		return chattingList;
		
	}
	
}
