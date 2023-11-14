<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link href="/resources/vendors/flatpickr/flatpickr.min.css" rel="stylesheet" />
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
</style>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

// 캘린더 데이터
$(document).ready(function() {
	$.ajax({
		type: "GET",
		url: "/mediform/admin/reservation/scheduler/list",
		dataType: 'json',
		contentType: "application/json; charset=utf-8",
		beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(param) {
        	console.log(param);
        	
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
        		height: '690px',
        		navLinks : true, 				// 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        		events : param,
        		locale : 'ko' 					// 한국어 설정
        	});
        	calendar.render();
        },	// success
        error: function(){
        	console.log("에러발생");
        }
	});
});

// 캘린더 초기화, 생성
function InitCalender(param){
	
}
</script>
</head>
<c:set var="customUser"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<style>
.table thead {
	position: sticky;
	top: 0;
/* 	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */ */
}
</style>

<div class="row">

	<div class="col-5">

		<div class="card border border-secondary" style="height: 820px;">

			<div class="card-header border-bottom p-2"
				style="height: 35px; background-color: midnightblue">
				<div class="row">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="">
							환자조회</h5>
					</div>

				</div>
			</div>


			<div class="row">
					<div class="col-8 pe-0">
						<div class="search-box w-100" id="">
							<form class="position-relative" data-bs-toggle="search">
								<input class="form-control form-control-sm" type="search" placeholder="환자명 또는 환자번호를 입력해 주세요." aria-label="Search"
										name="searchPatientWord" id="patientInput" style="font-style: italic;"/>
						 	</form>
						 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
								<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
							</div>
							<div class="dropdown-menu p-0 m-0 font-base overflow-hidden w-100" id="patientDropMenu">
								<div class="card p-0 m-0 scrollbar" style="height: 180px;">
									<div id="" class="">
										<div class="d-flex align-items-center">
											<table class="table table-sm text-center table-hover w-100">
												<thead>
													<tr class="bg-white">
														<td class="text-900 sort text-center">환자명</td>
														<td class="text-900 sort text-center">환자번호</td>
														<td class="text-900 sort text-center">나이</td>
														<td class="text-900 sort text-center" style="min-width: 40px;">성별</td>
														<td class="text-900 sort text-center" style="min-width: 80px;">생년월일</td>
													</tr>
												</thead>
												<tbody id="patientTbody"></tbody>
											</table>
										</div>
									</div>
					 			</div>
					 		</div>
						</div>
					</div>
				</div>
				<!-- 환자 검색 끝 -->
			
			
			
	
			<form>
				<div class="row card-body pt-0">
					<div class="tab-content">
	
						<br>
						<div class="row">
							<div class="col-4">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle-subtle text-black text-center form-control"
										type="text" value="이름" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntNm" name="patntNm"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="성별" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntSexdstn" name="patntSexdstn"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-5">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="생년월일" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntRrno1" name="patntRrno1"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
	
	
	
						<br>
						<div class="row">
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="전화번호" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntTelno" name="patntTelno"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="나이" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntAge" name="patntAge"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-9 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="건강보험" disabled />
									<div class="col-3 input-group-append p-0 m-0">
										<input
											class="text-black text-center form-control px-0 bg-white"
											id="patntHlthinsAt" name="patntHlthinsAt" type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
	
	
						<br>
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										 type="text" value="주소" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntAdres1" name="patntAdres1"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-12">
								<div class="row input-group">
									<div class="col-2"></div>
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntAdres2" name="patntAdres2"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
	
						<br>
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="특이사항" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntMemo" name="patntMemo"
											type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
	
						<br>
						<div class="row">
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="예약일" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<input class="form-control datetimepicker" id="rpatntDttm" name="rpatntDttm" type="text" 
										placeholder="예약일" data-options='{"disableMobile":true}' />
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="예약시간" disabled />
									<div class="col-8 input-group-append p-0 m-0">
											<input class="text-black form-control bg-white" id="rpatntTime" name="rpatntTime"
										placeholder="예약시간" type="text" value=""/>
									</div>
								</div>
							</div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										type="text" value="예약메모" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<textarea class="form-control" rows="1" id="rsvtResn" name="rsvtResn"
											placeholder="예약메모를 입력해 주세요"></textarea>
									</div>
								</div>
							</div>
						</div>
	
						<br>
						<div class="row">
							<div class="col-12">
								<div class="row align-self-center">
									<input
										class="fw-semi-bold col-12 text-white form-control"
										type="text" value="예약일정"
										style="background-color: midnightblue" disabled />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="table-container"
									style="overflow-y: auto; max-height: 150px;">
									<table class="table table-sm table-striped"
										style="height: 120px;">
										<thead>
											<tr class="bg-light">
												<th class="col-3 text-center" scope="col">예약날짜</th>
												<th class="col-3 text-center" scope="col">예약시간</th>
												<th class="col-2 text-center" scope="col">담당의</th>
												<th class="col-4 text-center" scope="col">증상</th>
											</tr>
										</thead>
										<tbody style="overflow-y: auto; max-height: 90px;" id="reservationListTable">
											<tr class="bg-light">
												
											</tr>

										</tbody>
									</table>
								</div>
							</div>
						</div>
	
						<div class="row">
	
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="예약구분" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											id="selectOption">
											<option selected="" value="">예약구분</option>
											<option value="1">진료</option>
											<option value="2">물리치료</option>
											<option value="3">작업치료</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="treatment" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="진료실" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example" name="empNo" id="empNo1">
											<option selected="">진료실</option>
											<option value="d20230085">1 진료실 허준</option>
											<option value="d20230086">2 진료실 우태원</option>
											<option value="d20230087">3 진료실 남민주</option>
											<option value="d20230089">4 진료실 장기려</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="cure" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="물리치료" disabled/>
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example" name="empNo" id="empNo2">
											<option selected="">물리치료실</option>
											<option value="1">1 병상</option>
											<option value="2">2 병상</option>
											<option value="3">3 병상</option>
											<option value="4">4 병상</option>
											<option value="5">5 병상</option>
											<option value="6">6 병상</option>
											<option value="7">7 병상</option>
											<option value="8">8 병상</option>
											<option value="9">9 병상</option>
											<option value="10">10 병상</option>
											<option value="11">11 병상</option>
											<option value="12">12 병상</option>
											<option value="13">13 병상</option>
											<option value="14">14 병상</option>
											<option value="15">15 병상</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="cure2" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="작업치료" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example" name="empNo" id="empNo3">
											<option selected="">작업치료실</option>
											<option value="t20230093">1 치료실 임찬빈</option>
											<option value="t20230096">2 치료실 이작업</option>
											<option value="t20230099">3 치료실 이순신</option>
											<option value="t20230097">4 치료실 오재활</option>
										</select>
									</div>
								</div>
							</div>
	
	
						</div>
	
						<br>
						<div class="row mt-3">
							<div class="col-8"></div>
							<div class="col-2">
							</div>
							<div class="col-2">
								<button class="btn btn-primary text-white" id="reservationBtn" type="button" style="background-color: midnightblue; border-style: none;">예약</button>
								&nbsp;&nbsp;
							</div>
							<br> <br> 
						</div>
	
					</div>
				</div>
			</form>
		</div>

	</div>



	<div class="col-7">


		<div class="card border border-secondary" style="height: 820px;">
			<div>
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item text-center col-6">
						<a class="nav-link active fw-semi-bold" id="profile-tab"
						data-bs-toggle="tab" href="#tab-profile" role="tab"
						aria-controls="tab-profile" aria-selected="true">
							예약 캘린더
						</a>
					</li>
					<li class="nav-item text-center col-6" >
						<a class="nav-link fw-semi-bold" id="home-tab"
						data-bs-toggle="tab" href="#tab-home" role="tab"
						aria-controls="tab-home" aria-selected="false">
							예약 리스트
						</a>
					</li>
				</ul>
			</div>


			<div class="row card-body pt-0">
				<div class="tab-content" id="myTabContent">

					<!-- 진료실 탭 -->
					<div class="tab-pane fade" id="tab-home"
						role="tabpanel" aria-labelledby="home-tab">
						<br>
						<div class="row">
							<div class="col-5">
								
								
								
								<form method="post" id="searchForm">
									<input type="hidden" name="page" id="page" />
									<input type="hidden" name="searchType" value="patient" />
										<div class="input-group">
											<button type="button" id="searchAll" class="form-control btn btn-outline-secondary" style="width: 50px; height: 40px;">
												전체조회
											</button>
											<input type="text" name="searchWord" id="searchWord2" value="${searchTypePatient }"
													class="form-control float-right border border-secondary" placeholder="환자명을 입력해 주세요" style="width: 150px; height: 40px;">		
											<div class="input-group-append">
												<button id="searchBtn" type="button" class="form-control btn btn-outline-secondary" style="height: 40px">
													&nbsp;<i class="fas fa-search"></i>&nbsp;
												</button>
											</div>
										</div>
									<sec:csrfInput />
								</form>
							
							</div>
						
							<div class="col-3">
							</div>
							<div class="col-4">
								<form method="post" id="searchForm2">
									<input type="hidden" name="page" id="page" />
									<input type="hidden" name="searchType" value="date" />
										<div class="input-group">
											<input class="form-control border border-secondary datetimepicker" id="searchWord1" name="searchWord" type="text" 
													placeholder="예약일자를 선택해주세요" value="${searchTypeDate }" data-options='{"disableMobile":true}' style="height: 40px;"/>
											<div class="input-group-append">
												<button id="searchBtn2" type="button" class="btn btn-outline-secondary" style="height: 40px">
													&nbsp;<i class="fas fa-search"></i>&nbsp;
												</button>
											</div>
										</div>
									<sec:csrfInput />
								</form>
							</div>
							
						</div>
						<div class="table-responsive row">
								<table style="height: 650px;" class="table table-hover mb-0 fs--4"data-datatables='data-datatables {"responsive":false,"pagingType":"simple","lengthChange":false,"searching":false,"pageLength":8,"language":{"info":"_START_ to _END_ Items of _TOTAL_"}}'>
									<thead class="bg-200">
										<tr>
											<th class="col-1 text-900 align-middle text-center">NO</th>
											<th class="col-2 text-900 align-middle text-center">이름</th>
											<th class="col-2 text-900 align-middle text-center">예약날짜</th>
											<th class="col-2 text-900 align-middle text-center">예약시간</th>
											<th class="col-1 text-900 align-middle text-center">담당의</th>
											<th class="col-4 text-900 align-middle text-center">증상</th>
										</tr>
									</thead>
									<tbody class="list" id="table-simple-pagination-body">
										<c:set value="1" var="count"/>	
										<c:set value="${pagingVO.dataList }" var="reservationList"/>
										<c:choose>
											<c:when test="${empty reservationList }">
												<tr>
													<td class="align-middle text-center" colspan="6">예약 환자가 존재하지 않습니다</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${reservationList }" var="reservation">
													<tr class="onePatient btn-reveal-trigger" id="${reservation.rsvtNo }" data-id="${reservation.rsvtNo }" data-name="${reservation.patntNo }" style="cursor: pointer;">
														<td class="align-middle text-center">${count }</td>
														<td class="align-middle text-center">${reservation.patntNm }</td>
														<td class="align-middle text-center">
															<fmt:formatDate value="${reservation.rpatntDttm }" pattern="yyyy.MM.dd"/>
														</td>
														<td class="align-middle text-center">${reservation.rpatntTime }</td>
														<td class="align-middle text-center">${reservation.empNm }</td>
														<td class="align-middle text-center">
															${reservation.rsvtResn }
														</td>
													</tr>
													<c:set value="${count+1 }" var="count"/>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
						</div>
						<br>
						<div class="row clearfix col-auto align-self-center text-center" id="pagingArea">
							<div class=col-5></div>
							<div class="col-2 align-self-center text-center">${pagingVO.pagingHTML }</div>
							<div class=col-5></div>
						</div>
					</div>


					<!-- 캘린더 탭 -->
					<div class="fade active show" id="tab-profile" role="tabpanel"
						aria-labelledby="profile-tab">
						<!-- 캘린더 시작 -->
							<div class="card pt-3" style="width: 100%; height: 690px;">
								<div class="card-body pt-3 pb-0" style="background-color: aliceblue;">
									<div id="calendar"></div>
									<br />
								</div>
							</div>
						<!-- 캘린더 끝 -->
					</div>





				</div>
			</div>

		</div>






	</div>



</div>







<!-- 접수 성공 모달창 -->

<div class="modal fade" id="reservationModal" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="width: 700; max-width: 700px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form method="post" id="reservationUpdateForm" action="/mediform/admin/reservation/update">
				<div class="modal-body p-0">
					<div class="rounded-top-3 py-3 ps-4 pe-6"
						style="background-color: midnightblue">
						<h4 class="mb-1 text-white" id="modalExampleDemoLabel">예약 내역</h4>
					</div>
					<div class="p-4 pb-0">
						<div class="row">
							<div class="col-4">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle-subtle text-black text-center form-control"
										id="" name="" type="text" value="이름" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntNmDt"
											name="patntNm" type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="성별" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white"
											id="patntSexdstnDt" name="patntSexdstn" type="text" value=""
											disabled />
									</div>
								</div>
							</div>
							<div class="col-5">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="생년월일" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntRrno1Dt"
											name="patntRrno1" type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="전화번호" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntTelnoDt"
											name="patntTelno" type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="나이" disabled />
									<div class="col-6 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntAgeDt"
											name="patntAge" type="text" value="" disabled />
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-9 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="건강보험" disabled />
									<div class="col-3 input-group-append p-0 m-0">
										<input
											class="text-black text-center form-control px-0 bg-white"
											id="patntHlthinsAtDt" name="patntHlthinsAt" type="text" value=""
											disabled />
									</div>
								</div>
							</div>
						</div>
	
	
						<br>
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="주소" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white"
											id="patntAdres1Dt" name="patntAdres1" type="text" value=""
											disabled />
									</div>
								</div>
							</div>
							<div class="col-12">
								<div class="row input-group">
									<div class="col-2"></div>
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white"
											id="patntAdres2Dt" name="patntAdres2" type="text" value=""
											disabled />
									</div>
								</div>
							</div>
						</div>
	
						<br>
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="메모" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntMemoDt"
											name="patntMemo" type="text" value="" disabled />
									</div>
								</div>
							</div>
						</div>
	
						<br>
						<div class="row">
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="예약일" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<input class="form-control datetimepicker" " id="rpatntDttmDt"
											name="rpatntDttm" type="text" placeholder="예약일"
											data-options='{"disableMobile":true}' />
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="예약시간" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="rpatntTimeDt"
											name="rpatntTime" placeholder="예약시간" type="text" value="" />
									</div>
								</div>
							</div>
						</div>
	
						<br>
	
						<div class="row">
							<div class="col-12">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="호소증상" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<textarea class="form-control" rows="1" id="rsvtResnDt"
											name="rsvtResn" placeholder=""></textarea>
									</div>
								</div>
							</div>
						</div>
						
						<br>
						
						<div class="row">
	
							<div class="col-6">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="구분" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											id="selectOptionDt">
											<option selected="" value="">구분</option>
											<option value="1">진료</option>
											<option value="2">물리치료</option>
											<option value="3">작업치료</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="treatmentDt" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="진료실" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											name="empNo" id="empNo1Dt">
											<option selected="">진료실</option>
											<option value="d20230085">1 진료실 허준</option>
											<option value="d20230086">2 진료실 우태원</option>
											<option value="d20230087">3 진료실 남민주</option>
											<option value="d20230089">4 진료실 장기려</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="cureDt" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="물리치료" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											name="empNo" id="empNo2Dt">
											<option selected="">물리치료실</option>
											<option value="1">1 병상</option>
											<option value="2">2 병상</option>
											<option value="3">3 병상</option>
											<option value="4">4 병상</option>
											<option value="5">5 병상</option>
											<option value="6">6 병상</option>
											<option value="7">7 병상</option>
											<option value="8">8 병상</option>
											<option value="9">9 병상</option>
											<option value="10">10 병상</option>
											<option value="11">11 병상</option>
											<option value="12">12 병상</option>
											<option value="13">13 병상</option>
											<option value="14">14 병상</option>
											<option value="15">15 병상</option>
										</select>
									</div>
								</div>
							</div>
	
							<div class="col-6" id="cure2Dt" style="display: none;">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-4 bg-secondary-subtitle text-black text-center form-control"
										id="" name="" type="text" value="작업치료" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											name="empNo" id="empNo3Dt">
											<option selected="">작업치료실</option>
											<option value="t20230093">1 치료실 임찬빈</option>
											<option value="t20230096">2 치료실 이작업</option>
											<option value="t20230099">3 치료실 이순신</option>
											<option value="t20230097">4 치료실 오재활</option>
										</select>
									</div>
								</div>
							</div>
	
	
						</div>
						<br>
					</div>
				</div>
				<input type="hidden" id="reservationNoHidden" value=""/>
			</form>
			<div class="modal-footer">
				<button class="btn btn-primary" id="updateBtn" type="button">수정</button>
				<button class="btn btn-primary" id="deleteBtn" type="button">삭제</button>
				<button class="btn btn-secondary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>





<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<script src="/resources/assets/js/flatpickr.js"></script>
<script type="text/javascript">

function formatPhoneNumber(phoneNumber) {
    return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}


$(function() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content")
	var updateBtn = $("#updateBtn");
	var deleteBtn = $("#deleteBtn");
	var reservationUpdateForm = $("#reservationUpdateForm");
	var rsvtNo = $("#reservationNoHidden").val();

	// 예약 정보 삭제
	deleteBtn.on("click", function(){
		
		Swal.fire({
		      icon: 'warning',
		      title: '예약 취소',
		      text: '예약을 취소하시겠습니까?',
		      showCancelButton: true,
		      confirmButtonText: '확인',
		      cancelButtonText: '취소',
		      confirmButtonColor: 'midnightblue',
		      cancelButtonColor: 'red', // cancel 버튼 색깔 지정
		    }).then(result => {
		    	if(result.isConfirmed){
		    	
		    		
		    		console.log("##### 예약번호 : " + rsvtNo);
		    		
		    		var deleteObject = {
		    				rsvtNo : rsvtNo
		    		}
		    		
		    		$.ajax({
		    	 		type : "post",
		    			url : "/mediform/admin/reservation/delete",
		    			data : JSON.stringify(deleteObject),
		    	 		contentType : "application/json; charset=utf-8",
		    	 		async: false,
		    	        beforeSend : function(xhr){            
		    	            xhr.setRequestHeader(header,token);
		    	        },
		    	 		success : function(result) {
		    				console.log("");
		    				
		    				Swal.fire({
		    				      icon: 'success',
		    				      title: '예약',
		    				      text: '예약이 취소되었습니다',
		    				      confirmButtonText: '확인',
		    				      confirmButtonColor: 'midnightblue',
		    				    }).then(result => {
		    				    	if(result.isConfirmed){
		    					    	location.href = "/mediform/admin/reservation/main";
		    				    	}
		    				    	});;
		    	 		}
		    	 	});	
		    	}
		    });
	});
	
	// 예약 정보 수정
	updateBtn.on("click", function(){
		
		var selectOption = $("#selectOptionDt").val();
		var rsvtResn = $("#rsvtResnDt").val();
		var rpatntDttm = $("#rpatntDttmDt").val();
		var rpatntTime = $("#rpatntTimeDt").val();
		var empNo = "";

		if(selectOption == "1"){
					empNo = $("#empNo1Dt").val();
				}else if(selectOption == "2"){
					empNo = $("#empNo2Dt").val();
				}else if(selectOption == "3"){
					empNo = $("#empNo3Dt").val();
				}
		

		if(selectOption === "" || selectOption == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		if(selectOption === "" || selectOption == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		if(rpatntDttm === "" || rpatntDttm == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '일자를 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		
		Swal.fire({
		      icon: 'warning',
		      title: '예약 수정',
		      text: '예약을 수정하시겠습니까?',
		      showCancelButton: true,
		      confirmButtonText: '확인',
		      cancelButtonText: '취소',
		      confirmButtonColor: 'midnightblue',
		      cancelButtonColor: 'red', // cancel 버튼 색깔 지정
		    }).then(result => {
		    	if(result.isConfirmed){
		    	
		    		var rsvtNo = $("#reservationNoHidden").val();
		    		
		    		console.log("##### 예약번호 : " + rsvtNo);
		    		
		    		var updateObject = {
		    				rsvtNo : rsvtNo,
		    				rsvtResn : rsvtResn,
		    				rpatntDttm : rpatntDttm,
		    				rpatntTime : rpatntTime,
		    				empNo : empNo
		    		}
		    		
		    		$.ajax({
		    	 		type : "post",
		    			url : "/mediform/admin/reservation/update",
		    			data : JSON.stringify(updateObject),
		    	 		contentType : "application/json; charset=utf-8",
		    	 		async: false,
		    	        beforeSend : function(xhr){            
		    	            xhr.setRequestHeader(header,token);
		    	        },
		    	 		success : function(result) {
		    				console.log("");
		    				
		    				Swal.fire({
		    				      icon: 'success',
		    				      title: '예약',
		    				      text: '예약이 수정되었습니다',
		    				      confirmButtonText: '확인',
		    				      confirmButtonColor: 'midnightblue',
		    				    }).then(result => {
		    				    	if(result.isConfirmed){
		    					    	location.href = "/mediform/admin/reservation/main";
		    					    	
		    				    	}
		    				    	});;
		    	 		}
		    	 	});	
		    	}
		    });
		
		
	});
	

	var onePatient = $(".onePatient");
	var reservationModal = $("#reservationModal");
	
	onePatient.on("click", function(){
		
		console.log("클릭이벤트");
 		reservationModal.modal('show');
		
 		var rsvtNo = $(this).attr("id");
		console.log("예약번호 ::::: " + rsvtNo);
 		
		var row = document.querySelector("tr[data-id='" + rsvtNo + "']");
 		
		var patntNo = row.getAttribute("data-name");
		
		var rsvtNoJson = {rsvtNo : rsvtNo}
		
		var patientObj = {
				patntNo : patntNo
				};
		
 		$.ajax({
 	 		type : "post",
 			url : "/mediform/admin/reservation/select",
 			data : JSON.stringify(rsvtNoJson),
 	 		contentType : "application/json; charset=utf-8",
 	 		async: false,
 	        beforeSend : function(xhr){            
 	            xhr.setRequestHeader(header,token);
 	        },
 	 		success : function(res) {
 	 			
 	 			console.log("patntNo : "+res.patntNo+" | patntNM : "+res.patntNm +" | patntTelno : "+res.patntTelno);
				// 보험
				if(res.patntHlthinsAt == "Y"){
					patntHlthinsAt = "O";
				}else{
					patntHlthinsAt = "X";
				}
				// 입원여부
				if(res.patntHsptlzAt == "Y"){
					patntHsptlzAt = '<span class="fas fa-bed text-success fs-2"></span>';
					
				}else {
					patntHsptlzAt = '<span class="fas fa-bed text-danger fs-2"></span>';
				}
				// 주민등록번호 앞자리를 문자열로 바꾼 후 앞에서 2개씩 끊어낸다.(생년월일에 사용하기 위해)
				var patntRrno1 = res.patntRrno1;
				// 성별
				var patntSexdstn = "";
				if(res.patntSexdstn == "M"){
					patntSexdstn = "남";
				}else{
					patntSexdstn = "여";
				}
					
				console.log("성별 ::::" + patntSexdstn);
				console.log("나이 ::::" + res.patntAge);
				
				var dateString = res.rpatntDttm;
				var date = new Date(dateString);
				var year = date.getFullYear();
				var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
				var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅

				// 원하는 형식으로 조합
				var formattedDate = year + '.' + month + '.' + day;
				
				
				$("#patntNmDt").val(res.patntNm);
				$("#rpatntDttmDt").val(formattedDate);
				$("#rpatntTimeDt").val(res.rpatntTime);
				$("#rsvtResnDt").val(res.rsvtResn);
				
				var room = (res.empNo).charAt(0);
				var selectElement = document.getElementById('selectOptionDt');
				var empNo1Dt = document.getElementById('empNo1Dt');
				var empNo2Dt = document.getElementById('empNo2Dt');
				var empNo3Dt = document.getElementById('empNo3Dt');
				
				document.getElementById('treatmentDt').style.display = 'none';
				document.getElementById('cureDt').style.display = 'none';
				document.getElementById('cure2Dt').style.display = 'none';
				
				console.log("room!!!!" + room)
				if(room == null){
					
 	 			}else if(room === 'd'){
 	 				selectElement.value = '1';
 	 				document.getElementById('treatmentDt').style.display = 'block';
 	 				console.log("의사 ::: !!!! : " + room);
 	 				if(res.empNo === 'd20230085'){
 	 					empNo1Dt.value = 'd20230085';
 	 				}else if(res.empNo === 'd20230086'){
 	 					empNo1Dt.value = 'd20230086';
 	 				}else if(res.empNo === 'd20230087'){
 	 					empNo1Dt.value = 'd20230087';
 	 				}else if(res.empNo === 'd20230089'){
 	 					empNo1Dt.value = 'd20230089';
 	 				}
				}else if(room === 't'){
					selectElement.value = '3';
					document.getElementById('cure2Dt').style.display = 'block';
					if(res.empNo === 't20230093'){
						empNo3Dt.value = 't20230093';
 	 				}else if(res.empNo === 't20230096'){
 	 					empNo3Dt.value = 't20230096';
 	 				}else if(res.empNo === 't20230099'){
 	 					empNo3Dt.value = 't20230099';
 	 				}else if(res.empNo === 't20230097'){
 	 					empNo3Dt.value = 't20230097';
 	 				}
				}else{
					selectElement.value = '2';
					document.getElementById('cureDt').style.display = 'block';
				}
 	 			
 	 		}
 	 	});
 		
 		document.getElementById('selectOptionDt').addEventListener('change',function() {
 			// 선택한 옵션의 값 가져오기
 			var selectedValue = this.value;
 		
 			// 아래에 표시될 영역 숨기기
 			document.getElementById('treatmentDt').style.display = 'none';
 			document.getElementById('cureDt').style.display = 'none';
 			document.getElementById('cure2Dt').style.display = 'none';
 		
 			// 선택한 옵션 값에 따라 해당하는 영역 표시
 			if (selectedValue === '1') {
 				document.getElementById('treatmentDt').style.display = 'block';
 			} else if (selectedValue === '2') {
 				document.getElementById('cureDt').style.display = 'block';
 			} else if (selectedValue === '3') {
 				document.getElementById('cure2Dt').style.display = 'block';
 			}
 		
 		

 		});
 		
		
		$.ajax({
			type : "post",
			url  : "/mediform/patient/info",
			data : JSON.stringify(patientObj),
			contentType : "application/json; charset=utf-8",
			async: false,
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				console.log("patntNo : "+res.patntNo+" | patntNM : "+res.patntNm +" | patntTelno : "+res.patntTelno);
				// 보험
				if(res.patntHlthinsAt == "Y"){
					patntHlthinsAt = "O";
				}else{
					patntHlthinsAt = "X";
				}
				// 입원여부
				if(res.patntHsptlzAt == "Y"){
					patntHsptlzAt = '<span class="fas fa-bed text-success fs-2"></span>';
					
				}else {
					patntHsptlzAt = '<span class="fas fa-bed text-danger fs-2"></span>';
				}
				// 주민등록번호 앞자리를 문자열로 바꾼 후 앞에서 2개씩 끊어낸다.(생년월일에 사용하기 위해)
				var patntRrno1 = res.patntRrno1;
				// 성별
				var patntSexdstn = "";
				if(res.patntSexdstn == "M"){
					patntSexdstn = "남";
				}else{
					patntSexdstn = "여";
				}
				
				
				// 환자 간단 정보에 값 넣기
// 					$(pTableTd[0]).html(res.patntNm);
// 					$(pTableTd[1]).html(res.patntNo);
// 					$(pTableTd[2]).html(patntHlthinsAt);
// 					$(pTableTd[3]).html(patntHsptlzAt);
// 					$(pTableTd[4]).html('<a href="/">특이사항</a>');
// 					$(pTableTd[5]).html(patntRrno1);
// 					$(pTableTd[6]).html(res.patntAge+"세");
// 					$(pTableTd[7]).html(patntSexdstn);
// 					$(pTableTd[8]).html(res.patntTelno);
// 					$(pTableTd[10]).html(res.patntMemo);
				
				console.log("성별 ::::" + patntSexdstn);
				console.log("나이 ::::" + res.patntAge);
				console.log("생년월일 ::::" + res.patntRrno1);
				$("#patntNmDt").val(res.patntNm);
				$("#patntSexdstnDt").val(patntSexdstn);
				
				let patntRrno1Str = (res.patntRrno1).toString();
                while (patntRrno1Str.length < 6) {
               	 patntRrno1Str = '0' + patntRrno1Str;
                }
				console.log("생년월일 >>> " + patntRrno1Str);
				$("#patntRrno1Dt").val(patntRrno1Str);
				$("#patntTelnoDt").val(formatPhoneNumber(res.patntTelno));
				$("#patntAgeDt").val(res.patntAge+"세");
				$("#patntHlthinsAtDt").val(patntHlthinsAt);
				$("#patntAdres1Dt").val(res.patntAdres1);
				$("#patntAdres2Dt").val(res.patntAdres2);
				$("#patntMemoDt").val(res.patntMemo);
				
				var inputElement = document.getElementById('reservationNoHidden');
				inputElement.value = rsvtNo;
				
				//////////////////// 
			},
			error : function(err){
				console.log("err에러 : " + err);
			}
			
		});
		
	});
	
	
	
	
	
	
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var searchForm2 = $("#searchForm2");
	var searchAllBtn = $("#searchAll");
	var searchWordInput = document.getElementById("searchWord");
	var searchWordInput2 = document.getElementById("searchWord2");
	var searchBtn = $("#searchBtn");	
	var searchBtn2 = $("#searchBtn2");	
	
	
	searchBtn.on("click", function(){
		searchForm.submit();
	});
	
	searchBtn2.on("click", function(){
		searchForm2.submit();
	});
	
	pagingArea.on("click", "a", function(event){
		
		event.preventDefault();
		var pageNo = $(this).data("page")
		searchForm.find("#page").val(pageNo);
		
		searchForm.submit();
		
	});
	
	
	searchAllBtn.on("click", function() {
	    // id가 "searchWord"인 입력 상자의 값을 빈 값으로 설정합니다.
	   location.href = "/mediform/admin/reservation/main";
	});
	
	
// 	document.getElementById('searchType').addEventListener('change',function() {
		
// 		var selectedValue = this.value;
// 		console.log("검색 구분 체인지 이벤트 발생");
// 		console.log("검색 구분 밸류 : " + this.value);
// 		document.getElementById('searchWord1').style.display = 'none';
// 		document.getElementById('searchWord2').style.display = 'none';
		
// 		if (selectedValue === 'patient') {
// 			console.log("환자 선택");
// 			document.getElementById('searchWord2').style.display = 'block';
// 		} else if (selectedValue === 'date') {
// 			console.log("날짜 선택");
// 			document.getElementById('searchWord1').style.display = 'block';
// 		}
		
// 	});
	
	
	
	
	
	document.getElementById('selectOption').addEventListener('change',function() {
		// 선택한 옵션의 값 가져오기
		var selectedValue = this.value;
	
		// 아래에 표시될 영역 숨기기
		document.getElementById('treatment').style.display = 'none';
		document.getElementById('cure').style.display = 'none';
		document.getElementById('cure2').style.display = 'none';
	
		// 선택한 옵션 값에 따라 해당하는 영역 표시
		if (selectedValue === '1') {
			document.getElementById('treatment').style.display = 'block';
		} else if (selectedValue === '2') {
			document.getElementById('cure').style.display = 'block';
		} else if (selectedValue === '3') {
			document.getElementById('cure2').style.display = 'block';
		}
	
	
	

	});
	

});
	
	
	
	

//환자 검색 관련 시작
var patientInput = $("#patientInput");
var patientTbody = $("#patientTbody");
var patientMenu = $("#patientMenu");
var patientDropMenu = $("#patientDropMenu");
var patientTbodyHtml = "";

//	환자 검색 시작
//		검색창 포커스 아웃일 때 드롭다운 사라지게 만들기
	patientInput.focusout(function(){
		setTimeout(() => {
			$(patientDropMenu).hide();
		}, 100);
	});

//검색창 포커스인
patientInput.focusin(function(){
	
	$(patientDropMenu).show();
	if(patientInput.val() == "" || patientInput.val() == null){
		
		$.ajax({
			type : "post",
			url  : "/mediform/patient/searchList",
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				var patientDropItemHtml = "";
				patientTbodyHtml = "";
				$(res).each(function(idx, item){
					var patientBirth = birthFormat(this.patntRrno1, this.patntRrno2);
					patientDropItemHtml = patientDropItem(this.patntNo, this.patntNm, this.patntAge, 
							this.patntRrno1, this.patntRrno2, patientBirth, this.patntSexdstn, this.patntTelno, this.patntHlthinsAt,
							this.patntHsptlzAt, this.prtctorNm, this.prtctorTelno, this.patntMemo, this.patntHeight, this.patntBdwgh, 
							this.patntBdp);
					
				});
				$(patientTbody).html(patientDropItemHtml);
			},
			error : function(err){
			}
		});
		
	}
});

//환자 keyup 검색
patientInput.on("keyup",function(event){
	
	
	
	if(event.which != 13){
		var patientKeyword = patientInput.val();
		var keyword = { 
				"keyword" : patientKeyword
				};
		// 검색 환자 정보
		$.ajax({
			type : "post",
			url  : "/mediform/patient/search",
			data : JSON.stringify(keyword),
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				var patientBirth = birthFormat(this.patntRrno1, this.patntRrno2);
				var patientDropItemHtml = "";
				patientTbodyHtml = "";
				if(res.length == 0){
					patientDropItemHtml += "<tr>";
					patientDropItemHtml += '<td colspan="5" onclick="event.cancelBubble=true;">조회하신 환자가 없습니다.</td>';
					patientDropItemHtml += '</tr>';
				}else{
					$(res).each(function(idx, item){
						var patientBirth = birthFormat(this.patntRrno1, this.patntRrno2);
						patientDropItemHtml = patientDropItem(this.patntNo, this.patntNm, this.patntAge, 
								this.patntRrno1, this.patntRrno2, patientBirth, this.patntSexdstn, this.patntTelno, this.patntHlthinsAt,
								this.patntHsptlzAt, this.prtctorNm, this.prtctorTelno, this.patntMemo, this.patntHeight, this.patntBdwgh, 
								this.patntBdp);
					});
				}
				$(patientTbody).html(patientDropItemHtml);
			},
			error : function(err){
			}
		});
	}
});

//환자 결과 누르기 이벤트들 시작 ---------------------------------------------
//엔터 눌렀을 시 제일 위에 환자 번호를 찾는다.
$(patientInput).keypress(function(event){
	if(event.which == 13){
		event.preventDefault();
		var patntNo = patientTbody.children("tr:eq(0)").data("patntno");
		var patntNm = patientTbody.children("tr:eq(0)").data("patntnm");
		var patntAge = patientTbody.children("tr:eq(0)").data("patntage");
		var patntRrno1 = patientTbody.children("tr:eq(0)").data("patntrrno1");
		var patntRrno2 = patientTbody.children("tr:eq(0)").data("patntrrno2");
		var patientBirth = patientTbody.children("tr:eq(0)").data("patientbirth");
		var patntSexdstn = patientTbody.children("tr:eq(0)").data("patntsexdstn");
		var patntTelno = patientTbody.children("tr:eq(0)").data("patnttelno");
		var patntHlthinsAt = patientTbody.children("tr:eq(0)").data("patnthlthinsat");
		var patntHsptlzAt = patientTbody.children("tr:eq(0)").data("patnthsptlzat");
		var prtctorNm = patientTbody.children("tr:eq(0)").data("prtctornm");
		var prtctorTelno = patientTbody.children("tr:eq(0)").data("prtctortelno");
		var patntMemo = patientTbody.children("tr:eq(0)").data("patntmemo");
		var patntHeight = patientTbody.children("tr:eq(0)").data("patntheight");
		var patntBdwgh = patientTbody.children("tr:eq(0)").data("patntbdwgh");
		var patntBdp = patientTbody.children("tr:eq(0)").data("patntbdp");
		
		// input태그 비우기
		$(patientInput).val("");
		
		patientInput.blur();
		$(patientDropMenu).hide();
	}
});

//검색창 목록 클릭 이벤트
$(patientTbody).on("click", function(){
	var targets = $(event.target);
	// 클릭된 요소의 부모인 tr 태그
	var clickTr = "";
	
	if(targets.is('td')){
		clickTr = targets.closest('tr');
	}else if(targets.is('tr')){
		clickTr = targets;
	}
	var patntNo = clickTr.data("patntno");
	var patntNm = clickTr.data("patntnm");
	var patntAge = clickTr.data("patntage");
	var patntRrno1 = clickTr.data("patntrrno1");
	var patntRrno2 = clickTr.data("patntrrno2");
	var patientBirth = clickTr.data("patientbirth");
	var patntSexdstn = clickTr.data("patntsexdstn");
	var patntTelno = clickTr.data("patnttelno");
	var patntHlthinsAt = clickTr.data("patnthlthinsat");
	var patntHsptlzAt = clickTr.data("patnthsptlzat");
	var prtctorNm = clickTr.data("prtctornm");
	var prtctorTelno = clickTr.data("prtctortelno");
	var patntMemo = clickTr.data("patntmemo");
	var patntHeight = clickTr.data("patntheight");
	var patntBdwgh = clickTr.data("patntbdwgh");
	var patntBdp = clickTr.data("patntbdp");
	var rceptNo = $("#rceptNo").val();
	// input 태그 비워주기
	$(patientInput).val("");
	
	patientInput.blur();
	$(patientDropMenu).hide();
	selectPatientAjax(patntNo);
	selectReservationAjax(patntNo);
});

//환자 결과 누르기 이벤트들 끝 ------------------------------------------------

//환자 검색창에 목록 생성
function patientDropItem(patntNo, patntNm, patntAge, patntRrno1, patntRrno2, patientBirth,
		patntSexdstn, patntTelno, patntHlthinsAt, patntHsptlzAt, prtctorNm, prtctorTelno, 
		patntMemo, patntHeight, patntBdwgh, patntBdp){
	
	patientTbodyHtml += "<tr class='hover-primary pointer'"
		+ "data-patntno='"+patntNo+"' data-patntnm='"+patntNm+"' data-patntage='"+patntAge+"'"
		+ "data-patntrrno1='"+patntRrno1+"' data-patntrrno2='"+patntRrno2+"' data-patientbirth='"+patientBirth+"'"
		+ "data-patntsexdstn='"+patntSexdstn+"' data-patnttelno='"+patntTelno+"' data-patnthlthinsat='"+patntHlthinsAt+"'"
		+ "data-patnthsptlzat='"+patntHsptlzAt+"' data-prtctornm='"+prtctorNm+"' data-prtctortelno='"+prtctorTelno+"'"
		+ "data-patntmemo='"+patntMemo+"' data-patntheight='"+patntHeight+"', data-patntbdwgh='"+patntBdwgh+"', data-patntbdp='"+patntBdp+"' >";
	patientTbodyHtml += "<td class='white-space-nowrap'>" + patntNm + "</td>";
	patientTbodyHtml += "<td class='white-space-nowrap'>" + patntNo + "</td>";
	patientTbodyHtml += "<td class='white-space-nowrap'>"+ patntAge +"세 </td>";
	if(patntSexdstn == "M"){
		patntSexdstn = "남";
	}else{
		patntSexdstn = "여";
	}
	patientTbodyHtml += "<td class='white-space-nowrap'>" + patntSexdstn + "</td>";
	patientTbodyHtml += "<td class='white-space-nowrap'>" + patientBirth + "</td>";
	patientTbodyHtml += "</tr>";

	return patientTbodyHtml;
	
}

//환자 검색 끝	
	
function birthFormat(patntRrno1, patntRrno2){
		if(patntRrno1 == null || patntRrno1 == "" || patntRrno2 == null || patntRrno2 == ""){
			return;
		}
		
		// 주민등록번호2의 첫번째 자리로 1900년도인지 2000년도인지 구분
		var firstNo = patntRrno2.toString().charAt(0);
		var birth = "";
		
		if(firstNo == "1" || firstNo == "2" || firstNo == "5" || firstNo == "6"){
			birth = "19";
		}else if(firstNo == "3" || firstNo == "4" || firstNo == "7" || firstNo == "8"){
			birth = "20";
		}
		// 주민등록번호1을 조합
		birth += patntRrno1;
		var birthSpl = birth.split('');
		
		// 연도, 월, 일을 구분지어주는 점 찍어주는 역할
		birthSpl.splice(4, 0, '.');
		birthSpl.splice(7, 0, '.');
		
		// 합치기
		var birthJoin = birthSpl.join('');
		
		return birthJoin;
	}	
	
	
	
	
	
	
	
	$(function(){
		// 시큐리티 토큰 관련 2개
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		// 검색 input요소
		var searchInput = $("#searchInput");
		// 드롭다운 요소(결과를 뿌려줄 곳)
		var searchRes = $("#search-results");
		// 환자 정보를 담을 테이블
		var patientTable = $("#patientTable");
		console.log(patientTable);
		let selectedIndex = -1;

		
		// 반만 작동중 수정해야함
		// 검색창에 공백일 때 클릭 시 전체 리스트 출력
		searchInput.focusin(function(){
			console.log("focusin...!");
			if(searchInput.val() == ""){
				console.log("서치인풋 밸 : "+ searchInput.val());
				$.ajax({
					type : "post",
					url : "/mediform/patient/searchList",
					contentType : "application/json; charset=utf-8",
					async: false,
			        beforeSend : function(xhr){
			           //ajax호출 중 처리
			           //글로벌 변수로 설정한 csrf token 셋팅
				       xhr.setRequestHeader(header,token);
				    },
					success : function(res){
						var searchResultsHtml = "";
						console.log(res.length);
						$(res).each(function(){
							console.log(this.patntNm + " " + this.patntAge);
							searchResultsHtml += '<div class="dropdown-item px-x1 py-2" data-no="'+this.patntNo+'" data-name="'+this.patntNm+'">';
							searchResultsHtml += '<div class="d-flex align-items-center">';
							searchResultsHtml += '<div class="flex-1">';
							searchResultsHtml += ' <h6 class="mb-0 title pointer">' + this.patntNo + '  |  ' + this.patntNm + '  |  ' + this.patntAge + '세  |  ' + this.patntRrno1 + '</h6>';
							searchResultsHtml += '</div>';
							searchResultsHtml += '</div>';
							searchResultsHtml += '</div>';
						});
						$(searchRes).html(searchResultsHtml);
					},
				   	error : function(err){
						console.log("err에러 : " + err);
					}
				});
			}
		});
		
		// 환자 검색 시 키보드를 한글자씩 눌렀다가 떼는 순간 이벤트 발생
		searchInput.on("keyup",function(){
			var keyword = searchInput.val();
			console.log("keyword : " + keyword);
			var searchObj = { 
					keyword : keyword
					};
			
			// 검색 환자 정보
			$.ajax({
				type : "post",
				url  : "/mediform/patient/search",
				data : JSON.stringify(searchObj),
				contentType : "application/json; charset=utf-8",
				async: false,
		        beforeSend : function(xhr){
		            //ajax호출 중 처리
		            //글로벌 변수로 설정한 csrf token 셋팅
		            xhr.setRequestHeader(header,token);
		        },
				success : function(res){
					var searchResultsHtml = "";
					console.log(res.length);
					// 받아온 데이터가 없을 때 
					// 환자 정보 없음은 h5로 설정(h6로 설정 시 클릭하면 환자 정보 테이블에 들어가지기 때문)
					if(res.length == 0){
						console.log("받아온 데이터 없음");
						searchResultsHtml += '<div class="dropdown-item px-x1 py-2">';
				        searchResultsHtml += '<div class="d-flex align-items-center">';
				        searchResultsHtml += '<div class="flex-1">';
				        searchResultsHtml += '<h5 class="mb-0 title">환자 정보가 존재하지 않습니다.</h5>';
				        searchResultsHtml += '</div>';
				        searchResultsHtml += '</div>';
				        searchResultsHtml += '</div>';
					}else{
						// 받아온 값을 뿌리는 역할
			            $(res).each(function(){
						console.log(this.patntNm + " " + this.patntAge);
						searchResultsHtml += '<div class="dropdown-item px-x1 py-2" data-no="'+this.patntNo+'" data-name="'+this.patntNm+'">';
				        searchResultsHtml += '<div class="d-flex align-items-center">';
				        searchResultsHtml += '<div class="flex-1">';
				        searchResultsHtml += ' <h6 class="mb-0 title pointer">' + this.patntNo + '  |  ' + this.patntNm + '  |  ' + this.patntAge + '세  |  ' + this.patntRrno1 + '</h6>';
				        searchResultsHtml += '</div>';
				        searchResultsHtml += '</div>';
				        searchResultsHtml += '</div>';
			       		});
					}
					$(searchRes).html(searchResultsHtml);
					},
				error : function(err){
					console.log("err에러 : " + err);
				}
			});
		});
		
		
		$("#searchInput").keypress(function(event){
			if(event.which == 13){
				event.preventDefault();
				var patntNo = searchRes.children("div:eq(0)").data("no");
				var patntNm = searchRes.children("div:eq(0)").data("name");
				console.log(patntNo);
				console.log("이름도 가져오나? " + patntNm);
				// input태그에 선택된 이름 넣어주기
				$(searchInput).val(patntNm);
				// 환자 조회
 				selectPatientAjax(patntNo);
				
 				selectReservationAjax(patntNo);
				// 진료 기록 조회
// 				selectClinicList(patntNo)
				
				searchInput.blur();
				$(".hideOnOff").hide();
			}
		});
		
		
		
///////////////////////////////////////////////////////////////////////////////////////////////		
		// 위에서 뿌려준 환자 정보를 클릭시 (드롭다운 div 안에 있는 <h6>태그 요소를 전부 가져와 클릭 이벤트 발생 시 작동)
		$(searchRes).on("click","h6",function(event){
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			// 클릭된 h6 태그
			var clickTarget = $(event.target);
			// h6 태그 안에 있는 환자 정보 텍스트
			var patientInfo = clickTarget.text();
			console.log(clickTarget.text());
			// 환자 정보 텍스트를 공백 기준으로 나누기
			var patientSplit = patientInfo.split(' ');
			console.log(patientSplit);
			// 환자 번호(환자 정보 텍스트를 공백 기준으로 나누고 나서 0번째 요소)
			var patntNo = patientSplit[0];
			console.log(patntNo);
			var patientObj = {
					patntNo : patntNo
					}
			selectPatientAjax(patntNo);
			selectReservationAjax(patntNo);

			
			// tbody 태그에 담을 곳
			var tbodyInsertHtml = "";
			var patntHlthinsAt = "";
			var patntHsptlzAt = "";
			
			
			
			
			var reservation = "";
			
			// 환자 진료 기록 조회 ajax 시작
			$.ajax({
				type : "post",
				url  : "/mediform/doctor/allClinic",
				data : JSON.stringify(patientObj),
				contentType : "application/json; charset=utf-8",
				async: false,
		        beforeSend : function(xhr){
		            //ajax호출 중 처리
		            //글로벌 변수로 설정한 csrf token 셋팅
		            xhr.setRequestHeader(header,token);
		        },
				success : function(res){
					console.log("환자 진료 기록 조회 : " + res.length);
					$(res).each(function(){
						
					});
				},
				error : function(err){
					console.log(err.status)
				}
			});
			// 환자 진료 기록 조회 ajax 끝
		});
	});
	
	
	function selectReservationAjax(patntNo){
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var reservationListHtml = "";
		var reservationListTable = $("#reservationListTable");
		
		var patientObj = {
				patntNo : patntNo
				};
		
		// 환자 예약 기록 조회 ajax 시작
		$.ajax({
			type : "post",
			url  : "/mediform/admin/reservation/list",
			data : JSON.stringify(patientObj),
			contentType : "application/json; charset=utf-8",
			async: false,
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				console.log("환자 진료 기록 조회 : " + res.length);
				if(res.length == 0){
					
					console.log("진료 기록 조회 없음");
					reservationListHtml += "<tr class='oneBoard' id=''>";
					reservationListHtml += "	<td colspan='4' class='text-center' style='vertical-align: middle'>" + "예약 내역이 없습니다" + "</td>";
					reservationListHtml += "</tr>";
					
				}else{
					$(res).each(function(){
						
						var dateString = this.rpatntDttm;
						var date = new Date(dateString);
						var year = date.getFullYear();
						var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
						var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅

						// 원하는 형식으로 조합
						var formattedDate = year + '.' + month + '.' + day;

						
						var rsvtResnStr = "";
						
						if(this.rsvtResn ==  null || this.rsvtResn === ""){
							rsvtResnStr = "(증상 메모 없음)";
						}else{
							rsvtResnStr = this.rsvtResn;
						}
						
						
						reservationListHtml += "<tr class='oneBoard' id=''>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + formattedDate + "</td>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + this.rpatntTime + "</td>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + this.empNm + "</td>";
						reservationListHtml += "	<td class='' style='vertical-align: middle'>" + rsvtResnStr + "</td>";
						reservationListHtml += "</tr>";
						
					});
				}
				reservationListTable.html(reservationListHtml);
				
			},
			error : function(err){
				console.log(err.status)
			}
		});
		// 환자 예약 기록 조회 ajax 끝
		
		
		
	}
	
	
	
	
	
	function selectPatientAjax(patntNo){
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var patientObj = {
				patntNo : patntNo
				};
		
		// 환자 정보 ajax 시작
		$.ajax({
			type : "post",
			url  : "/mediform/patient/info",
			data : JSON.stringify(patientObj),
			contentType : "application/json; charset=utf-8",
			async: false,
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				console.log("patntNo : "+res.patntNo+" | patntNM : "+res.patntNm +" | patntTelno : "+res.patntTelno);
				// 보험
				if(res.patntHlthinsAt == "Y"){
					patntHlthinsAt = "O";
				}else{
					patntHlthinsAt = "X";
				}
				// 입원여부
				if(res.patntHsptlzAt == "Y"){
					patntHsptlzAt = '<span class="fas fa-bed text-success fs-2"></span>';
					
				}else {
					patntHsptlzAt = '<span class="fas fa-bed text-danger fs-2"></span>';
				}
				// 주민등록번호 앞자리를 문자열로 바꾼 후 앞에서 2개씩 끊어낸다.(생년월일에 사용하기 위해)
				var patntRrno1 = res.patntRrno1;
				// 성별
				var patntSexdstn = "";
				if(res.patntSexdstn == "M"){
					patntSexdstn = "남";
				}else{
					patntSexdstn = "여";
				}
				
				
				// 환자 간단 정보에 값 넣기
// 					$(pTableTd[0]).html(res.patntNm);
// 					$(pTableTd[1]).html(res.patntNo);
// 					$(pTableTd[2]).html(patntHlthinsAt);
// 					$(pTableTd[3]).html(patntHsptlzAt);
// 					$(pTableTd[4]).html('<a href="/">특이사항</a>');
// 					$(pTableTd[5]).html(patntRrno1);
// 					$(pTableTd[6]).html(res.patntAge+"세");
// 					$(pTableTd[7]).html(patntSexdstn);
// 					$(pTableTd[8]).html(res.patntTelno);
// 					$(pTableTd[10]).html(res.patntMemo);
				
				console.log("성별 ::::" + patntSexdstn);
				console.log("나이 ::::" + res.patntAge);
				
				$("#patntNm").val(res.patntNm);
				$("#patntSexdstn").val(patntSexdstn);
				$("#patntRrno1").val(patntRrno1);
				$("#patntTelno").val(formatPhoneNumber(res.patntTelno));
				$("#patntAge").val(res.patntAge+"세");
				$("#patntHlthinsAt").val(patntHlthinsAt);
				$("#patntAdres1").val(res.patntAdres1);
				$("#patntAdres2").val(res.patntAdres2);
				$("#patntMemo").val(res.patntMemo);
				
				
			},
			error : function(err){
				console.log("err에러 : " + err);
			}
			
		});
	// 환자 정보 ajax 끝
	
	
	// 예약 버튼 클릭시 접수 insert ajax
	var reservationBtn = $("#reservationBtn");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
		
	reservationBtn.on("click", function(){
		
		var patntNm = $("#patntNm").val();
		var empNo = $("#empNo").val();
		var modalText = $("#modalText");
		var rsvtResn = $("#rsvtResn").val();
		var rceptPriort = $("#rceptPriort").val();
		var selectOption = $("#selectOption").val();
		var rpatntDttm = $("#rpatntDttm").val();
		var rpatntTime = $("#rpatntTime").val();
		var empNo = "";
		
		if(selectOption == "1"){
			empNo = $("#empNo1").val();
		}else if(selectOption == "2"){
			empNo = $("#empNo2").val();
		}else if(selectOption == "3"){
			empNo = $("#empNo3").val();
		}
		
		
		if(patntNo === "" || patntNo == null){
			
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '환자를 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		if(selectOption === "" || selectOption == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		if(selectOption === "" || selectOption == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		if(rpatntDttm === "" || rpatntDttm == null){
			Swal.fire({
			      icon: 'error',
			      title: '예약',
			      text: '일자를 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	location.href = "/mediform/admin/reservation/main";
			    	}
			    	});
		}
		
		var patientObj = {
				patntNo : patntNo,
				patntNm : patntNm,
				rsvtResn : rsvtResn,
				rpatntDttm : rpatntDttm,
				rpatntTime : rpatntTime,
				empNo: empNo
				};
		
		
		$.ajax({
			type : "post",
			url  : "/mediform/admin/reservation/insert",
			data : JSON.stringify(patientObj),
			contentType : "application/json; charset=utf-8",
			async: false,
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				console.log("인서트 성공!!!");
				
				
				Swal.fire({
				      icon: 'success',
				      title: '예약',
				      text: '정상적으로 예약되었습니다',
				      confirmButtonText: '확인',
				      confirmButtonColor: 'midnightblue',
				    }).then(result => {
				    	if(result.isConfirmed){
					    	location.href = "/mediform/admin/reservation/main";
				    	}
				    	});
				
				
			},
			error : function(err){
				console.log("err에러 : " + err);
			}
			
		});
		
		
	});
	
	
	
}
	
	
	
	
	
	
	
</script>







