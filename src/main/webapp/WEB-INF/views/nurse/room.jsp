<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />
<script src="https://unpkg.com/picmo@5.7.6/dist/umd/index.js"></script>
<script
	src="https://unpkg.com/@picmo/popup-picker@5.7.6/dist/umd/index.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/vendors/echarts/echarts.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
<style>
.table thead {
	position: sticky;
	top: 0;
	z-index: 1;
	/* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}

/* #patntClnicModal, .modal-xl { - */
/* 	-falcon-modal-width: 1000px; */
/* } */

#xrayModal, .modal-xl { -
	-falcon-modal-width: 450px;
}


</style>

<c:set var="customUser"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<div class="row">
	<input type="hidden" id="empNm1" value="${ customUser.employee.empNm}">
	<input type="hidden" id="empNo" value="${ customUser.employee.empNo}">
	<!-- ================================= 환자 차트모달 시작 =================================================-->
	<div class="modal fade" id="patntClnicModal" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg mt-6" role="document">
			<div class="modal-content border-0" style="width: 1000px;">
				<div class="modal-body" style="padding: 0px;">
					<div class="kanban-column" style="width: 100%">
							<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
							<div class="col-12 align-self-center">
								<h5 class="text-white mb-0 fw-semi-bold" id="header">
									환자 기록 차트</h5>
							</div>
						</div>
						<table class="table mb-0 data-table fs--1 " id="">
							<thead class="bg-200">
								<tr>
									<th class="text-800 text-center sort">진료번호</th>
									<th class="text-800 text-center sort" noWrap>담당의</th>
									<th class="text-800 text-center sort">진료일</th>
									<th class="text-800 text-center sort">진단내역</th>
									<th class="text-800 text-center sort" noWrap>입원여부</th>
									<th class="text-800 text-center sort">발병일</th>
									<th class="text-800 text-center sort" noWrap>메모사항</th>
								</tr>
							</thead>
							<tbody class="list" style="width: 250pt;" id="patntClnicTable">

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 환자 차트모달 끝 =================================================-->
	<!-- ================================= 환자 상세 조회 시작 =================================================-->
	<div class="col-2">
		<div class="card border border-secondary m-0" style="height: 820px;">
			<div class="row">
				<div class="col">
					<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							환자 상세 정보</h5>
					</div>
				</div>
				</div>
			</div>

			<div class="row">
				<div class="col">
					<div class="input-group search-box pt-2 pb-0 px-2">
						<form class="position-relative w-60" data-bs-toggle="search"
							data-bs-display="static">
							<input class="form-control search-input fuzzy-search"
								type="search" placeholder="환자명을 입력해 주세요." aria-label="Search"
								id="searchInput" style="height: 40px" /> <span
								class="fas fa-search search-box-icon"></span>
						</form>

						<div
							class="dropdown-menu border font-base start-1 mt-2 py-0 overflow-hidden"
							style="top: 35px; width: 270px;">
							<!-- 드롭다운 길이 수정 : max-height: 17rem;  	 -->
							<div class="scrollbar list" style="max-height: 17rem;" id="search-results"></div>
						</div>
					</div>
				</div>
			</div>

			<form>
				<div class="row card-body py-0">
					<div class="tab-content" style="height: 600px;">
						<br>
						<table>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="차트 번호" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="clnicNo" name="clnicNo" type="text" value="" disabled /><br>
								</td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="환자명" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="patntNm" name="patntNm" type="text" value="" disabled /> <br>
								</td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="생년월일" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="patntRrno1" name="patntRrno1" type="text" value="" disabled />
									<br></td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="담당의사" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="empNm2" name="empNm2" type="text" value="" disabled /> <br>
								</td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="입원일" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="hsptlzDe" name="hsptlzDe" type="text" value="" disabled />
									<br></td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="예정 퇴원일" disabled /></th>
							</tr>
							<tr>
								<td><input class="text-black form-control bg-white"
									id="prarndeLhstl" name="prarndeLhstl" type="text" value=""
									disabled /> <br></td>
							</tr>
							<tr>
								<th><input
									class="fw-semi-bold col-6  text-black text-center form-control"
									style="width: 50%; height: 30px;" id="" name="" type="text"
									value="호실/병상" disabled /></th>
							</tr>
							<tr>
								<td>
									<div style="width: 35%; white-space: nowrap;">
										<input class="text-black form-control bg-white"
											id="hsptlzSckrm" name="hsptlzSckrm" type="text" value=""
											disabled style="display: inline-block;" />&nbsp;호
										&nbsp;&nbsp; <input class="text-black form-control bg-white"
											id="hsptlzSckbd" name="hsptlzSckbd" type="text" value=""
											disabled style="display: inline-block;" />&nbsp;병상
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- ================================= 환자 상세 조회 끝 =================================================-->

	<!-- ================================= 환자 처방, 검사 , 치료기록/vital 시작 =================================================-->
	<div class="col-4">

		<div class="card border border-secondary" style="height: 410px;">
			<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							입원 환자 기록</h5>
					</div>
				</div>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link active" id="home-tab"
					data-bs-toggle="tab" href="#tab-home" role="tab"
					aria-controls="tab-home" aria-selected="true">처방</a></li>
				<li class="nav-item"><a class="nav-link" id="profile-tab"
					data-bs-toggle="tab" href="#tab-profile" role="tab"
					aria-controls="tab-profile" aria-selected="false">검사</a></li>
				<li class="nav-item"><a class="nav-link" id="contact-tab"
					data-bs-toggle="tab" href="#tab-contact" role="tab"
					aria-controls="tab-contact" aria-selected="false">치료</a></li>
			</ul>
			<!-- 탭 시작 -->
			<div class="tab-content border border-0 p-0" id="myTabContent">
				<!-- TAB1 -->
				<div class="tab-pane fade show active" id="tab-home" role="tabpanel"
					aria-labelledby="home-tab">
					<div class="table-container scrollbar"
						style="overflow-y: auto; max-height: 310px;">
						<table class="table mb-0 data-table fs--1 " style="height: px;">
							<thead class="bg-100">
								<tr>
									<th class="col-1 text-center" scope="col">약품명</th>
									<th class="col-1 text-center" scope="col">약품코드</th>
									<th class="col-1 text-center" scope="col">투여경로</th>
									<th class="col-1 text-center" scope="col">투여용량</th>
									<th class="col-1 text-center" scope="col">투여횟수</th>
									<th class="col-1 text-center" scope="col">투여기간</th>
								</tr>
							</thead>
							<tbody
								style="overflow-y: auto; max-height: 90px; text-align: center;"
								id="prescriptionTable">

								<!-- 차트에 따른 처방 내용 -->
							</tbody>
						</table>
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
				</div>

				<!-- TAB2 -->
				<div class="tab-pane fade" id="tab-profile" role="tabpanel"
					aria-labelledby="profile-tab">
					<div class="table-container scrollbar"
						style="overflow-y: auto; max-height: 310px;">
						<table class="table mb-0 data-table fs--1 " style="height: 90px;">
							<thead class="bg-100">
								<tr id="" class="bg-light">
									<th class="col-1 text-center" scope="col">날짜</th>
									<th class="col-1 text-center" scope="col">채혈</th>
									<th class="col-1 text-center" scope="col">소변</th>
									<th class="col-1 text-center" scope="col">X-RAY</th>
								</tr>
							</thead>
							<tbody
								style="overflow-y: auto; max-height: 90px; text-align: center;"
								id="examinationListTable">
								<!-- 										검사 내용 출력  -->
							</tbody>
						</table>
					</div>

					<div
						style="display: flex; justify-content: space-between; align-items: center;">
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
				</div>

				<!-- TAB3 -->
				<div class="tab-pane fade" id="tab-contact" role="tabpanel"
					aria-labelledby="contact-tab">
					<div class="table-container scrollbar"
						style="overflow-y: auto; max-height: 310px;">
						<table class="table mb-0 data-table fs--1 " style="height: 90px;">
							<thead class="bg-100">
								<tr>
									<th class="col-1 text-center" scope="col">차트번호</th>
									<th class="col-1 text-center" scope="col">치료</th>
									<th class="col-1 text-center" scope="col">치료사</th>
									<th class="col-1 text-center" scope="col">치료일시</th>
									<th class="col-1 text-center" scope="col">치료구분</th>
								</tr>
							</thead>
							<tbody
								style="overflow-y: auto; max-height: 90px; text-align: center;"
								id="treatmentTable">
								<!-- 치료 내용 -->
							</tbody>
						</table>
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
				</div>
			</div>
		</div>

		<div class="card border border-secondary" style="height: 410px;">
			<div class="">
				<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							입원 환자 바이탈</h5>
					</div>
				</div>
			</div>

			<div class="card-body" style="padding: 5px;">
				<br> &emsp;&emsp;<span class="badge badge-subtle-info">체온</span>
				&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp;
				&emsp; &emsp; &emsp; <span class="badge badge-subtle-danger">혈압</span>
				<br> <br>
				<div class="row g-3 mb-3">
					<!-- 체온 bar chart -->
					<div class="col-6">
						<div class="tempChart" style="height: 250px;"
							data-echart-responsive="true"></div>
					</div>
					<!-- 혈압 line chart -->
					<div class="col-6">
						<div class="pressChart" style="height: 200px;"
							data-echart-responsive="true"></div>
					</div>
				</div>
				<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
			</div>
		</div>
	</div>
	<!-- ================================= 환자 처방, 검사 , 치료일정/vital 끝 =================================================-->

	<!-- ================================= 환자 검사 x-ray모달 시작 =================================================-->
	<div class="modal fade" id="patntXRAYModal" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg mt-6" role="document" id="xrayModal">
			<div class="modal-content border-0" style="width: 400px; height: 400px;">
					<div class="kanban-column" style="width: 100%">
						<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
							<h5 class="text-white mb-0 fw-semi-bold" id="header">
								X-RAY 검사 결과</h5>
						</div>
					</div>

					</div>
					<div class="carousel slide" id="carouselExampleControls"
						data-bs-ride="carousel" style="width: 400px; height: 400px;">

						<div class="carousel-indicators">
							<button class="active" type="button"
								data-bs-target="#carouselExampleControls" data-bs-slide-to="0"
								aria-current="true" aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#carouselExampleControls"
								data-bs-slide-to="1" aria-label="Slide 2"></button>

						</div>
						<div class="carousel-inner rounded" id="xrayHtmlSpace"></div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</button>
					</div>
			</div>
		</div>
	</div>
	<!-- ================================= 환자 검사 x-ray모달  끝 =================================================-->

	<!-- ================================= 환자 간호 기록지, 식이/I,O 시작 =================================================-->
	<div class="col-3">
		<div class="card border border-secondary" style="height: 410px;">
			<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							간호 기록지</h5>
					</div>
				</div>
			<div class="form-floating mb-3" style="position: relative;">
				<textarea class="form-control" id="nrsRcordMemo"
					placeholder="간호기록내역을 작성해 주세요" style="height: 320px; overflow: auto;"></textarea>
				<label for="floatingInput" style="font-size: 16px; font-weight: bold;">작성자  : ${ customUser.employee.empNm} 간호사
				</label>
				<button class="btn btn-secondary btn-sm" type="button" id="nrBtn"
					style="background-color: midnightblue; position: absolute; top: 325px; right: 10px;">저장</button>
			</div>
		</div>

		<!-- 식이 & I/O 시작 -->
		<div class="card border border-secondary" style="height: 410px;">
			<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							식이 & I/O</h5>
					</div>
				</div>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item col-6"><a class="nav-link active"
					id="home-tab" data-bs-toggle="tab" href="#tab-meal" role="tab"
					aria-controls="tab-home" aria-selected="true">식이</a></li>
				<li class="nav-item col-6"><a class="nav-link" id="profile-tab"
					data-bs-toggle="tab" href="#tab-io" role="tab"
					aria-controls="tab-profile" aria-selected="false">I/O</a></li>
			</ul>
			<!--식이 탭 시작  -->
			<div class="tab-content border border-0 p-0" id="myTabContent">
				<!-- TAB1 -->
				<div class="tab-pane fade show active" id="tab-meal" role="tabpanel"
					aria-labelledby="home-tab" >
					<button class="btn btn-outline-warning btn-sm" type="button"
						id="mealbtn" style="margin-top: 5px; padding-left:5px; padding-right:5px; margin-right: 10px; float: right;">식이
						작성</button>
						<br> <br>
					<div class="table-container scrollbar"
						style="overflow-y: auto; max-height: 280px;">
						<table class="table mb-0 data-table fs--1 " style="height: 80px; text-align: center;">
							<thead class="bg-100">
								<tr id="" class="bg-light">
									<th class="col-1 " scope="col">날짜</th>
									<th class="col-1 " scope="col">식이코드</th>
									<th class="col-1 " scope="col">식이명</th>
									<th class="col-1 " scope="col">시간</th>
								</tr>
							</thead>
							<tbody style="overflow-y: auto; max-height: 90px; text-align: center;"
								id="mealListTable">
								<!-- 식이 내용 -->
							</tbody>
						</table>
					</div>
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
				</div>
				<!-- TAB2 -->
				<!--I/O 탭 시작  -->
				<div class="tab-pane fade" id="tab-io" role="tabpanel"
					aria-labelledby="profile-tab">
					<button class="btn btn-outline-warning btn-sm" type="button"
						id="iobtn" style="margin-top: 5px; padding-left:5px; padding-right:5px; margin-right: 10px; float: right;">
						I/O 작성</button>
						<br> <br>
					<div class="table-container scrollbar"
						style="overflow-y: auto; max-height: 280px;">
						<table class="table mb-0 data-table fs--1 " style="height: 80px; text-align: center;">
							<thead class="bg-100">
								<tr id="" class="bg-light">
									<th class="col-1 " scope="col" noWrap>시행일자</th>
									<th class="col-1 " scope="col">섭취</th>
									<th class="col-1 " scope="col">섭취 (mL)</th>
									<th class="col-1 " scope="col">배출</th>
									<th class="col-1 " scope="col">배출 (mL)</th>
								</tr>
							</thead>
							<tbody style="overflow-y: auto; max-height: 90px; text-align: center;"
								id="ioListTable">
								<!-- i/o 작성 -->
							</tbody>
						</table>
					</div>
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3"></div>
				</div>
			</div>

		</div>
		<!-- ROW -->
	</div>
	<!-- ================================= 환자 간호 기록지, 식이/I,O 끝 =================================================-->

	<!-- ================================= 환자 인수인계 시작 =================================================-->
	<div class="col-3">
		<div class="card border border-secondary" style="height: 820px;">
			<div class="card-header border-bottom p-2"	style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							환자 인수인계</h5>
					</div>
				<button class="btn btn-secondary btn-sm" id="rebtn"
					style="background-color: midnightblue; position: absolute; top: 4px; right: 10px; border: none;"
					data-fa-transform="shrink-3">
					<span class="fas fa-redo fs-1"></span>
				</button>
			</div>
			<div class="h-100 overflow-auto scrollbar">
				<div class="timeline-vertical" id="jyList"
					style="width: 90%; padding-left: 30px;">
					<!-- 여기안에다 ajax 출력하는 곳 -->
				</div>
			</div>

			<div class="chat-editor-area" style="height: 80px;">
				<input type="hidden" name="nrsRcordCd" id="nrsRcordCd">
				<div class="emojiarea-editor outline-none scrollbar" id="nrsRcordCn"
					contenteditable="true" contenteditable="true" style="height: 80px;"></div>
				<!--text area  -->
				<div class="btn btn-link emoji-icon" data-picmo="data-picmo" 
					data-picmo-input-target=".emojiarea-editor">
					<span class="far fa-laugh-beam"></span>
				</div>
				<button class="btn btn-sm btn-send shadow-none" id="takeOverBtn"timeline-item-card
					type="button">저장</button>
			</div>

		</div>
	</div>

	<!-- ================================= 환자 인수인계 끝 =================================================-->

	<!-- 환자번호 hidden -->
	<input type="hidden" id="patntNo" value="" />
	<!-- 환자이름 hidden -->
	<input type="hidden" id="patntNm" value="" />
	<!-- 환자 주민 번호 hidden -->
	<input type="hidden" id="patntRrno1" value="" />
	<!-- 입원번호 hidden -->
	<input type="hidden" id="hsptlzCd" value="" />
	<!-- 환자 차트번호 hidden -->
	<input type="hidden" id="clnicNo1" value="" />

	<!-- ================================= 식이 모달 창 시작  =================================================-->

	<div class="modal fade" id="mealEventModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content border">

				<div class="modal-header px-x1 border-bottom-3"
					style="background-color: midnightblue;">
					<h5 class="modal-title text-white">식이 기록지</h5>
					<button class="btn-close me-n1" type="button"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="px-x1 border-bottom-0">
					<input type="hidden" name="mealCd" id="mealCd"> <input
						type="hidden" name="hsptlzCd" id="hsptlzCd"> <input
						type="hidden" name="empNo" id="empNo">
					<!-- 식이 코드 -->
					<div class="mb-3 mt-3">
						<label class="fs-0" for="eventLabel">식이 명</label> <select
							class="form-select" id="mealNm" name="mealNm"
							onchange="updateMealPrice()">
							<option value="RD" selected="selected">일반식[R/D]</option>
							<option value="TD">허용식 [T/D]</option>
							<option value="SD">연식 [S/D]</option>
							<option value="LD">유동식 [L/D]</option>
							<option value="SOW">물 [SOW]</option>
							<option value="NPO">금식 [NPO]</option>
						</select>
					</div>
					<div class="mb-3">
						<label class="fs-0" for="eventTitle">식대</label> <input
							class="form-control" type="number" name="mealPrice"
							id="mealPrice" required="required" disabled />
					</div>
					<div class="mb-3">
						<label class="fs-0" for="eventStartDate">섭취일</label> 
						<input class="form-control" id="mealDate" name="mealDate"
							required="required" type="datetime-local" placeholder="섭취일정을 설정해주세요"/>
					</div>
					<div class="mb-3">
						<label class="fs-0" for="eventLabel">섭취 시간</label> <select
							class="form-select" id="mealTime" name="mealTime">
							<option value="bkft" selected="selected">아침</option>
							<option value="lanch">점심</option>
							<option value="dinner">저녁</option>
						</select>
					</div>
				</div>
				<div
					class="modal-footer d-flex justify-content-end align-items-center bg-body-tertiary border-0">
					<button class="btn btn-secondary btn-sm" id="mailEventBtn"
						style="background-color: midnightblue;">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 식이 모달 창 끝  =================================================-->

	<!-- ================================= I/O 모달 창 시작  =================================================-->

	<div class="modal fade" id="ioEventModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content border">
				<div class="modal-header px-x1 border-bottom-0"
					style="background-color: midnightblue;">
					<h5 class="modal-title text-white">I/O 기록지</h5>
					<button class="btn-close me-n1" type="button"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="px-x1 border-bottom-0">
					<input type="hidden" name="ioCd" id="ioCd">
					<!-- I/O 코드 -->
					<div class="modal-body p-x1">
						<div class="mb-3">
							<label class="fs-0" for="eventStartDate">작성 시간</label>
							<input class="form-control " id="ioDate" name="ioDate"
							required="required" type="datetime-local" placeholder="I/O일정을 설정해주세요"/> 
						</div>
						<div class="mb-3">
							<label class="fs-0" for="eventTitle">섭취 내용</label> <input
								class="form-control" type="text" name="ioNtk" id="ioNtk"
								required="required" />
						</div>
						<div class="mb-3">
							<label class="fs-0" for="eventTitle">섭취 용량 (mL)</label> <input
								class="form-control" type="number" name="ioNtkMl" id="ioNtkMl"
								required="required" />
						</div>
						<div class="mb-3">
							<label class="fs-0" for="eventLabel">배설 내용</label> <select
								class="form-select" id="ioOut" name="ioOut">
								<option value="UO" selected="selected">소변</option>
								<option value="VOM">구토</option>
								<option value="DIA">설사</option>
								<option value="SO">대변</option>
							</select>
						</div>
						<div class="mb-3">
							<label class="fs-0" for="eventTitle">배설 용량 (mL)</label> <input
								class="form-control" type="number" name="ioOutMl" id="ioOutMl"
								required="required" />
						</div>
					</div>
					<div
						class="modal-footer d-flex justify-content-end align-items-center bg-body-tertiary border-0">
						<button class="btn btn-secondary btn-sm"
							style="background-color: midnightblue;" id="ioEventBtn">저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ================================= I/O 모달 창 끝  =================================================-->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script
	src="https://cdn.jsdelivr.net/jsbarcode/3.3.20/JsBarcode.all.min.js"></script>
<script type="text/javascript"
	src="/resources/assets/js/nurse/barcode.js"></script>

<script type="text/javascript">
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	var patntClnicModal = $("#patntClnicModal");
	var patntClnicTable = $("#patntClnicTable");
	
	var takeOverBtn = $("#takeOverBtn");
	var mailEventBtn = $("#mailEventBtn");
	var ioEventBtn = $("#ioEventBtn");
	var rebtn = $("#rebtn"); //인수인계 새로고침 버튼
	
	var empNm = $("#empNm").val();
	var empNm1 = $("#empNm1").val();
	var empNo = $("#empNo").val();
	var patntNo = "";
			
			
/* --------------------환자조회----------------------- */

		// 검색 input요소
		var searchInput = $("#searchInput");
		// 드롭다운 요소(결과를 뿌려줄 곳)
		var searchRes = $("#search-results");
		// 환자 정보를 담을 테이블
		var patientTable = $("#patientTable");
		console.log(patientTable);
		let selectedIndex = -1;

		searchInput.focusin(function () {
			console.log("searchInput...!");
			if (searchInput.val() == "") {
				console.log("searchInput.val() : " + searchInput.val());
				$.ajax({
					type: "post",
					url: "/mediform/patient/HsptlzInfo",
					contentType: "application/json; charset=utf-8",
					beforeSend: function (xhr) {
						//ajax호출 중 처리
						//글로벌 변수로 설정한 csrf token 셋팅
						xhr.setRequestHeader(header, token);
					},
					success: function (res) {
						var searchResultsHtml = "";
						console.log(res.length);
						
						searchResultsHtml += ' <table class="table table-sm table-hover">';
						searchResultsHtml += '<thead class="bg-100">';
						searchResultsHtml += '<tr class="">';
						searchResultsHtml += '<td class="text-900 sort text-center">환자번호</td>';
						searchResultsHtml += '<td class="text-900 sort text-center">환자명</td>';
						searchResultsHtml += '<td class="text-900 sort text-center">나이</td>';
						searchResultsHtml += '<td class="text-900 sort text-center" style="min-width: 80px;">생년월일</td>';
						searchResultsHtml += '</tr>';
						searchResultsHtml += '</thead>';
												
						$(res).each(function () {
							 var number = this.patntRrno1;  // 주민번호 변수로 설정
							 // 변환된 생년월일을 담을(리턴할) 변수
						     var formatRrno1 = "";
							 
							 var zeroLength = 6 - number.toString().length;
							
							 if (zeroLength > 0) {
							     for (var i = 0; i < zeroLength; i++) {
							         formatRrno1 += "0";
							     }
							 }
							
							 formatRrno1 += number;

						    console.log(this.patntNm + " " + this.patntAge);
						    searchResultsHtml += '<tr class="patntinfo">';
						    searchResultsHtml += '<td class="text-900 sort text-center" id="' + this.patntNo + '">' + this.patntNo + '</td>';
						    searchResultsHtml += '<td class="text-900 sort text-center" id="' + this.patntNm + '">' + this.patntNm + '</td>';
						    searchResultsHtml += '<td class="text-900 sort text-center">' + this.patntAge + '세 </td>';
						    searchResultsHtml += '<td class="text-900 sort text-center" id="' + formatRrno1 + '">' + formatRrno1 + '</td>';
						    searchResultsHtml += '</tr>';
						});

						searchResultsHtml += '</table>';
						
						$(searchRes).html(searchResultsHtml);
					},
					error: function (err) {
						console.log("환자 조회>>>err에러 : " + err);
					}
				});
			}
		});

		// 환자 검색 시 키보드를 한글자씩 눌렀다가 떼는 순간 이벤트 발생
		searchInput.on("keyup", function () {
			$("#patntNo").val(""); //환자 정보 초기화
			$("#patntNm").val(""); 
			$("#patntRrno1").val("");
			$("#hsptlzCd").val("");
			$("#clnicNo1").val("");
			
			var keyword = searchInput.val();
			console.log("keyword : " + keyword);
			var searchObj = {
				keyword: keyword
			};

			// 검색 환자 정보
			$.ajax({
				type: "post",
				url: "/mediform/patient/hsptlzSearch",
				data: JSON.stringify(searchObj),
				contentType: "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					//ajax호출 중 처리
					//글로벌 변수로 설정한 csrf token 셋팅
					xhr.setRequestHeader(header, token);
				},
				success: function (res) {
					var searchResultsHtml = "";
					console.log(res.length);
					// 받아온 데이터가 없을 때 
					// 환자 정보 없음은 h5로 설정(h6로 설정 시 클릭하면 환자 정보 테이블에 들어가지기 때문)
					if (res.length == 0) {
						console.log("받아온 데이터 없음");
						searchResultsHtml += '<table class="table table-sm table-hover">';
						searchResultsHtml += '<tr class="">';
						searchResultsHtml += '<td class="text-900 sort text-center" colspan="4">환자 정보가 존재하지 않습니다.</td>';
						searchResultsHtml += '</tr>';
					} else {
						// 받아온 값을 뿌리는 역할

						searchResultsHtml += ' <table class="table table-sm table-hover">';
						searchResultsHtml += '<thead class="bg-100">';
						searchResultsHtml += '<tr class="">';
						searchResultsHtml += '<td class="text-900 sort text-center">환자번호</td>';
						searchResultsHtml += '<td class="text-900 sort text-center">환자명</td>';
						searchResultsHtml += '<td class="text-900 sort text-center">나이</td>';
						searchResultsHtml += '<td class="text-900 sort text-center" style="min-width: 80px;">생년월일</td>';
						searchResultsHtml += '</tr>';
						searchResultsHtml += '</thead>';
												
						$(res).each(function () {
							 var number = this.patntRrno1;  // 주민번호 변수로 설정
							 // 변환된 생년월일을 담을(리턴할) 변수
						     var formatRrno1 = "";
							 
							 var zeroLength = 6 - number.toString().length;
							
							 if (zeroLength > 0) {
							     for (var i = 0; i < zeroLength; i++) {
							         formatRrno1 += "0";
							     }
							 }
							
							 formatRrno1 += number;
							console.log(this.patntNm + " " + this.patntAge);
							searchResultsHtml += '<tr class="patntinfo">';
							searchResultsHtml += '<td class="text-900 sort text-center" id="' + this.patntNo + '">' + this.patntNo + '</td>';
							searchResultsHtml += '<td class="text-900 sort text-center" id="' + this.patntNm + '">' + this.patntNm + '</td>';
							searchResultsHtml += '<td class="text-900 sort text-center">' + this.patntAge + '세 </td>';
							searchResultsHtml += '<td class="text-900 sort text-center" id="' + formatRrno1 + '">' + formatRrno1 + '</td>';
							searchResultsHtml += '</tr>';
						});
						searchResultsHtml += '</table>';
					}
					$(searchRes).html(searchResultsHtml);
				},
				error: function (err) {
					console.log("환자 검색 >>err에러 : " + err);
				}
			});
		});

		$("#searchInput").keypress(function (event) {
			if (event.which == 13) {
				event.preventDefault();
				patntNo = searchRes.children("div:eq(0)").data("no");
				var patntNm = searchRes.children("div:eq(0)").data("name");
				console.log(patntNo);
				// input태그에 선택된 이름 넣어주기
				$(searchInput).val(patntNm);
				// 환자 조회
				selectPatientAjax(patntNo);


				searchInput.blur();
				$(".hideOnOff").hide();
			}
		});

	// 위에서 뿌려준 환자 정보를 클릭시 (드롭다운 div 안에 있는 patntinfo 클래스 요소를 전부 가져와 클릭 이벤트 발생 시 작동)
	$(searchRes).on("click", ".patntinfo", function() {

		var patntNo = $(this).find("td:nth-child(1)").attr("id");
	    var patntNm = $(this).find("td:nth-child(2)").attr("id");
	    var patntRrno1 = $(this).find("td:nth-child(4)").attr("id");

	    console.log("클릭된 환자번호:", patntNo);
	    console.log("클릭된 환자이름:", patntNm);
	    console.log("클릭된 주민등록번호:", patntRrno1);
		
		$("#patntNo").val(patntNo);
		$("#patntNm").val(patntNm);
		$("#patntRrno1").val(patntRrno1);

		//환자 차트 모달 
		patntClnicModal.modal("show");
		//환자 차트 조회
		patntClnicList(patntNo);
		//환자 take over 조회
		selectTakeOverAjax(patntNo);
		//환자 meal, IO 조회
		selectMealIoAjax();
		//환자 바이탈 정보
		selectVitalAjax(patntNo);
		//환자 치료 조회
		selectTreatmentAjax(patntNo);
		//환자 tale over 등록
		//insertTakeOverAjax(patntNo);
		//환자 검색 조회
		selectExaminationAjax(patntNo);
			
		
	});
	


function patntClnicList(patntNo) {
	
	$.ajax({
		type: "post",
		url: "/mediform/nurse/room/patntClnic/list",
		data: JSON.stringify({ "patntNo": patntNo }),
		contentType: "application/json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function (dataList) {
			console.log("TOdataList::::::", dataList);

			let htmlStr = "";
			for (let i = 0; i < dataList.length; i++) {
				let pc = dataList[i];
				
				if(pc.atfssDt == null){
					pc.atfssDt = "-";
				}else{
					pc.atfssDt = pc.atfssDt.replace(/-/g, ".");
				}
				if(pc.clnicMemo == null){
					pc.clnicMemo = "-";
				}
				if(pc.clnicCn == null){
					pc.clnicCn = "["+pc.patntNm+"] "+"환자 내원 사유: 검사 시행";
				}
				pc.clnicTime = pc.clnicTime.replace(/-/g, ".");
				
				if(pc.hsptlzAt == 'N'){
					pc.hsptlzAt = "x";
					htmlStr += `
						<tr>
							<th>\${pc.clnicNo}</th><!-- 입원여부가 N일때는 막아놓기 -->
							<th>\${pc.empNm}</th>
							<th noWrap>\${pc.clnicTime}</th>
							<th>\${pc.clnicCn}</th>
							<th class="text-center">\${pc.hsptlzAt}</th>
							<th class="text-center" noWrap>\${pc.atfssDt}</th>
							<th class="text-center">\${pc.clnicMemo}</th>
						</tr>
							`;
				}else{
					pc.hsptlzAt = "o";
				htmlStr += `
						<tr>
							<th><a id="clnicNobtn" href="#">\${pc.clnicNo}</a></th>
							<th>\${pc.empNm}</th>
							<th noWrap>\${pc.clnicTime}</th>
							<th>\${pc.clnicCn}</th>
							<th class="text-center">\${pc.hsptlzAt}</th>
							<th class="text-center" noWrap>\${pc.atfssDt}</th>
							<th class="text-center">\${pc.clnicMemo}</th>
						</tr>
						`;
				}
			}
			$("#patntClnicTable").html(htmlStr);  // 화면에 html넣기
		},
		error: function (err) {
			console.log("인수인계 >>err에러 : " + err);
		}
	});
	
}

///////////////////////////////////////////////////////////////

    //차트 번호를 눌렀을때 
	$(patntClnicTable).on("click", "a", function (event) {
				
		var clickTarget = $(event.target);

		var clnicInfo = clickTarget.text();
		console.log("clnicInfo>>>>>",clnicInfo);
		//환자 차트정보값 저장
		$("#clnicNo1").val(clnicInfo);
		//환자 차트,입원 상세정보
		 selectPatientAjax();
		//환자 차트에 따른 처방 내역
		 selectPrescriptionAjax();
		 $('#patntClnicModal').modal('hide');
	});	
	//환자 detail
	function selectPatientAjax() {
		var clnicNo = $("#clnicNo1").val();
		var patntNo = $("#patntNo").val();
		var patntNm = $("#patntNm").val();
		var patntRrno1 = $("#patntRrno1").val();
		
		console.log("clnicInfo>>???????????????>>>",clnicNo);
			// 환자 정보 ajax 시작
			$.ajax({
				type: "post",
				url: "/mediform/nurse/room/patientHospital/list",
				data: { "clnicNo" : clnicNo },
				//contentType : "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function (res) {
					
					  var dateString = res.hsptlzDe;
	                  var date = new Date(dateString);
	                  var year = date.getFullYear();
	                  var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
	                  var day = date.getDate().toString().padStart(2, '0'); 
					  var formattedDate = year +'.'+ month + '.' + day;
					  
					  var dateString = res.prarndeLhstl;
	                  var date1 = new Date(dateString);
	                  var year = date1.getFullYear();
	                  var month = (date1.getMonth() + 1).toString().padStart(2, '0'); 
	                  var day = date1.getDate().toString().padStart(2, '0'); 
					  var formattedDate1 = year +'.'+ month + '.' + day;
					 
					 if(res.clnicNo === null || res.clnicNo === undefined){ //null 또는 undefined 일 때 처리
				            $("#clnicNo").val("입원 내역이 없습니다.");
				            $("#empNm2").val("-");
				            $("#hsptlzDe").val("-");
				            $("#prarndeLhstl").val("-");
				            $("#hsptlzSckrm").val("-");
				            $("#hsptlzSckbd").val("-");
				        } else {
					  
					console.log("[환자 상세 정보] 환자번호: " + patntNo + " | 환자이름: " + patntNm + " | 환자 주민앞자리:" + patntRrno1);
					$("#clnicNo").val(res.clnicNo);
					$("#patntNm").val(patntNm);
                    $("#patntRrno1").val(patntRrno1);
					$("#empNm2").val(res.empNm);
					$("#hsptlzDe").val(formattedDate);
					$("#prarndeLhstl").val(formattedDate1);
					$("#hsptlzSckrm").val(res.hsptlzSckrm);
					$("#hsptlzSckbd").val(res.hsptlzSckbd);
			
					console.log("res.hsptlzCd::>>>>",res.hsptlzCd);
					
					$("#hsptlzCd").val(res.hsptlzCd);
				     }
				},
				error: function (err) {
					console.log("환자 정보>>>err에러 : " + err);
				}
				
			});
			
		
		}

	/* --------------------환자조회  끝----------------------- */
		//간호기록내역 작성 작성!!!!!!!!!!!!!
		    $("#nrBtn").on("click", function() {
		    	
		    	patntNo = $("#patntNo").val();	
		    	var clnicNo = $("#clnicNo1").val();
				var nrsRcordCd = $("#nrsRcordCd").val();
				var nrsRcordMemo = $("#nrsRcordMemo").val();
			    	
					if(nrsRcordMemo == ""){
						Swal.fire({
						      icon: 'warning',
						      title: '간호기록 작성',
						      text: '내용을 입력해주세요!',
						      confirmButtonColor: 'blue'
						    });
					}else{
					 
			        var nrecordData = {
							patntNo : patntNo,
							clnicNo : clnicNo,
							nrsRcordWrter : empNo,
							nrsRcordMemo : nrsRcordMemo
			        };

				     console.log("간호기록 내역 들어갔나??>>",nrecordData);

			        
			        $.ajax({
			            url : "/mediform/nurse/room/nrecord/insert",
			            type : "POST",
			            data : JSON.stringify(nrecordData),
			            contentType : "application/json; charset=utf-8",
			            beforeSend : function(xhr) {
			                xhr.setRequestHeader(header, token);
			            },
			            success : function(response) {
			            	Swal.fire({
							      icon: 'success',
							      title: '간호기록내역',
							      text: '간호기록내역이 저장되었습니다.',
							      confirmButtonColor: 'blue'
							    });
						    $("#nrsRcordMemo").val("");
							
						},
						error : function(err) {
							Swal.fire({
							      icon: 'warning',
							      title: '기록 내용을 입력하세요!',
							      confirmButtonColor: 'blue'
							    });
						}
			        });
				  }
			  });
			
			//간호기록내역 작성 작성!!!!!!!!!!!!!
		
////////////////////////////////////////////////////////////////////////////////////////////////
/* --------------------환자인수인계 시작----------------------- */
	function selectTakeOverAjax(patntNo) {
			
		
			$.ajax({
				type: "post",
				url: "/mediform/nurse/room/takeOver/list",
				data: JSON.stringify({ "patntNo": patntNo }),
				contentType: "application/json",
				beforeSend: function (xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function (dataList) {
					console.log("TOdataList::::::", dataList);

					let htmlStr = "";
					for (let i = 0; i < dataList.length; i++) {
						
						let to = dataList[i];
						
				      var dateString = to.nrsRcordDe;
	                  var date = new Date(dateString);
	                  var year = date.getFullYear();
	                  var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
	                  var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅
					  var hour = date.getHours().toString().padStart(2, '0');
					  var minute = date.getMinutes().toString().padStart(2, '0');
		                  // 원하는 형식으로 조합
		              var formattedDate = month + '.' + day +" " +hour+":"+minute;
					
		             	if(to.nrsRcordCd.startsWith("NRM")){
		             		//간호기록은 안뜨게 하기
		             	}else{
		             		
		             		if(to.empNm == empNm1){
							htmlStr += `
							<div class="timeline-item timeline-item-end"> <!-- 로그인자가 쓴것 -->
							<div class="timeline-icon icon-item icon-item-lg text-primary border-300">
								<span class="fs-1 fas fa-mobile"></span>
							</div>
									`;
						}else{
							htmlStr += `
							<div class="timeline-item timeline-item-start"> <!-- 다른 간호사가 쓴것 -->
							<div class="timeline-icon icon-item icon-item-lg text-primary border-300">
								<span class="fs-1 fas fa-mobile"></span>
							</div>
									`;
						}
						
						htmlStr += `
							<div class="row">
								<div class="col-lg-6 timeline-item-time">
									<div>
									
										<div class="fs--1 mb-0 fw-semi-bold">`+year+`</div>
										<div class="fs--2 text-600">`+formattedDate+`</div>
									</div>
								</div>
								<div class="col-lg-6">
									<div class="timeline-item-content">
										<div class="timeline-item-card">
											<h5 class="mb-2">\${to.empNm} </h5><h6>간호사</h6>
											<p class="fs--1 mb-0">\${to.nrsRcordCn}</p>
										</div>
									</div>
								</div>
							</div>
						</div>
								`;
		             	} 
					}
					$("#jyList").html(htmlStr);  // 화면에 html넣기
				},
				error: function (err) {
					console.log("인수인계 >>err에러 : " + err);
				}
			});
	}	
	
	//인수인계 새로고침 버튼
	rebtn.on("click", function() {
		var patntNo = $("#patntNo").val();
		selectTakeOverAjax(patntNo);
	});
	
 //인수인계 등록	
 takeOverBtn.on("click", function() {
	 	
	 	patntNo = $("#patntNo").val();	
		var nrsRcordCn = document.getElementById('nrsRcordCn').innerHTML;
		var nrsRcordCd = $("#nrsRcordCd").val();
		
		if(nrsRcordCn == ""){
			Swal.fire({
			      icon: 'warning',
			      title: '인수인계 작성',
			      text: '내용을 입력해주세요!',
			      confirmButtonColor: 'blue'
			    });
		}else{
		
		var takeOverObj = {
				nrsRcordCd : nrsRcordCd,
				patntNo : patntNo,
				nrsRcordWrter : empNo,
				nrsRcordCn : nrsRcordCn
		}
		console.log("empNo::::>>>",empNo);
		
		$.ajax({
                   type : "post",
                   url : "/mediform/nurse/room/takeOver/insert",
                   data : JSON.stringify(takeOverObj),
                   contentType : "application/json; charset = utf-8",
                     beforeSend : function(xhr){            
                      	xhr.setRequestHeader(header,token);
                     },
                   success: function(result) {
                      console.log("result:"+ result);
				Swal.fire({
     			      icon: 'success',
     			      title: '인수인계 작성',
     			      text: '인수인계가 등록되었습니다.',
     			      confirmButtonColor: 'blue'
     			    });
                      selectTakeOverAjax(patntNo);
                      $("#nrsRcordCn").html("");
                   },
                   error : function(err) {
                  	 Swal.fire({
 	      			      icon: 'warning',
 	      			      text: '인수인계 내용을 입력하세요!',
 	      			      confirmButtonColor: 'blue'
 	      			    });
                   }
                });
		}
	});	
		 
/* --------------------환자인수인계 끝----------------------- */

/* --------------------환자 식이 , I/O 조회 시작----------------------- */
	function selectMealIoAjax() {
	
		patntNo = $("#patntNo").val();
	
				$.ajax({ 
						type: "post",
						url: "/mediform/nurse/room/meal/list",
						data: JSON.stringify({ "patntNo": patntNo }),
						contentType: "application/json",
						beforeSend: function (xhr) {
							xhr.setRequestHeader(header, token);
						},
						success: function (dataList) {
							console.log("mealdataList::::::", dataList);
							let htmlStr = "";
							
							for (let i = 0; i < dataList.length; i++) {
								let meal = dataList[i];
								
							var mealName = meal.mealNm;
							var mealNminfo="";
							  if(mealName == 'RD'){
								  mealNminfo = '일반식[R/D]';
							  }else if(mealName == 'TD'){
								  mealNminfo = '허용식 [T/D]';
							  }else if(mealName == 'SD'){
								  mealNminfo = '연식 [S/D]';
							  }else if(mealName == 'LD'){
								  mealNminfo = '유동식 [L/D]';
							  }else if(mealName == 'SOW'){
								  mealNminfo = '물 [SOW]';
							  }else if(mealName == 'NPO'){
								  mealNminfo = '금식 [NPO]';
							  }
							  
							var mealTime = meal.mealTime;
							var mealTimeinfo="";
							if(mealTime == 'bkft'){
								mealTimeinfo = '아침';
							}else if(mealTime == 'lanch'){
								mealTimeinfo = '점심';
							}else if(mealTime == 'dinner'){
								mealTimeinfo = '저녁';
							}
							
					      var dateString = meal.mealDate;
		                  var date = new Date(dateString);
		                  var year = date.getFullYear();
		                  var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
		                  var day = date.getDate().toString().padStart(2, '0'); 
			                  // 원하는 형식으로 조합
			              var formattedDate = year+"."+month + '.' + day;
							
							htmlStr += `
									<tr >
										<td>`+formattedDate+`</td> 
										<td>\${meal.mealCd}</td>
										<td>`+mealNminfo+`</td>
										<td>`+mealTimeinfo+`</td>
									</tr>
									`;
						}
						$("#mealListTable").html(htmlStr); 
					},
					error: function (err) {
						console.log("인수인계 >>err에러 : " + err);
					}
				});
		
		
		$.ajax({
			type: "post",
			url: "/mediform/nurse/room/io/list",
			data: JSON.stringify({ "patntNo": patntNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (dataList) {
				console.log("iodataList::::::", dataList);
	
				let htmlStr = "";
				for (let i = 0; i < dataList.length; i++) {
					
					let io = dataList[i];
					
					var ioOutName = io.ioOut;
					var ioOutinfo="";
					  if(ioOutName == 'UO'){
						  ioOutinfo = '소변';
					  }else if(ioOutName == 'VOM'){
						  ioOutinfo = '구토';
					  }else if(ioOutName == 'DIA'){
						  ioOutinfo = '설사';
					  }else if(ioOutName == 'SO'){
						  ioOutinfo = '대변';
					  }
					
					
					var dateString = io.ioDate;
	                var date = new Date(dateString);
	                var year = date.getFullYear();
	                var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
	                var day = date.getDate().toString().padStart(2, '0'); 
	                var hour = date.getHours().toString().padStart(2, '0');
					var minute = date.getMinutes().toString().padStart(2, '0');
		            var formattedDate = month + '.' + day +" " +hour+":"+minute;
					
					htmlStr += `
						<tr>
							<td>`+formattedDate+`</td>
							<td>\${io.ioNtk}</td>
							<td>\${io.ioNtkMl}</td>
							<td>`+ioOutinfo+`</td>
							<td>\${io.ioOutMl}</td>
						</tr>
							`;
				}
				$("#ioListTable").html(htmlStr); 
			},
			error: function (err) {
				console.log("io >>err에러 : " + err);
			}
		});
	}
/* --------------------환자 식이 , I/O 조회 시작----------------------- */
 
/* --------------------식이, I/O 모달 창 & insert 시작----------------------- */
	var mealbtn = $("#mealbtn");
	var iobtn = $("#iobtn");
	var mealEventModal = $("#mealEventModal");
	var ioEventModal = $("#ioEventModal");
	
	function updateMealPrice() {
	    var mealSelectedValue = document.getElementById("mealNm").value;
	    var mealPriceInput = document.getElementById("mealPrice");

	    if (!mealSelectedValue || mealSelectedValue === "RD") { // 선택안했거나 일반식
	        mealPriceInput.value = 6000;
	    } else if (mealSelectedValue === "SD" || mealSelectedValue === "LD") { // 연식, 유동식
	        mealPriceInput.value = 3000; 
	    } else if (mealSelectedValue === "TD" || mealSelectedValue === "SOW" || mealSelectedValue === "NPO") { // 허용식(개인음식), 물, 금식
	        mealPriceInput.value = 0; 
	    } else {
	        mealPriceInput.value = 6000;
	    }
	}
		//식이, I/O 모달 창 클릭 시 실행
		mealbtn.on("click", function () {
			var hsptlzCd = $("#hsptlzCd").val();
			//console.log("식이 hsptlzCd>>>>",hsptlzCd);
			
			if(patntNo == ""){
				Swal.fire({
				      icon: 'warning',
				      title: '식이 작성',
				      text: '환자 정보를 선택해주세요!',
				      confirmButtonColor: 'blue'
				    });
			}else if(hsptlzCd == ""){
				Swal.fire({
				      icon: 'warning',
				      title: '식이 작성',
				      text: '입원 정보가 없습니다.',
				      confirmButtonColor: 'blue'
				    });
				
			}else{
			//console.log("식이 모달 클릭 이벤트 성공!!!");
			mealEventModal.modal("show");
			var mealPrice = $("#mealPrice").val(6000);
			}
		});	
				mailEventBtn.on("click", function() {
					var mealNm = $("#mealNm").val();
					var mealTime = $("#mealTime").val();
					var mealPrice = $("#mealPrice").val();
					var patntNo = $("#patntNo").val();
					var hsptlzCd = $("#hsptlzCd").val();
					var mealDate = $("#mealDate").val();
					
					console.log("환자번호도 받아왔나>?>>>",patntNo);
					console.log("hsptlzCd를 받아왔나?>>>>",hsptlzCd);
					console.log("clnicNo를 받아왔나?>>>>",clnicNo);
					
					
					var MealObj = {
							mealNm : mealNm,
							mealTime : mealTime,
							mealPrice : mealPrice,
							empNo : empNo,
							hsptlzCd : hsptlzCd,
							patntNo : patntNo,
							mealDate : mealDate
					};
					console.log("patentno::::>>>",patntNo);
					
					$.ajax({
	                     type : "post",
	                     url : "/mediform/nurse/room/meal/insert",
	                     data : JSON.stringify(MealObj),
	                     contentType : "application/json; charset = utf-8",
	                       beforeSend : function(xhr){            
	                        	xhr.setRequestHeader(header,token);
	                       },
	                     success: function(result) {
// 	                        alert("식이정보가 등록되었습니다.");
							Swal.fire({
		      			      icon: 'success',
		      			      title: '식이 작성',
		      			      text: '식이정보가 등록되었습니다.',
		      			      confirmButtonColor: 'blue'
		      			    });
	                        mealEventModal.modal('hide');
	                        selectMealIoAjax();
	                     },
	                     error : function(err) {
	                        alert(err,"meal 등록 실패!!");
	                     }
	                  });
					
				});
		


	iobtn.on("click", function () {
		var hsptlzCd = $("#hsptlzCd").val();
		//console.log("io hsptlzCd>>>>",hsptlzCd);
		if(patntNo == ""){
			Swal.fire({
			      icon: 'warning',
			      title: 'I/O 작성',
			      text: '환자 정보를 선택해주세요!',
			      confirmButtonColor: 'blue'
			    });
		}else if(hsptlzCd == ""){
			Swal.fire({
			      icon: 'warning',
			      title: 'I/O 작성',
			      text: '입원 정보가 없습니다.',
			      confirmButtonColor: 'blue'
			    });
		}else{
		//console.log("I/O 모달 클릭 이벤트 성공!!!");
		ioEventModal.modal("show");
	
		}
	});
	
	ioEventBtn.on("click", function() {
		var ioOut = $("#ioOut").val();
		var ioNtk = $("#ioNtk").val();
		var ioOutMl = $("#ioOutMl").val();
		var ioNtkMl = $("#ioNtkMl").val();
		var ioDate = $("#ioDate").val();
		var patntNo = $("#patntNo").val();
		var hsptlzCd = $("#hsptlzCd").val();

		
		//console.log("환자번호도 받아왔나>?>>>",patntNo);
		//console.log("hsptlzCd를 받아왔나?>>>>",hsptlzCd);
		
		var IoObj = {
				empNo : empNo,
				ioOut : ioOut,
				ioNtk : ioNtk,
				hsptlzCd : hsptlzCd,
				patntNo : patntNo,
				ioOutMl : ioOutMl,
				ioNtkMl : ioNtkMl,
				ioDate : ioDate
					}
		
		$.ajax({
                   type : "post",
                   url : "/mediform/nurse/room/io/insert",
                   data : JSON.stringify(IoObj),
                   contentType: "application/json",
	       			beforeSend: function (xhr) {
	       				xhr.setRequestHeader(header, token);
	       			},
                   success: function(result) {
//                       alert("I/O정보가 등록되었습니다.");
                  	Swal.fire({
      			      icon: 'success',
      			      title: 'I/O 작성',
      			      text: 'I/O정보가 등록되었습니다.',
      			      confirmButtonColor: 'blue'
      			    });
                      ioEventModal.modal('hide');
                      selectMealIoAjax();
                   },
                   error : function(err) {
                      alert(err,"IO 등록실패!!");
                   }
             });
		});

/* --------------------식이, I/O 모달 창 & insert 끝----------------------- */

/* --------------------치료 조회 시작----------------------- */
 	function selectTreatmentAjax(patntNo) {
		var dateInput = $("#dateInput");
		
 		$.ajax({
			type: "post",
			url: "/mediform/nurse/room/treatment/list",
			data: JSON.stringify({ "patntNo": patntNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
   				xhr.setRequestHeader(header, token);
   			},
			success: function(dataList) {
				console.log("treatmentdataList>>>",dataList);
				
				let htmlStr = "";
				
				for (let i = 0; i < dataList.length; i++) {
					let tm = dataList[i];
					
					var mdlrtCl = tm.mdlrtCl;
					var mdlrtClinfo="";
					  if(mdlrtCl == "물리"){
						  mdlrtClinfo = '<span class="badge rounded-pill badge-subtle-primary">물리</span>';
					  }else{
						  mdlrtClinfo = '<span class="badge rounded-pill badge-subtle-success">작업</span>';
					  }
					
					
					var dateString = tm.mdlrtDt;
	                var date = new Date(dateString);
	                var year = date.getFullYear();
	                var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
	                var day = date.getDate().toString().padStart(2, '0'); 
	                var hour = date.getHours().toString().padStart(2, '0');
					var minute = date.getMinutes().toString().padStart(2, '0');
		            var formattedDate = year+"."+month + '.' + day +" " +hour+":"+minute;
		            
		            if(tm.mdlrtDt === undefined || tm.mdlrtDt === null){
						formattedDate ='-';
					}
				 	if(tm.mdlrtCurer === undefined || tm.mdlrtCurer === null){
						tm.mdlrtCurer = "-";
					}
		            
					htmlStr += `
						<tr>
							<td>\${tm.clnicNo}</td>
							<td class="text-start" noWrap>\${tm.mdlrtNm}</td>
							<td>\${tm.mdlrtCurer}</td>
							<td>\${formattedDate}</td>
							<td>\${mdlrtClinfo}</td>
						</tr>
							`;
					
				}
				$("#treatmentTable").html(htmlStr);  // 화면에 html넣기
			},
            error : function(err) {
                alert(err,"치료 조회 실패!!");
             }
		});
		
//  		dateInput.on("click", function() {
//  			patntNo = $("#patntNo").val();
//  			var rceptDt = $("#dateInput").val();
 			
//  			$.ajax({
//  				type: "post",
//  				url: "/mediform/nurse/room/rceptDt/list",
//  				data: JSON.stringify({ "patntNo": patntNo,
//  										"rceptDt":rceptDt}),
//  				contentType: "application/json",
//  				beforeSend: function (xhr) {
//  	   				xhr.setRequestHeader(header, token);
//  	   			},
//  				success: function(dataList) {
//  					console.log("treatmentrceptDtdataList>>>",dataList);
 					
//  					let htmlStr = "";
 					
//  					for (let i = 0; i < dataList.length; i++) {
//  						let tm = dataList[i];
 						
//  						var rceptSttus = tm.rceptSttus;
//  						var rceptSttusinfo="";
//  						  if(rceptSttus == 0 || rceptSttus == 1){
//  							  rceptSttusinfo = '<span class="badge rounded-pill badge-subtle-info">진료중</span>';
//  						  }else if(rceptSttus == 2 || rceptSttus == 3 || rceptSttus == 4){
//  							  rceptSttusinfo = '<span class="badge rounded-pill badge-subtle-warning">검사중</span>';
//  						  }else if(rceptSttus == 5 || rceptSttus == 6 || rceptSttus == 7 || rceptSttus == 8){
//  							  rceptSttusinfo = '<span class="badge rounded-pill badge-subtle-success">치료중</span>';
//  						  }else{
//  							  rceptSttusinfo = '<span class="badge rounded-pill badge-subtle-primary">치료완료</span>';
//  						  }
 						
 						
//  						var dateString = tm.mdlrtDt;
//  		                var date = new Date(dateString);
//  		                var year = date.getFullYear();
//  		                var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
//  		                var day = date.getDate().toString().padStart(2, '0'); 
//  		                var hour = date.getHours().toString().padStart(2, '0');
//  						var minute = date.getMinutes().toString().padStart(2, '0');
//  			            var formattedDate = year+"."+month + '.' + day +" " +hour+":"+minute;
 			            
//  						if(tm.mdlrtDt === undefined || tm.mdlrtDt === null){
//  							formattedDate ='치료 대기';
//  						}
//  						if(tm.mdlrtCurer === undefined || tm.mdlrtCurer === null){
//  							tm.mdlrtCurer = "-";
//  						}
 			            
//  						htmlStr += `
//  							<tr>
//  								<td>\${tm.clnicNo}</td>
//  								<td noWrap>\${tm.mdlrtNm}</td>
//  								<td>\${tm.mdlrtCurer}</td>
//  								<td>\${formattedDate}</td>
//  								<td>\${rceptSttusinfo}</td>
//  							</tr>
//  								`;
//  					}
//  					$("#treatmentTable").html(htmlStr);  // 화면에 html넣기
//  				},
//  	            error : function(err) {
//  	                alert(err,"치료 캘린터 조회실패!!");
//  	             }
//  			});	
 			
// 		});
	}
 
/* --------------------치료 조회 끝----------------------- */
 
/* --------------------처방 조회 시작----------------------- */
 
 function selectPrescriptionAjax() {
	 var clnicNo = $("#clnicNo1").val();
	  console.log("처방눌렀을때 clnicNo>>>",clnicNo);
		$.ajax({
			type: "post",
			url: "/mediform/nurse/room/pres/list",
			data: JSON.stringify({ "clnicNo": clnicNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(dataList) {
				console.log("차트 처방prescription>>>",dataList);
				
				let htmlStr = "";
				
				for (let i = 0; i < dataList.length; i++) {
					let pr = dataList[i];
					
		            
					if(dataList === undefined || dataList === null){
						htmlStr += `
							<tr>
								<td colspan="6">처방 내역이 존재하지 않습니다.</td>
							</tr>
								`;
					}else{
					
					htmlStr += `
						<tr>
							<td class="text-center">\${pr.prscrptnNm}</td>
							<td class="text-center">\${pr.medcinCd}</td>
							<td class="text-center">\${pr.mdctnCoursUsage}</td>
							<td class="text-center">\${pr.mdctnCpcty}</td>
							<td class="text-center">\${pr.mdctnCo}</td>
							<td class="text-center">\${pr.mdctnPd}</td>
						</tr>
							`;
						}
				}
				$("#prescriptionTable").html(htmlStr);  // 화면에 html넣기
			},
         error : function(err) {
             alert(err,"치료 조회 실패!!");
          }
		});
	}		
/* --------------------처방 조회 시작----------------------- */

/* --------------------검사 조회 시작----------------------- */
	var patntXRAYModal = $("#patntXRAYModal");
	var patntXRAY = $(".patntXRAY");
	
	function selectExaminationAjax(patntNo) {
		
		$.ajax({
			type: "post",
			url: "/mediform/nurse/room/examination/list",
			data: JSON.stringify({ "patntNo": patntNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
   				xhr.setRequestHeader(header, token);
   			},
			success: function(dataList) {
				console.log("검사examinationdataList>>>",dataList);
				
				let htmlStr = "";
				
				for (let i = 0; i < dataList.length; i++) {
					let ex = dataList[i];
					
					var dateString = ex.clnicTime;
	                var date = new Date(dateString);
	                var year = date.getFullYear();
	                var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
	                var day = date.getDate().toString().padStart(2, '0'); 
		            var formattedDate = year+"."+month + '.' + day;
		            
		            if(ex.hc001 === null && ex.hc002 === null ){
						//검사 전일때 방지
					}else{
						
						if(ex.hc001 === undefined || ex.hc001 === null){
							ex.hc001 ='-';
						}
						if(ex.hc002 === undefined || ex.hc002 === null){
							ex.hc002 = "-";
						}
						
						htmlStr += "<tr>"
						htmlStr += "<td>" + formattedDate + "</td>"
						htmlStr += "<td>" + ex.hc001 + " (μL)</td>"
						htmlStr += "<td>" + ex.hc002 +" (ph)</td>"
						htmlStr += "<td><a class='patntXRAY' id='" + ex.clnicNo + "' href='#'>결과보기</a></td>"
						htmlStr += "</tr>"
							
								console.log("ex.clnicNo>>>>>>>>>>>>>>>>>>>>>>>>>>>",ex.clnicNo);
						
							
					}
				}
				$("#examinationListTable").html(htmlStr);  // 화면에 html넣기
			},
            error : function(err) {
                alert(err,"치료 조회 실패!!");
             }
		});
	}		
		
	$("#examinationListTable").on("click", ".patntXRAY", function () {
		console.log("진료번호>>>>>>>>>>>>>>>>>>>>>>>>"+ $(this).attr("id"));
		
		var clnicNo = $(this).attr("id");
		
		console.log("XRAY 모달 클릭 이벤트 성공!!!");
		patntXRAYModal.modal("show");
		
		var xraySelectObj = {
			clnicNo : clnicNo
		}
		
		var xrayHtml = "";
		var xrayHtmlSpace = $("#xrayHtmlSpace");
		$.ajax({
	 		type : "post",
			url : "/mediform/nurse/room/filemaster/select",
			data : JSON.stringify(xraySelectObj),
	 		contentType : "application/json; charset=utf-8",
	 		async: false,
	        beforeSend : function(xhr){            
	            xhr.setRequestHeader(header,token);
	        },
	 		success : function(res) {
				console.log("엑스레이 사진 가져오기 성공!!!");
				
				console.log("파일 개수 >>> " + res.length);
				
				$(res).each(function(){
					
					xrayHtml += "<div class='carousel-item active'>";
					xrayHtml += "  <img class='d-block' src='" + this.fileFlpth + "' alt='First slide' height='400' width='400'/>";
					xrayHtml += "</div>";
					
				});
				
				xrayHtmlSpace.html(xrayHtml);
				
	 		}
	 	});
		
		
		
		
		
		});
/* --------------------검사 조회 끝----------------------- */

/* --------------------chart 시작----------------------- */
	function selectVitalAjax(patntNo) {
				
		var hghrkHhprsdata = ""; //최고 혈압
		var lwtrkHhprsdata = ""; //최저 혈압
		var bdheatdata = ""; //체온
		var vitalDatedata = ""; //작성일
		
		$.ajax({
		    type: "post",
		    url: "/mediform/nurse/acting/vital",
		    data: JSON.stringify({ "patntNo": patntNo }),
		    contentType: "application/json",
		    beforeSend: function (xhr) {
		        xhr.setRequestHeader(header, token);
		    },
		    success: function (dataList) {
		        console.log("dataList vital:>>>>", dataList);
			        	
		            var hghrkHhprsdata = dataList.map(function(item) {
					    return item.hghrkHhprs;
						});
					
					var lwtrkHhprsdata = dataList.map(function(item) {
					    return item.lwtrkHhprs;
						});
					
					var bdheatdata = dataList.map(function(item) {
					    return item.bdheat;
						});
					
					var vitalDatedata = dataList.map(function(item) {
					    var date = new Date(item.vitalDate);
					    var formattedDate = date.getFullYear() + '.' + (date.getMonth() + 1).toString().padStart(2, '0') + '.' + date.getDate().toString().padStart(2, '0');
					    return formattedDate;
						});
		   
			console.log("vitalDatedata??????????:",vitalDatedata);
			console.log("lwtrkHhprsdata??????????:",lwtrkHhprsdata);
			console.log("hghrkHhprsdata??????????:",hghrkHhprsdata);
			console.log("bdheatdata??????????:",bdheatdata);
			
		//bar chart
		var barchartDom = $('.tempChart')[0];
	    var barchartChart = echarts.init(barchartDom);
	    var barchartOption;
	    
		const colors = ['#99CCFF', '#91CC75', '#EE6666'];
		barchartOption = {
		  color: colors,
		  tooltip: {
		    trigger: 'axis',
		    axisPointer: {
		      type: 'cross'
		    }
		  },
		  grid: {
			  left: '20%',
		    right: '5%'
		  },
		  toolbox: {
		    feature: {
		      dataView: { show: true, readOnly: false },
		      saveAsImage: { show: true }
		    }
		  },
		  legend: {
		    data: ['체온']
		  },
		  xAxis: [
		    {
		      type: 'category',
		      axisTick: {
		        alignWithLabel: true
		      },
		      data: vitalDatedata
		    }
		  ],
		  yAxis: [
		    {
		      type: 'value',
		      position: 'right',
		      alignTicks: true,
		      axisLine: {
		        show: true,
		        lineStyle: {
		          color: colors[0]
		        }
		      },
		     axisLabel: {
		        formatter: '{value} °C'
		        }
		    },
		    {
		      type: 'value',
		      name: '좌표',
		      position: 'right',
		      alignTicks: true,
		      axisLine: {
		        show: true,
		        lineStyle: {
		          color: colors[1]
		        }
		      },
		      axisLabel: {
		        formatter: '{value} °C'
		      }
		    },
		    {
		      type: 'value',
		      name: '기온',
		      position: 'left',
		      alignTicks: true,
		      axisLine: {
		        show: true,
		        lineStyle: {
		          color: colors[2]
		        }
		      },
		      axisLabel: {
		        formatter: '{value} °C'
		      }
		    }
		  ],
		  series: [
		    {
		      name: '체온',
		      type: 'bar',
		      yAxisIndex: 2,
		      data: bdheatdata
		    }
		  ]
		};
		barchartOption && barchartChart.setOption(barchartOption);
		//---------------------------------------------------------------	
		//line chart
		    var linechartDom = $('.pressChart')[0];
		    var linechartChart = echarts.init(linechartDom);
		    var linechartOption;
		
		    linechartOption = {
					  tooltip: {
					    trigger: 'axis'
					  },
					  legend: {
					    data: ['최저혈압', '최고혈압']
					  },
					  grid: {
					    left: '3%',
					    right: '10%',
					    bottom: '3%',
					    containLabel: true
					  },
					  toolbox: {
					    feature: {
					      saveAsImage: {}
					    }
					  },
					  xAxis: {
					    type: 'category',
					    boundaryGap: false,
					    data: vitalDatedata
					  },
					  yAxis: {
					    type: 'value'
					  },
					  series: [
					    {
					      name: '최저혈압',
					      color: '#f7e600',
					      type: 'line',
					      stack: 'Total',
					      data: lwtrkHhprsdata
					    },
					    {
					      name: '최고혈압',
					      color: 'red',
					      type: 'line',
					      stack: 'Total',
					      data: hghrkHhprsdata
					    }
					  ]
					};
		    linechartOption && linechartChart.setOption(linechartOption);
		    },
			error: function (err) {
				console.log("바이탈 차트 >>err에러 : " + err);
			}
		});
	} 
/* --------------------chart 끝----------------------- */
</script>