<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page import="java.util.Date"%>
<!-- Include the Material Ui theme -->
<c:set var="customUser"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PatientList</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style type="text/css">
/* 오른쪽 현황 차트 css */
.container {
	display: flex;
	gap: 10px;
	max-width: 1300px;
	margin: 0 auto;
	cursor: pointer;
}

.table thead {
	position: sticky;
	top: 0;
	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}

.column {
	flex-basis: 20%;
	background-color: white;
	min-height: 33svh;
	padding: 5px;
	border-radius: 10px;
	margin-top: 20px;
	box-shadow: 3px 3px 3px 3px rgba(128, 128, 128, 0.5);
	position: relative;
}

.column::before {
	content: "";
	background-color: midnightblue;
	height: 10px;
	width: 100%;
	border-radius: 10px 10px 0 0;
	display: block;
	position: absolute;
	top: 0;
	left: 0;
}

.column h1 {
	text-align: center;
	font-size: 18px;
	margin-top: 15px;
	font-weight: bold;
}

.no-gap {
	padding-left: 5px;
	padding-right: 5px;
}

.scrollbar::-webkit-scrollbar {
	display: none;
}

.custom-width-element {
	width: 350px;
}
/* 오른쪽 현황 차트 css */

/* 프린트 출력 (pdf 저장)*/
@media print {
	#patientToday {
		display: none !important;
	}
	header * {
		display: none !important;
	}
	#printArea2 {
		display: block !important;
	}
	@page {
		margin: 0
	}
}

/* 왼쪽 기본 css 시작  */
#patientTable th, #patientTable td {
	padding: 8px; /* 열 간격을 조절합니다. */
	font-size: 16px; /* 글꼴 크기를 조절합니다. */
}
/* 왼쪽 기본 css 끝  */

/* 진단서 css 시작  */
.cdTable {
	table-layout: fixed;
	margin-top: 0pt;
	margin-bottom: 0pt
}

.inline-block {
	display: inline-block;
}

.cdTd1 {
	width: 180px;
	table-layout: fixed;
}

.cdTd2 {
	width: 180px
}
/* 진단서 css 끝  */

/* 진료확인서 css 시작  */
.mtcTable {
	table-layout: fixed;
	margin-top: 0pt;
	margin-bottom: 0pt;
	width: 740px;
}

.mtcFont {
	font-family: 굴림체;
	color: black;
}

.textCenter {
	text-align: center;
}

.vaMiddle {
	vertical-align: middle
}

.inline-block {
	display: inline-block;
}

td {
	height: 40px; /* 원하는 픽셀 단위의 높이 설정 */
}

/* 진료확인서 css 끝  */

/* 처방전 css 끝  */
.a3 {
	margin: 0pt 0pt 0pt 13.2pt;
	text-indent: -13.2pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: normal;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\31 {
	margin: 0pt 0pt 0pt 7.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\32 {
	margin: 0pt 0pt 0pt 17.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\33 {
	margin: 0pt 0pt 0pt 27.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\34 {
	margin: 0pt 0pt 0pt 37.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\35 {
	margin: 0pt 0pt 0pt 47.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\36 {
	margin: 0pt 0pt 0pt 57.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.\37 {
	margin: 0pt 0pt 0pt 67.4pt;
	text-indent: -7.4pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a4 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY중고딕;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a2 {
	margin: 0pt 10pt 0pt 0pt;
	text-indent: 0pt;
	text-align: right;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: normal;
	widows: 0;
	orphans: 0;
	font-family: HY중고딕;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a0 {
	margin: 4.2pt 17.5pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 107%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: -0.25pt;
	vertical-align: 0pt;
	color: #000000
}

.a9 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 11pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a6 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY중고딕;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a8 {
	margin: 20pt 0pt 45pt;
	text-indent: 0pt;
	text-align: center;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 120%;
	widows: 0;
	orphans: 0;
	font-family: '양재 튼튼B';
	font-size: 20pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: -0.5pt;
	vertical-align: 0pt;
	color: #000000
}

.a1 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY견고딕;
	font-size: 10pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a7 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY신명조;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

.a5 {
	margin: 0pt;
	text-indent: 0pt;
	text-align: justify;
	page-break-before: auto;
	page-break-inside: auto;
	page-break-after: auto;
	line-height: 104%;
	widows: 0;
	orphans: 0;
	font-family: HY중고딕;
	font-size: 9pt;
	font-weight: normal;
	font-style: normal;
	letter-spacing: 0pt;
	vertical-align: 0pt;
	color: #000000
}

span.EndnoteReference {
	vertical-align: super
}

span.FootnoteReference {
	vertical-align: super
}

span.Hyperlink {
	text-decoration: underline;
	color: #0000ff
}
/* 처방전 css 끝  */
</style>

</head>
<!-- Sheet JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver savaAs 이용 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 오늘의 현황 드래그 앤 드롭 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"
	integrity="sha512-zYXldzJsDrNKV+odAwFYiDXV2Cy37cwizT+NkuiPGsa9X1dOz04eHvUWVuxaJ299GvcJT31ug2zO4itXBjFx4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 오늘의 현황 시계 css -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/nurse/clock.css"
	rel="stylesheet">
</head>
<body>
	<!-- ================================= 환자 조회  시작 =================================================-->
	<div class="row" id="patientToday">
		<div class="col-4">
			<div class="card border border-secondary m-0" style="height: 820px;">
				<div class="row">
					<div class="col">
						<div class="card-header p-2" style="background-color: midnightblue;">
							<div class="row flex-between-center">
								<div class="col-6 col-sm-auto d-flex align-items-center pe-0">
									<h5
										class="py-2 py-xl-0 text-white fw-semi-bold">환자목록
									</h5>
								</div>
								<div class="col-6 col-sm-auto ms-auto text-end ps-0">
									<div class="table-simple-pagination-replace-element">
										<button class="btn btn-falcon-default btn-sm mx-1"
											type="button">
											<span class="fas fa-plus" data-fa-transform="shrink-3 down-2"></span>
											<span class="d-none d-sm-inline-block ms-1"
												data-bs-toggle="modal" data-bs-target="#newPatient-modal"
												id="newPatientBtn">신규환자등록</span>
										</button>
										<div class="btn-group">
											<button
												class="btn btn-falcon-default btn-sm mx-1 dropdown-toggle"
												type="button" data-bs-toggle="dropdown"
												data-display="static" aria-haspopup="true"
												aria-expanded="false">
												<span class="fas fa-filter"
													data-fa-transform="shrink-3 down-2"></span> <span
													class="d-none d-sm-inline-block ms-1">필터</span>
											</button>
											<div class="dropdown-menu py-0">
												<div class="card shadow-none border-0" style="width: 10rem;">
													<div class="card-body">
														<div
															class="row text-start justify-content-between align-items-center mb-2">
															<div class="col-auto">
																<p class="mb-0" style="font-size: 1rem">필터</p>
															</div>
														</div>
														<div class="position-relative">
															<hr />
														</div>
														<div class="row flex-between-center">
															<div class="col-auto">
																<div class="form-check mb-0">
																	<input class="form-check-input" type="checkbox"
																		id="checkAll" checked="checked" /> <label
																		class="form-check-label mb-0" for="basic-checkbox">전체</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntHsptlzAtY" value="filter1" name="checkFilter"
																		type="checkbox" checked="checked" /> <label
																		class="form-check-label mb-0" for="basic-checkbox">입원</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntHsptlzAtN" value="filter2" name="checkFilter"
																		type="checkbox" checked="checked" /> <label
																		class="form-check-label mb-0" for="basic-checkbox">외래</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntSexdstnM" value="filter3" name="checkFilter"
																		type="checkbox" checked="checked" /> <label
																		class="form-check-label mb-0" for="basic-checkbox">남자</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntSexdstnF" value="filter4" name="checkFilter"
																		type="checkbox" checked="checked" /> <label
																		class="form-check-label mb-0" for="basic-checkbox">여자</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntHlthinsAtY" value="filter5"
																		name="checkFilter" type="checkbox" checked="checked" />
																	<label class="form-check-label mb-0"
																		for="basic-checkbox">보험 유</label>
																</div>
																<div class="form-check mb-0">
																	<input class="form-check-input filter-check"
																		id="patntHlthinsAtN" value="filter6"
																		name="checkFilter" type="checkbox" checked="checked" />
																	<label class="form-check-label mb-0"
																		for="basic-checkbox">보험 무</label>
																</div>
															</div>
														</div>
														<div class="position-relative mt-4">
															<hr style="margin: 0;" />
														</div>
														<div style="display: flex; justify-content: flex-end;">
															<button class="btn btn-primary btn-sm d-block mt-3"
																id="checkFilterBtn" type="submit" name="submit">적용</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<button class="btn btn-falcon-default btn-sm mx-1"
											type="button">
											<span class="fas fa-external-link-alt"
												data-fa-transform="shrink-3 down-2"></span> <span
												class="d-none d-sm-inline-block ms-1">execel저장</span>
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="card-body">
							<form class="col-6 col-sm-auto d-flex align-items-center pe-0"
								method="post" id="searchForm">
								<input type="hidden" name="page" id="page" />
								<div class="col-6 col-sm-auto d-flex align-items-center pe-0">
									<select class="form-select" aria-label="Default select example"
										name="searchType">
										<option value="patntnm"
											<c:if test="${searchType eq 'patntnm' }">selected</c:if>>환자명</option>
										<option value="patntno"
											<c:if test="${searchType eq 'patntno' }">selected</c:if>>환자번호</option>
									</select>
								</div>
								<div
									class="col-5 col-sm-auto d-flex align-items-center pe-0 search-Box">
									<div class="input-group ">
										<input type="text" name="searchWord" id="searchWord2"
											value="${searchTypePatient}" aria-label="Search"
											class="form-control" placeholder="환자명을 입력해 주세요."
											style="height: 35px; width: 250px;">
										<button id="searchBtn" type="button"
											class="btn btn-outline-secondary" style="height: 35px">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
								<sec:csrfInput />
							</form>

							<div class="card-body px-0 pt-4 pb-0">
								<table id="patientTable"
									class="table mb-0 overflow-hidden data-table fs--4"
									data-datatables='{"responsive":false,"pagingType":"simple","lengthChange":false,"searching":false,"pageLength":8,"language":{"info":"_START_ to _END_ Items of _TOTAL_"}}'>
									<thead class="bg-200">
										<tr>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">환자번호</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">환자명</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">보험</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">입원</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">성별</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">만
												나이</th>
											<th
												class="text-900 sort pe-1 align-middle white-space-nowrap text-center">환자기록</th>
										</tr>
									</thead>
									<tbody class="list" id="table-simple-pagination-body">
										<c:set value="${pagingVO.dataList }" var="patientList" />
										<c:choose>
											<c:when test="${empty patientList }">
												<tr>
													<td colspan="17" align="center">환자정보가 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${patientList }" var="patient">
													<tr class="btn-reveal-trigger">
														<td
															class="align-middle white-space-nowrap fw-semi-bold text-center no">${patient.patntNo }</td>
														<td
															class="align-middle white-space-nowrap fw-semi-bold text-center">${patient.patntNm }</td>
														<c:choose>
															<c:when test="${patient.patntHlthinsAt eq 'Y'}">
																<td class="align-middle white-space-nowrap text-center">유</td>
															</c:when>
															<c:otherwise>
																<td class="align-middle white-space-nowrap text-center">무</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${patient.patntHsptlzAt eq 'Y'}">
																<td class="align-middle white-space-nowrap text-center">유</td>
															</c:when>
															<c:otherwise>
																<td class="align-middle white-space-nowrap text-center">무</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${patient.patntSexdstn eq 'M'}">
																<td class="align-middle white-space-nowrap text-center">남</td>
															</c:when>
															<c:otherwise>
																<td class="align-middle white-space-nowrap text-center">여</td>
															</c:otherwise>
														</c:choose>
														<td class="align-middle white-space-nowrap text-center">${patient.patntAge }
															세</td>
														<td class="align-middle white-space-nowrap text-center">
															<div
																class="dropstart font-sans-serif position-static d-inline-block">
																<button
																	class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal float-end"
																	type="button"
																	id="dropdown-simple-pagination-table-item-13"
																	data-bs-toggle="dropdown" data-boundary="window"
																	aria-haspopup="true" aria-expanded="false"
																	data-bs-reference="parent">
																	<span class="fas fa-ellipsis-h fs--1"></span>
																</button>
																<div class="dropdown-menu dropdown-menu-end border py-2"
																	aria-labelledby="dropdown-simple-pagination-table-item-13">
																	<button class="dropdown-item detailPatientBtn"
																		data-bs-toggle="modal"
																		data-bs-target="#newPatient-modal"
																		data-patient-id="${patient.patntNo}">상세정보</button>
																	<div class="dropdown-divider"></div>
																	<button class="dropdown-item patientModal" 
																		data-bs-toggle="modal" data-bs-target="#patntClnicModal" 
																		id="${patient.patntNo }"
																		data-patient-id1="${patient.patntNo}">진료기록</button>
																</div>
															</div>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<div
								class="card-footer clearfix col-auto align-self-center pagingArea"
								style="margin-left: 200px;" id="pagingArea">
								${pagingVO.pagingHTML }</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- ================================= 환자 조회 끝 =================================================-->




		<!-- ===================================== 메디폼 오늘의 현황 시작 =========================================-->

		<div class="col-8 no-gap">
			<div class="card border border-secondary" style="height: 820px;">
				<div class="card-header border-bottom p-2"
					style="height: 45px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">
							오늘의 현황</h5>
					</div>
				</div>

				<c:set value="${waitingList }" var="waitingList" />

				<div class="container">
					<div class="custom-width-element ">
						<!-- ==========================1 진료실 담당의사 허준============================================================ -->
						<div class="column ">
							<h1>1 진료실</h1>
							<h6 class="text-center">담당의사 : 허준</h6>
							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">



											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptClnc == 'd1' }">


														<c:if test="${waiting.rceptSttus == '1' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-info">진료중</span>
																</td>
															</tr>
														</c:if>
														<c:if test="${waiting.rceptSttus == '0' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-warning">진료대기</span>
																</td>
															</tr>
														</c:if>


													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
						<!-- ===================================1 진료실 담당의사 허준 끝============================================================ -->


						<!-- ===================================2 진료실 담당의사  우태원 시작============================================================ -->
						<div class="column">
							<h1>2 진료실</h1>
							<h6 class="text-center">담당의사 : 우태원</h6>


							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">



											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptClnc == 'd2' }">
														<c:if test="${waiting.rceptSttus == '1' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-info">진료중</span>
																</td>
															</tr>
														</c:if>
														<c:if test="${waiting.rceptSttus == '0' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-warning">진료대기</span>
																</td>
															</tr>
														</c:if>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>

									</tbody>
								</table>
							</div>
						</div>
					</div>


					<!-- =====================================3 진료실 담당의사 남민주 시작============================================================ -->
					<div class="custom-width-element">
						<div class="column">
							<h1>3 진료실</h1>
							<h6 class="text-center">담당의사 : 남민주</h6>

							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">



											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptClnc == 'd3' }">
														<c:if test="${waiting.rceptSttus == '1' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-info">진료중</span>
																</td>
															</tr>
														</c:if>
														<c:if test="${waiting.rceptSttus == '0' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-warning">진료대기</span>
																</td>
															</tr>
														</c:if>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>

									</tbody>
								</table>
							</div>
						</div>
						<!-- =====================================3 진료실 담당의사 남민주 끝============================================================ -->



						<!-- =====================================4 진료실 담당의사 장기려 시작============================================================ -->
						<div class="column">
							<h1>4 진료실</h1>
							<h6 class="text-center">담당의사 : 장기려</h6>

							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">



											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptClnc == 'd4' }">
														<c:if test="${waiting.rceptSttus == '1' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-info">진료중</span>
																</td>
															</tr>
														</c:if>
														<c:if test="${waiting.rceptSttus == '0' }">
															<tr class="oneBoard" id="">
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntNm }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	${waiting.patntRrno1 }</td>
																<td class="text-center"
																	style="vertical-align: middle; font-size: 13px;">
																	<span class="badge rounded-pill badge-subtle-warning">진료대기</span>
																</td>
															</tr>
														</c:if>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- =====================================4 진료실 담당의사 장기려 끝============================================================ -->


					<!-- ====================================검사 및 오더실 시작============================================================ -->
					<div class="custom-width-element">
						<div class="column">
							<h1>검사 및 오더실</h1>
							<h6 class="text-center">담당간호사 : 박유빈</h6>
							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">


											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptSttus == '3' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-warning">검사중</span></td>
														</tr>
													</c:if>
													<c:if test="${waiting.rceptSttus == '2' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-primary">검사대기</span></td>
														</tr>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>


						</div>
						<div class="column">
							<h1>치료실</h1>
							<h6 class="text-center">물리치료 / 작업치료</h6>


							<div class="table-container scrollbar"
								style="overflow-y: auto; max-height: 240px;">
								<table class="table table-sm table-striped"
									style="height: 180px;">
									<thead>
										<tr id="" class="bg-light">
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">환자명</th>
											<th class="col-4 text-center" scope="col"
												style="font-size: 13px;">생년월일</th>
											<th class="col-3 text-center" scope="col"
												style="font-size: 13px;">상태</th>
										</tr>
									</thead>
									<tbody style="overflow-y: auto; max-height: 180px;">

										<c:choose>
											<c:when test="">



											</c:when>
											<c:otherwise>
												<c:forEach items="${waitingList }" var="waiting"
													varStatus="loop">
													<c:if test="${waiting.rceptSttus == '6' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-success">물리치료중</span></td>
														</tr>
													</c:if>
													<c:if test="${waiting.rceptSttus == '8' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-success">작업치료중</span></td>
														</tr>
													</c:if>
													<c:if test="${waiting.rceptSttus == '5' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-warning">물리치료대기중</span></td>
														</tr>
													</c:if>
													<c:if test="${waiting.rceptSttus == '7' }">
														<tr class="oneBoard" id="">
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntNm }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;">
																${waiting.patntRrno1 }</td>
															<td class="text-center"
																style="vertical-align: middle; font-size: 13px;"><span
																class="badge rounded-pill badge-subtle-warning">작업치료대기중</span></td>
														</tr>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- ====================================검사 및 오더실 끝============================================================ -->


					<!-- ===================================실시간 환자 현황 시작 ===========================================================-->

					<div class="subCardBody custom-width-element">
						<div class="column">
							<h1>실시간 환자 현황</h1>
							<div class="card-body"
								style="padding-bottom: 20px; padding-top: 50px; padding-left: 37px;">
								<div style="">
									<div class="row g-0">
										<div
											class="col-6 col-md-4 border-200 border-bottom border-end pb-4">
											<h6 class="pb-1 text-">내원</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2"
												id="todayPatientCount"></p>
											<div class="d-flex align-items-center">
												<h6 class="fs--1 text-500 mb-0" id="yesterdayPatientCount"></h6>
												<h6 class="fs--2 ps-3 mb-0 " id="patientCountChange"></h6>
											</div>
										</div>
										<div
											class="col-6 col-md-4 border-200 border-bottom border-end-md pb-4 ps-3">
											<h6 class="pb-1 text-700">입원</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2"
												id="todayAdmissionCount"></p>
											<div class="d-flex align-items-center">
												<h6 class="fs--1 text-500 mb-0" id="yesterdayAdmissionCount"></h6>
												<h6 class="fs--2 ps-3 mb-0 " id="admissionCountChange">


												</h6>
											</div>
										</div>
										<div
											class="col-6 col-md-4 border-200 border-bottom border-end border-end-md-0 pb-4 pt-4 pt-md-0 ps-md-3">
											<h6 class="pb-1 text-700">퇴원</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2" id="dischargeCount"></p>
											<div class="d-flex align-items-center">
												<h6 class="fs--1 text-500 mb-0"></h6>
												<h6 class="fs--2 ps-3 mb-0 "></h6>
											</div>
										</div>
										<div
											class="col-6 col-md-4 border-200 border-bottom border-bottom-md-0 border-end-md pt-4 pb-md-0 ps-3 ps-md-0">
											<h6 class="pb-1 text-700">진료 대기</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2"
												id="clinicWaitCount"></p>
										</div>
										<div
											class="col-6 col-md-4 border-200 border-bottom-md-0 border-end pt-4 pb-md-0 ps-md-3">
											<h6 class="pb-1 text-700">진료</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2" id="clinicCount"></p>
										</div>
										<div class="col-6 col-md-4 pb-0 pt-4 ps-3">
											<h6 class="pb-1 text-700">치료</h6>
											<p class="font-sans-serif lh-1 mb-1 fs-2" id="treatmentCount"></p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- ===================================실시간 환자 현황 끝 ===========================================================-->


						<!-- ===================================시간시간시계시계 ===========================================================-->

						<div class="column">
							<div class="clock-container">
								<div class="clock" style="margin-top: 20px;">
									<div class="needle hour"></div>
									<div class="needle minute"></div>
									<div class="needle second"></div>
									<div class="center-point"></div>
								</div>

								<div class="time"></div>
								<div class="date"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- =================================메디폼 오늘의 현황 끝===================================================== -->


	<!-- ================================= 환자 기록 modal 시작 =================================================-->
	<div class="modal fade" id="patntClnicModal" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document" id="clnicModal">
			<div class="modal-content border-0" style="width: 1000px;">
				<div class="kanban-column-header"
					style="background-color: midnightblue; padding-top: 10px;">
					<h5 class="fs-0 mb-0 text-white">
						환자 진료 기록<span class="text-500" id="modalCount"></span>
					</h5>
				</div>
				<table class="table mb-0 data-table fs--1 " id="">
					<thead class="bg-200">
						<tr>
							<th class="text-800 text-center sort" noWrap>진료번호</th>
							<th class="text-800 text-center sort" noWrap>담당의</th>
							<th class="text-800 text-center sort" noWrap>진료일</th>
							<th class="text-800 text-center sort" noWrap>진단내역</th>
							<th class="text-800 text-center sort" noWrap>입원여부</th>
							<th class="text-800 text-center sort" noWrap>발병일</th>
							<th class="text-800 text-center sort" noWrap>메모사항</th>
							<th class="text-800 text-center sort" noWrap>진단서</th>
							<th class="text-800 text-center sort" noWrap>진료확인서</th>
							<th class="text-800 text-center sort" noWrap >처방전</th>
						</tr>
					</thead>
					<tbody class="list" style="width: 250pt;" id="patntClnicTable">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- ================================= 환자 기록 modal 끝 =================================================-->

	<!-- ================================= 신규 환자 등록 modal 시작 =================================================-->
	<div class="modal fade" id="newPatient-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg mt-6" role="document">
			<div class="modal-content border-0">
				<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
					<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-0">
					<div class="rounded-top-3 py-3 ps-4 pe-6"
						style="background-color: midnightblue;">
						<h4 class="mb-1 text-white" id="textPatientTitle">신규 환자 등록</h4>
					</div>
					<div class="p-4">
						<form action="/mediform/nurse/patient/insert" method="post"
							class="row g-3" id="insertForm">
							
							<div class="col-md-12 mt-0">
								<button class="btn btn-outline-info btn-sm"  style="float: right; width: 90px; color: midnightblue; display: none;" type="button" id="setingBtn">자동완성</button>
							 </div>
							
							
							<div class="col-md-12 pNo" style="display: none; margin-top: 0px;">
								<label class="form-label" for="patntNm">환자번호</label> <input
									class="form-control" id="patntNo" name="patntNo"
									value="${patient.patntNo }" readonly="readonly" />
								<p>
									<font id="pNo" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-6" style="margin-top: 0px;">
								<label class="form-label" for="patntNm">환자명</label> <input
									class="form-control" id="patntNm" name="patntNm" type="text"
									placeholder="환자명" />
								<p>
									<font id="pNm" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-6" style="margin-top: 0px;">
								<label class="form-label" for="patntTelno">환자 연락처</label> 
								<input class="form-control" id="patntTelno" name="patntTelno"
									type="text" placeholder="환자연락처" />
								<p>
									<font id="pTelno" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-8">
								<label class="form-label" for="patntRrno">주민등록번호</label>
								<button class="btn btn-sm btn-falcon-default" type="button"
									id="calAgeBtn" style="padding: revert;">만 나이 적용</button>
								<div class="input-group">
									<input class="form-control" id="patntRrno1" name="patntRrno1"
										type="text" placeholder="앞 6자리" />&nbsp;&nbsp; - &nbsp;&nbsp;
									<input class="form-control" id="patntRrno2" name="patntRrno2"
										type="text" placeholder="뒤 7자리" />
								</div>
								<p>
									<font id="pRrno1" color="red" class="text-danger"></font>
								</p>
								<p>
									<font id="pRrno2" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-4">
								<label class="form-label" for="patntAge">만 나이</label> <input
									class="form-control" id="patntAge" name="patntAge" type="text"
									placeholder="만 나이" readonly="readonly" />
								<p>
									<font id="pAge" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-mb-2">
								<div class="col-sm-12">
									<div class="form-check-inline">
										<input class="form-check-input" id="M" type="radio"
											name="patntSexdstn" value="M" readonly="readonly" checked />
										<label class="form-check-label mb-0" for="M">남성</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input" id="F" type="radio"
											name="patntSexdstn" value="F" readonly="readonly" /> <label
											class="form-check-label mb-0" for="F">여성</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input" id="patntHlthinsAt"
											type="checkbox" checked="checked" value="Y" /> <input
											type="hidden" name="patntHlthinsAt" id="patntHlthinsAtHidden"
											value="" /> <label class="form-check-label"
											for="patntHlthinsAt">건강보험 유</label>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<label class="form-label" for="patntHeight">신장(cm)</label> <input
									class="form-control" id="patntHeight" name="patntHeight"
									type="text" placeholder="신장" />
							</div>
							<div class="col-md-4">
								<label class="form-label" for="patntBdwgh">몸무게(kg)</label> <input
									class="form-control" id="patntBdwgh" name="patntBdwgh"
									type="text" placeholder="몸무게" />
							</div>
							<div class="col-md-4">
								<label class="form-label" for="patntBdp">혈액형(ABO)</label> <select
									class="form-select" id="patntBdp" name="patntBdp">
									<option selected="selected" value="A">A</option>
									<option value="B">B</option>
									<option value="AB">AB</option>
									<option value="O">O</option>
									<option value="기타">기타</option>
								</select>
							</div>
							<div class="col-sm-12">
								<label class="form-label" for="patntZip">우편번호</label>
								<div class="input-group">
									<input class="form-control" id="patntZip" name="patntZip"
										type="text" placeholder="우편번호" />
									<button type="button" onclick="DaumPostcode()"
										class="btn btn-secondary btn-flat">우편번호 찾기</button>
								</div>
								<p>
									<font id="pZip" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-sm-12">
								<label class="form-label" for="patntAdres">주소</label> <input
									class="form-control" id="patntAdres1" name="patntAdres1"
									type="text" placeholder="주소" />
								<p>
									<font id="pAdres1" color="red" class="text-danger"></font>
								</p>
								<input class="form-control" id="patntAdres2" name="patntAdres2"
									type="text" placeholder="상세주소" />
								<p>
									<font id="pAdres2" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-6">
								<label class="form-label" for="prtctorNm">보호자 성명</label> <input
									class="form-control" id="prtctorNm" name="prtctorNm"
									type="text" placeholder="보호자 성명" />
							</div>
							<div class="col-md-6">
								<label class="form-label" for="prtctorTelno">보호자 연락처</label> <input
									class="form-control" id="prtctorTelno" name="prtctorTelno"
									type="text" placeholder="보호자 연락처" />
							</div>
							<div class="col-md-12">
								<label class="form-label" for="patntMemo">메모사항</label>
								<textarea class="form-control" id="patntMemo" name="patntMemo"
									rows="3" placeholder="메모사항"></textarea>
							</div>
							<div align="right" class="form-check-inline patntAgre">
								<input class="form-check-input" id="patntAgre" name="patntAgre"
									type="checkbox" checked="checked" value="Y" /> <label
									class="form-check-label" for="patntAgre">개인 정보 제공 동의</label>
								<p>
									<font id="pAgre" color="red" class="text-danger"></font>
								</p>
							</div>
							<div class="col-md-12">
								<div align="right">
									<button class="btn btn-outline-secondary" type="reset" id="resetBtn">초기화</button>
									<button class="btn btn-primary" id="insertBtn"
										style="background-color: midnightblue; border: none;">저장</button>
								</div>
							</div>
							<sec:csrfInput />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 신규 환자 등록 modal 끝 =================================================-->
	<!-- ================================= 진단서 모달 시작 =================================================-->
	<div class="modal fade" id="diagnosisModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document"
			style="max-width: 800px">
			<div class="modal-content position-relative">
				<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
					<button class="btn-close me-n1" type="button" data-bs-theme="light"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-0">
					<div class="rounded-top-2 py-2 ps-3 pe-6"
						style="background-color: midnightblue;">
						<h4 class="mb-0 text-white" id="modalExampleDemoLabel">진료 확인서</h4>
					</div>
					<div id="printArea" class="pdfArea" class="p-4 pb-0">
						<div
							style="margin-top: 30px; margin-right: 30px; margin-left: 30px;">



						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="printBtn" type="button" style="background-color: midnightblue; border: none;"
						onclick="return window.print()">출력</button>
					<button class="btn btn-secondary" type="button"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 진단서 모달 끝 =================================================-->

	<!-- ================================= 진료 확인서 모달 시작 =================================================-->
	<div class="modal fade" id="mtcModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document"
			style="max-width: 800px">
			<div class="modal-content position-relative">
				<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
					<button class="btn-close me-n1" type="button" data-bs-theme="light"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-0">
					<div class="rounded-top-2 py-2 ps-3 pe-6"
						style="background-color: midnightblue;">
						<h4 class="mb-0 text-white" id="modalExampleDemoLabel">진료 확인서</h4>
					</div>
					<div id="printArea1" class="pdfArea1" class="p-4 pb-0">
						<div
							style="margin-top: 30px; margin-right: 30px; margin-left: 30px;">

							<table
								style="width: 740px; border: 1.5pt solid #000000; border-collapse: collapse">
								<tr style="height: 80.6pt">
									<td rowspan="4">
										<p class="textCenter"
											style="font-size: 18pt; margin-bottom: 0px;">
											<strong><span class="mtcFont mtcTitle">진료 확인서</span></strong>
										</p>
									</td>
								</tr>
							</table>
							<p>
								<span style="font-family: Wingdings;"></span> <span
									style="color: black;">번 &#xa0; 호 :</span>
								<!-- 제증명 번호 0.mtcInsert -->
								<span class="mtc" style="color: black;" id="patntNoCl"></span>
							</p>
							<table class="mtcTable" style="border-collapse: collapse">
								<tr style="height: 41.5pt">
									<td colspan="1"
										style="border-top: 1.5pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.5pt solid #000000;">
										<p class="textCenter mtcFont">성&#xa0; 명</p>
									</td>
									<td colspan="2"
										style="border-top: 1.5pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<!-- 0. 환자 이름 .mtcVal -->
										<p class="textCenter mtcFont mtcVal" id="patntNmCl"></p>
									</td>
									<td
										style="border-top: 1.5pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">성&#xa0; 별</p>
									</td>
									<td
										style="width: 80.75pt; border-top: 1.5pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<!-- 1. 환자 성별 .mtcVal-->
										<p class="textCenter mtcFont mtcVal" id="patntSexdstnCl">
										</p>
									</td>
									<td
										style="width: 43.8pt; border-top: 1.5pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<p class="mtcFont textCenter">연&#xa0; 령</p>
									</td>
									<td
										style="width: 80.55pt; border-top: 1.5pt solid #000000; border-right: 1.5pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-left: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">
											<span>만</span>
											<!-- 2. 환자 나이(만) .mtcVal -->
											<span class="mtcVal" id="patntAgeCl">&#xa0;&#xa0;&#xa0;</span>
											<span>세</span>
										</p>
									</td>
								</tr>
								<tr style="height: 38.65pt">
									<td
										style="border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.5pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">주&#xa0; 소</p>
									</td>
									<td colspan="3"
										style="border: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">
											<!-- 3. 환자 주소1 / 4. 우편번호 / 5. 상세주소 .mtcVal -->
											<span class="mtcVal" id="patntAdres1Cl"></span>(<span
												class="mtcVal" id="patntZipCl">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</span>)
											<span class="mtcVal" id="patntAdres2Cl"></span>
										</p>
									</td>
									<td
										style="border: 0.75pt solid #000000; padding-right: 0.22pt; padding-left: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">주민등록번호</p>
									</td>
									<td colspan="2"
										style="border-top: 0.75pt solid #000000; border-right: 1.5pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-left: 0.22pt; vertical-align: middle">
										<!-- 6. 환자 주민등록번호 .mtcVal-->
										<p class="textCenter mtcFont" id="patntRrnoCl"></p>
									</td>
								</tr>
								<tr style="height: 106.8pt">
									<td colspan="2"
										style="width: 108.75pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.5pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">상병부위 및</p>
										<p class="textCenter mtcFont">상 병 명</p>
									</td>
									<td colspan="5"
										style="width: 336.05pt; border-top: 0.75pt solid #000000; border-right: 1.5pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-left: 0.22pt; vertical-align: middle">

										<!-- 7. 환부 코드 .mtcVal-->
										<div class="inline-block mtcVal mtcFont"
											style="margin-left: 10px;">
											<p class="textCenter" id="sckwndKrCl"></p>
										</div> <!-- 8. 상병명 .mtcVal-->
										<div class="inline-block mtcVal mtcFont"></div>
									</td>
								</tr>
								<tr style="height: 50pt">
									<td colspan="2"
										style="width: 108.75pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.5pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">입원일</p>
									</td>
									<td colspan="2"
										style="width: 336.05pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-left: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">
											<!-- 9. 입원일 .mtcVal -->
											<span class="mtcVal" id="hsptlzDeCl">&#xa0;&#xa0;&#xa0;&#xa0;년
												&#xa0;&#xa0;월 &#xa0;&#xa0;일</span><span>부터</span>
										</p>
									</td>
									<td
										style="width: 54.75pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">
											<span>퇴원일</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 108.75pt; border-top: 0.75pt solid #000000; border-right: 1.5pt solid #000000; border-bottom: 0.75pt solid #000000; padding-right: 0.22pt; vertical-align: middle">
										<p class="textCenter mtcFont">
											<!-- 10. 퇴원일 .mtcVal -->
											<span class="mtcVal" id="realLhstlCl">&#xa0;&#xa0;&#xa0;&#xa0;년
												&#xa0;&#xa0;월 &#xa0;&#xa0;일</span>
										</p>
									</td>
								</tr>
								<tr style="height: 175pt">
									<td colspan="7"
										style="border-top: 0.75pt solid #000000; border-right: 1.5pt solid #000000; border-left: 1.5pt solid #000000; border-bottom: 0.75pt solid #000000; padding-left: 0.22pt; vertical-align: middle">
										<p class="mtcFont">
											<!-- 진료일 / 진료 내용 테이블 .mtcClinicTable-->
										<table class="mtcFont mtcClinicTable"
											style="margin-left: 10px;">
											<tr>
												<th class="textCenter mtcFont"
													style="background-color: #e5e5e5; margin-right: 10px; padding-right: 10px; border-right: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000;"
													width="138px">진료날짜</th>
												<th class="textCenter mtcFont"
													style="background-color: #e5e5e5; margin-left: 10px; padding-left: 10px; border-bottom: 0.75pt solid #000000;"
													width="566px">진료 내용</th>
											</tr>
											<tr>
												<td class="mtcFont"
													style="border-right: 0.75pt solid #000000;"
													id="clnicTimeCl"></td>
												<td class="mtcFont"
													style="border-right: 0.75pt solid #000000;" id="clnicCnCl"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height: 139.25pt">
									<td colspan="7"
										style="width: 446pt; border-top: 0.75pt solid #000000; border-right: 1.5pt solid #000000; border-left: 1.5pt solid #000000; border-bottom: 1.5pt solid #000000; vertical-align: middle">
										<p class="textCenter mtcFont"
											style="margin-right: 5pt; margin-left: 5pt;">
											<!-- 11. 발급일 .mtcVal 1.mtcInsert -->
											<span class="mtcVal" id="sysdateCl">&#xa0;&#xa0;&#xa0;&#xa0;년
												&#xa0;&#xa0;월 &#xa0;&#xa0;일</span>
										</p>
										<p class="" style="margin-right: 5pt; margin-left: 5pt">
											&#xa0;</p>
										<p class="mtcFont" style="margin-right: 5pt; margin-left: 5pt">
											<span>의료기관명 : 메디폼 재활전문 병원</span>
										</p>
										<p class="" style="margin-right: 5pt; margin-left: 5pt">
											&#xa0;</p>
										<p class="mtcFont" style="margin-right: 5pt; margin-left: 5pt">
											<span>담당의사 면허번호 제</span>
											<!-- 12. 전문의 면허번호 .mtcVal -->
											<span class="mtcVal" id="empDoctrLcnsNoCl">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</span>
											<span>호</span>
										</p>
										<p class="" style="margin-right: 5pt; margin-left: 5pt">
											&#xa0;</p>
										<p class="mtcFont"
											style="margin-right: 15pt; margin-left: 5pt; text-align: right">
											<span>의&#xa0; 사 : </span>
											<!-- 13. 담당의사 이름  .mtcVal-->
											<span class="mtcVal" id="empNmCl">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</span>
											<span>(인)</span>
										</p>
									</td>
								</tr>
								<tr style="height: 0pt">
									<td style="width: 54.95pt"></td>
									<td style="width: 55.15pt"></td>
									<td style="width: 75.05pt"></td>
									<td style="width: 53.5pt"></td>
									<td style="width: 81.95pt"></td>
									<td style="width: 45pt"></td>
									<td style="width: 81.9pt"></td>
								</tr>
							</table>
							<p class=""
								style="text-align: center; line-height: 123%; font-size: 1pt">
								&#xa0;</p>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="printBtn" type="button" style="background-color: midnightblue; border: none;"
						onclick="return window.print()">출력</button>
					<button class="btn btn-secondary" type="button"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 진료 확인서 모달 끝 =================================================-->

	<!-- ================================= 처방전 모달 시작 =================================================-->
	<div class="modal fade" id="prescriptionModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document"
			style="max-width: 800px">
			<div class="modal-content position-relative">
				<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
					<button class="btn-close me-n1" type="button" data-bs-theme="light"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-0">
					<div class="rounded-top-2 py-2 ps-3 pe-6"
						style="background-color: midnightblue;">
						<h4 class="mb-0 text-white" id="modalExampleDemoLabel">처방전</h4>
					</div>
					<div id="printArea2" class="pdfArea2" class="p-4 pb-0">
						<div
							style="margin-top: 30px; margin-right: 30px; margin-left: 70px;">

							<table style="border-collapse: collapse">
								<tr style="height: 59.6pt">
									<td colspan="20"
										style="width: 488.2pt; border-top: 1.12pt solid #000000; border-right: 1.12pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 18pt">
											<span class="a"
												style="font-size: 18pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">처</span><span
												class="a"
												style="font-size: 18pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="font-size: 18pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">방</span><span
												class="a"
												style="font-size: 18pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="font-size: 18pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">전</span>
										</p>
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">1</span><span
												class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">■</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">의료보험
												2</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">□</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">의료보호
												3</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">□</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">산재보험
												4</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">□</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">자동차보험
												5</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">□</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">기타(</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">)</span>
										</p>
									</td>
								</tr>
								<tr style="height: 34.2pt">
									<td colspan="6"
										style="width: 74.7pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">교부
												연월일</span>
										</p> <%
											 	Date now = new Date();
												java.text.SimpleDateFormat year = new java.text.SimpleDateFormat("yyyy");
												java.text.SimpleDateFormat month = new java.text.SimpleDateFormat("MM");
												java.text.SimpleDateFormat day = new java.text.SimpleDateFormat("dd");
												String yyyy = year.format(now);
												String mm = month.format(now);
												String dd = day.format(now);
											 %>
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">및
												번호</span>
										</p>
									</td>
									<td colspan="5"
										style="width: 149.55pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline"><%=yyyy%>
												년</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline"><%=mm%>
												월</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline"><%=dd%>
												일</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">-</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">제</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">10
												호</span>
										</p>
									</td>
									<td colspan="2" rowspan="4"
										style="width: 13.2pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">의료기관</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 81.4pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">명</span><span
												class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">칭</span>
										</p>
									</td>
									<td colspan="4" class="text-center"
										style="width: 158.05pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										메디폼 재활병원</td>
								</tr>
								<tr style="height: 16.65pt">
									<td rowspan="3"
										style="width: 13.2pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">환</span>
										</p>
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">자</span>
										</p>
									</td>
									<td colspan="5" rowspan="2"
										style="width: 58.65pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">성
												명</span>
										</p>
									</td>
									<td colspan="5" class="text-center" rowspan="2"
										style="width: 149.55pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<input type="text" id="patntNm3" name="patntNm3"
										disabled="disabled">
									</td>
									<td colspan="3"
										style="width: 81.4pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">전화번호</span>
										</p>
									</td>
									<td colspan="4" class="text-center"
										style="width: 158.05pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										82)042-222-8202</td>
								</tr>
								<tr style="height: 14.95pt">
									<td colspan="3"
										style="width: 81.4pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">팩스번호</span>
										</p>
									</td>
									<td colspan="4" class="text-center"
										style="width: 158.05pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										070-8768-2972</td>
								</tr>
								<tr style="height: 14.95pt">
									<td colspan="5"
										style="width: 58.65pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 10pt; letter-spacing: -0.75pt; vertical-align: baseline">주민등록번호</span>
										</p>
									</td>
									<td colspan="5" class="text-center"
										style="width: 149.55pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<input type="text" id="patntRrno13" name="patntRrno1"
										disabled="disabled">-<input type="password"
										id="patntRrno23" name="patntRrno2" disabled="disabled">
									</td>
									<td colspan="3"
										style="width: 81.4pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">e-mail주소</span>
										</p>
									</td>
									<td colspan="4" class="text-center"
										style="width: 158.05pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										mediform777@naver.com</td>
								</tr>
								<tr style="height: 28.6pt">
									<td colspan="3" rowspan="2"
										style="width: 23pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">질병</span>
										</p>
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">분류</span>
										</p>
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">기호</span>
										</p>
									</td>
									<td
										style="width: 11.45pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 11.4pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 20.35pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 3.8pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 11pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2" rowspan="2"
										style="width: 59.9pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">처</span><span
												class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">방</span>
										</p>
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">의료인의</span>
										</p>
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">성</span><span
												class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">명</span>
										</p>
									</td>
									<td colspan="7" rowspan="2"
										style="width: 167.6pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="7"
											style="margin-left: 0pt; text-indent: 0pt; text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">(서명
												또는 날인)</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 50.65pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">면허종별</span>
										</p>
									</td>
									<td class="text-center"
										style="width: 103.65pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										재활전문의</td>
								</tr>
								<tr style="height: 26pt">
									<td
										style="width: 11.45pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 11.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 20.35pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 3.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 11pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 50.65pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">면허번호</span>
										</p>
									</td>
									<td
										style="width: 103.65pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">제
											</span><input type="text" id="empDoctrLcnsNo3"
												name="empDoctrLcnsNo3" disabled="disabled"><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">
												호</span>
										</p>
									</td>
								</tr>
								<tr style="height: 18.3pt">
									<td colspan="20"
										style="width: 488.2pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt; vertical-align: middle">
										<p class="a"
											style="margin-left: 5pt; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">※</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">환자의
												요구가 있는 때에는 질병분류기호를 기재하지 아니합니다.</span>
										</p>
									</td>
								</tr>
								<tr style="height: 45.25pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">처방
												의약품의 명칭</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">1회
												투약량</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">1일</span>
										</p>
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">투여</span>
										</p>
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">횟수</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">총
											</span>
										</p>
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">투약일수</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">용</span><span
												class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">법</span>
										</p>
									</td>
								</tr>

								<!-- 처방 의약품 첫줄 -->

								<!-- 처방 의약품 반복구간 -->
								<tbody id="medcinTable">
									<!-- 약 반복 내용 -->
								</tbody>
								<tr style="height: 16.6pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 16.6pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 16.6pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 16.6pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>


								<!-- 주사제 처방내역 -->
								<tr style="height: 18.45pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt dotted #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조제시
												참고사항</span>
										</p>
									</td>
								</tr>
								<tr style="height: 18.45pt">
									<td colspan="18"
										style="width: 359pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="7"
											style="margin-left: 0pt; text-indent: 0pt; text-align: center; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">주사제
												처방내역(원내조제 </span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">■</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">,</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">원외처방
											</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">ㅁ</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: -0.25pt; vertical-align: baseline">)</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>

								<!-- 주사반복 구역 -->
								<tbody id="injectionmedcinTable">
									<!-- 주사반복 내용 -->
								</tbody>
								<tr style="height: 16.6pt">
									<td colspan="12"
										style="width: 228.4pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 48.7pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td
										style="width: 30.8pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 42.6pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt dotted #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="2"
										style="width: 126.4pt; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: top">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 18.45pt">
									<td colspan="4"
										style="width: 37.3pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: -0.4pt; vertical-align: baseline">사용기간</span>
										</p>
									</td>
									<td colspan="8"
										style="width: 188.3pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="margin-left: 5pt; line-height: normal; font-size: 11pt">
											<!-- 몇일 간인지? -->
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">교부일부터
												(</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">&#xa0;&#xa0;&#xa0;&#xa0;3&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;
											</span><span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">)일간</span>
										</p>
									</td>
									<td colspan="8"
										style="width: 256.95pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="margin-left: 5pt; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">사용기간내에
												약국에 제출하여야 합니다.</span>
										</p>
									</td>
								</tr>
								<tr style="height: 16.6pt">
									<td colspan="20"
										style="width: 488.2pt; border-top: 1.12pt solid #000000; border-right: 1.12pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt; vertical-align: middle">
										<p class="a"
											style="text-align: center; line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">의
												약 품</span><span class="a"
												style="line-height: 104%; font-size: 11pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">&#xa0;
											</span><span class="a"
												style="line-height: 104%; font-size: 11pt; font-weight: bold; letter-spacing: normal; vertical-align: baseline">조
												제 내 역</span>
										</p>
									</td>
								</tr>
								<tr style="height: 30.95pt">
									<td colspan="2" rowspan="4"
										style="width: 21.8pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 1.12pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 1.02pt 1.4pt 0.84pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조제
												내역</span>
										</p>
									</td>
									<td colspan="4"
										style="width: 50.05pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조제기관의
												명칭</span>
										</p>
									</td>
									<td colspan="9"
										style="width: 236pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span style="letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
									<td colspan="5"
										style="width: 171.8pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 0.75pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a"
											style="margin-left: 15pt; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">처방의
												변경</span><span class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">·</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">수정</span><span
												class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">·</span><span
												class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">확인</span><span
												class="a"
												style="font-family: 'Arial Unicode MS'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">·</span>
										</p>
										<p class="a"
											style="margin-left: 15pt; line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-size: 11pt; letter-spacing: normal; vertical-align: baseline">대체시
												그 내용 등</span>
										</p>
									</td>
								</tr>
								<tr style="height: 19.85pt">
									<td colspan="4"
										style="width: 50.05pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-family: 휴먼명조; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조제약사</span>
										</p>
									</td>
									<td colspan="3"
										style="width: 22.65pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal">
											<span class="a"
												style="font-family: 휴먼명조; letter-spacing: normal; vertical-align: baseline">성명</span>
										</p>
									</td>
									<td colspan="6"
										style="width: 210.55pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="text-align: center; line-height: normal">
											<span class="a"
												style="font-family: 'HCI Poppy'; letter-spacing: normal; vertical-align: baseline">(</span><span
												class="a"
												style="font-family: 휴먼명조; letter-spacing: normal; vertical-align: baseline">서명
												또는 날인</span><span class="a"
												style="font-family: 'HCI Poppy'; letter-spacing: normal; vertical-align: baseline">)</span>
										</p>
									</td>
									<td colspan="5" rowspan="3"
										style="width: 171.8pt; border-top: 0.75pt solid #000000; border-right: 1.12pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 0.84pt 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal">
											<span
												style="font-family: 'HCI Poppy'; letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 19.85pt">
									<td colspan="4"
										style="width: 50.05pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-family: 휴먼명조; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조
												제 량</span>
										</p>
										<p class="a" style="line-height: normal; font-size: 11pt">
											<span class="a"
												style="font-family: 'HCI Poppy'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">(</span><span
												class="a"
												style="font-family: 휴먼명조; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">조제일수</span><span
												class="a"
												style="font-family: 'HCI Poppy'; font-size: 11pt; letter-spacing: normal; vertical-align: baseline">)</span>
										</p>
									</td>
									<td colspan="9"
										style="width: 236pt; border: 0.75pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal">
											<span
												style="font-family: 'HCI Poppy'; letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 19.85pt">
									<td colspan="4"
										style="width: 50.05pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: 104%; font-size: 11pt">
											<span class="a"
												style="line-height: 104%; font-family: 휴먼명조; font-size: 11pt; letter-spacing: -0.45pt; vertical-align: baseline">조제연월일</span>
										</p>
									</td>
									<td colspan="9"
										style="width: 236pt; border-top: 0.75pt solid #000000; border-right: 0.75pt solid #000000; border-left: 0.75pt solid #000000; border-bottom: 1.12pt solid #000000; padding: 1.4pt 1.02pt; vertical-align: middle">
										<p class="a" style="line-height: normal">
											<span
												style="font-family: 'HCI Poppy'; letter-spacing: normal">&#xa0;</span>
										</p>
									</td>
								</tr>
								<tr style="height: 0pt">
									<td style="width: 16pt"></td>
									<td style="width: 8.6pt"></td>
									<td style="width: 1.2pt"></td>
									<td style="width: 14.3pt"></td>
									<td style="width: 14.2pt"></td>
									<td style="width: 23.2pt"></td>
									<td style="width: 6.6pt"></td>
									<td style="width: 13.8pt"></td>
									<td style="width: 5.05pt"></td>
									<td style="width: 57.65pt"></td>
									<td style="width: 69.25pt"></td>
									<td style="width: 1.35pt"></td>
									<td style="width: 14.65pt"></td>
									<td style="width: 36.85pt"></td>
									<td style="width: 33.6pt"></td>
									<td style="width: 13.75pt"></td>
									<td style="width: 0.95pt"></td>
									<td style="width: 30.8pt"></td>
									<td style="width: 22.65pt"></td>
									<td style="width: 106.55pt"></td>
								</tr>
							</table>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="printBtn" type="button" style="background-color: midnightblue; border: none;"
						onclick="return window.print()">출력</button>
					<button class="btn btn-secondary" type="button"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ================================= 처방전 모달 끝 =================================================-->






	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.7.2/bluebird.min.js"></script>
	<!-- jsPDF : PDF 파일을 생성하고 다운로드 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
	<!-- html2canvas : 웹 페이지의 DOM 요소를 캡처해 이미지로 만듦 -->
	<script
		src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/nurse/clock.js"></script>
	<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var setingBtn = $("#setingBtn");
setingBtn.on("click", function() {

	$("#patntNm").val("김대덕");
    $("#patntRrno1").val("960403");
	$("#patntRrno2").val("2408745");
    $("#patntTelno").val("01012345678");
    $("#patntZip").val("34908");
    $("#patntAdres1").val("대전광역시 중구 계룡로 846");
    $("#patntAdres2").val("4층 404호");
    //$("#patntAge").val("");
    //$("#patntSexdstn").val("");
    $("#prtctorNm").val("이인재");
    $("#prtctorTelno").val("01087654321");
    //$("#patntAgre").val();
    $("#patntHeight").val("160");
    $("#patntBdwgh").val("50");
    $("#patntBdp").val("O");
    //$("#patntHlthinsAt").val("");
    $("#patntMemo").val("일주일 전부터 무릎이 아파 다리를 잘 펴지 못하고, 일상생활에 어려움을 겪고 있음.");
    //$("#patntHsptlzAt").val("");
});

//시계
$(document).ready(function() {
	mediformAjax();
	setTimeoutFt();
	
	function setTimeoutFt(){
		setTimeout(() => {
			  mediformAjax();
			  setTimeoutFt();
			}, "3000");
		
	}
});
// console.log('1');

function mediformAjax(){
	
	$.ajax({
	    type: "post",
	    url: "/mediform/manager/patient/statistics/select",
	    contentType: "application/json; charset=utf-8",
	    beforeSend: function (xhr) {
	        xhr.setRequestHeader(header, token);
	    },
	    success: function (rst) {
// 	        console.log("ajax 성공");
// 	        console.log("rst : " + rst);

	        var patientCountChange = rst.todayPatientCount - rst.yesterdayPatientCount;
	        var admissionCountChange = rst.todayAdmissionCount - rst.yesterdayAdmissionCount;

	        // 텍스트 업데이트
	        $('#todayPatientCount').text(rst.todayPatientCount);
	        $('#yesterdayPatientCount').text(rst.yesterdayPatientCount);
	        $('#patientCountChange').text(patientCountChange);
	        $('#todayAdmissionCount').text(rst.todayAdmissionCount);
	        $('#yesterdayAdmissionCount').text(rst.yesterdayAdmissionCount);
	        $('#dischargeCount').text(rst.dischargeCount);
	        $('#clinicWaitCount').text(rst.clinicWaitCount);
	        $('#clinicCount').text(rst.clinicCount);
	        $('#treatmentCount').text(rst.treatmentCount);

	        // 입원 환자 비교 후 svg 뿌려주기
	        var admissionChangeHTML = '';
	        if (admissionCountChange > 0) {
	            // 양수인 경우
	            $('#admissionCountChange').addClass('text-danger');
	            admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16"><path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/></svg>';
		        $('#admissionCountChange').html(admissionChangeHTML + ' ' + admissionCountChange);
	        } else if (admissionCountChange < 0) {
	            // 음수인 경우
	            $('#admissionCountChange').addClass('text-primary');
	            admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>';
		        $('#admissionCountChange').html(admissionChangeHTML + ' ' + (-admissionCountChange));
	        } else {
	        	admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16"><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg>'
		        $('#admissionCountChange').html(admissionChangeHTML);
	        }
	        
	        // 내원 환자 비교 후 svg 뿌려주기
	        var patientCountChangeHTML = '';
	        if (patientCountChange > 0) {
	            // 양수인 경우
	            $('#patientCountChange').addClass('text-danger');
	            patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16"><path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/></svg>';
		        $('#patientCountChange').html(patientCountChangeHTML + ' ' + patientCountChange);
	        } else if (patientCountChange < 0) {
	            // 음수인 경우
	            $('#patientCountChange').addClass('text-primary');
	            patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>';
		        $('#patientCountChange').html(patientCountChangeHTML + ' ' + (-patientCountChange));
	        } else {
	        	patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16"><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg>'
		        $('#patientCountChange').html(patientCountChangeHTML);
	        }
	    }
	});


}

// 오늘의 현황 drag and drop!!!!!!
function s2ab(s) { 
  var buf = new ArrayBuffer(s.length); 
  var view = new Uint8Array(buf); 
  for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; 
  return buf;    
}

const containers = document.querySelectorAll(".container");

containers.forEach(container => {
  new Sortable(container, {
    group: "shared-containers",
    animation: 150,
    ghostClass: "blue-background-class"
  });
});


//-------------------------------환자 차트 script--------------------------------------------------
var searchBtn = $("#searchBtn");

searchBtn.on("click", function(){
	searchForm.submit();
});

var updateFlag = false;

$(function(){
	var newPatientBtn = $("#newPatientBtn");

	// 신규 환자 등록 Modal
	newPatientBtn.on("click",function(){
	
		$("#insertForm")[0].reset();
		$(".pNo").hide();
		$("#patntNo").val("");
		$("#textPatientTitle").html("신규 환자 등록");
		$(".patntAgre").css("display", "block");
		$("#setingBtn").show();
        $("#resetBtn").show();
        $("#insertBtn").html("저장");
        $("#insertForm").attr("action", "/mediform/nurse/patient/insert");		// 폼 경로 바꾸기 
        
		$('#newPatient-modal').modal("show");
	});
	
	var insertBtn = $("#insertBtn");
	$("#insertBtn").on("click", function() {
		var insertForm = $("#insertForm");
		var patntNm = $("#patntNm").val();
		var patntTelno = $("#patntTelno").val();
		var patntRrno1 = $("#patntRrno1").val();
		var patntRrno2 = $("#patntRrno2").val();
		var patntAge = $("#patntAge").val();
		var patntZip = $("#patntZip").val();
		var patntAdres1 = $("#patntAdres1").val();
		var patntAdres2 = $("#patntAdres2").val();
		var patntAgre = $("#patntAgre:checked").val();
		var patntHlthinsAt = $("#patntHlthinsAt:checked").val();
		var patntHsptlzAt = $("#patntHsptlzAt:checked").val();
		
		
		if (patntNm == null || patntNm == "") {
		    $("#pNm").html("환자명을 입력해주세요.");
		    $("#patntNm").focus();
		    return false;
		}
		if (patntTelno == null || patntTelno == "") {
		    $("#pTelno").html("환자 연락처를 입력해주세요.");
		    $("#patntTelno").focus();
		    return false;
		}
		if (patntRrno1 == null || patntRrno1 == "") {
		    $("#pRrno1").html("주민번호를 입력해주세요.");
		    $("#patntRrno1").focus();
		    return false;
		}
		if (patntRrno2 == null || patntRrno2 == "") {
		    $("#pRrno2").html("주민번호를 입력해주세요.");
		    $("#patntRrno2").focus();
		    return false;
		}
		if (patntAge == null || patntAge == "") {
		    $("#pAge").html("나이를 입력해주세요.");
		    $("#patntAge").focus();
		    return false;
		}
		if (patntZip == null || patntZip == "") {
		    $("#pZip").html("우편번호를 입력해주세요.");
		    $("#patntZip").focus();
		    return false;
		}
		if (patntAdres1 == null || patntAdres1 == "") {
		    $("#pAdres1").html("주소를 입력해주세요.");
		    $("#patntAdres1").focus();
		    return false;
		}
		if (patntAdres2 == null || patntAdres2 == "") {
		    $("#pAdres2").html("주소를 입력해주세요.");
		    $("#patntAdres2").focus();
		    return false;
		}
		if (patntAgre != 'Y' || patntAgre == "") {
		    $("#pAgre").html("개인 정보 제공에 동의하셔야합니다.");
		    $("#patntAgre").focus();
		    return false;
		}
		
		if($("#patntHsptlzAt").is(":checked")){
			$("#patntHsptlzAtHidden").val("Y");
		}else{
			$("#patntHsptlzAtHidden").val("N");
		}
		if($("#patntHlthinsAt").is(":checked")){
			$("#patntHlthinsAtHidden").val("Y");
		}else{
			$("#patntHlthinsAtHidden").val("N");
		}
		
		insertForm.submit();
	});
	
// 만나이 계산 & 성별 적용
$(function(){
	$("#calAgeBtn").on("click",function(){
		var patntRrno1Val = $("#patntRrno1").val();
		var patntRrno2Val = $("#patntRrno2").val();
		
		if (patntRrno1Val == null || patntRrno1Val == "") {
		    $("#pRrno1").html("주민번호를 입력해주세요.");
		    $("#patntRrno1").focus();
		    return false;
		}
		if (patntRrno2Val == null || patntRrno2Val == "") {
		    $("#pRrno2").html("주민번호를 입력해주세요.");
		    $("#patntRrno2").focus();
		    return false;
		}	
	
		var patntY = null;
		var patntY1 = patntRrno1Val.substr(0,2);
		var patntY2 = patntRrno2Val.substr(0,1);
		
		if(patntY2 == 1 || patntY2 == 2) patntY = '19' + patntY1;
		if(patntY2 == 3 || patntY2 == 4) patntY = '20' + patntY1;
		
		var patntMD = patntRrno1Val.substr(2);
		
		var date = new Date();
		var year = date.getFullYear();
		var month = (date.getMonth() + 1);
		var day = date.getDate();
		
		if(month < 10) month = '0' + month;
		if(day < 10) day = '0' + day;
		var monthDay = month + day;
		
		var age = monthDay < patntMD ? year - patntY - 1 : year - patntY;
		
		$("#patntAge").val(age);
		
		// 성별
		if(patntY2 == 1 || patntY2 == 3){
			$("#M").prop("checked", true);
		}else if(patntY2 == 2 || patntY2 == 4){
			$("#F").prop("checked", true);
		}
// 		console.log();
	});
	
});

//전화번호에 하이픈 추가~
function formatPhoneNumber(phoneNumber) {
    if (phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
    return phoneNumber;
}


	
// 환자 정보 상세보기 & 수정
	var detailPatientBtn = $(".detailPatientBtn");
	
	detailPatientBtn.on("click",function(){
		var patntNo = $(this).data("patient-id");

        $.ajax({
            type : "post",
            url : "/mediform/nurse/updateForm",
            data : patntNo,
            contentType : "application/json; charset=utf-8",
            async: false,
	        beforeSend : function(xhr){
	            xhr.setRequestHeader(header,token);
	        },
            success: function(data){
            	if(data == null || data == ""){
            		alert("다시 시도해주세요!");
            		return false;
            	}else{
	            	$('#newPatient-modal').modal();			// 모달 띄우기
	            	
// 	            	console.log("patient detail data>>>>>",data);
	                $("#patntNo").val(data.patntNo);
	                $("#patntNm").val(data.patntNm);
	                
	                // 00년생 ~09년생 처리
	                let patntRrno1 = data.patntRrno1.toString();
	                while (patntRrno1.length < 6) {
	                    patntRrno1 = '0' + patntRrno1;
	                }
	                $("#patntRrno1").val(patntRrno1);
	                
	                // 주민번호 뒷자리 가리기
	                let patntRrno2 = data.patntRrno2.toString();
					let rePatntRrno2 = patntRrno2.replace(/(?<=.{1})./gi, "*");
					$("#patntRrno2").val(rePatntRrno2);
	                
	                $("#patntTelno").val(formatPhoneNumber(data.patntTelno));
	                $("#patntZip").val(data.patntZip);
	                $("#patntAdres1").val(data.patntAdres1);
	                $("#patntAdres2").val(data.patntAdres2);
	                $("#patntAge").val(data.patntAge);
	                $("#patntSexdstn").val(data.patntSexdstn);
	                $("#prtctorNm").val(data.prtctorNm);
	                $("#prtctorTelno").val(formatPhoneNumber(data.prtctorTelno));
	                $("#patntAgre").val(data.patntAgre);
	                $("#patntHeight").val(data.patntHeight);
	                $("#patntBdwgh").val(data.patntBdwgh);
	                $("#patntBdp").val(data.patntBdp);
	                $("#patntHlthinsAt").val(data.patntHlthinsAt);
	                $("#patntMemo").val(data.patntMemo);
	                $("#patntHsptlzAt").val(data.patntHsptlzAt);
	                
	                $(".pNo").show();
            		$("#textPatientTitle").html("환자 상세정보");
            		$(".patntAgre").css("display", "none");
                    $("#resetBtn").hide();
                    
					var insertForm = $("#insertForm");
					
                    insertBtn.html("수정");
                    insertForm.attr("action", "/mediform/nurse/patient/update");		// 폼 경로 바꾸기 
					
            	}
            },
            error: function () {
                console.error("데이터를 가져오는 중 오류가 발생했습니다.");
            }
        });
    });
	

	updateflag = false;
	$("#insertForm")[0].reset();
	$(".pNo").hide();
	$("#textPatientTitle").html("신규 환자 등록");
	$(".patntAgre").css("display", "block");
    $("#resetBtn").show();
	$("#insertBtn").html("저장");
    $("#insertForm").attr("action", "/mediform/nurse/patient/insert");
	
	//환자 차트 모달 시작
	$(".patientModal").on("click", function() {
	
		var patntNo = $(this).attr("id");
		console.log("patntNo >>> " + patntNo);
		$("#patntClnicModal").modal("show");
		
		$.ajax({
			type: "post",
			url: "/mediform/nurse/room/patntClnic/list",
			data: JSON.stringify({ "patntNo": patntNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (dataList) {
				console.log("dataList >>> " + dataList);
				let htmlStr = "";
				if (dataList.length === 0) {
	            	htmlStr += '<tr>';
            		htmlStr += '<th class="text-center" colspan="10">진료 정보가 없는 환자 입니다.</th>';
           			htmlStr += '</tr>';
		        }else{
				
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
					if(pc.hsptlzAt == 'N'){
						pc.hsptlzAt = "x";
					}else{
						pc.hsptlzAt = "o";
					}
					    pc.clnicTime = pc.clnicTime.replace(/-/g, ".");
					
					htmlStr += '<tr>';
					htmlStr +=	'<th>'+ pc.clnicNo + '</th>';
					htmlStr +=	'<th>' + pc.empNm + '</th>';
					htmlStr +=	'<th noWrap>' + pc.clnicTime + '</th>';
					htmlStr +=	'<th class="text-900 sort pe-1" style="text-align: left; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 88px;">' + pc.clnicCn + '</th>';
					htmlStr +=	'<th class="text-center">' + pc.hsptlzAt + '</th>';
					htmlStr +=	'<th class="text-center" noWrap>' + pc.atfssDt + '</th>';
					htmlStr +=	'<th class="text-center">' + pc.clnicMemo + '</th>';
					htmlStr +=	'<th noWrap><button id="' + pc.clnicNo + '" class="btn btn-falcon-primary me-1 mb-1 diagnosispage" type="button">진단서</button></th>';
					htmlStr +=	'<th noWrap><button id="' + pc.clnicNo + '" class="btn btn-falcon-success  me-1 mb-1 mtcpage" type="button">진료확인서</button></th>';
					htmlStr +=	'<th noWrap><button id="' + pc.clnicNo + '" class="btn btn-falcon-warning  me-1 mb-1 prescriptionpage" type="button">처방전</button></th>';
					htmlStr +=	'</tr>';
					}
				}
				$("#patntClnicTable").html(htmlStr);  // 화면에 html넣기
				
			},
			error: function (err) {
				console.log("환자 차트 >>err에러 : " + err);
			}
		});
	});	
	
	
	
//진단서
var diagnosisModal = $("#diagnosisModal");

	$("#patntClnicTable").on("click", ".diagnosispage", function () {
		var clnicNo = $(this).attr("id");
		console.log(">>>>진단서 진료번호 <<<<   " + clnicNo);
		
 		console.log("diagnosispage 모달 클릭 이벤트 성공!!!");
		diagnosisModal.modal("show");
	
	
	
	
	
	
	
	});		

	
// 타임스탬프 날짜 변환 함수(시,분,초 포함) 
// yyyy년 MM월 dd일 
function formatDate(timeStamp){
    var date = new Date(timeStamp);

    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 두 자리로 만듭니다.
    var day = date.getDate().toString().padStart(2, '0'); // 일도 두 자리로 만듭니다.
    var hours = date.getHours().toString().padStart(2, '0'); // 시도 두 자리로 만듭니다.
    var minutes = date.getMinutes().toString().padStart(2, '0'); // 분도 두 자리로 만듭니다.
    var seconds = date.getSeconds().toString().padStart(2, '0'); // 초도 두 자리로 만듭니다.

    var formattedDate = year + '년 ' + month + '월 ' + day + '일';

    return formattedDate;
}
	
	
//진료확인서 -> 진료확인서 모달
var mtcModal = $("#mtcModal");
	$("#patntClnicTable").on("click", ".mtcpage", function () {
		var clnicNo = $(this).attr("id");
// 		console.log(">>>> 진료확인서 진료번호 <<<<   " + clnicNo);
		
// 		console.log("mtcModal 모달 클릭 이벤트 성공!!!");
		
	
		//환자 정보
		$.ajax({ 
			type: "post",
			url: "/mediform/nurse/clnicInfo/list",
			data: clnicNo,
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (rst) {
				console.log("환자 정보dataList>>>>>",rst);
				// 환자 번호
				$('#patntNoCl').text(rst.patntNo);
				
				// 환자명
				$('#patntNmCl').text(rst.patntNm);
				
				// 환자 성별
				var genderStr = "";
				if(rst.patntSexdstn != null && rst.patntSexdstn == "M"){
					genderStr = "남성";
				}else{
					genderStr = "여성";
				}
				$('#patntSexdstnCl').text(genderStr);
				
				// 환자 나이
				$('#patntAgeCl').text(rst.patntAge);
				
				// 환자 우편번호
				$('#patntZipCl').text(rst.patntZip);
				
				// 환자 주소1
				$('#patntAdres1Cl').text(rst.patntAdres1);
				
				// 환자 주소2
				$('#patntAdres2Cl').text(rst.patntAdres2);
				
				// 환자 주민번호
				$('#patntRrnoCl').text(rst.patntRrno1 + "-" + rst.patntRrno2);
				
				// 의사등록번호
	        	$('#empDoctrLcnsNoCl').text(rst.empDoctrLcnsNo);
				
        	   // 입원일
        	   $('#hsptlzDeCl').text(formatDate(rst.hsptlzDe));
        	 
        	   // 실제 퇴원일
        	   $('#realLhstlCl').text(formatDate(rst.realLhstl));
				
				
			},
			error: function (err) {
				console.log("환자 정보 >>err에러 : " + err);
			}
		});
		
		// 상병
		$.ajax({
	         type : "post",
	         url  : "/mediform/doctor/clinic/select",
	         data: JSON.stringify({ "clnicNo": clnicNo }),
	         contentType : "application/json; charset=utf-8",
	           beforeSend : function(xhr){
	               xhr.setRequestHeader(header,token);
	           },
	         success : function(rst){
	        	 console.log("환자 상병 res>>>>>",rst);
	        	 // 상병명(반복문 써야 함.) -> 한글명, 영문명, 질병분류기호 + "줄넘김"
	        	 var dataList = rst.sickAndWoundedVOList;
	        	 var sckwndKrStr = ""; 
	        	 $.each(dataList, function(index, item){
						
	        		 sckwndKrStr = item.sckwndKr + "(" + item.sckwndEn + ", " + item.kcd + ") " + "\n";
						
					});
	        	 
	        	 $('#sckwndKrCl').text(sckwndKrStr);
	        	 
	        	 // 진료 일시
	        	 $('#clnicTimeCl').text(rst.clnicTime);
	        	 
	        	 // 진료 내역
	        	 $('#clnicCnCl').text(rst.clnicCn);
	        	 
	        	 // 의사명 
	        	 $('#empNmCl').text(rst.empNm);
	        	 
	        	 // 현재 날짜 출력 후 진료 확인서의 오늘 날짜란에 추가
	        	 var currentDate = new Date();
				 var year = currentDate.getFullYear();
				 var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
				 var day = currentDate.getDate().toString().padStart(2, '0');
				 var hours = currentDate.getHours().toString().padStart(2, '0');
				 var minutes = currentDate.getMinutes().toString().padStart(2, '0');
				
				 var formattedDateTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
				 // 현재
				 $('#sysdateCl').text(formattedDateTime);
	        	 
	        	 mtcModal.modal("show");
	        	 
	        	 
	         },
	         error : function(err){
	            console.log(err.status);
	         }
	      });

	
	
	});
	
	
	
// THISTHIS처방전
var prescriptionModal = $("#prescriptionModal");

	$("#patntClnicTable").on("click", ".prescriptionpage", function () {
		var clnicNo = $(this).attr("id");
// 		console.log(">>>> 처방전 진료번호 <<<<   " + clnicNo);
		
// 		console.log("prescriptionModal 모달 클릭 이벤트 성공!!!");
		//환자 정보 리스트
		$.ajax({ 
			type: "post",
			url: "/mediform/nurse/clnicInfo/list",
			data: clnicNo,
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (dataList) {
				console.log("환자 정보dataList>>>>>",dataList);
				let data = dataList;
				
				$("#patntNo3").val(data.patntNo);
				$("#empNo3").val(data.empNo);
				$("#empNm3").val(data.empNm);
				$("#empDoctrLcnsNo3").val(data.empDoctrLcnsNo);
                $("#patntNm3").val(data.patntNm);
                $("#patntRrno13").val(data.patntRrno1);
                $("#patntRrno23").val(data.patntRrno2);
                $("#patntTelno3").val(data.patntTelno);
                $("#patntZip3").val(data.patntZip);
                $("#patntAdres13").val(data.patntAdres1);
                $("#patntAdres23").val(data.patntAdres2);
                $("#patntAge3").val(data.patntAge);
                $("#patntSexdstn3").val(data.patntSexdstn);
                $("#prtctorNm3").val(data.prtctorNm);
                $("#prtctorTelno3").val(data.prtctorTelno);
                $("#patntAgre3").val(data.patntAgre);
                $("#patntHeight3").val(data.patntHeight);
                $("#patntBdwgh3").val(data.patntBdwgh);
                $("#patntBdp3").val(data.patntBdp);
                $("#patntHlthinsAt3").val(data.patntHlthinsAt);
                $("#patntMemo3").val(data.patntMemo);
                $("#patntHsptlzAt3").val(data.patntHsptlzAt);
				
                $("#patntNm3").replaceWith('<span id="patntNm3" class="custom-text">' + data.patntNm + '</span>');
                $("#patntRrno13").replaceWith('<span id="patntRrno13" class="custom-text">' + data.patntRrno1 + '</span>');
                $("#patntRrno23").replaceWith('<span id="patntRrno23" class="custom-text">' + data.patntRrno2 + '</span>');
                $("#empDoctrLcnsNo3").replaceWith('<span id="empDoctrLcnsNo3" class="custom-text">' + data.empDoctrLcnsNo + '</span>');
				
			},
			error: function (err) {
				console.log("차트벉호에따른 환자내용 >>err에러 : " + err);
			}
		});
		
		//약 리스트
		$.ajax({ 
			type: "post",
			url: "/mediform/nurse/clnic/medicine/list",
			data: JSON.stringify({ "clnicNo": clnicNo }),
			contentType: "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (res) {
			
				let htmlStr = ""; //주사
				let htmlStr2 = "";//알약
				console.log("차트번호에따른 약내용 >>>>>",res);
					if(res === undefined || res === null || res.length === 0){
						Swal.fire({
						      icon: 'warning',
						      title: '처방전',
						      text: '처방된 정보가 존재하지 않습니다.',
						      confirmButtonColor: 'blue'
						    });
					}else{
						console.log("prescriptionModal 모달 클릭 이벤트 성공!!!");
						prescriptionModal.modal("show");
						
						for (let i = 0; i < res.length; i++) {
							let mdc = res[i];
							
							if(mdc.mdctnUnit === "앰플"){
								console.log("res앰플만>>>",mdc);
								
								htmlStr += `
										<tr style="height:16.6pt">
											<td  colspan="12" style="width:228.4pt; border-top:0.75pt solid #000000; border-right:0.75pt solid #000000; border-left:1.12pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt 1.4pt 0.84pt; vertical-align:middle">
												<p class="a" style="line-height:normal; font-size:11pt">
													<span style="letter-spacing:normal">\${mdc.prscrptnNm}</span>
												</p>
											</td>
											<td class="textCenter" colspan="2" style="width:48.7pt; border-top:0.75pt solid #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
												<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
													<span style="letter-spacing:normal">\${mdc.mdctnCpcty}</span>
												</p>
											</td>
											<td class="textCenter" style="width:30.8pt; border-top:0.75pt solid #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
												<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
													<span style="letter-spacing:normal">\${mdc.mdctnCo}</span>
												</p>
											</td>
											<td class="textCenter" colspan="3" style="width:42.6pt; border-top:0.75pt solid #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
												<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
													<span style="letter-spacing:normal">\${mdc.mdctnPd}</span>
												</p>
											</td>
											<td colspan="2" style="width:126.4pt; border-right:1.12pt solid #000000; border-left:0.75pt solid #000000; padding:1.4pt 0.84pt 1.4pt 1.02pt; vertical-align:top">
												<p class="a" style="line-height:normal; font-size:11pt">
													<span style="letter-spacing:normal">&#xa0;</span>
												</p>
											</td>
										</tr>
										`;	
							}else{
								
								htmlStr2 += `
									<tr style="height:16.6pt">
										<td colspan="12" style="width:228.4pt; border-top:0.75pt dotted #000000; border-right:0.75pt solid #000000; border-left:1.12pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt 1.4pt 0.84pt; vertical-align:middle">
											<p class="a" style="line-height:normal; font-size:11pt">
												<span style="letter-spacing:normal">\${mdc.prscrptnNm}</span>
											</p>
										</td>
										<td colspan="2" style="width:48.7pt; border-top:0.75pt dotted #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
											<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
												<span  style="letter-spacing:normal">\${mdc.mdctnCpcty}</span>
											</p>
										</td>
										<td style="width:30.8pt; border-top:0.75pt dotted #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
											<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
												<span style="letter-spacing:normal">\${mdc.mdctnCo}</span>
											</p>
										</td>
										<td colspan="3" style="width:42.6pt; border-top:0.75pt dotted #000000; border-right:0.75pt solid #000000; border-left:0.75pt solid #000000; border-bottom:0.75pt dotted #000000; padding:1.4pt 1.02pt; vertical-align:middle">
											<p class="a" style="line-height:normal; font-size:11pt; text-align:center;">
												<span style="letter-spacing:normal">\${mdc.mdctnPd}</span>
											</p>
										</td>
										<td colspan="2" style="width:126.4pt; border-right:1.12pt solid #000000; border-left:0.75pt solid #000000; padding:1.4pt 0.84pt 1.4pt 1.02pt; vertical-align:top">
											<p class="a" style="line-height:normal; font-size:11pt">
												<span style="letter-spacing:normal">&#xa0;</span>
											</p>
										</td>
									</tr>
										`;	
										
							}
						}
				$("#injectionmedcinTable").html(htmlStr);
				$("#medcinTable").html(htmlStr2);
				}
			},
			error: function (err) {
				console.log("차트번호에따른 약내용 >>err에러 : " + err);
			}
		});
		
		
	});
	
});


var printBtn = $("#printBtn");

printBtn.on("click", function(){
	var modalContent = document.querySelector("#printArea");
    var printWindow = window.open('', '', 'width=600,height=600');
    printWindow.document.open();
    printWindow.document.close();
    printWindow.document.write('<html><head>');
    printWindow.document.write('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
    printWindow.document.write('<meta name="generator" content="PhpSpreadsheet, https://github.com/PHPOffice/PhpSpreadsheet">');
    printWindow.document.write('<meta name="author" content="HIRA" />');
    printWindow.document.write('<link rel="stylesheet" href="/MediForm/src/main/webapp/resources/css/print.css"></head><body>');
    printWindow.document.write(modalContent.innerHTML);
    printWindow.document.write('</body></html>');
    printWindow.print();
    printWindow.close();
}); 


//페이징
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

// 체크박스 필터링
$(document).ready(function() {
    $(".filter-check").on("click", function() {
        var FilterChk = $(this).val();
    	
    	if (!$(this).is(':checked')) {
			$("#checkAll").prop("checked",false);
        }
        
        if ($(".filter-check:checked").length === $(".filter-check").length) {
            $("#checkAll").prop("checked", true);
       }
    });
});

// 전체
$(function(){
	var checkAll = $("#checkAll");
	checkAll.on("click",function(){
		if($(this).is(":checked")){
			$(".filter-check").prop("checked",true);
		}else{
			$(".filter-check").prop("checked",false);
		}
	});
});

// 필터 적용
$(document).ready(function() {
//     $(".filter-check").change(function() {
//         applyFilter();
//     });

    $("#checkFilterBtn").click(function() {
        applyFilter();
        
        $("#searchForm").submit();
    });

    // 필터 적용 함수
    function applyFilter() {
    	var html = "";
    	var flag = false;	// 검색 필터 체크된 항목이 없을때
    	console.log($(".filter-check"));
    	$(".filter-check").map(function(i,e){
			console.log("Element : " + e + ", index : " + i);    		
    		if(e.checked){
				html += "<input type='hidden' name='"+$(this).val()+"' value='"+$(this).val()+"'>";
				flag = true;
			}
   		})
    	if(flag){
			html += "<input type='hidden' name='filterFlag' value='true'>";    		
    	}
		$("#searchForm").append(html);
		console.log($("#searchForm").html());
    }
});

function DaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== ''
						&& /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== ''
						&& data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
			} 

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('patntZip').value = data.zonecode;
			document.getElementById("patntAdres1").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("patntAdres2").focus();
		}
	}).open();
};




//excel 다운로드 로직
const excelDownload = document.querySelector('#excelDownload');

document.addEventListener('DOMContentLoaded', function() {

    excelDownload.addEventListener('click', exportExcel);
});

function exportExcel(){ 
  // step 1. workbook 생성
  var wb = XLSX.utils.book_new();

  // step 2. 시트 만들기 
  var newWorksheet = excelHandler.getWorksheet();

  // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
  XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

  // step 4. 엑셀 파일 만들기 
  var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

  // step 5. 엑셀 파일 내보내기 
  saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

var excelHandler = {
    getExcelFileName : function(){
        return 'patientTable.xlsx';	//파일명
    },
    getSheetName : function(){
        return 'Table Test Sheet';	//시트명
    },
    getExcelData : function(){
        return document.getElementById('patientTable'); 	//TABLE id
    },
    getWorksheet : function(){
        return XLSX.utils.table_to_sheet(this.getExcelData());
    }
}

function s2ab(s) { 
  var buf = new ArrayBuffer(s.length); 
  var view = new Uint8Array(buf); 
  for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; 
  return buf;    
}



var renderedImg = new Array;
var contWidth = 200, // 너비(mm) (a4에 맞춤)
padding = 3; // 상하좌우 여백(mm)
function createPdf() { // 이미지를 pdf로 만들기
	console.log("ceatePdf 함수 실행!");
	var lists = document.querySelectorAll(".pdfArea1"), // 출력대상 명확히 지정 필요 -> div가 한 묶음으로 출력
				deferreds = [],
				doc = new jsPDF("p", "mm", "a4"),
				listsLeng = lists.length;
	
	for (var i = 0; i < listsLeng; i++) { // div 개수만큼 이미지 생성
	var deferred = $.Deferred();
	deferreds.push(deferred.promise());
	generateCanvas(i, doc, deferred, lists[i]);
	}

	$.when.apply($, deferreds).then(function () { // 이미지 렌더링이 끝난 후
		var sorted = renderedImg.sort(function(a,b){return a.num < b.num ? -1 : 1;}), // 순서대로 정렬
		curHeight = padding, // 위 여백 (이미지가 들어가기 시작할 y축)
		sortedLeng = sorted.length;
	
		for (var i = 0; i < sortedLeng; i++) {
			var sortedHeight = sorted[i].height, //이미지 높이
			sortedImage = sorted[i].image; //이미지
				if( curHeight + sortedHeight > 297 - padding * 2 ){ // a4 높이에 맞게 남은 공간이 이미지 높이보다 작을 경우 페이지 추가
					doc.addPage(); // 페이지를 추가함
					curHeight = padding; // 이미지가 들어갈 y축을 초기 여백값으로 초기화
					doc.addImage(sortedImage, 'jpeg', padding ,
					curHeight, contWidth, sortedHeight); // 이미지 넣기
					curHeight += sortedHeight; // y축 = 여백 + 새로 들어간 이미지 높이
				} else { // 페이지에 남은 공간보다 이미지가 작으면 페이지 추가하지 않음
					doc.addImage(sortedImage, 'jpeg', padding ,
					curHeight, contWidth, sortedHeight); // 이미지 넣기
					curHeight += sortedHeight; // y축 = 기존y축 + 새로 들어간 이미지 높이
				}
		}
		doc.save('pdf_test.pdf'); // pdf 저장
		curHeight = padding; // y축 초기화
		renderedImg = new Array; // 이미지 배열 초기화
	});
}


function generateCanvas(i, doc, deferred, curList){ // 페이지를 이미지로 만들기
	var pdfWidth = $(curList).outerWidth() * 0.2645, // px -> mm로 변환
		pdfHeight = $(curList).outerHeight() * 0.2645,
		heightCalc = contWidth * pdfHeight / pdfWidth;
		html2canvas( curList ).then(
		function (canvas) {
			var img = canvas.toDataURL('image/jpeg', 1.0); // 이미지 형식 지정
			renderedImg.push({num:i, image:img,
			height:heightCalc}); // renderedImg 배열에 이미지 데이터 저장(뒤죽박죽방지)
			deferred.resolve(); // 결과 보내기
		}
	);
}

</script>
</body>
</html>




