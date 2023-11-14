package kr.or.ddit.security;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.common.vo.EmployeeVO;
import lombok.Data;

public class CustomUser extends User{

	private EmployeeVO employee;
	private String empProfile;
	
	public CustomUser(String username, String password, List<? extends GrantedAuthority> authorities, String empProfile) {
			
			
		super(username, password, authorities);
		this.empProfile = empProfile;	
			
	}
	
	public CustomUser(EmployeeVO employee) {
		// Java 스트립을 사용한 경우 (람다 표현식)
		// - 자바 버전 8 부터 추가된 기능
		// map : 컬렉션(List, Map, Set 등), 배열 등의 설정되어 있는 각 타입의 값들을 하나씩 참조하여 람다식으로 반복 처리할 수 있게 해준다
		// collect : Stream()을 돌려 발생하는 데이터를 가공처리 하고 원하는 형태의 자료형으로 변환을 돕는다
		// 회원 정보 안에 들어있는 역할명들을 컬렉션 형태의 스트림으로 만들어서 보내준다
		super(employee.getEmpNo(), employee.getEmpPw(), 
				employee.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthorNm())).collect(Collectors.toList()));
		// 람다 표현식에는 전처리와 후처리가 존재한다
		// 전처리에 해당하는 로직으로 .map 컬렉션 데이터를 활용하고
		// 후처리에 해당하는 로직으로 .collector가 돌아 마지막으로 데이터를 가공 처리 후 마무리 되어야 하는 데이터 타입으로 변환을 마무리한다
		this.employee = employee;
		
	}
	
	public EmployeeVO getEmployee() {
		return employee;
	}
	
	public void setEmployee(EmployeeVO employee) {
		this.employee = employee;
	}

	public String getEmpProfile() {
		return empProfile;
	}

	public void setEmpProfile(String empProfile) {
		this.empProfile = empProfile;
	}
	
	
	
}
