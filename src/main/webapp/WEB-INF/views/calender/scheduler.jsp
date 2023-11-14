<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<head>
<style type="text/css">
#calendar .fc-day-sun{
	color: lightcoral;
}
#calendar .fc-day-sat{
	color: cornflowerblue;
}
.fc .fc-button-primary{
	background-color: midnightblue;
}
.fc .fc-scrollgrid{
	border: 1px solid
}
.form-select {
	padding-right: 10px;
}
.vacation-table {
    width: 600px;
    border-collapse: collapse;
    font-family: '맑은 고딕';
    font-size: 16px;
}
.vacation-cell {
    border: 1px solid;
    text-align: center;
    vertical-align: middle;
}
.vacation-title {
    width: 250px;
    font-weight: bold;
    letter-spacing: 15px;
    font-size: 25px;
}
.vacation-day {
    width: 20px;
}
.vacation-label {
    width: 90px;
}
.vacation-space {
    width: 100px;
}
.vacation-content {
    width: 500px;
}
</style>
<meta charset="UTF-8">
<title>메디폼 | 일정</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

// 일정 수정 flag
var updateFlag = "F";
// console.log("처음 updateFlag: " + updateFlag);

$(document).ready(function() {
	tabList('scheduler-tab');

    $('.nav-link').on('click', function() {
        var tabId = $(this).attr('id');
//         console.log(tabId);
        tabList(tabId);
    });
});
	
function tabList(tabId){
    var url;
//     console.log(tabId);
    if (tabId === 'scheduler-tab') {
        
        $.ajax({
    		type: "GET",
    		url: '/mediform/scheduler/list',
    		dataType: 'json',
    		contentType: "application/json; charset=utf-8",
    		beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function(param) {
//             	console.log(param);
            	
            	if(calendar) {
                    calendar.destroy();
                }
            	
            	var calendarEl = document.getElementById('calendar');
            	var calendar = new FullCalendar.Calendar(calendarEl, {
            		initialView: 'dayGridMonth',
            		headerToolbar : {
            			start: 'prev,next today',
            			center: 'title',
            			end: 'dayGridMonth,dayGridWeek,dayGridDay'
            		},
            		weekends: true,
            		buttonText: {
            			today: '오늘',
            			month: '월간',
            			week: '주간',
            			day: '일간'
            		},
            		views: {
            			dayGridMonth: {
            				titleFormat: {month: 'long', year: 'numeric'}
            			}
            		},
            		height: '700px',
            		navLinks : true, 				// 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
            		editable : true, 				// 수정 가능
            		selectable : true, 				// 달력 일자 드래그 설정 가능
            		droppable : true, 				// 드래그 앤 드롭
            		events : param,
            		locale : 'ko', 					// 한국어 설정
            		select: function(info){			// 날짜 클릭 및 드래그로 이벤트(일정 등록) 생성
            			NewSchedulerModal(info);
            		},
            		eventClick: function(info){		// 이벤트 클릭시 상세보기 & 수정 & 삭제
            			updateFlag = "T";
//             			console.log("eventClick updateFlag: " + updateFlag);
            			detailModal(info, updateFlag);
            		},
            		eventDrop: function(info){		// 드래그 앤 드랍 수정
            			updateFlag = "T";
//             			console.log("eventDrop updateFlag: " + updateFlag);
            			dragDropUpdate(info, updateFlag);
            		}
            	});
            	
            	if (param && param.length > 0) {
            		searchFilterSchStart = param[0].searchFilterSchStart;
            		schdlBgngDt = param[0].start;
            		if(searchFilterSchStart != null){
            			calendar.gotoDate(searchFilterSchStart);
            		}
            		if(schdlBgngDt != null){
            			calendar.gotoDate(schdlBgngDt);
            		}
            		if (searchFilterSchStart == null && schdlBgngDt == null) {
            		    calendar.gotoDate(new Date());
            		}
            	}
            	calendar.render();
            }
    	});
        
    } else if (tabId === 'vacation-tab') {
        $.ajax({
    		type: "GET",
    		url: '/mediform/vacation/list',
    		dataType: 'json',
    		contentType: "application/json; charset=utf-8",
    		beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function(param) {
//             	console.log(param);
            	
            	if(calendar) {
                    calendar.destroy();
                }
            	
            	var calendarEl = document.getElementById('calendar');
            	var calendar = new FullCalendar.Calendar(calendarEl, {
            		initialView: 'dayGridMonth',
            		headerToolbar : {
            			start: 'prev,next today',
            			center: 'title',
            			end: 'dayGridMonth,dayGridWeek,dayGridDay'
            		},
            		weekends: true,
            		buttonText: {
            			today: '오늘',
            			month: '월간',
            			week: '주간',
            			day: '일간'
            		},
            		views: {
            			dayGridMonth: {
            				titleFormat: {month: 'long', year: 'numeric'}
            			}
            		},
            		height: '700px',
            		navLinks : true, 				// 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
            		events : param,
            		locale : 'ko', 					// 한국어 설정
            		eventDataTransform: function(event) {
            			if (event.end) {
            				var endDt = new Date(event.end);
            				endDt.setDate(endDt.getDate());
            				event.end = endDt;
            				}
            				return event;
            			}
            	});
            	calendar.render();
            }
    	});
    }
   
}
</script>
</head>
<body>
<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<input type="hidden" name="loginEmpNo" id="loginEmpNo" value="${customUser.employee.empNo}"/>
<input type="hidden" name="loginEmpNm" id="loginEmpNm" value="${customUser.employee.empNm}"/>
<input type="hidden" name="loginEmpSe" id="loginEmpSe" value="${customUser.employee.empSe}"/>
<input type="hidden" name="loginEmpClsf" id="loginEmpClsf" value="${customUser.employee.empClsf}"/>
<input type="hidden" name="loginEmpYrycRemndr" id="loginEmpYrycRemndr" value="${customUser.employee.empYrycRemndr}"/>
<input type="hidden" name="loginEmpOffhodRemndr" id="loginEmpOffhodRemndr" value="${customUser.employee.empOffhodRemndr}"/>
<input type="hidden" name="loginEmpSicknsRemndr" id="loginEmpSicknsRemndr" value="${customUser.employee.empSicknsRemndr}"/>

<div class="row" style="height: 900px;">
	<!-- 캘린더 시작 -->
	<div class="col-7">
		<div class="card">
			<div class="">
				<div class="card-header p-2" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
					<div class="row" style="display: flex; justify-content: start;">
						<div class="col-auto">
							<h5 class="mb-0 ms-2 text-white" style="font-weight: bold;">달력</h5>
						</div>
					</div>
				</div>

				<!-- 캘린더 시작 -->
				<div style="display: flex; align-items: center; flex-direction: column;">
					<div class="card" style="width: 100%">
						<div class="card-body pb-0" style="background-color: aliceblue;">
							<div id="calendar"></div>
							<br/>
						</div>
					</div>
				</div>
				<!-- 캘린더 끝 -->
				
			</div>
		</div>
	</div>
	<!-- 캘린더 끝 -->
	
	<!-- 일정 시작 -->
	<div class="col-5">
		<div class="card border" style="height: 785px;">
		
			<!-- 일정 & 휴가 상단 탭 시작 -->
			<div>
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item text-center col-6">
						<a class="nav-link active fw-semi-bold" id="scheduler-tab" data-bs-toggle="tab" href="#tab-scheduler" role="tab" aria-controls="tab-scheduler" aria-selected="true">일정</a>
					</li>
					<li class="nav-item text-center col-6">
						<a class="nav-link fw-semi-bold" id="vacation-tab" data-bs-toggle="tab" href="#tab-vacation" role="tab" aria-controls="tab-vacation" aria-selected="false">내 휴가</a>
					</li>
				</ul>
			</div>
			<!-- 일정 & 휴가 상단 탭 끝 -->

			<!-- 탭 바디 시작 -->
			<div class="card-body pt-0">
				<div class="tab-content" id="myTabContent">
				
					<!-- 일정 탭 시작 -->
					<div class="col-12 tab-pane fade show active" id="tab-scheduler" role="tabpanel" aria-labelledby="scheduler-tab">
				
						<!-- 상단 날짜, 등록버튼 시작 -->
						<div class="row pt-3 pb-2 pe-3" style="width: 774px; padding-left: 23px">
							<div class="p-0 col-8 row">
								<div class="col-6 col-sm-auto d-flex align-items-center pe-0 search-Box">
									<input class="form-control form-control-sm datetimepicker" type="text"
										data-options='{"static":"true","format":"YYYY-MM-DD"}' id="searchSchedulerStart"
										name="searchSchedulerStart" value="${pagingVO.searchVO.searchFilterSchStart }" style="width: 150px"/>
								</div>
								<div class="col-1 pe-0" style="text-align: center; font-weight: bold; font-size: 15px;">~</div>
								<div class="col-5 col-sm-auto d-flex align-items-center pe-0 search-Box">
									<input class="form-control form-control-sm datetimepicker" type="text" 
										data-options='{"static":"true","format":"YYYY-MM-DD"}' id="searchSchedulerEnd"
										name="searchSchedulerEnd" value="${pagingVO.searchVO.searchFilterSchEnd }" style="width: 150px"/>
									<button class="input-group-text" id="schDateFilterBtn" style="padding-right: 10px; padding-left: 10px;"><i class="fas fa-search"></i></button>
								</div>
							</div>
							<div class="col-4 p-0" style="display: flex; justify-content: flex-end; height: 30px;">
								<button class="btn btn-falcon-primary btn-sm" type="button">
									<span class="d-none d-sm-inline-block ms-1" data-bs-toggle="modal" data-bs-target="#new-scheduler-modal" id="newSchedulerBtn" style="color: midnightblue;"><span class="fas fa-plus me-2"></span>일정등록</span>
								</button>
							</div>
						</div>
						<!-- 상단 날짜, 등록 버튼 끝 -->
						
						<!-- 일정 필터 & 검색 시작 -->
						<div class="card-body p-2">
							<div class="row col-12" style="width: 721px; padding-bottom: 10px; padding-left: 16px">
								<div class="col-6 p-0">
									<div class="search-box">
										<form class="col-6 col-sm-auto d-flex align-items-center pe-0" method="post" id="searchForm">
											<input type="hidden" name="page" id="page" />
											<div class="col-6 col-sm-auto d-flex align-items-center pe-0">
												<select class="form-select form-select-sm" aria-label="Default select example" style="width: 90px;" name="searchType">
													<option value="searchSchStart" <c:if test="${searchType eq 'searchSchStart' }">selected="selected"</c:if>>시작일</option>
													<option value="searchSchEnd" <c:if test="${searchType eq 'searchSchEnd' }">selected="selected"</c:if>>종료일</option>
												</select>
											</div>
											<div class="col-6 col-sm-auto d-flex align-items-center pe-0 search-Box">
												<input class="form-control form-control-sm datetimepicker" type="text"
													data-options='{"static":"true","format":"YYYY-MM-DD"}' placeholder="날짜를 입력해 주세요."
													name="searchWord" id="searchWord" value="${searchWord }" style="width: 170px"/>
												<button class="input-group-text" id="searchBtn" style="padding-right: 10px; padding-left: 10px;"><i class="fas fa-search"></i></button>
											</div>
											<sec:csrfInput />
										</form>
									</div>
								</div>
								<div class="col-6 p-0" style="display: flex; justify-content: flex-end;">
									<button class="btn btn-falcon-default btn-sm me-1" type="button" id="allResetButton">초기화</button>
									<button class="btn btn-falcon-default btn-sm me-1 filterBtn" type="button" value="all" style="float: left;">병원전체</button>
									<div class="dropdown font-sans-serif">
										<button class="btn dropdown-toggle btn-sm btn-falcon-default me-1" id="dropSchBtn" type="button" data-bs-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false" style="float: left;">부서별</button>
										<div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropSchBtn" style="--falcon-dropdown-min-width: 5.2rem; transform: translate(0px, 30px);">
											<button class="dropdown-item filterBtn dropSchBtn" value="h">병원</button>
											<button class="dropdown-item filterBtn dropSchBtn" value="a">원무</button>
											<button class="dropdown-item filterBtn dropSchBtn" value="d">의사</button>
											<button class="dropdown-item filterBtn dropSchBtn" value="n">간호</button>
											<button class="dropdown-item filterBtn dropSchBtn" value="t">치료</button>
										</div>
									</div>
									<button class="btn btn-falcon-default btn-sm me-1 filterBtn" type="button" value="my" style="float: left;">내 일정</button>
								</div>
							</div>
							<!-- 일정 필터 & 검색 끝 -->
						
							<!-- 일정 리스트 테이블 시작 -->
							<div id="schedulerTable" >
								<div class="table-responsive scrollbar" style="height: 585px;">
									<table class="table table-sm data-table table-striped fs--1 mb-0 overflow-hidden" data-list='{"valueNames":["count","dep","start","end"]}'>
										<thead class="bg-200">
											<tr>
												<th class="text-900 sort pe-1" data-sort="count" style="text-align: center;">번호</th>
												<th class="text-900 sort pe-1" data-sort="dep" style="text-align: center;">구분</th>
												<th class="text-900 sort pe-1" style="text-align: center;">일정명</th>
												<th class="text-900 sort pe-1" data-sort="start" style="text-align: center;">일정시작일</th>
												<th class="text-900 sort pe-1" data-sort="end" style="text-align: center;">일정종료일</th>
												<th class="text-900 sort pe-1" style="text-align: center; padding-right: 10px;">작성자</th>
											</tr>
										</thead>
										<tbody class="list" id="table-purchase-body">
										<c:set value="${pagingVO.dataList }" var="schList" />
										<c:choose>
											<c:when test="${empty schList }">
												<tr>
													<td colspan="17" align="center">일정정보가 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${schList }" var="schList" varStatus="status">
													<tr class="btn-reveal-trigger">
														<td class="count align-middle white-space-nowrap" style="text-align: center;">${status.count}</td>
														<td class="dep align-middle white-space-nowrap" style="text-align: center;">
															<c:if test="${schList.schdlDep eq 'a'}">원무</c:if>
															<c:if test="${schList.schdlDep eq 'd'}">의사</c:if>
															<c:if test="${schList.schdlDep eq 'n'}">간호</c:if>
															<c:if test="${schList.schdlDep eq 't'}">치료</c:if>
															<c:if test="${schList.schdlDep eq 'h'}">병원</c:if>
															<c:if test="${schList.schdlDep eq 'my'}">내일정</c:if>
														</td>
														<td class="align-middle white-space-nowrap" style="text-align: center; white-space: nowrap;
															overflow: hidden; text-overflow: ellipsis; max-width: 150px;">${schList.schdlNm }</td>
														<td class="start align-middle white-space-nowrap" style="text-align: center;">${schList.schdlBgngDt }</td>
														<td class="end align-middle white-space-nowrap" style="text-align: center;">${schList.schdlEndDt }</td>
														<td class="align-middle white-space-nowrap" style="text-align: center; padding-right: 10px;">${schList.schedulerEmpName }</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										</tbody>
									</table>
								</div>
							</div>
							<div class="p-0 mt-2">
								<div class="p-0 card-footer clearfix col-auto align-self-center pagingArea" id="pagingArea" style="display: flex; justify-content: center;">${pagingVO.pagingHTML }</div>
							</div>
							<!-- 일정 리스트 테이블 끝 -->
						</div>
					</div>
					<!-- 일정 탭 끝 -->
					
					<!-- 휴가 탭 시작 -->
					<div class="col-12 tab-pane fade" id="tab-vacation" role="tabpanel" aria-labelledby="vacation-tab">
						
						<!-- 상단 날짜, 등록버튼 시작 -->
						<div class="card-body p-2">
							<div class="mt-2">
								<div class="search-Box" style="float: left;">
									<input class="form-control form-control-sm datetimepicker" type="text"
										data-options='{"static":"true","format":"YYYY-MM-DD"}' id="searchVacStart"
										name="searchVacStart" disabled="disabled" style="width: 120px"/>
								</div>
								<div class="p-0" style="text-align: center; font-weight: bold; font-size: 15px; float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
								<div class="col-sm-auto d-flex align-items-center pe-0 search-Box" style="float: left;">
									<input class="form-control form-control-sm datetimepicker" type="text" 
										data-options='{"static":"true","format":"YYYY-MM-DD"}' id="searchVacEnd"
										name="searchVacEnd" disabled="disabled" style="width: 120px; float: left;"/>
								</div>
								<div class="p-0" style="display: flex; justify-content: flex-end; height: 30px;">
									<c:if test="${customUser.employee.empClsf eq '0'}">
										<div class="pe-1">
											<button class="btn btn-falcon-primary btn-sm" id="vacationAppBtn" type="button">
												<span class="d-none d-sm-inline-block" style="color: midnightblue;"><span class="far fa-edit me-2"></span>휴가결재</span>
											</button>
										</div>
									</c:if>
									<div>
										<button class="btn btn-falcon-primary btn-sm" data-bs-toggle="modal" data-bs-target="#new-vacation-modal" id="newVacationBtn" type="button">
											<span class="d-none d-sm-inline-block ms-1" style="color: midnightblue;"><span class="fas fa-plus me-2"></span>휴가신청</span>
										</button>
									</div>
								</div>
							</div>
						</div>
						<!-- 상단 날짜, 등록 버튼 끝 -->
						
						<!-- 휴가 서브탭 시작 -->
						<div class="col-12 p-2">
							<ul class="nav nav-tabs" id="vacTab" role="tablist">
					            <li class="nav-item text-center col-6" role="presentation">
					                <a class="nav-link active me-1" id="signup-tab" data-bs-toggle="tab" href="#tab-signup" role="tab" aria-controls="tab-signup"
					                aria-selected="true" style="background-color: aliceblue;">신청중</a>
					            </li>
					            <li class="nav-item text-center col-6" role="presentation">
					                <a class="nav-link" id="allvac-tab" data-bs-toggle="tab" href="#tab-allvac" role="tab" aria-controls="tab-allvac"
					                aria-selected="false" style="background-color: aliceblue;">전체</a>
					            </li>
					        </ul>
						</div>
						<!-- 휴가 서브탭 끝 -->
						
						<!-- 탭 content 시작 -->
						<div class="card-body p-2">	
							<div class="tab-content">
								
								<!-- 휴가 신청 탭 시작 -->
								<div class="tab-pane fade show active" id="tab-signup" role="tabpanel" aria-labelledby="signup-tab">
									
									<!-- 휴가 신청내역 테이블 시작 -->
									<div class="table table-hover" id="VacationSignTable" >
										<div class="table-responsive scrollbar" style="height: 585px;">
											<table class="table table-sm table-hover data-table table-striped fs--1 mb-0 overflow-hidden" data-list='{"valueNames":["count","date","start","end", "status"]}'>
												<thead class="bg-200">
													<tr>
														<th class="text-900 sort pe-1" data-sort="count" style="text-align: center; padding-left: 4px;">번호</th>
														<th class="text-900 sort pe-1" data-sort="date" style="text-align: center;">신청일</th>
														<th class="text-900 sort pe-1" style="text-align: center;">구분</th>
														<th class="text-900 sort pe-1" style="text-align: center;">부서</th>
														<th class="text-900 sort pe-1" style="text-align: center;">신청자</th>
														<th class="text-900 sort pe-1" data-sort="start" style="text-align: center;">시작일</th>
														<th class="text-900 sort pe-1" data-sort="end" style="text-align: center;">종료일</th>
														<th class="text-900 sort pe-1" style="text-align: left; white-space: nowrap;
																overflow: hidden; text-overflow: ellipsis; max-width: 100px;">휴가사유</th>
														<th class="text-900 sort pe-1" style="text-align: center; min-width: 40px;">차감</th>
														<th class="text-900 sort pe-1" data-sort="status" style="text-align: center;">상태</th>
													</tr>
												</thead>
												<tbody class="list" id="table-signup-body">
												<c:set value="${signupList }" var="signupList" />
												<c:set var="signupCount" value="0" />
													<c:choose>
														<c:when test="${empty signupList }">
															<tr>
																<td colspan="17" align="center">휴가 신청 정보가 존재하지 않습니다.</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${signupList }" var="signList" varStatus="status">
																<tr class="btn-reveal-trigger">
																	<td style="display: none;" id="signupVcatnCd" >${signList.vcatnCd }</td>
																	<td style="display: none;" id="signupSelfEmpno">${signList.vcatnSelfEmpno }</td>
																	<td style="display: none;" id="signupSelfEmpclsf">${signList.vcatnSelfEmpclsf }</td>
																	<td class="count align-middle white-space-nowrap" style="text-align: center; padding-left: 4px;">${status.count}</td>
																	<td class="date align-middle white-space-nowrap" style="text-align: center;">
																		<fmt:formatDate value="${signList.vcatnRqstdt }" pattern="yyyy-MM-dd"/>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;">
																		<c:if test="${signList.vcatnCl eq '1'}">연차휴가</c:if>
																		<c:if test="${signList.vcatnCl eq '2'}">오전반차</c:if>
																		<c:if test="${signList.vcatnCl eq '3'}">오후반차</c:if>
																		<c:if test="${signList.vcatnCl eq '4'}">기타</c:if>
																		<c:if test="${signList.vcatnCl eq '5'}">공가</c:if>
																		<c:if test="${signList.vcatnCl eq '6'}">병가</c:if>
																		<c:if test="${signList.vcatnCl eq '7'}">경조휴가</c:if>
																		<c:if test="${signList.vcatnCl eq '8'}">출산휴가</c:if>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;" id="signupSelfEmpse">
																		<c:if test="${signList.vcatnSelfEmpse eq 'a'}">원무과</c:if>
																		<c:if test="${signList.vcatnSelfEmpse eq 'd'}">의사과</c:if>
																		<c:if test="${signList.vcatnSelfEmpse eq 'n'}">간호과</c:if>
																		<c:if test="${signList.vcatnSelfEmpse eq 't'}">치료과</c:if>
																		<c:if test="${signList.vcatnSelfEmpse eq 'm'}">관리자</c:if>
																		<c:if test="${signList.vcatnSelfEmpse eq 'k'}">병원장</c:if>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;" id="signupSelfEmpnm">${signList.vcatnSelfEmpnm }</td>
																	<td class="start align-middle white-space-nowrap" style="text-align: center;">${signList.vcatnBgndt }</td>
																	<td class="end align-middle white-space-nowrap" style="text-align: center;">${signList.vcatnEnddt }</td>
																	<td class="align-middle white-space-nowrap" style="text-align: left; white-space: nowrap;
																		overflow: hidden; text-overflow: ellipsis; max-width: 100px;">${signList.vcatnResn }</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;">${signList.vcatnYrycCo }</td>
																	<td class="status align-middle white-space-nowrap" style="text-align: center;">
																		<c:if test="${signList.vcatnConfmStep eq 1}">
																			<button class="btn btn-primary btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">1차승인</button>
																		</c:if>
																		<c:if test="${signList.vcatnConfmStep eq 0}">
																			<button class="btn btn-primary btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">대기</button>
																		</c:if>
																	</td>
																</tr>
																<c:set var="signupCount" value="${signupCount + 1}" />
															</c:forEach>
														</c:otherwise>
													</c:choose>
													<tr class="btn-reveal-trigger" style="background: #EDF2F9;">
														<td colspan="17" align="left" style="font-weight: bold" onclick="event.stopPropagation()">총&nbsp;&nbsp;<span id="signupCount">${signupCount}</span> 건</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!-- 휴가 신청 테이블 끝 -->
									
								</div>	
								<!-- 휴가 신청 탭 끝 -->
								
								<!-- 휴가 전체 탭 시작 -->
								<div class="tab-pane fade" id="tab-allvac" role="tabpanel" aria-labelledby="allvac-tab">
									
									<!-- 휴가 전체 테이블 시작 -->
									<div class="table table-hover" id="vacationTable" >
										<div class="table-responsive scrollbar" style="height: 600px;">
											<table class="table table-sm table-hover data-table table-striped fs--1 mb-0 overflow-hidden" data-list='{"valueNames":["count","date","start","end", "status"]}'>
												<thead class="bg-200">
													<tr>
														<th class="text-900 sort pe-1" data-sort="count" style="text-align: center; padding-left: 4px;">번호</th>
														<th class="text-900 sort pe-1" data-sort="date" style="text-align: center;">신청일</th>
														<th class="text-900 sort pe-1" style="text-align: center;">구분</th>
														<th class="text-900 sort pe-1" style="text-align: center;">부서</th>
														<th class="text-900 sort pe-1" style="text-align: center;">신청자</th>
														<th class="text-900 sort pe-1" data-sort="start" style="text-align: center;">시작일</th>
														<th class="text-900 sort pe-1" data-sort="end" style="text-align: center;">종료일</th>
														<th class="text-900 sort pe-1" style="text-align: left; white-space: nowrap;
																overflow: hidden; text-overflow: ellipsis; max-width: 100px;">휴가사유</th>
														<th class="text-900 sort pe-1" style="text-align: center; min-width: 40px;">차감</th>
														<th class="text-900 sort pe-1" data-sort="status" style="text-align: center;">상태</th>
													</tr>
												</thead>
												<tbody class="list" id="table-vacation-body">
												<c:set value="${vacationList }" var="vacationList" />
													<c:choose>
														<c:when test="${empty vacationList }">
															<tr>
																<td colspan="17" align="center">휴가 신청 정보가 존재하지 않습니다.</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${vacationList }" var="vacList" varStatus="vacstatus">
																<tr class="btn-reveal-trigger" >
																	<td class="count align-middle white-space-nowrap" style="text-align: center; padding-left: 4px;">${vacstatus.count}</td>
																	<td class="date align-middle white-space-nowrap" style="text-align: center;">
																		<fmt:formatDate value="${vacList.vcatnRqstdt }" pattern="yyyy-MM-dd"/>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;">
																		<c:if test="${vacList.vcatnCl eq '1'}">연차휴가</c:if>
																		<c:if test="${vacList.vcatnCl eq '2'}">오전반차</c:if>
																		<c:if test="${vacList.vcatnCl eq '3'}">오후반차</c:if>
																		<c:if test="${vacList.vcatnCl eq '4'}">기타</c:if>
																		<c:if test="${vacList.vcatnCl eq '5'}">공가</c:if>
																		<c:if test="${vacList.vcatnCl eq '6'}">병가</c:if>
																		<c:if test="${vacList.vcatnCl eq '7'}">경조휴가</c:if>
																		<c:if test="${vacList.vcatnCl eq '8'}">출산휴가</c:if>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;" id="signupSelfEmpse">
																		<c:if test="${vacList.vcatnSelfEmpse eq 'a'}">원무과</c:if>
																		<c:if test="${vacList.vcatnSelfEmpse eq 'd'}">의사과</c:if>
																		<c:if test="${vacList.vcatnSelfEmpse eq 'n'}">간호과</c:if>
																		<c:if test="${vacList.vcatnSelfEmpse eq 't'}">치료과</c:if>
																		<c:if test="${vacList.vcatnSelfEmpse eq 'm'}">관리자</c:if>
																		<c:if test="${vacList.vcatnSelfEmpse eq 'k'}">병원장</c:if>
																	</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;" id="signupSelfEmpnm">${vacList.vcatnSelfEmpnm }</td>
																	<td class="start align-middle white-space-nowrap" style="text-align: center;">${vacList.vcatnBgndt }</td>
																	<td class="end align-middle white-space-nowrap" style="text-align: center;">${vacList.vcatnEnddt }</td>
																	<td class="align-middle white-space-nowrap" style="text-align: left; white-space: nowrap;
																		overflow: hidden; text-overflow: ellipsis; max-width: 100px;">${vacList.vcatnResn }</td>
																	<td class="align-middle white-space-nowrap" style="text-align: center;">${vacList.vcatnYrycCo }</td>
																	<td class="status align-middle white-space-nowrap" style="text-align: center;">
																		<c:if test="${vacList.vcatnConfmAt eq 'Y'}">
																			<button class="btn btn-success btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">승인</button>
																		</c:if>
																		<c:if test="${vacList.vcatnConfmAt eq 'N'}">
																			<button class="btn btn-danger btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">반려</button>
																		</c:if>
																		<c:if test="${vacList.vcatnConfmAt eq null}">
																			<c:if test="${vacList.vcatnConfmStep eq 1}">
																				<button class="btn btn-primary btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">1차승인</button>
																			</c:if>
																			<c:if test="${vacList.vcatnConfmStep eq 0}">
																				<button class="btn btn-primary btn-sm rounded-pill p-1" type="button" disabled="disabled" style="font-size: 12px;">대기</button>
																			</c:if>
																		</c:if>
																	</td>
																</tr>
															</c:forEach>
														</c:otherwise>
													</c:choose>
													<tr class="btn-reveal-trigger" style="background: #EDF2F9;">
														<td colspan="17" align="left" style="font-weight: bold" onclick="event.stopPropagation()">총&nbsp;&nbsp;<span id="vacCount">${vacCount}</span> 건</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!-- 휴가 신청 테이블 끝 -->
									
								</div>
								<!-- 휴가 전체 탭 끝 -->
								
							</div>
						</div>
						<!-- tab content 끝 -->
						
					</div>
					
				</div>
			</div>
			<!-- 탭 바디 끝 -->
			
		</div>
	</div>
</div>

<!-- 일정 등록 모달 시작 -->
<div class="modal fade" id="new-scheduler-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content border-0">
			<div class="position-absolute top-0 end-0 mt-2 me-3 z-1">
				<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base closeSchedulerBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue;">
					<h4 class="fw-semi-bold text-white p-0 m-0" id="textSchedulerTitle">일정 추가</h4>
				</div>
				<div class="p-4">
					<input type="hidden" value="F" id="updateFlag"/>
					<form action="/mediform/scheduler/insert" method="POST" class="row g-3" id="insertSchedulerForm">
						<input type="hidden" name="schdlEmpNo" id="schdlEmpNo" value="${customUser.employee.empNo}"/>
						<input type="hidden" name="schdlAllDay" value="" id="allDay"/>
						<input type="hidden" name="schdlCd" value="" id="schdlCd"/>
						<div class="col-md-6" id="hiddenPstgDt" style="display: none;">
							<label class="form-label" for="pstgDt">작성날짜</label>
							<input class="form-control" type="text" id="pstgDt" name="pstgDt" value="" disabled="disabled"/>
						</div>
						<div class="col-md-6" id="hiddenSchdlUpdDt" style="display: none;">
							<label class="form-label" for="schdlUpdDt">수정날짜</label>
							<input class="form-control" type="text" id="schdlUpdDt" name="schdlUpdDt" value="" disabled="disabled"/>
						</div>
						<div class="col-md-2">
							<label class="form-label" for="schdlDepartment">구분</label>
						</div>
						<div class="col-md-10">
							<select class="form-select form-select-sm schdlDepartment" name="schdlDep" aria-label="Default select example">
								<option class="" value="h" selected="selected">병원</option>
								<option class="" value="a">원무과</option>
								<option class="" value="d">의사</option>
								<option class="" value="n">간호과</option>
								<option class="" value="t">치료사</option>
								<option class="" value="my">내 일정</option>
							</select>
						</div>
						<div class="col-md-12">
							<label class="form-label" for="schdlNm">일정명</label>
							<input class="form-control" id="schdlNm" name="schdlNm" type="text" placeholder="일정명을 입력해 주세요." required="required"/>
						</div>
						<div class="input-group">
							<div class="col-md-4">
								<div class="form-check form-switch">
									<input class="form-check-input" id="schdlAllDay" type="checkbox" value=""/> 
									<label class="form-label" for="schdlAllDay">하루종일</label>
								</div>
							</div>
							<div class="col-md-2">
								<label class="form-label" for="schdlColor">중요도</label>
							</div>
							<div class="col-md-6">
								<select class="form-select schdlColor" id="schdlColor" name="schdlColor" aria-label="Default select example" required="required">
									<option class="bg-light" value="bg-light" selected="selected" disabled="disabled">중요도</option>
									<option class="bg-danger-subtle text-danger" value="bg-danger-subtle">★★★★★ 매우 중요</option>
									<option class="bg-warning-subtle text-warning" value="bg-warning-subtle">★★★★ 중요</option>
									<option class="bg-info-subtle text-info" value="bg-info-subtle">★★★ 보통</option>
									<option class="bg-success-subtle text-success" value="bg-success-subtle">★★ 낮음</option>
									<option class="bg-light" value="bg-light">★ 매우 낮음</option>
								</select>
							</div>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="schdlBgngDt">시작일</label>
							<input class="form-control datetimepicker" id="schdlBgngDt" name="schdlBgngDt" type="text" data-options='{"static":"true","enableTime":"true","format":"YYYY-MM-DD h:m"}' placeholder="시작일을 입력해 주세요." required="required"/>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="schdlEndDt">종료일</label>
							<input class="form-control datetimepicker" id="schdlEndDt" name="schdlEndDt" type="text" data-options='{"static":"true","enableTime":"true","format":"YYYY-MM-DD h:m"}' placeholder="종료일을 입력해 주세요." required="required"/>
						</div>
						<div class="col-md-12">
							<label class="form-label" for="schdlCn">일정 내용</label>
							<textarea class="form-control" id="schdlCn" name="schdlCn" rows="3" placeholder="일정내용을 입력해 주세요."></textarea>
						</div>
						<div class="col-md-12">
							<div align="right">
								<button class="btn btn-falcon-default btn-sm me-1 px-2" type="reset" id="resetSchedulerBtn">초기화</button>
								<button class="btn btn-primary btn-sm" type="button" id="updateSchedulerBtn" style="display: none; background-color: midnightblue; border-color: midnightblue;">수정</button>
								<button class="btn btn-danger btn-sm" type="button" id="deleteSchedulerBtn" style="display: none;" >삭제</button>
								<button class="btn btn-primary btn-sm" type="button" id="insertSchedulerBtn" style="background-color: midnightblue; border-color: midnightblue;">등록</button>
								<button class="btn btn-secondary btn-sm closeSchedulerBtn" type="button" data-bs-dismiss="modal" id="closeSchedulerBtn">닫기</button>
							</div>
						</div>
						<sec:csrfInput /> 
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 일정 등록 모달 끝 -->

<!-- 휴가 신청 모달 시작 -->
<div class="modal fade" id="new-vacation-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg mt-3 p-2" role="document" style="width: 700px;">
		<div class="modal-content border-0">
			<div class="p-5" style="color: black;">
				<form action="/mediform/vacation/insert" method="POST" class="row g-3" id="insertVacForm">
					<input type="hidden" name="vcatnSelfEmpno" id="vcatnSelfEmpno" value="${customUser.employee.empNo}"/>
				    <table class="vacation-table">
				        <tr>
				            <td class="vacation-cell vacation-title" rowspan="3" colspan="2">휴가신청서</td>
				            <td class="vacation-cell vacation-day p-3" rowspan="3">
				                <p>결</p>
				                <p>재</p>
				            </td>
				            <td class="vacation-cell vacation-label">기안자</td>
				            <td class="vacation-cell vacation-label">부결</td>
				            <td class="vacation-cell vacation-label">전결</td>
				        </tr>
				        <tr style="height: 70px;">
				            <td class="vacation-cell vacation-label"></td>
				            <td class="vacation-cell vacation-label"></td>
				            <td class="vacation-cell vacation-label"></td>
				        </tr>
				        <tr style="height: 20px;">
				            <td class="vacation-cell vacation-label" id="signDt"></td>
				            <td class="vacation-cell vacation-label"></td>
				            <td class="vacation-cell vacation-label"></td>
				        </tr>
				        <tr style="height: 50px;">
				            <td class="vacation-cell vacation-space">소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속</td>
				            <td class="vacation-cell vacation-content" colspan="5">
								<input class="p-0 m-0" type="hidden" name="vcatnSelfEmpse" id="vcatnSelfEmpse" value="${customUser.employee.empSe}"/>
								<P class="p-0 m-0" style="align-items: center">
									<c:if test="${customUser.employee.empSe eq 'a' }">
										원무과
										<input type="hidden" name="vcatnColor" value="slategray">
									</c:if>
									<c:if test="${customUser.employee.empSe eq 'd' }">
										의사과
										<input type="hidden" name="vcatnColor" value="dodgerblue">
									</c:if>
									<c:if test="${customUser.employee.empSe eq 'n' }">
										간호과
										<input type="hidden" name="vcatnColor" value="crimson">
									</c:if>
									<c:if test="${customUser.employee.empSe eq 't' }">
										치료과
										<input type="hidden" name="vcatnColor" value="teal">
									</c:if>
									<c:if test="${customUser.employee.empSe eq 'k' }">
										병원장
										<input type="hidden" name="vcatnColor" value="rebeccapurple">
									</c:if>
									<c:if test="${customUser.employee.empSe eq 'm' }">
										관리자
										<input type="hidden" name="vcatnColor" value="rebeccapurple">
									</c:if>
								</p>
				            </td>
				        </tr>
				        <tr style="height: 50px;">
				            <td class="vacation-cell vacation-space">직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위</td>
				            <td class="vacation-cell vacation-content" colspan="5">
				            	<input type="hidden" name="vcatnSelfEmpclsf" id="vcatnSelfEmpclsf" value="${customUser.employee.empClsf}"/>
				            	<P class="p-0 m-0" style="align-items: center">
									<c:if test="${customUser.employee.empClsf eq '1' }">일반</c:if>
									<c:if test="${customUser.employee.empClsf eq '0' }">과장</c:if>
								</p>
				            </td>
				        </tr>
				        <tr style="height: 50px;">
				            <td class="vacation-cell vacation-space">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
				            <td class="vacation-cell vacation-content" colspan="5" style="height: 50px; text-align: center;">
				            	${customUser.employee.empNm}
				            	<input class="p-0 m-0" type="hidden" name="vcatnSelfEmpnm" id="vcatnSelfEmpnm" value="${customUser.employee.empNm}"/>
				            </td>
				        </tr>
				        <tr style="height: 50px;">
				            <td class="vacation-cell vacation-space">휴가구분</td>
				            <td class="vacation-cell vacation-content pt-2" colspan="5" style="font-size: 16px;">
				                <div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" type="radio" value="1" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">연차휴가</label>
								</div>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" id="vcatnCl5" type="radio" value="2" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">오전반차</label>
								</div>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" id="vcatnCl6" type="radio" value="3" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">오후반차</label>
								</div>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" type="radio" value="4" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">기타</label>
								</div>
								<br>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" type="radio" value="5" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">공가</label>
								</div>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" type="radio" value="6" name="vcatnCl" />
									<label class="form-check-label" style="font-size: 1rem;">병가</label>
								</div>
								<div class="form-check form-check-inline pb-0 mb-0">
									<input class="form-check-input vcatnCl" type="radio" value="7" id="vcatnClSpeclRadio" name="vcatnCl" />
									<select class="form-select form-select-sm" id="vcatnClSpeclSelect" required="required" style="width: 150px; display: none;">
										<option value="0" disabled="disabled" selected="selected">경조휴가</option>
										<option value="5" >본인의 결혼</option>
										<option value="1">가족 결혼</option>
										<c:if test="${customUser.employee.empSexdstn eq 'M'}">
											<option value="10">배우자의 출산(1명)</option>
											<option value="15">배우자의 출산(2명 이상)</option>
										</c:if>
										<option value="5">부모나 배우자의 사망</option>
										<option value="3">조부모의 사망</option>
										<option value="3">자녀의 사망</option>
										<option value="3">형제자매의 사망</option>
									</select>
									<label class="form-check-label" style="font-size: 1rem;" id="vcatnClSpeclLabel">경조휴가</label>
								</div>
								<c:if test="${customUser.employee.empSexdstn eq 'F'}">
									<div class="form-check form-check-inline pb-0 mb-0">
										<input class="form-check-input vcatnCl" type="radio" value="8" id="vcatnClChldbrthRadio" name="vcatnCl" />
										<select class="form-select form-select-sm" id="vcatnClChldbrthSelect" required="required" style="width: 110px; display: none;">
											<option value="0" disabled="disabled" selected="selected">출산휴가</option>
											<option value="90" >1명</option>
											<option value="120" >2명 이상</option>
										</select>
										<label class="form-check-label" id="vcatnClChldbrthLabel" style="font-size: 1rem;">출산휴가</label>
									</div>
								</c:if>
				            </td>
				        </tr>
				        <tr style="height: 50px;">
				            <td class="vacation-cell vacation-space">일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;시</td>
				            <td class="vacation-cell vacation-content" colspan="5">
				            	<div class="" style="float: left;">
									<input class="form-control datetimepicker p-0" id="vcatnBgndt" name="vcatnBgndt" type="text" style=" text-align: center; height: 40px; width: 130px;"
									data-options='{"static":"true","format":"YYYY-MM-DD"}' placeholder="시작일 입력" required="required"/>
								</div>
								<div class="" style="float: left; height: 40px; display: flex; justify-content: space-around; align-items: center;">
									&nbsp;부터&nbsp;&nbsp;
								</div>
				            	<div class="" style="float: left;">
									<input class="form-control datetimepicker p-0" id="vcatnEnddt" name="vcatnEnddt" type="text" style="text-align: center; height: 40px; width: 130px;"
									data-options='{"static":"true","format":"YYYY-MM-DD"}' placeholder="종료일 입력" required="required"/>
								</div>
								<div class="" style="float: left; height: 40px; display: flex; justify-content: space-around; align-items: center;">
									&nbsp;까지&nbsp;&nbsp;
								</div>
								<div class="" style="float: left; display: flex; justify-content: space-around; align-items: center;">
									<button type="button" class="p-0 btn btn-sm btn-falcon-default me-2" style="float: left; height: 30px; width: 40px; font-size: 14px;" id="vcatnYrycCoBtn">계산</button>
									<input class="form-control pe-0" type="text" style="float: left; height: 40px; width: 55px; display: flex; align-items: center; justify-content: flex-end;" readonly="readonly" id="vcatnYrycCoShow"/>
								</div>
								<div class="p-0" style="float: left; height: 40px; display: flex; justify-content: space-around; align-items: center;">일간</div>
								<br/>
								<div>
									<div class="input-group input-group-sm">
										<span class="input-group-text">사용가능</span>
										<input class="form-control" type="text" id="vcatnYrycRemndr" style="letter-spacing: 1px;" readonly="readonly"/>
										<span class="input-group-text">차감</span>
										<input class="form-control" type="text" id="vcatnYrycCo" name="vcatnYrycCo" style="letter-spacing: 1px;" readonly="readonly"/>
										<span class="input-group-text">차감 후</span>
										<input class="form-control" type="text" id="vcatnYrycCoAfter" style="letter-spacing: 1px;" readonly="readonly"/>
									</div>
								</div>
				            </td>
				        </tr>
				        <tr style="height: 100px;">
				            <td class="vacation-cell vacation-space">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;유</td>
				            <td class="vacation-cell vacation-content" colspan="5">
				            	<textarea class="form-control" id="vcatnResn" name="vcatnResn" rows="4" ></textarea>
				            </td>
				        </tr>
				        <tr style="height: 220px;">
				            <td class="vacation-cell vacation-content" colspan="6">
				            	<br>
				            	<br>
				                <p>위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</p>
				                <br>
				                <p>
				                <P class="pb-0 mb-0" id="vcatnRqstdtShow" style="height: 40px; width: 300px; margin-left: 150px; text-align: center;"></p>
				                <div class="p-4" style="display: flex; justify-content: flex-end; align-items: center;">
				                	<div class="p-0" style="float: left; text-align: center;">성&nbsp;명&nbsp;:&nbsp;&nbsp;</div>
				                	<P class="p-0 m-0" style="float: left; height: 30px; display: flex; width: 100px; align-items: center; justify-content: center;">${customUser.employee.empNm}</p>
				                	<p class="p-0 m-0" style="float: left;">&nbsp;&nbsp;&nbsp;(인) </p>
				                </div>
				            </td>
				        </tr>
				    </table>
					<div class="col-md-12">
						<div class="pt-3" align="right">
							<button class="btn btn-falcon-default me-1" type="reset" id="resetVacBtn">초기화</button>
							<button class="btn me-1 text-white" type="button" id="insertVacBtn" style="background-color: midnightblue; border-color: midnightblue;">신청</button>
							<button class="btn btn-secondary closeVacBtn" type="button" data-bs-dismiss="modal" id="closeVacBtn">닫기</button>
						</div>
					</div>
				    <sec:csrfInput /> 
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 휴가 신청 모달 끝 -->


</body>

<link href="${pageContext.request.contextPath }/resources/vendors/flatpickr/flatpickr.min.css" rel="stylesheet" />
<script	src="${pageContext.request.contextPath }/resources/assets/js/flatpickr.js"></script>
<script type="text/javascript">
// console.log(updateFlag);


//////////////////////////////////////////////////////////////////
// 캘린더 이벤트 스크립트 시작

// 날짜 형식화 함수
function formatDate(date){
	var year = date.getFullYear();
	var month = String(date.getMonth() + 1).padStart(2, '0');
	var day = String(date.getDate()).padStart(2, '0');
	return year + "-" + month + "-" + day;
}

//날짜 형식화(년월일)
function formatDate2(date){
	var year = date.getFullYear();
	var month = String(date.getMonth() + 1).padStart(2, '0');
	var day = String(date.getDate()).padStart(2, '0');
	return year + "년 " + month + "월 " + day + "일";
}

// 날짜 형식화(.)
function formatDate3(date){
	var year = date.getFullYear().toString().substring(2, 4);
	var month = String(date.getMonth() + 1).padStart(2, '0');
	var day = String(date.getDate()).padStart(2, '0');
	return year + "." + month + "." + day;
}

// 시간 형식화 함수
function formatTime(date){
	var hour = date.getHours().toString().padStart(2,'0');
	var minute = date.getMinutes().toString().padStart(2,'0');
	return hour + ":" + minute;
}

//날짜 형식화
function dateFormate(date){
	var year = date.getFullYear();
	var month = String(date.getMonth() + 1).padStart(2, '0');
	var day = String(date.getDate()).padStart(2, '0');
	var hour = date.getHours().toString().padStart(2,'0');
	var minute = date.getMinutes().toString().padStart(2,'0');
	return year + "-" + month + "-" + day + " " + hour + ":" + minute;
}

// datetimepicker 초기화 및 형식화 함수
function datetimepicker(date, id){
	$('#' + id).val(date);
	$('#' + id).flatpickr({
	    enableTime: true,
	    dateFormat: "Y-m-d H:i", 												// 날짜 및 시간 형식
	    defaultDate: date, 														// 시작일 값 설정
	    onChange: function (selectedDates, dateStr, instance) {
            start = dateStr.substring(0, 10);
            end = dateStr.substring(0, 10);
            allDayFunction(start, end);
        }
	});
	return date;
}

// 한달간의 날짜
$(function() {
	var today = new Date();																// 현재시간
    var first = new Date(today.getFullYear(), today.getMonth());						// 첫날
    var last = new Date(today.getFullYear(), today.getMonth()+1, 0);					// 끝날
    var firstDay = formatDate(first);
    var lastDay = formatDate(last);
    
	$("#searchSchedulerStart").attr("placeholder", firstDay);
	$("#searchSchedulerEnd").attr("placeholder", lastDay);
	
	$("#searchVacStart").attr("placeholder", firstDay);
	$("#searchVacEnd").attr("placeholder", lastDay);
});

// 하루종일
function allDayFunction(start, end){
	console.log(start);
	console.log(end);
	
	$("#schdlAllDay").on("change",function(){
		var schdlBgngDt = $("#schdlBgngDt");
		var schdlEndDt = $("#schdlEndDt");
		
		if($(this).is(":checked")){
			schdlBgngDt.readOnly = true;
			schdlBgngDt.val((start.toString() + ' 00:00'));
			schdlEndDt.readOnly = true;
			schdlEndDt.val((end.toString() + ' 23:59'));
			$(this).val("true");
		}else{
			schdlBgngDt.readOnly = false;
			schdlBgngDt.val("");
			schdlEndDt.readOnly = false;
			schdlEndDt.val("");
		}
	});
}

// 폼 초기화 함수
function resetForm(){
	$("#hiddenPstgDt").hide();
	$("#hiddenSchdlUpdDt").hide();
	$("#updateSchedulerBtn").hide();
	$("#insertSchedulerBtn").show();
	$("#deleteSchedulerBtn").hide();
	$("#textSchedulerTitle").html('일정추가');
	$("#insertSchedulerForm")[0].reset();
}

//폼 데이터 초기화
function resetDataForm(){
    $("#pstgDt").val("");
    $("#allDay").val("");
    $("#schdlCd").val("");
    $("#schdlUpdDt").val("");
    $("#schdlDepartment").val("");
    $("#schdlNm").val("");
    $("#schdlAllDay").val("");
    $("#schdlColor").val("");
    $("#schdlBgngDt").val("");
    $("#schdlEndDt").val("");

}

function beginEnd(){
	var schdlBgngDt = $("#schdlBgngDt").val();
    var schdlEndDt = $("#schdlEndDt").val();
    
    // 시작일자 > 종료일자 일때
    if(schdlBgngDt >= schdlEndDt){
    	Swal.fire({
		      title: "일자 변경 안내",
		      text: "종료일자는 시작일자보다 이후여야합니다.",
		      icon: 'error',
		      confirmButtonColor: 'gray',
		      confirmButtonText: '닫기'
		    });
    	return "f";
    }
    return "t";
}

// 유효검사
function isNullfnt(){
	var nullFlag = false;
	var schdlNm = $("#schdlNm").val();
	var schdlColor = $("#schdlColor").val();
	var schdlBgngDt = $("#schdlBgngDt").val();
	var schdlEndDt = $("#schdlEndDt").val();
	var schdlCn = $("#schdlCn").val();
	
	if(
		schdlNm == null || schdlNm == "" ||
		schdlColor == null || schdlColor == "" ||
		schdlBgngDt == null || schdlBgngDt == "" ||
		schdlEndDt == null || schdlEndDt == "" ||
		schdlCn == null || schdlCn == ""
	){
		if(schdlNm == null || schdlNm == ""){
			Swal.fire({
				title: "일정명 입력",
				text: "일정명을 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(schdlColor == null || schdlColor == ""){
			Swal.fire({
				title: "중요도 입력",
				text: "중요도를 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(schdlBgngDt == null || schdlBgngDt == ""){
			Swal.fire({
				title: "시작일 입력",
				text: "시작일을 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(schdlEndDt == null || schdlEndDt == ""){
			Swal.fire({
				title: "종료일을 입력",
				text: "종료일을 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(schdlCn == null || schdlCn == ""){
			Swal.fire({
				title: "내용 입력",
				text: "일정 내용을 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		nullFlag = false;
	}else{
		nullFlag = true;
	}
	return nullFlag;
}

$("#searchBtn").on('click',function(){
	var searchWord = $("#searchWord").val();
	if(searchWord == null || searchWord == ""){
		Swal.fire({
			title: "날짜 입력",
			text: "날짜를 입력해주세요.",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기'
		});
		return false;
	}
});

// 일정 등록(버튼 클릭시)
$("#newSchedulerBtn").on("click",function(){
	resetForm();
	resetDataForm();
// 	console.log(updateFlag);
	if(updateFlag == "F"){
	    var date = new Date();														// 현재시간
		var start = formatDate(date);												// 시작날짜 셋팅
		var end = formatDate(date);													// 종료날짜 셋팅
		var startFormat = start + ' ' + formatTime(date);							// 시작날짜 셋팅
		var endFormat = end + ' ' + formatTime(date);								// 종료날짜 셋팅
		
		datetimepicker(startFormat, 'schdlBgngDt');
		datetimepicker(endFormat, 'schdlEndDt');
		
		$('#schdlBgngDt, #schdlEndDt').on('change',function(){
			start = $("#schdlBgngDt").val().toString().substring(0, 10);
			end = $("#schdlEndDt").val().toString().substring(0, 10);
		});
		
		allDayFunction(start, end);
		
		var btnText = $("#insertSchedulerBtn").text();
		if(btnText == "등록"){
			$("#insertSchedulerBtn").on("click",function(){
				var nullFlag = isNullfnt();
				if(nullFlag){
					var flag = beginEnd();
					if(flag == "t"){
					    $("#allDay").val("false");
					    if($("#schdlAllDay").is(":checked")){
					    	$("#allDay").val("true");
					    }
					    var insertForm = $("#insertSchedulerForm");
					    insertForm.attr("action", "/mediform/scheduler/insert");	
					    insertForm.submit();
					}
				}
			});
		}
	}
});

// 일정 등록(날짜 클릭시)
function NewSchedulerModal(info){
	resetForm();
	resetDataForm();
	$('#new-scheduler-modal').modal('show');
    
	var start = info.startStr; 											// 선택된 시작 날짜
	var eventEnd1 = new Date(info.endStr); 								// 선택된 종료 날짜(+1)
	var eventEnd = new Date(eventEnd1);
	eventEnd.setDate(eventEnd1.getDate() - 1);							// 종료일자 - 1일
	var end = eventEnd.toISOString().substring(0,10);					// allDay 함수로 넘길 종료일
	
	var date = new Date();												// 시스템 시간
	var startSet = start + ' ' + formatTime(date);						// 시작날짜 셋팅
	var endSet = formatDate(eventEnd) + ' ' + formatTime(date);	// 종료날짜 셋팅

	datetimepicker(startSet, 'schdlBgngDt');
	datetimepicker(endSet, 'schdlEndDt');
	
	allDayFunction(start, end);
	
	var btnText = $("#insertSchedulerBtn").text();
	if(btnText == "등록"){
		$("#insertSchedulerBtn").on("click",function(){
			var nullFlag = isNullfnt();
			if(nullFlag){
				var flag = beginEnd();
				if(flag == "t"){
				    $("#allDay").val("false");
				    if($("#schdlAllDay").is(":checked")){
				    	$("#allDay").val("true");
				    }
				    var insertForm = $("#insertSchedulerForm");
				    insertForm.attr("action", "/mediform/scheduler/insert");	
				    insertForm.submit();
				}
			}
		});
	}
}

// 닫기 버튼 클릭시
$(".closeSchedulerBtn").on("click", function(){
	updateFlag = "F";
	resetForm();
});

// 일정 상세보기 & 수정 & 삭제
function detailModal(info, updateFlag){
	if(updateFlag == "T"){											// updateFlag가 "T"일때만 수정 실행
		$("#new-scheduler-modal").modal('show');
		$("#textSchedulerTitle").html("일정 상세");
		$("#hiddenPstgDt").show();
		$("#hiddenSchdlUpdDt").show();
	    $("#updateSchedulerBtn").show();
	    $("#deleteSchedulerBtn").show();
	    $("#insertSchedulerBtn").hide();
		
		var id = info.event.id;
		var dep = info.event.extendedProps.schdlDep;
		var title = info.event.title;
		var className = info.event.classNames;
		var allDay = info.event.extendedProps.schdlAllDay;
		var description = info.event.extendedProps.description;
		
		var start = info.event.start;										// 날짜 시작일
		var startSet = dateFormate(start);
		var end = info.event.end;											// 날짜 종료일
		var endSet = dateFormate(end);
		var pstgDt = info.event.extendedProps.pstgDt;						// 작성일
		
		var schdlUpdDt = info.event.extendedProps.schdlUpdDt;
		console.log("schdlUpdDt>> " + schdlUpdDt);
		if(schdlUpdDt != null && schdlUpdDt != ""){
			$("#schdlUpdDt").val(schdlUpdDt);
		}else{
			$("#schdlUpdDt").val("");
		}
		
		$("#schdlCd").val(id);
		$(".schdlDepartment").val(dep).change();
		$("#schdlNm").val(title);
		$(".schdlColor").val(className).change();
		$("#pstgDt").val(pstgDt);
		$("#schdlCn").val(description);

		if(allDay == "true") {
			$("#schdlAllDay").prop("checked", true);
		    $("#allDay").val("true");
		} else {
			$("#schdlAllDay").prop("checked", false);
		    $("#allDay").val("false");
		}
		
		// 하루종일 날짜
		var startAllDay = formatDate(start);
		var endAllDay = formatDate(end);
		allDayFunction(startAllDay, endAllDay);
		
		datetimepicker(startSet, 'schdlBgngDt');						// datetimepicker 셋팅
		datetimepicker(endSet, 'schdlEndDt');
	    
	    var btnText = $("#updateSchedulerBtn").text();
		if(btnText == "수정"){
			$("#updateSchedulerBtn").on("click",function(){
				var nullFlag = isNullfnt();
				if(nullFlag){
					var flag = beginEnd();
					if(flag == "t"){
						Swal.fire({
							icon: 'info',
							title: '수정',
							text: '수정을 진행하시겠습니까?',
							showCancelButton: true,
							confirmButtonText: '확인',
							cancelButtonText: '취소',
							confirmButtonColor: 'midnightblue',
							cancelButtonColor: 'red'
						}).then(result => {
							if(result.isConfirmed){
								var insertForm = $("#insertSchedulerForm");
								insertForm.attr("action", "/mediform/scheduler/update");	
								insertForm.submit();
							}else{
								return;
								$("#new-scheduler-modal").modal('hide');
							}
						});
					}
				}
			});
			updateFlag = "F";
// 			console.log("수정 updateFlag : " + updateFlag);
		}
	    
		$("#deleteSchedulerBtn").css('display','line-block');
	    // 삭제 버튼
		$("#deleteSchedulerBtn").on("click",function(){
			var btnText = $(this).text();
	    	
	    	if(btnText == "삭제"){
	    		Swal.fire({
	    			icon: 'warning',
	    			title: '삭제',
	    			text: '삭제를 진행하시겠습니까?',
	    			showCancelButton: true,
	    			confirmButtonText: '확인',
	    			cancelButtonText: '취소',
	    			confirmButtonColor: 'midnightblue',
	    			cancelButtonColor: 'red'
	    		}).then(result => {
	    			if(result.isConfirmed){
	    				var insertForm = $("#insertSchedulerForm");
						insertForm.attr("action", "/mediform/scheduler/delete");
						insertForm.submit();
	    			}else{
	    				return;
	    				$("#new-scheduler-modal").modal('hide');
	    			}
	    		});
	    	}
			updateFlag = "F";
// 			console.log("삭제 updateFlag : " + updateFlag);
		});
	    
	}else{ // 일정 상세보기 & 수정 & 삭제 updateFlag 'F'일때
		Swal.fire({
			title: '일정 상세 결과',
			text: "서버 오류! 다시 시도해주세요.",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기',
		});
		return false;
		resetForm();
		resetDataForm();
	}
}

// 드래그 앤 드롭 기능
function dragDropUpdate(info, updateFlag) {
// 	console.log("드래그 앤 드롭 기능 updateFlag : " + updateFlag);
	if(updateFlag == "T"){					// updateFlag T일때
		var id = info.event.id;
		var title = info.event.title;
		var dep = info.event.extendedProps.schdlDep;
		var description = info.event.extendedProps.description;
		var pstgDt = info.event.extendedProps.pstgDt;
		var className = info.event.classNames;
		var allDay = info.event.extendedProps.schdlAllDay;
		
		$("#schdlCd").val(id);
		$("#schdlNm").val(title);
		$(".schdlDepartment").val(dep).change();
		$("#schdlCn").val(description);
		$("#pstgDt").val(pstgDt);
		$(".schdlColor").val(className).change();
		
		$("#allDay").val("false");
	    if(allDay == "true"){
	    	$("#allDay").val("true");
	    }

		// 형식에 맞춘 날짜
		var start = info.event.start;										// 날짜 시작일
		var startSet = dateFormate(start);
		var end = info.event.end;											// 날짜 종료일
		var startEnd = dateFormate(end);
		
		$("#schdlBgngDt").val(startSet);
 	    $("#schdlEndDt").val(startEnd);
		
		Swal.fire({
		      icon: 'info',
		      title: '수정',
		      text: '수정을 진행하시겠습니까?',
		      showCancelButton: true,
		      confirmButtonText: '확인',
		      cancelButtonText: '취소',
		      confirmButtonColor: 'midnightblue',
		      cancelButtonColor: 'red',
		}).then(result => {
			if(result.isConfirmed){
				var insertForm = $("#insertSchedulerForm");
				insertForm.attr("action", "/mediform/scheduler/update");	
				insertForm.submit();
			}else{
				$("#new-scheduler-modal").modal('hide');
			}
		});
		
		updateFlag = "F";
// 		console.log("드래그앤드랍 수정 updateFlag : " + updateFlag);
		
	}else{ // 일정 수정 updateFlag 'F'일때
		Swal.fire({
			title: '서버 오류',
			text: "다시 시도해주세요.",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기',
		});
		return false;
		resetForm();
	}
}

// 캘린더 이벤트 스크립트 끝

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 일정 list 스크립트 시작

$("#allSchBtn").on('click',function(){
	location.href = "/mediform/scheduler/main";
});

// 필터 적용(버튼필터)
var html = "";
var schedulerFlag = false;
var schdlDep;

$(".filterBtn").click(function() {
// 	console.log($(this).val());
    html = "<input type='hidden' name='schdlDep' id='schdlDep' value='" + $(this).val() + "'>";
    schedulerFlag = true;
	
    if(schedulerFlag){
		html += "<input type='hidden' name='filterFlag' value='true'>";
    }
	$("#searchForm").append(html);
// 	console.log($("#searchForm").html());
	
	$("#searchForm").submit();
});

$("#schDateFilterBtn").on('click', function() {
	if($("#searchSchedulerStart").val() == null || $("#searchSchedulerStart").val() == ""){
		Swal.fire({
			title: "시작일 입력",
			text: "시작일을 입력하세요!",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기'
		});
		return false;
	}
	if($("#searchSchedulerEnd").val() == null || $("#searchSchedulerEnd").val() == ""){
		Swal.fire({
			title: "종료일 입력",
			text: "종료일을 입력하세요!",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기'
		});
		return false;
	}
	
	var sSS = new Date($("#searchSchedulerStart").val());
	var sSE = new Date($("#searchSchedulerEnd").val());
	var formatSSS = formatDate(sSS);
	var formatSSE = formatDate(sSE);
	
	if(sSS > sSE){
		Swal.fire({
			title: "일자 변경 안내",
			text: "종료일자는 시작일자보다 이후여야합니다.",
			icon: 'error',
			confirmButtonColor: 'gray',
			confirmButtonText: '닫기'
		});
	}else{
		html = "<input type='hidden' name='searchFilterSchStart' value='" + formatSSS + "'>";
	    html += "<input type='hidden' name='searchFilterSchEnd' value='" + formatSSE + "'>";
	    schedulerFlag = true;
		
	    if(schedulerFlag){
			html += "<input type='hidden' name='filterFlag' value='true'>";
	    }
// 	    console.log(html);
		$("#searchForm").append(html);
		
		$("#searchForm").submit();
	}
});

// 페이징
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

$(function(){
	$("#allResetButton").on('click',function(){
		location.href = "/mediform/scheduler/main";
	});
});

// 일정 list 스크립트 끝

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 유효검사
function vacIsNullfnt(){
	var nullFlag = false;
	var signDt = $("#signDt").val();
	var vcatnSelfEmpse = $("#vcatnSelfEmpse").val();
	var vcatnSelfEmpclsf = $("#vcatnSelfEmpclsf").val();
	var vcatnSelfEmpnm = $("#vcatnSelfEmpnm").val();
	var vcatnYrycCoShow = $("#vcatnYrycCoShow").val();
	var vcatnResn = $("#vcatnResn").val();
	var signDt = $("#signDt").val();

	if(
		vcatnResn == null || vcatnResn == "" ||
		vcatnSelfEmpse == null || vcatnSelfEmpse == "" ||
		vcatnSelfEmpclsf == null || vcatnSelfEmpclsf == "" ||
		vcatnSelfEmpnm == null || vcatnSelfEmpnm == "" ||
		vcatnYrycCoShow == null || vcatnYrycCoShow == "" ||
		vcatnResn == null || vcatnResn == ""
	){
		if(vcatnSelfEmpse == null || vcatnSelfEmpse == ""){
			Swal.fire({
				title: "부서 확인",
				text: "부서를 확인하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(vcatnSelfEmpclsf == null || vcatnSelfEmpclsf == ""){
			Swal.fire({
				title: "직위 확인",
				text: "직위를 확인하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(vcatnSelfEmpnm == null || vcatnSelfEmpnm == ""){
			Swal.fire({
				title: "이름 확인",
				text: "휴가 사유를 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(vcatnYrycCoShow == null || vcatnYrycCoShow == ""){
			Swal.fire({
				title: "차감수 계산",
				text: "사용 차감수를 계산해 주세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		if(vcatnResn == null || vcatnResn == ""){
			Swal.fire({
				title: "휴가 사유 입력",
				text: "휴가 사유를 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
		}
		nullFlag = false;
	}else{
		nullFlag = true;
	}
	return nullFlag;
}

// 휴가 신청
$("#newVacationBtn").on("click",function(){
    var date = new Date();													// 현재시간
    var today = formatDate2(date);
	$("#vcatnRqstdtShow").text(today);
    var signdt = formatDate3(date);
    console.log("signdt>> " + signdt);
	$("#signDt").text(signdt);
	
	// 셀랙박스 show hide
	$(".vcatnCl").on('click',function(){
		if($(this).val() === '7'){
			$("#vcatnClSpeclLabel").hide();
			$("#vcatnClSpeclSelect").show();
			$("#vcatnClChldbrthSelect").hide();
			$("#vcatnClChldbrthLabel").show();
		}else if($(this).val() === '8'){
			$("#vcatnClChldbrthLabel").hide();
			$("#vcatnClChldbrthSelect").show();
			$("#vcatnClSpeclSelect").hide();
			$("#vcatnClSpeclLabel").show();
		}else{
			$("#vcatnClSpeclSelect").hide();
			$("#vcatnClSpeclLabel").show();
			$("#vcatnClChldbrthSelect").hide();
			$("#vcatnClChldbrthLabel").show();
		}
	});
	
	// 연차 사용 갯수 계산
	$("#vcatnYrycCoBtn").on('click', function() {
		var selectedvcatnCl = $(".vcatnCl:checked").val();
// 		console.log(selectedvcatnCl);
	    if (selectedvcatnCl != null) { // 연차구분 체크 여부
	        var vcatnBgndt = $("#vcatnBgndt").val();
	        if (vcatnBgndt != null && vcatnBgndt != "") { // 시작일 입력 여부
	            var vcatnEnddt = $("#vcatnEnddt").val();
	            if (vcatnEnddt != null && vcatnEnddt != "") { // 종료일 입력 여부
                    if (vcatnBgndt > vcatnEnddt) { // 시작일 > 종료일 체크
						Swal.fire({
							title: "일자 변경 안내",
							text: "종료일자는 시작일자보다 이후여야합니다.",
							icon: 'error',
							confirmButtonColor: 'gray',
							confirmButtonText: '닫기'
						});
                    }else{
					    var vcatnBgndt = $("#vcatnBgndt").val() ? new Date($("#vcatnBgndt").val()) : null;
				        var vcatnEnddt = $("#vcatnEnddt").val() ? new Date($("#vcatnEnddt").val()) : null;
	                	
	                	var loginEmpYrycRemndr = $("#loginEmpYrycRemndr").val();				// 로그인한 사람의 남은 연차수
	                	var loginEmpOffhodRemndr = $("#loginEmpOffhodRemndr").val();			// 로그인 남은 공가수
	                	var loginEmpSicknsRemndr = $("#loginEmpSicknsRemndr").val();			// 로그인 남은 병가수
	                	
	                	var day = (vcatnEnddt - vcatnBgndt) / (1000 * 60 * 60 * 24) + 1;		// 일수
	                	var count = 1;															// 차감 개수
	                	var remindeCount = 0;													// 사용가능 개수
	                	var afterCount = 0;														// 차감 후 개수
	                	var canFlag = false;
	                	
	                	if(selectedvcatnCl === '1' || selectedvcatnCl === '4'){					// 연차휴가/기타
	                		remindeCount = loginEmpYrycRemndr;
	                	}else if(selectedvcatnCl === '2' || selectedvcatnCl === '3'){			// 반차
							count = 0.5;
							remindeCount = loginEmpYrycRemndr;
						}else if(selectedvcatnCl === '5'){										// 공가
							remindeCount = loginEmpOffhodRemndr;
// 							console.log(remindeCount);
						}else if(selectedvcatnCl === '6'){										// 병가
							remindeCount = loginEmpSicknsRemndr;
// 							console.log(remindeCount);
						}else if(selectedvcatnCl === '7'){										// 경조휴가
							remindeCount = $("#vcatnClSpeclSelect").val();
// 							console.log(remindeCount);
							if(remindeCount === '0'){
								Swal.fire({
									title: "휴가 분류 선택 안내",
									text: "경조휴가 분류를 선택하세요",
									icon: 'error',
									confirmButtonColor: 'gray',
									confirmButtonText: '닫기'
								});
							}
							canFlag = true;
						}else if(selectedvcatnCl === '8'){										// 출산휴가
							remindeCount = $("#vcatnClChldbrthSelect").val();
// 							console.log(remindeCount);
							if(remindeCount === '0'){
								Swal.fire({
									title: "휴가 분류 선택 안내",
									text: "출산휴가 분류를 선택하세요",
									icon: 'error',
									confirmButtonColor: 'gray',
									confirmButtonText: '닫기'
								});
							}
		                	canFlag = true;
						}
	                	var useCount = Number(day * count);												// 일수 * 카운트 = 차감수
	                	var parseRemindeCount = Number(remindeCount);
	                	
	                	if(canFlag){
	                		var useCanCount = (parseRemindeCount - useCount);
	                		if(useCanCount < 0){
								Swal.fire({
									title: '날짜 조정 안내',
									text: "사용 가능 일수를 (" + Math.abs(useCanCount) + "일) 초과하였습니다.",
									icon: 'error',
									confirmButtonText: '확인',
									confirmButtonColor: 'midnightblue'
								});
		                	}else{
								$("#vcatnYrycRemndr").val(parseRemindeCount);
								$("#vcatnYrycCo").val("-");
								$("#vcatnYrycCoAfter").val("-");
		                		$("#vcatnYrycCoShow").val(day);
		                	}
	                	}else{
	                		afterCount = (parseRemindeCount - useCount);
		                	if(afterCount < 0){
								Swal.fire({
									title: '날짜 조정 안내',
									text: "사용 가능 개수를 (" + Math.abs(afterCount) + ")개 초과하였습니다.",
									icon: 'error',
									confirmButtonText: '확인',
									confirmButtonColor: 'midnightblue'
								});
		                	}else{
								$("#vcatnYrycRemndr").val(parseRemindeCount);
								$("#vcatnYrycCo").val(useCount);
								$("#vcatnYrycCoAfter").val(afterCount);
		                		$("#vcatnYrycCoShow").val(day);
		                	}
	                	}
	                }
	            }else{
					Swal.fire({
						title: '종료일 입력 안내',
						text: "종료일을 입력 하세요",
						icon: 'error',
						confirmButtonText: '확인',
						confirmButtonColor: 'midnightblue'
					});
	                $("#vcatnEnddt").focus();
	            }
	        }else{
				Swal.fire({
					title: '시작일 입력 안내',
					text: "시작일을 입력 하세요",
					icon: 'error',
					confirmButtonText: '확인',
					confirmButtonColor: 'midnightblue'
				});
	            $("#vcatnBgndt").focus();
	        }
	    } else {
			Swal.fire({
				title: '연차 구분 안내',
				text: "연차 구분을 선택하세요",
				icon: 'error',
				confirmButtonText: '확인',
				confirmButtonColor: 'midnightblue'
			});
	        $(".vcatnCl")[0].focus();
	    }
	});

	// 휴가 신청 등록
	$("#insertVacBtn").on("click",function(){
		var nullFlag = vacIsNullfnt();
		if(nullFlag){
			Swal.fire({
				icon: 'warning',
				title: '휴가 신청',
				text: '휴가를 신청하시겠습니까?',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				confirmButtonColor: 'midnightblue',
				cancelButtonColor: 'red'
			}).then(result => {
				if(result.isConfirmed){
					$("#insertVacForm").submit();
				}else{
					return;
				}
			});
		}
		
	});
});

//폼 초기화
function closeReset(){
	$(".vacNm1").text('');
	$("#vacReprsntEmpno").text('');
	$("#vacConfirmerEmpno").text('');
	$(".writeDt3").text('');
	$("#vacConfmDt1").text('');
	$("#vacConfmDt2").text('');
	$(".vacDep").text('');
	$(".vacClsf").text('');
	$(".vacNm").text('');
	$(".vacCl").text('');
	$(".vacDt").text('');
	$(".vacReson").text('');
	$(".writeDt").text('');
	$(".writeName").text('');

    $(".vacNm1").html('');
    $("#vacReprsntEmpno").html('');
    $("#vacConfirmerEmpno").html('');
    $(".writeDt3").html('');
    $("#vacConfmDt1").html('');
    $("#vacConfmDt2").html('');
    $(".vacDep").html('');
    $(".vacClsf").html('');
    $(".vacNm").html('');
    $(".vacCl").html('');
    $(".vacDt").html('');
    $(".vacReson").html('');
    $(".writeDt").html('');
    $(".writeName").html('');
}

// 닫기 버튼 클릭시 초기화
$(".closeVacBtn").on("click", function(){
	closeReset();
});

// 휴가 결재 이동
$("#vacationAppBtn").on('click',function(){
	location.href = "/mediform/vacation/main";
});

</script>
</html>