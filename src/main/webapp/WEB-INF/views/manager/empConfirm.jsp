<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메디폼 │ 행정관리자</title>
<style type="text/css">
#header {
	font-weight: bold;
}

#searchBtn {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 35px;
}

.text-nowrap {
	cursor: pointer;
}

#msgArea {
	font-size: 17px;
	margin-bottom: 50px;
}

#empSelectBox, #conSelectBox, #comSelectBox  {
	margin-left: auto;
	margin-top: 20px;
	width: 150px;
	height: 35px;
}

#empSearchBox {
	margin-top: 18px;
	margin-right: 8px;
}

.subMenu:hover {
	border-color: #3f51b5;
 	background-color: rgba(63, 81, 181, 0.1);
}

.subMenu {
	font-size: 16px;
	margin-left : 20px;
	margin-right : 20px; 
}

.profileImg {
	width: 150px; /* 원하는 가로 크기로 설정 */
 	height: 150px; /* 원하는 세로 크기로 설정 */
  	object-fit: cover; /* 이미지 비율 유지하면서 부족한 부분을 채움 */
}

</style>
</head>
<body>

<!-- 서브 메뉴 -->            
<ul class="navbar-nav d-flex flex-row" style="margin-bottom: 15px; border-bottom: 1px solid #ededed; border-top: 1px solid #ededed;">
	<li style="margin-left:15px;"></li>
    <li class="subMenu nav-item">
      <a class="nav-link" href="/mediform/manager/employee/list/select" role="button" id="employeeManagementBtn">&nbsp;&nbsp;직원 관리&nbsp;&nbsp;</a>
    </li>
    <li class="subMenu nav-item">
      <a class="nav-link" href="/mediform/manager/employee/confirm/list/select" role="button" id="employeeCompleteBtn">&nbsp;&nbsp;신청 내역&nbsp;&nbsp;</a>
    </li>
    <li class="subMenu nav-item">
      <a class="nav-link" href="/mediform/manager/employee/chart/select" role="button" id="employeeOrganizationChartBtn">&nbsp;&nbsp;직원 조직도&nbsp;&nbsp;</a>
    </li>
</ul>
<!-- 서브 메뉴 -->            
     
<input type="hidden" id="msg" value="${msg }">
<!-- ////////////////////// 탭 구현 시작 ///////////////////////// -->
<div class="col-xl-12 ps-xl-2">
	<div class="card " style="height: 770px;" >
		<div class="card-header d-flex flex-between-center py-2 " style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
			<div class="row flex-between-end">
				<div class="col-auto align-self-center">
					<h5 class="mb-0 text-white" id="headerText" style="font-weight: bold;">
						직원 목록
					</h5>
				</div>
			</div>
		</div>
		<div class="card-body bg-body-tertiary" style="padding: initial !important; heigth: 730px;">
			<div class="tab-content">
				<div class="card overflow-hidden" style="width: 100%;">
						<!--  //////////////// 직원 조회 시작////////////////// -->
						<div class="table-responsive scrollbar" style="height: 667px;">
							<div class="" style="display: flex; justify-content: flex-start; margin-left: 20px; padding-top:0px; padding-bottom:0px;">
							    <form action="/mediform/manager/employee/list/select" method="post" id="searchForm" style="display: flex;">
							        <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="empSelectBox" name="searchType">
							            <option <c:if test="${searchType eq 'default'}">selected</c:if> value="default" >전체</option>
							            <option <c:if test="${searchType eq 'a'}">selected</c:if> value="a">원무</option>
							            <option <c:if test="${searchType eq 'd'}">selected</c:if> value="d">의사</option>
							            <option <c:if test="${searchType eq 'n'}">selected</c:if> value="n">간호</option>
							            <option <c:if test="${searchType eq 't'}">selected</c:if> value="t">치료</option>
							            <option <c:if test="${searchType eq 'm'}">selected</c:if> value="m">관리</option>
							            <option <c:if test="${searchType eq 'r'}">selected</c:if> value="r">퇴직</option>
							        </select>
							        <div class="input-group" id="empSearchBox" style="margin-top: 20px; width: 290px; height: 35px;">
							            <input class="searchInput form-control search-input " type="search" placeholder="직원명이나 사번을 입력해 주세요." aria-label="Search" id="empSearchInput" style="flex: 1;" value="${pagingVO.searchWord }" name="searchWord"/>
							        </div>
							        <div style="display: flex; justify-content: flex-end; margin-top: 20px;" >
							        	<button class="btn btn-outline-secondary me-1 mb-1"  type="button" id="searchBtn" style="width:70px;">검색</button>
							        </div>
							        <input type="hidden" name="page" id="page" />
							        <sec:csrfInput />
							    </form>
							</div>
						<hr/>
						<table class="table table-hover table-striped overflow-hidden" >
							<thead>
								<tr style="margin-bottom: 20px;">
									<th class="col-2 " scope="col" style="margin-left: 500px;">&nbsp;이름</th>
									<th class="col-2" scope="col">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사번</th>
									<th class="col-2" scope="col">소속</th>
									<th class="col-2" scope="col">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이메일</th>
									<th class="col-2" scope="col">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연락처</th>
									<th class="col-2" scope="col">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입사일자</th>
								</tr>
							</thead>
							<tbody>
								<!-- 넘어온 값 셋팅 -->
								<c:set value="${pagingVO.dataList }" var="empList"/>
								<c:choose>
									<c:when test="${empty empList }">
										<tr class="align-middle" id="">
											<td class="text-center" colspan="5">등록된 직원 내역이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${empList }" var="emp">
											<tr class="selectDetail align-middle" id="${emp.empNo }">
												<td class="text-nowrap">${emp.empNm }</td>
												<td class="text-nowrap">${emp.empNo }</td>
												<td class="text-nowrap"><c:choose>
														<c:when test="${emp.empSe eq 'n'}">간호</c:when>
														<c:when test="${emp.empSe eq 'a'}">원무</c:when>
														<c:when test="${emp.empSe eq 'd'}">전문</c:when>
														<c:when test="${emp.empSe eq 't'}">치료</c:when>
														<c:when test="${emp.empSe eq 'm'}">관리</c:when>
														<c:when test="${emp.empSe eq 'k'}">병원장</c:when>
													</c:choose></td>
												<td class="text-nowrap" >${emp.empEmail }</td>
												<td class="telNoTd text-nowrap">${emp.empTelno }</td>
												<td class="text-nowrap">
													<fmt:formatDate value="${emp.empRgsde }" pattern="yyyy.MM.dd HH:mm" />
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="card-footer clearfix col-auto align-self-center pagingArea" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
					
				</div>
			</div>	
		</div>
	</div>
</div>
<!--  //////////////// 직원 조회 끝////////////////// -->

<!-- 1 직원 내역 모달 탬플릿 시작 -->
<div class="modal fade" id="memberDetail-modal" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 1200px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6 " style="background-color: midnightblue; font-weight: bold;">
					<h4 class="modalHeader mb-1 text-white " id="modalExampleDemoLabel">직원내역 상세보기</h4>
				</div>
				<div class="p-4 pb-0">
					<div class="text-center">
                    	<img class="profileImg rounded-circle img-thumbnail shadow-sm" width="150" height="150" src="/resources/image/profile/profileImg.png" alt="User profile picture" id="empProfile">
                    </div>
                    <div class="row">
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for=empNoInput>사번</label> <input
								class="form-control" id="empNoInput" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for=empNm>이름</label> <input
								class="form-control" id="empNm" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="empSexdstn">성별</label> <input
								class="form-control" id="empSexdstn" type="text" name=""
								readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-4  mb-3 form-group">
							<label class="col-form-label" for="empSe">소속</label> <input
								class="form-control" id="empSe" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="empEncpn">입사일자</label> 
							<input class="form-control" id="empEncpn" type="text" name="" readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="empTelno">연락처</label> <input
								class="form-control" id="empTelno" type="text" name=""
								readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-6 mb-3 form-group">
							<label class="col-form-label" for="empRrno">주민등록번호</label> <input
								class="form-control" id="empRrno" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-6 mb-3 form-group">
							<label class="col-form-label" for="empEmailInput">이메일</label> <input
								class="form-control" id="empEmailInput" type="text"
								name="empEmail" readonly="readonly" />
						</div>
					</div>
					<div class="row"> 
						<div class="mb-3 form-group">
							<label class="col-form-label" for="empAdres">주소</label> <input
								class="form-control" id="empAdres" type="text" name=""
								readonly="readonly" />
						</div>
					</div>
					<div class="row"> 
						<form action="/mediform/manager/employee/update" method="post" id="modifyForm" enctype="application/x-www-form-urlencoded">
							<input type="hidden" id="empNoUpdate" name="empNo" value="">
							<input type="hidden" id="empSeUpdate" name="empSe" value="">
							<div class="col-6 form-group mb-2">
					        	<label class="col-form-label" for="empClsf">직급</label> <br>
                				<input class="form-check-input" id="empClsf1" type="radio" name="empClsf" value="1" > 일반 사원
                				<input class="form-check-input" id="empClsf0" type="radio" name="empClsf" value="0" style="margin-left: 20px;"> 과장 
               				</div>
               				<div class="col-6 form-group">
								<label class="col-form-label" for="empHffcAt">재직 여부</label> <br>
								<input class="form-check-input" id="retireCheckboxO" type="radio" name="empHffcAt" value="Y" /> Y
								<input class="form-check-input" id="retireCheckboxX" type="radio" style="margin-left: 20px;" name="empHffcAt" value="N" /> N
							</div>
							<sec:csrfInput />
						</form>
					</div>
					<div class="mb-3 form-group">
						<!-- 수정 폼 -->
					</div>
					<div class="mb-3 form-group">
						<label class="col-form-label" for="empRetireInput">퇴직 일자</label>
						<input class="form-control" id="empRetireInput" type="text" name="" readonly="readonly"/>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" id="modifyEmpBtn" style="background-color: midnightblue; border: 1px midnightblue solid">수정</button>
				<button class="btn btn-secondary" type="button" id="" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
	</div>
<!-- 1 직원 내역 모달 탬플릿 끝 -->

<script type="text/javascript">
$(function() {
	$(document).ready(function() {
		
		
		msgFunction(); 
    	
    	$('.telNoTd').each(function() {
            // 현재 td 요소의 텍스트 내용 가져오기
            var phoneNumber = $(this).text();
            // 전화번호 형식 변경
            var formattedPhoneNumber = formatPhoneNumber(phoneNumber);
            // 변경된 내용으로 업데이트
            $(this).text(formattedPhoneNumber);
        });
	});
	
	// 전화번호 형식을 변경하는 함수
    function formatPhoneNumber(phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
	
	// 넘어온 메세지 값이 있을 시 안내 모달창 발생
	function msgFunction(){
		var msg = $('#msg').val();
// 		console.log(msg);
		if (msg != null && msg != "" && msg == "y") {
			Swal.fire({
			      icon: 'success',
			      title: '실행 결과',
			      text: '정상적으로 처리 되었습니다.',
			      confirmButtonColor: 'midnightblue'
			    });
		}else if(msg != null && msg != "" && msg == "n"){
			Swal.fire({
			      icon: 'error',
			      title: '실행 결과',
			      text: '해당 요청 실행 중 오류가 발생했습니다.',
			      confirmButtonColor: 'midnightblue'
			    });
		}else if(msg != null && msg != "" && msg == "e"){
			Swal.fire({
			      icon: 'error',
			      title: '실행 결과',
			      text: '이미 본 과에 해당 직책이 존재합니다.',
			      confirmButtonColor: 'midnightblue'
			    });
		}
	}
			
	/* 검색 input 글자 삭제 */
	var searchXbtn = $('.btn-close-falcon-container');
	searchXbtn.on('click', function(){
		event.preventDefault();
		$('.fuzzy-search').val("");
	});
	
	var searchForm = $('#searchForm');
	var searchBtn = $('#searchBtn');
	searchBtn.on('click', function(){
		searchForm.submit();
	});
	/* 페이징 */
	var pagingArea = $('#pagingArea');
		pagingArea.on("click", "a", function(event){
		
		event.preventDefault();
		var pageNo = $(this).data("page")
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
				
				
	// 검색 후 엔터를 누르면 submit
	$("#empSearchInput").on("keydown", function(event) {
	       if (event.key === "Enter") {
	           event.preventDefault(); // 기본 Enter 동작 방지
	           $("#searchForm").submit(); 
	       }
	});
				
				
	// 타임스탬프 날짜 변환 함수(시,분,초 포함) 
	// yyyy/MM/dd hh:mm:ss
	function formatDate(timeStamp){
	    var date = new Date(timeStamp);
	
	    var year = date.getFullYear();
	    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 두 자리로 만듭니다.
	    var day = date.getDate().toString().padStart(2, '0'); // 일도 두 자리로 만듭니다.
	    var hours = date.getHours().toString().padStart(2, '0'); // 시도 두 자리로 만듭니다.
	    var minutes = date.getMinutes().toString().padStart(2, '0'); // 분도 두 자리로 만듭니다.
	    var seconds = date.getSeconds().toString().padStart(2, '0'); // 초도 두 자리로 만듭니다.
	
	    var formattedDate = year + '.' + month + '.' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	
	    return formattedDate;
	}
	
	
	// yyyy/MM/dd
	function formatDateNoTime(timeStamp){
	    var date = new Date(timeStamp);
	    
	    var year = date.getFullYear();
	    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 문자열로 변환하여 두 자리로 만듭니다.
	    var day = date.getDate().toString().padStart(2, '0'); // 일도 마찬가지로 두 자리로 만듭니다.
	    
	    var formattedDate = year + '.' + month + '.' + day;
	    
	    return formattedDate;
	}
				
				
	var token = $("input[name='_csrf']").val();
	var header = $("input[name='_csrf_header']").val();
	var selectList = $('#selectList');
	
	selectList.on('change', function() {
	
		var optionVal = selectList.val();
	
		var data = {
			optionVal : optionVal
		};
	
	});
				
	
	// 직원 목록 상세조회
	var selectDetail = $('.selectDetail');
	
	selectDetail.on('click', function() {
		// 사용한 모달 요소 초기화
		$('#retireCheckboxO').prop("disabled", false);
		$('#retireCheckboxX').prop("disabled", false);
		$('#empClsf0').prop("disabled", false);
		$('#empClsf1').prop("disabled", false);
		$('#empRetireInput').val(null);
	
		// 해당 데이터의 값을 상세 조회 모달로 이동
		var empNo = $(this).attr("id");
		var data = {
			empNo : empNo
		};
	
		$.ajax({
		type : "post",
		url : "/mediform/manager/employee/getEmployee",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(emp) {
	
			var empNo = emp.empNo;
			var empNm = emp.empNm;
			var empRrno = emp.empRrno1 + "-" + emp.empRrno2;
			var empSeCd = emp.empSe;
			var empSeName = "";
			if (empSeCd == "d") {
				empSeName = "전문의";
			} else if (empSeCd == "n") {
				empSeName = "간호"
			} else if (empSeCd == "t") {
				empSeName = "치료"
			} else if (empSeCd == "m") {
				empSeName = "관리"
			} else if (empSeCd == "a") {
				empSeName = "원무"
			} else if (empSeCd == "k") {
				empSeName = "병원장"
			}
			
			var empTelno = emp.empTelno;
			
			var empAdres = emp.empAdres1 + " " + emp.empAdres2;
			var empSexdstn = emp.empSexdstn;
			var empSexdstnName = "";
			if (empSexdstn == "F") {
				empSexdstnName = "여자";
			} else {
				empSexdstnName = "남자";
			}
			var empEmail = emp.empEmail;
			var empRetire = emp.empRetire;
			var empClsf = emp.empClsf;
			var empHffcAt = emp.empHffcAt;
			var empEncpn = emp.empEncpn;
			var empProfile = emp.empProfile;
	
				// 모달창에 해당 상세 정보 넣기
// 				console.log("empNo : " + empNo);
				$('#rejectEmpNo').val(empNo);
				$('#empNoInput').val(empNo);
				$('#empNo').val(empNo);
				$('#empNoUpdate').val(empNo);
				$('#empNm').val(empNm);
				$('#empRrno').val(empRrno);
				$('#empSe').val(empSeName);
				$('#empSeUpdate').val(empSeCd);
				var formatTelno = formatPhoneNumber(empTelno);
				$('#empTelno').val(formatTelno);
				$('#empAdres').val(empAdres);
				$('#empSexdstn').val(empSexdstnName);
				$('#empEmail').val(empEmail);
				$('#empEmailInput').val(empEmail);
				$('#rejectEmpEmail').val(empEmail);
				var formatEmpEncpn = formatDateNoTime(empEncpn);
				$('#empEncpn').val(formatEmpEncpn);
				
				// 프로필 사진이 비어있지 않으면
				if(empProfile != null){
					$('#empProfile').attr("src", empProfile);
				}
	
				if(empClsf == "0"){
					$('#empClsf0').attr("checked", true);
				}else{
					$('#empClsf1').attr("checked", true);
				}
	
				if (empHffcAt == "N") {
					$('#retireCheckboxX').attr("checked", true);
					$('#retireCheckboxO').prop("disabled", true);
					$('#retireCheckboxX').prop("disabled", true);
					$('#empClsf0').prop("disabled", true);
					$('#empClsf1').prop("disabled", true);
					
					
					var formattedDate = formatDate(empRetire);
					$('#empRetireInput').val(formattedDate);
				} else if(empHffcAt == "Y"){
					$('#retireCheckboxX').attr("checked", false);
					$('#retireCheckboxO').prop("checked", true);
				}
			}
		});
	
		// 모달창 show
		$("#memberDetail-modal").modal("show");
	
		// 수정 버튼 클릭시	
		$('#modifyEmpBtn').on('click', function(event) {
		    var modifyForm = $('#modifyForm');
		    var retireCheckboxO = $('#retireCheckboxO');
	
		    // 이미 퇴직한 직원은 수정 불가
		    if (retireCheckboxO.prop("disabled")) {
		        event.preventDefault();
		        var msg = "퇴직한 직원의 내용은 수정할 수 없습니다.";
		        Swal.fire({
				      icon: 'error',
				      title: '수정 실패',
				      text: msg,
				      confirmButtonColor: 'midnightblue'
				    });
					// 사용한 요소들 모두 초기화
			        $('#msgArea').text(null);
					$('#retireCheckboxO').attr("checked", false);
					$('#retireCheckboxO').prop("disabled", false);
					$('#retireCheckboxX').prop("disabled", false);
					$('#empClsf0').prop("disabled", false);
					$('#empClsf1').prop("disabled", false);
		    } else {
		        modifyForm.submit();
		    }
		});
	});

});
	</script>
</body>
</html>