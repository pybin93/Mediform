package kr.or.ddit.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.common.vo.AlarmVO;
import kr.or.ddit.mapper.common.AlarmMapper;
import kr.or.ddit.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class AlarmHandler extends TextWebSocketHandler {

	@Inject
	AlarmMapper mapper;

	// 소켓에 접속한 인원들을 담기 위한 리스트 객체 생성
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();
	
	
	// 현재 접속한 모든 사용자에게 메시지를 발송
	public void sendMessageToAll(AlarmVO alarmVO) {
		
		Iterator<String> it = userSessions.keySet().iterator();
		while(it.hasNext()) {
			String empNo = it.next();
			WebSocketSession session = userSessions.get(empNo);
			
			WebSocketMessage message = new TextMessage(alarmVO.getAlarmCn().getBytes());
			
			try {
				session.sendMessage(message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	

	// HttpSession과 WebSocketSession은 다름
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		log.info("afterConnectionEstablished() 실행...!! 클라이언트 서버 접속 연결 성공...! : " + session);

		String empId = session.getPrincipal().getName();
		log.info("empId : {}", empId);

		// 담아
		userSessions.put(empId, session);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("handleTextMessage() 실행...!! 메세지 전송 시도 성공...!");
		log.info("메세지야 들어오아라..." + message.getPayload().toString());
		TextMessage tm = new TextMessage(message.getPayload().toString());
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("afterConnectionClosed() 실행...!! 서버 연결 종료...!");
		
		// 브라우저에서 웹소켓 연결이 끊기면 우리 접속목록에서 삭제해줘야 다음에 그놈한테 메시지 안보냄
		Iterator<String> it = userSessions.keySet().iterator();
		while(it.hasNext()) {
			String empNo = it.next();
			WebSocketSession s = userSessions.get(empNo);
			
			if(s.getId().equals(session.getId())) {
				userSessions.remove(empNo);
			}
		}
	}

	private String getId(WebSocketSession session) {
		SecurityContextImpl secContextImpl = null;
		String id = null;
		Map<String, Object> httpSession = session.getAttributes();
		Set<Entry<String, Object>> entrySet = httpSession.entrySet();
		Iterator<Entry<String, Object>> entryIte = entrySet.iterator();
		while (entryIte.hasNext()) {
			Entry<String, Object> entry = entryIte.next();
			String key = entry.getKey();
			log.info("key : " + key);
			if (key.equals("SPRING_SECURITY_CONTEXT")) {
				secContextImpl = (SecurityContextImpl) httpSession.get("SPRING_SECURITY_CONTEXT");
				log.info("security context : " + secContextImpl);

			}
		}

		CustomUser user = (CustomUser) secContextImpl.getAuthentication().getPrincipal();
		id = user.getEmployee().getEmpNo();
		if (null == user.getUsername()) {
			id = session.getId();
		}
		return id;
	}
}
