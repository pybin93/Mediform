package kr.or.ddit.common.vo;


import java.util.List;

import lombok.Data;

@Data
public class ChattingRoomVO {

	private String chttRoomNo; // 방번호
	private String chttRoomNm; // 초기 설정 방이름
	
	private String chttMbIdx; // 채팅방 멤버 인덱스
	private String empNo; // 사번
	private String empNm; // 이름
	private String empSe; // 부서
	private String empProfile; // 프로필 이미지
	private String chttEntnc; // 채팅방 입장 인덱스
	private String chttLast; // 마지막 읽은 시점
	private String indvdlSetupRoomNm; // 개인설정방이름
	
	
	private String chttCn; // 채팅방 내용 - 마지막으로 보낸 내용 출력
	private String chttDe; // 채팅 보낸 시간 - 마지막으로 보낸 시간 출력
	private int chttRoomIndx; // 채팅방 별 채팅 index

	private List<ChattingMemberVO> memberList;
	
}
