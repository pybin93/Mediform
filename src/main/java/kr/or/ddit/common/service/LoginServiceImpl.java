package kr.or.ddit.common.service;

import java.io.UnsupportedEncodingException;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.vo.EmployeeVO;
import kr.or.ddit.mapper.common.LoginMapper;

@Service
public class LoginServiceImpl implements ILoginService {

	@Inject
	private LoginMapper loginMapper;
	
	// 자바 메일 sender 의존성 주입
	@Inject
	private JavaMailSender emailSender;
	
	@Inject
	private PasswordEncoder pe;
	
	@Override
	public EmployeeVO loginCheck(EmployeeVO employee) {
		
		return loginMapper.loginCheck(employee);
	}

	// 비밀번호 찾기 전 해당 사원 정보 체크
	@Override
	public int findPasswordChk(EmployeeVO empVO) {
		return loginMapper.findPasswordChk(empVO);
	}

	@Override
	public void sendCode(String empEmail, String rndCd) throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		helper.setTo(empEmail);	// 받는 사람 이메일
		helper.setSubject("메디폼 재활병원 │ 비밀번호 찾기 │ 인증번호 발송");	// 메일 제목
		String emailContent = codeContent(rndCd);
		
		helper.setText(emailContent, true);	// 메일 내용
		helper.setFrom(new InternetAddress("nammj0419@gmail.com","메디폼재활병원 행정관리자"));
		emailSender.send(message);
	}

	// 비밀번호 찾기시 인증번호 메일 보낼 메소드
	public String codeContent(String rndCd) {
		StringBuilder sb = new StringBuilder();
		
		String content = "";
		content += "<html>";
		content += "<head>";
		content += "<title>메디폼 재활병원</title>";
		content += "</head>";
		content += "<body>";
		content += "<div style='margin:100px;'>";
		content += "<h1>비밀번호 찾기 │ <font color='red'>인증번호 발송</font></h1>";
		content += "<p>인증번호를 확인해 주세요.<p>";
		content += "<br/>";
		content += "<hr/>";
		content += "<h2>인증번호 : "+ rndCd + "</h2>";
		content += "<br/>";
		content += "<p>본 화면으로 돌아가 인증을 진행해 주세요.<p>";
		content += "<hr/>";
		content += "</div>";
		content += "</body>";
		
		sb.append(content);
		
		return sb.toString();
	}

	@Transactional
	@Override
	public int sendPassword(EmployeeVO empVO) throws MessagingException, UnsupportedEncodingException {
		// 변경된 비밀번호
		UUID uuid = UUID.randomUUID();
		String rndPw = uuid.toString().replace("-", "").substring(0,8);
		// 인코딩한 비밀번호
		String encPw = pe.encode(rndPw);
		empVO.setEmpPw(encPw);
		
		// 비밀번호 변경에 성공하면
		int cnt = loginMapper.passwordUpdate(empVO);
		if(cnt > 0) {
			// 이메일 전송
			MimeMessage message = emailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setTo(empVO.getEmpEmail());	// 받는 사람 이메일
			helper.setSubject("메디폼 재활병원 │ 비밀번호 찾기 │ 비밀번호 발송");	// 메일 제목
			
			String emailContent = completeContent(rndPw); 
			
			helper.setText(emailContent, true);	// 메일 내용
			helper.setFrom(new InternetAddress("nammj0419@gmail.com","메디폼재활병원 행정관리자"));
			emailSender.send(message);
			
		}
		
		return cnt;
	}
	
	public String completeContent(String rndPw) {
		StringBuilder sb = new StringBuilder();
		
		String content = "";
		content += "<html>";
		content += "<head>";
		content += "<title>메디폼 재활병원</title>";
		content += "</head>";
		content += "<body>";
		content += "<div style='margin:100px;'>";
		content += "<h1>비밀번호 찾기 │ <font color='red'>변경된 비밀번호 발송</font></h1>";
		content += "<p>비밀번호를 확인해주시고, 로그인 후 반드시 비밀번호를 변경하여 주세요.<p>";
		content += "<br/>";
		content += "<hr/>";
		content += "<h2>인증번호 : "+ rndPw + "</h2>";
		content += "<br/>";
		content += "<hr/>";
		content += "</div>";
		content += "</body>";
		
		sb.append(content);
		
		return sb.toString();
	}
	
}
