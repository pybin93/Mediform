<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />

<head>

<meta charset="UTF-8">
<title>의사 | 진료실</title>
<style type="text/css">
.callbutton {
    width: 60px; 
    height: 30px;  
    padding: 1px 5px;  
    font-size: x-small;
}
$thisButton.css{
	width: 60px; 
    height: 30px;  
    padding: 1px 5px;  
    font-size: x-small;
}
.patientInfoCss{
	font-size: small;
	border: none;
	box-shadow: none;
	background-color: none;
	background: initial;
}
.patientCss2{
    font-weight: bold;
    color: midnightblue;
}
.pointer{
	cursor: pointer;
}
.clinic-content{
	font-size: 12px;
}
.patient-content{
    display: flex;
    align-items: center;
}
</style>
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

<!-- 의사 진료 시작 -->
<div class="row" style="height: 820px;">

	<!-- 진료환자 리스트 시작 -->
	<div class="col-2 px-2" style="">
		<div class="card border border-secondary">
			<div class="card-header p-3" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
				<div class="" style="display: flex; justify-content: center;">
					<div class="fw-semi-bold text-white text-center" style="font-size: 20px;">${clinicNo } 진 료 실</div>
				</div>
				<div class="" style="display: flex; justify-content: center;">
					<div class="fw-semi-bold text-white text-center"> 담 당 의 | <span>${customUser.employee.empNm}</span>
					</div>
				</div>
			</div>
			
			<div class="card scrollbar" style="height: 722px; overflow-x: hidden;">
				<div>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item text-center col-6">
							<a	class="nav-link active fw-semi-bold" id="waiting-tab" data-bs-toggle="tab" href="#tab-waiting" role="tab" aria-controls="tab-waiting" aria-selected="true">진료대기</a>
						</li>
						<li class="nav-item text-center col-6">
						<a class="nav-link fw-semi-bold" id="done-tab" data-bs-toggle="tab"	href="#tab-done" role="tab" aria-controls="tab-done" aria-selected="false">진료완료</a>
						</li>
					</ul>
				</div>
				<div>
					<div class="row card-body" style="padding: 0px; height: 680px;">
						<div class="tab-content" id="myTabContent">

							<!-- 진료대기 탭 시작 -->
							<div class="col-12 tab-pane fade show active p-0" id="tab-waiting" role="tabpanel" aria-labelledby="waiting-tab">
								<div class="col-12"	style="display: flex; justify-content: flex-end;"></div>
								<div class="list bg-body-tertiary scrollbar d-flex flex-column gap-1" id="waitingList" style="overflow-y: auto; max-height: 680px; width: 300px;">
									<!-- 내용 ajax 비동기 생성 -->
								</div>
							</div>
							<!-- 진료대기 탭 끝 -->

							<!-- 진료완료 탭 시작 -->
							<div class="col-12 tab-pane fade" id="tab-done" role="tabpanel" aria-labelledby="done-tab">
								<div class="list bg-body-tertiary scrollbar d-flex flex-column gap-1" id="doneClinicList" style="overflow-y: auto; max-height: 680px; width: 300px;"></div>
							</div>
							<!-- 진료완료 탭 끝 -->

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 진료환자 리스트 끝 -->
	
	<!-- 환자 정보 시작 -->
	<div class="col-3 px-2 ">
		<div class="card border border-secondary" >
			
			<div class="card-header p-1" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
				<div class="mb-1 ms-1" style="display: flex; justify-content: start;">
					<div class="fw-semi-bold text-white text-start ms-1" style="font-size: 16px;">환자정보</div>
				</div>
				
				<!-- 환자 검색 시작 -->
				<div class="row">
					<div class="col-1">
						<button class="input-group-text" id="searchPatientBtn" style="padding-right: 10px; padding-left: 10px; background: unset; border: initial" disabled="disabled"><i class="fas fa-search text-white"></i></button>
					</div>
					<div class="col-9 pe-0">
						<div class="search-box w-100" id="">
							<form class="position-relative" data-bs-toggle="search">
								<input class="form-control form-control-sm" type="search" placeholder="환자명 또는 환자번호를 입력해 주세요." aria-label="Search"
										name="searchPatientWord" id="patientInput" style="border: none; font-style: italic;"/>
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
													<tr class="">
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
					<div class="col-2 ps-0" style="display: flex; align-items: center; justify-content: flex-end;">
						<button class="btn btn-falcon-default btn-small resetButton py-1 px-2 me-1" type="button" style="font-size: 12px;">초기화</button>
					</div>
				</div>
				<!-- 환자 검색 끝 -->
			</div>
				
			<!-- 환자 정보 시작 -->
			<div class="">
				<div class="mt-1">
					<div class="col-12 scrollbar" style="height: 152px; overflow-x: hidden;">
						<div class="row">
							<div class="col-6 pe-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">환자번호</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntNoDt" readonly="readonly"/>
								</div>
							</div>
							<div class="col-6 ps-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">환자명</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntNmDt" readonly="readonly"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6 pe-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">생년월일</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntRrno1Dt" readonly="readonly"/>
								</div>
							</div>
							<div class="col-6 ps-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0" style="letter-spacing: 4px;">나 이</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntAgeDt" readonly="readonly"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6 pe-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0" style="letter-spacing: 13px;">성별</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntSexdstnDt" readonly="readonly"/>
								</div>
							</div>
							<div class="col-6 ps-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">환자연락처</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntTelDt" readonly="readonly"/>
								</div>
							</div>
						</div>	
						<div class="row">
							<div class="col-6 pe-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">보험여부</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntHlthinsAtDt" readonly="readonly"/>
								</div>
							</div>
							<div class="col-6 ps-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0" style="letter-spacing: 4px;">입원여부</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="hsptlzAtDt" readonly="readonly"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6 pe-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">보호자연락처</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="prtctorTelnoDt" readonly="readonly"/>
								</div>
							</div>
							<div class="col-6 ps-0">
								<div class="input-group input-group-sm">
									<span class="input-group-text patientInfoCss patientCss2 pe-0">보호자이름</span>
									<input class="form-control patientInfoCss patient-content pe-0" type="text" id="prtctorNmDt" readonly="readonly"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="input-group input-group-sm mb-2">
									<span class="input-group-text patientInfoCss patientCss2 pe-0" style="display: flex; align-items: flex-start;">특이사항</span>
									<textarea class="form-control patientInfoCss patient-content" cols="2" id="patntMemoDt" readonly="readonly"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 환자 정보 끝 -->
			</div>
		</div>
		<!-- 환자 정보 끝 -->
				
		<!-- 바이탈 시작 -->
		<div class="card border border-secondary mt-2" >
			<div class="card-body scrollbar p-0">
				<div id="p-0">
					<div class="table-responsive scrollbar">
						<table class="table table-sm table-bordered table-striped mb-0" style="font-size: 14px;">
							<thead class="bg-200">
								<tr>
									<th class="text-800 text-center py-0 ms-2">키</th>
									<th class="text-800 text-center py-0">몸무게</th>
									<th class="text-800 text-center py-0">혈액형</th>
									<th class="text-800 text-center py-0">최고혈압</th>
									<th class="text-800 text-center py-0">최저혈압</th>
									<th class="text-800 text-center py-0 me-2">체온</th>
								</tr>
							</thead>
							<tbody class="list text-center">
								<tr class="" style="height: 25px;">
									<td class="py-0 ms-2" id="patntHeightDt"></td>
									<td class="py-0" id="patntBdwghDt"></td>
									<td class="py-0" id="patntBdpDt"></td>
									<td class="py-0" id="hghrkHhprsDt"></td>
									<td class="py-0" id="lwtrkHhprsDt"></td>
									<td class="py-0 me-2" id="bdheatDt"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>	
		</div>
		<!-- 바이탈 끝 -->
				
		<!-- 진료기록 시작 -->
		<div class="card mt-2">
			<div class="card border border-secondary" style="height: 518px; background-color: aliceblue;">
				<div class="card-header p-1" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
					<div class="ms-2" style="display: flex; justify-content: start;">
						<div class="fw-semi-bold text-white text-start mb-1" style="font-size: 16px;">진료기록</div>
					</div>
				</div>
				<div class="row pt-1">
					<div class="col-auto" style="padding-left: 20px; padding-right: 5px;">
						<div class="card" style="height: 470px; min-width: 82px; max-width: 82px;">
							<div class="card-header p-1" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
								<div class="" style="display: flex; justify-content: center;">
									<div class="fw-semi-bold text-white text-center" style="font-size: 13px;">진료날짜</div>
								</div>
							</div>
							<table>
								<tbody id="allClnicTimeDt" style="text-align: center;"></tbody>
							</table>
						</div>
					</div>
					<div class="col-auto" style="padding-left: 0px; padding-right: 20px;">
						<div class="card" style="height: 470px; min-width: 360px; max-width: 360px;">
							<div class="card-header p-1" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
								<div class="" style="display: flex; justify-content: center;"></div>
							</div>
							<div class="p-2 scrollbar" style="overflow-x: hidden;">
								<div class="row mb-2">
									<div class="col-8 pe-0">
										<div class="input-group input-group-sm">
											<span class="input-group-text patientInfoCss patientCss2 pe-0">진료일시</span>
											<div class="form-control patientInfoCss pe-0 clinic-content" id="pastClnicTime"></div>
										</div>
									</div>
									<div class="col-4 ps-0" style="text-align: end;">
										<button class="btn btn-sm vacFormDetailBtn dropdown"  data-bs-toggle="dropdown"
												data-boundary="window" aria-haspopup="true" aria-expanded="false"
												data-bs-reference="parent"type="button" style="height: 30px;">
											<div class="row">
												<div class="col-auto p-0">
													<span class="material-icons p-0" style="color: midnightblue;">description</span>
												</div>
												<div class="col-auto p-0" style="display: flex; align-items: center;">
													<span style="color: midnightblue;">제증명</span>
												</div>
											</div>
										</button>
										<div class="dropstart font-sans-serif position-static d-inline-block">
											<div class="dropdown-menu dropdown-menu-end border py-2 certificatesBtn" aria-labelledby="dropdown-simple-pagination-table-item-13">
												<button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#certificates-modal" id="certificates-diagnosis-Btn">진단서</button>
												<button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#certificates-modal" id="certificates-mtc-Btn">진료확인서</button>
												<button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#certificates-modal" id="certificates-prescription-Btn">처방전</button>
											</div>
										</div>
									</div>
								</div>
								<div class="row mb-2">
									<div class="col-7 pe-0">
										<div class="input-group input-group-sm">
											<span class="input-group-text patientInfoCss patientCss2 pe-0">진료번호</span>
											<div class="form-control patientInfoCss clinic-content pe-0" id="pastClnicNo"></div>
										</div>
									</div>
									<div class="col-5 ps-0">
										<div class="input-group input-group-sm">
											<span class="input-group-text patientInfoCss patientCss2 pe-0">담당의</span>
											<div class="form-control patientInfoCss clinic-content pe-0" id="pastEmpNm"></div>
										</div>
									</div>
								</div>
								<div class="row mb-2">
									<div class="input-group input-group-sm">
										<span class="input-group-text patientInfoCss patientCss2 pe-0" style="letter-spacing: 5px;">발병일</span>
										<div class="form-control patientInfoCss clinic-content pe-0" id="pastAtfssDt"></div>
									</div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text patientInfoCss patientCss2 pe-0">진단내역</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastClnicCn" class="scrollbar form-control clinic-content patientInfoCss"></div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text patientInfoCss patientCss2 pe-0">상병내역</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastSAW" class="scrollbar form-control clinic-content patientInfoCss"></div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text patientInfoCss patientCss2 pe-0">검사내역</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastMEO" class="form-control patientInfoCss clinic-content"></div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text patientInfoCss patientCss2 pe-0">치료내역</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastMTR" class="form-control patientInfoCss clinic-content"></div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text patientInfoCss patientCss2 pe-0">처방내역</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastPO" class="form-control patientInfoCss clinic-content"></div>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-text text-center patientInfoCss patientCss2 pe-0">메모사항</div>
								</div>
								<div class="input-sm mb-2">
									<div id="pastMemo" class="form-control patientInfoCss clinic-content"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 진료기록 끝 -->
	</div>
	<!-- 환자정보 끝 -->
	
	<!-- 진료작성 시작 -->
	<input type="hidden" id="rceptNo" value="">		
	<input type="hidden" id="clnicNo" value="">		
	<div class="col-5 px-2">
		<div class="card border border-secondary" style="height: 807px;">
			<div class="card-header p-1" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
				<div class="" style="display: flex; flex-wrap: wrap;">
					<div class="fw-semi-bold text-white text-center ms-2" style="font-size: 16px;">진료기록 작성
						[ <input id="clnicTimeInput" class="patientInfoCss text-white fw-semi-bold" value="" style="width: 130px; font-size: 16px;" readonly />]
					</div>
				</div>
			</div>
			
			<div class="row">
			
				<!-- 진단내역 시작 -->
				<div class="col-7 mt-1">
					<div class="card pe-0" style="height: 195px;">
						<form class="row align-items-center pt-1 pb-1">
							<div class="row pe-2">
								<div class="col-2 ps-4 pe-0" style="">
									<label class="mb-0 fw-semi-bold text-black" style="font-size: 16px;">진단</label>
								</div>
								<div class="col-4 p-0 dropdown font-sans-serif d-inline-block">
									<button class="btn p-0 btn-sm" id="clinicMemoBtn" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border: none;" >
										<span class="bi-sticky-fill" style="color: midnightblue;">&nbsp;메모</span>
									</button>
									<div class="dropdown-menu dropdown-menu-start py-0" aria-labelledby="clinicMemoBtn">
										<textarea id="clnicMemoDt" class="scrollbar" style="height: 150px; width: 375px; background-color: aliceblue; border: none;" placeholder="진료메모 내용을 입력해 주세요."></textarea>
									</div>
								</div>
								<div class="col-6 px-0">
									<div class="input-group input-group-sm">
										<div class="input-group-text">발병일</div>
										<input id="atfssDt" class="form-control form-control-sm" type="date" value=""/>
									</div>
								</div>
								</div>
							<div class="row pt-1 pe-2">
								<div class="col-12 pe-0" style=" padding-left: 25px;">
									<textarea id="clnicCn" class="form-control scrollbar patientInfoCss" cols="20" placeholder="진단내역을 작성하세요." style="border: midnightblue solid 1px; height: 150px;"></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 진단내역 끝 -->
				
				<!-- 검사 시작 -->
				<div class="col-5 ps-0">
					<div class="card" style="height: 200px;">
						<div class="card shadow-none">
							<div class="card-body p-0">
								<div class="row">
									<div class="col-4 d-flex pe-0" style="height: 30px;">
										<div class="">
											<div class="fw-semi-bold text-black ps-2 pt-1" style="font-size: 16px; min-width: max-content;">검사</div>
										</div>
										<button class="input-group-text pe-2" style="padding-right: 10px; padding-left: 10px; background: unset; border: initial" disabled="disabled"><i class="fas fa-search"></i></button>
									</div>
									<div class="col-8 d-flex align-items-center justify-content-end">
										<div class="pe-2" id="exam-replace">
											<button id="hcOrderBtn" class="btn btn-warning btn-sm px-1" type="button" style="font-size: 12px;">검사오더</button>
										</div>
									</div>
								</div>
								<div class="table scrollbar mb-0 mt-1" style="height: 160px;">
									<table class="table table-sm mb-0" style="font-size: small;">
										<thead class="bg-200">
											<tr>
												<th class="text-900 align-middle text-left" style="width: 70px;">검사코드</th>
												<th class="text-900 p-0 align-middle text-left" style="width: 60px;">검사명</th>
												<th class="text-900 p-0 align-middle text-left" style="width: 40px;">급여</th>
												<th class="align-end text-end pe-2" style="width: 50px;">
													<button class="btn btn-outline-danger btn-sm px-1 py-1 allDelBtn" type="button" style="font-size: 10px;">전체삭제</button>
												</th>
											</tr>
										</thead>
										<tbody id="exam-body">
											<!-- 검사검색 시작 -->
											<tr>
												<td class="p-0" colspan="7">
													<div class="search-box w-100" id="hcSearchBox">
														<div class="" style="display: flex; justify-content: space-around;">
															<form class="position-relative" data-bs-toggle="search">
																	<span class="fas fa-plus search-box-icon"></span>
																	<input class="form-control form-control-sm py-0 mt-1 search-input hCInput" type="search" placeholder="검사코드 및 검사명으로 검색" aria-label="Search" style="width: 220px; font-size: 12px; border: none; font-style: italic;"/>
														 	</form>
														 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
																<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
															</div>
												 		</div>
														<div class="dropdown-menu font-base overflow-hidden py-0 w-100" id="hcDropMenu">
						    								<div id="hcMenu" class="list scrollbar">
						    									<div class="d-flex align-items-center">
						    										<table class="table table-sm text-center table-hover pb-0 mb-0 w-100">
																		<tbody id="hCTbody" class="list text-black">
																		</tbody>
																	</table>
														        </div>
						    								</div>
						    							</div>
													</div>
												</td>
											</tr>
											<!-- 검사검색 끝 -->
										</tbody>
										<tbody id="hcInsertTable">
											<!-- 검사선택 시작 -->
											<!-- 검사선택 끝 -->
										</tbody>
									</table>
								</div>
							</div>
							<!-- 검사테이블 끝 -->
							
						</div>
						
					</div>
				</div>
				<!-- 검사 끝 -->
			</div>
			
			<!-- 상병 시작 -->
			<div class="">
				<div class="card mt-1" style="height: 170px;">
					
					<div class="card shadow-none">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-4 d-flex pe-0" style="height: 30px;">
									<div class="">
										<div class="fw-semi-bold text-black ps-2 pt-1" style="font-size: 16px; min-width: max-content;">상병</div>
									</div>
									<button class="input-group-text pe-2" style="padding-right: 10px; padding-left: 10px; background: unset; border: initial" disabled="disabled"><i class="fas fa-search"></i></button>
								</div>
							</div>
							<div class="table mb-0 scrollbar" style="height: 140px;">
								<table class="table table-sm mb-0" style="font-size: small;">
									<thead class="bg-200">
										<tr>
											<th class="text-900 align-middle text-left" style="width: 60px;">상병코드</th>
											<th class="text-900 p-0 align-middle text-center" style="width: 20px;">주</th>
											<th class="text-900 p-0 align-middle text-center" style="width: 100px;">구분</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="width: 120px;">한글명</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="width: 120px">영문명</th>
											<th class="align-end pe-1" style="width: 40px;">
												<button class="btn btn-outline-danger btn-sm px-2 py-1 allDelBtn" type="button" style="font-size: 10px;">전체삭제</button>
											</th>
										</tr>
									</thead>
									<tbody id="sick-body">
										<!-- 상병검색 시작 -->
										<tr>
											<td class="p-0" colspan="7">
												<div class="search-box w-100" id="sawlSearchBox">
													<div class="" style="display: flex; justify-content: space-around;">
														<form class="position-relative" data-bs-toggle="search">
															<span class="fas fa-plus search-box-icon"></span>
															<input class="form-control form-control-sm py-0 mt-1 search-input sawlInput" type="search" placeholder="상병코드 및 상병명으로 검색" aria-label="Search" style="font-size: 12px; width: 300px; border: none; font-style: italic;"/>
													 	</form>
													 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
															<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
														</div>
											 		</div>
													<div class="dropdown-menu font-base overflow-hidden py-0 w-100" id="sawlDropMenu">
					    								<div id="sawlMenu" class="list scrollbar" style="height:100px;">
					    									<div class="d-flex align-items-center">
					    										<table class="table table-sm text-center table-hover pb-0 mb-0 w-100">
																	<tbody id="sawlTbody" class="list text-black">
																	</tbody>
																</table>
													        </div>
					    								</div>
					    							</div>
												</div>
											</td>
										</tr>
										<!-- 상병검색 끝 -->
									</tbody>
									<!-- 주상병 넣어주는 테이블 -->
									<tbody id='sawlInsertTable1' class="sawDelTable">
									</tbody>
									<!-- 부상병 넣어주는 테이블 -->
									<tbody id='sawlInsertTable2' class="sawDelTable">
									</tbody>
									<!-- 배제상병 넣어주는 테이블 -->
									<tbody id='sawlInsertTable3' class="sawDelTable">
									</tbody>
								</table>
							</div>
						</div>
						<!-- 상병테이블 끝 -->
						
					</div>
					
					
				</div>
			</div>
			<!-- 상병 끝 -->
				
			<!-- 처방 시작 -->
			<div class="">
				<div class="card mt-1" style="height: 350px;">
					
					<div class="card shadow-none">
					
						<div class="card-body p-0">
							<div class="row">
								<div class="col-4 d-flex pe-0" style="height: 30px;">
									<div class="">
										<div class="fw-semi-bold text-black ps-2 pt-1" style="font-size: 16px; min-width: max-content;">처방</div>
									</div>
									<button class="input-group-text pe-2" style="padding-right: 10px; padding-left: 10px; background: unset; border: initial" disabled="disabled"><i class="fas fa-search"></i></button>
								</div>
							</div>
							<div class="table mb-0 scrollbar" style="height: 170px;">
								<table class="table table-sm mb-0" style="font-size: small;">
									<thead class="bg-200">
										<tr>
											<th class="text-900 align-middle text-left" style="width: 55px;">약품코드</th>
											<th class="text-900 p-0 align-middle text-left" style="width: 120px;">약품명</th>
											<th class="text-900 p-0 align-middle text-left" style="width: 60px;">업체명</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="font-size: 12px; width: 50px;">투여경로</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="width: 50px; font-size: 12px;">투여량</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="width: 50px; font-size: 12px;">투여횟수</th>
											<th class="text-900 py-0 px-2 align-middle text-left" style="width: 50px; font-size: 12px;">투여기간</th>
											<th class="align-end text-end pe-2" style="width: 60px;">
												<button class="btn btn-outline-danger btn-sm px-2 py-1 allDelBtn" type="button" style="font-size: 10px;">전체삭제</button>
											</th>
										</tr>
									</thead>
									<tbody id="medicine-body">
										<!-- 처방 검색 시작 -->
										<tr>
											<td class="p-0" colspan="8">
												<div class="search-box w-100" id="mSearchBox">
													<div class="" style="display: flex; justify-content: space-around;">
														<form class="position-relative" data-bs-toggle="search">
																<span class="fas fa-plus search-box-icon"></span>
																<input class="form-control form-control-sm py-0 mt-1 search-input mInput" type="search" placeholder="약품코드 및 약품명으로 검색" aria-label="Search" style="font-size: 12px; width: 300px; border: none; font-style: italic;"/>
													 	</form>
													 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
															<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
														</div>
											 		</div>
													<div class="dropdown-menu font-base overflow-hidden py-0 w-100" id="mDropMenu">
					    								<div id="mMenu" class="list scrollbar" style="height:100px;">
					    									<div class="d-flex align-items-center">
					    										<table class="table table-sm table-hover pb-0 mb-0 w-100">
						    										<thead>
																		<tr style='font-size: 12px;'>
																			<th class='align-middle ps-4 text-left' style='width: 20px;'>약품코드</th>
																			<th class='align-start text-left' style='width: 120px;'>약품명</th>
																			<th class='align-start text-left' style='width: 70px;'>업체명</th>
																			<th class='align-start text-left' style='width: 50px;'>투여경로</th>
																			<th class='align-start text-left' style='width: 30px;'></th>
																		</tr>
																	</thead>
																	<tbody id="mTbody" class="list scrollbar text-black">
																	</tbody>
																</table>
													        </div>
					    								</div>
					    							</div>
												</div>
											</td>
										</tr>
										<!-- 처방 검색 끝 -->
									</tbody>
									<!-- 처방 삽입 t바디 -->
									<tbody id="mInsertTable">
									</tbody>
								</table>
							</div>
						</div>
						<!-- 처방 테이블 끝 -->
						
						<!-- 치료 테이블 시작 -->
						<div class="card-body p-0">
							<div class="row">
								<div class="col-12 d-flex align-items-center justify-content-end me-2">
									
								</div>
							</div>
							<div class="table mb-0 scrollbar" style="height: 150px;">
								<table class="table table-sm mb-0" style="font-size: small;">
									<thead class="bg-200">
										<tr>
											<th class="text-900 align-middle text-left" style="width: 60px;">치료코드</th>
											<th class="text-900 p-0 align-middle text-left" style="width: 60px;">구분</th>
											<th class="text-900 p-0 align-middle text-left" style="width: 100px;">치료명</th>
											<th class="text-900 py-0 px-2 align-middle text-left me-10" style="width: 60px;">급여</th>
											<th class="align-end text-end pe-2" style="width: 40px;">
												<button class="btn btn-outline-danger btn-sm px-2 py-1 allDelBtn" type="button" style="font-size: 10px;">전체삭제</button>
											</th>
										</tr>
									</thead>
									<tbody id="treat-body">
										<!-- 치료 검색 시작 -->
										<tr>
											<td class="p-0" colspan="8">
												<div class="search-box w-100" id="mtSearchBox">
													<div class="" style="display: flex; justify-content: space-around;">
														<form class="position-relative" data-bs-toggle="search">
																<span class="fas fa-plus search-box-icon"></span>
																<input class="form-control form-control-sm py-0 mt-1 search-input mtInput" type="search" placeholder="치료코드 및 치료명으로 검색" aria-label="Search" style="font-size: 12px; width: 300px; border: none; font-style: italic;"/>
													 	</form>
													 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
															<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
														</div>
											 		</div>
													<div class="dropdown-menu font-base overflow-hidden py-0 w-100" id="mtDropMenu">
					    								<div id="mtMenu" class="list scrollbar" style="height:100px;">
					    									<div class="d-flex">
					    										<table class="table table-sm table-hover pb-0 mb-0 w-100">
																	<tbody id="mtTbody" class="list text-black">
																	</tbody>
																</table>
													        </div>
					    								</div>
					    							</div>
												</div>
											</td>
										</tr>
										<!-- 치료 검색 끝 -->
									</tbody>
									<!-- 처방 삽입 t바디 -->
									<tbody id="mtInsertTable">
									</tbody>
								</table>
							</div>
						</div>
						<!-- 치료 테이블 끝 -->
						
					</div>
					
				</div>
			</div>
			<!-- 처방 끝 -->
			
			<!-- 진료등록 버튼 시작 -->
			<div class="row pt-1 pe-1" style="display: flex; justify-content: flex-end;">
				<div class="col-auto px-0" style="display: flex; justify-content: flex-end; align-items: center;">
					<div class="form-check mb-0">
						<input class="form-check-input" id="hsptlzAt" type="checkbox" value="Y" />
						<label class="form-check-label fw-semi-bold ms-1 mb-0 pointer" for="hsptlzAt">입원</label>
					</div>
				</div>
				<div class="col-auto">
					<button id="clnicInsertBtn" class="btn btn-sm text-white fw-semi-bold" type="button" style="background: midnightblue;">진료등록</button>
				</div>
			</div>
			<!-- 진료등록 버튼 끝 -->
			
		</div>
	</div>
	<!-- 진료작성 끝 -->		
	
	
	   <!--  -->
   <div class="col-2 px-2">
      <!-- 결과 시작 -->
      <div class="card border border-secondary mb-1" style="height: 300px;">
         <div class="card-header p-0" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
            <div class="row">
               <div class="" style="display: flex; flex-wrap: wrap;">
                  <div class="fw-semi-bold text-white text-center py-2 ps-2">검사결과</div>
               </div>
            </div>
         </div>
         
         <ul class="nav nav-tabs" id="hcTab" role="tablist">
            <li class="nav-item text-center col-6">
               <a class="nav-link active fw-semi-bold p-1" id="hcResult-tab" data-bs-toggle="tab" href="#tab-hcResult" role="tab" aria-controls="tab-hcResult" aria-selected="true">검사결과</a></li>
            <li class="nav-item text-center col-6">
               <a class="nav-link fw-semi-bold p-1" id="xray-tab" data-bs-toggle="tab" href="#tab-xray" role="tab" aria-controls="tab-xray" aria-selected="false">X-RAY</a>
            </li>
         </ul>
         
         <div class="card-body p-1 mt-1" id="hcTabContent">   
            <div class="tab-content">
               
               <!-- 검사결과 시작 -->
               <div class="tab-pane fade show active" id="tab-hcResult" role="tabpanel" aria-labelledby="hcResult-tab">
                  
                  <div class="table-responsive scrollbar" style="height: 200px;">
                     <table class="table mb-0" style="font-size: small;">
                        <thead class="bg-200">
                           <tr>
                              <th class="text-900 px-0 py-1 align-middle text-center" style="width: 60px;">검사코드</th>
                              <th class="text-900 px-0 py-1 align-middle text-center" style="width: 60px;">검사명</th>
                              <th class="text-900 px-0 py-1 align-middle text-center" style="width: 100px;">결과</th>
                           </tr>
                        </thead>
                        <tbody id="exam-result-body">
                        </tbody>
                     </table>
                  </div>
               </div>
               <!-- 검사결과 끝 -->
               
               <!-- X-RAY 시작 -->
               <div class="tab-pane fade" id="tab-xray" role="tabpanel" aria-labelledby="xray-tab">
                  
                  <div style="display: flex; justify-content: center;">
                     <ul class="nav nav-tabs ms-1" id="xrayResultTab" role="tablist" style="border: none;">
                        <!-- x-ray검사 결과 탭 -->
<!--                         <li class='nav-item text-center col-auto me-1'><a class='nav-link active fw-semi-bold py-0' id='0-tab' data-bs-toggle='tab' href='#tab-0' role='tab' aria-controls='tab-0'aria-selected='true' style='border-bottom: 10px solid; border-radius: 10px;'></a></li> -->
                        
                     </ul>
                  </div>
                  
                  <div class="card-body p-1 mt-1" id="">   
                     <div class="tab-content" id="xrayResultImage">
                        
                        <!-- 검사결과 시작 -->
<!--                         <div class='tab-pane fade show active' id='tab-0' role='tabpanel' aria-labelledby='0'><div style='display: flex; justify-content: center;'> <span class='arrows-fullscreen fs-5 text-white' onclick='openImg()'></span><img alt='' src='/resources/xray/b2471a08-88f7-4365-ae7a-c40998eb42d8_KakaoTalk_20231101_092544650.jpg' style='height: 185px;' onclick='openImg()'/></div></div> -->
                       
                     </div>
                  </div>
                  
               </div>
               <!-- X-RAY 끝 -->
            </div>
         </div>
      </div>
      <!-- 결과 끝 -->
   
      <!-- 그룹오더 시작 -->
      <div class="card border border-secondary mt-1" style="height: 500px;">
         <div class="card-header p-0" style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
            <div class="row">
               <div class="" style="display: flex; flex-wrap: wrap;">
                  <div class="fw-semi-bold text-white text-center py-2 ps-2">그룹오더</div>
               </div>
            </div>
         </div>
         
		<!-- 오더 등록 버튼 시작 -->
		<div class="p-1 align-items-end">
			<div class="row">
				<div class="col-6">
					<button id="orderAjaxBtn" class="btn btn-sm btn-primary py-1 px-1" style="background-color: midnightblue; border-color: midnightblue; font-size: 11px;">오더등록</button>
				</div>
				<div class="col-6"  style="display: flex; justify-content: flex-end;">
					<button id="insertGroupOrderBtn" class="btn btn-falcon-primary py-0 px-1 btn-sm" type="button">
						<span class="d-none d-sm-inline-block" data-bs-toggle="modal" data-bs-target="" style="color: midnightblue; font-size: 11px;"><span class="fas fa-plus me-1"></span>그룹오더 생성</span>
					</button>
				</div>
			</div>
		</div>
        <!-- 오더 등록 버튼 끝 -->
         
         <!-- 오더 시작 -->
         <div class="card-body px-1 pt-1">
	         <div class="p-0">
	            <ul class="mb-0 treeview treeview-slect" id="groupOrder" data-options='{"select":true}'>
	                <c:set value="${groupOrderList }" var="groupOrderList" />
	                <c:choose>
	                   <c:when test="${empty groupOrderList }">
	                   </c:when>
	                   <c:otherwise>
	                      <c:forEach items="${groupOrderList }" var="gList">
	                        <li class="treeview-list-item">
	                            <div class="toggle-container">
	                                <input class="form-check-input groupOrderCheckAll" type="checkbox" data-target="#${gList.groCd }"/>
                                    <div class="row">
	                                    <div class="col-auto pe-0">
			                                <a data-bs-toggle="collapse" href="#${gList.groCd }" role="button" aria-expanded="false">
												<p class="treeview-text">${gList.groNm }</p>
			                                </a>
	                                    </div>
	                                    <div class="col-auto p-0">
	                                    	<button value="${gList.groCd }" data-gronm="${gList.groNm }" class="updateGroupOrderBtn btn btn-falcon-primary py-0 px-1 btn-sm" style="box-shadow: none;" type="button">
												<span class="d-none d-sm-inline-block" data-bs-toggle="modal" data-bs-target="#new-groupOrder-modal" style="color: midnightblue; font-size: 10px;"><span class="fas fa-edit me-1"></span>수정</span>
											</button>
										</div>
									</div>
	                            </div>
	                            <c:set value="${groupOrderContentList }" var="groupOrderContentList" />
	                            <ul class="collapse treeview-list groupOrderList" id="${gList.groCd }" data-show="false">
	                            <c:forEach items="${groupOrderContentList }" var="gCList">
	                               <c:if test="${gCList.groCd eq gList.groCd}">
	                                   <li class="treeview-list-item">
	                                       <div class="treeview-item">
	                                           <input class="form-check-input groupOrderCheck" type="checkbox" id="${gCList.contentCd }" 
	                                           			data-groupContentNm="${gCList.contentNm }" 
	                                           			data-groupMedcinMfbiz="${gCList.medcinMfbiz }" 
	                                           			data-groupMdctnCours="${gCList.mdctnCours }" 
	                                           			data-groupMedcinPc="${gCList.medcinPc }" 
	                                           			data-groupMedcinStandard="${gCList.medcinStandard }" 
	                                           			data-groupMedcinUnit="${gCList.medcinUnit }" 
	                                           			/>
	                                           <a class="flex-1" href="#!">
	                                               <p class="treeview-text"><span class="me-2 fas fas fa-pills" style="color: midnight;" id="${gCList.contentCd }"></span>${gCList.contentNm }</p>
	                                           </a>
	                                       </div>
	                                   </li>
	                               </c:if>
	                             </c:forEach>
	                            </ul>
	                        </li>
	                      </c:forEach>
	                   </c:otherwise>
	                </c:choose>
	            </ul>
	         </div>
	      </div>
	      <!-- 오더 끝 -->
         
      </div>
	</div>
</div>
<!-- 의사 진료 끝 -->

<!-- 제증명 진단서 모달 시작 -->
<div class="modal fade" id="certificates-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1 modalOthersBtn">
				<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="p-4 modalContent">
					<div id="diagnosisForm" style="display: none;">
						<%@ include file="../common/diagnosisForm.jsp"%>
					</div>
					<div id="mtcForm" style="display: none;">
						<%@ include file="../common/mtcForm.jsp"%>
					</div>
					<div id="prescriptionForm" style="display: none;">
						<%@ include file="../common/prescriptionForm.jsp"%>
					</div>
					<div class="col-md-12 hcBtn" style="display: none;">
						<div align="right">
							<button class="btn" type="reset" id="resetBtn">초기화</button>
							<button data-bs-dismiss="modal" class="btn btn-primary modalOthersBtn" id="certificatesInsertBtn">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 제증명 진단서 모달 끝 -->

<!-- 그룹오더 등록 모달 시작 -->
<div class="modal fade" id="new-groupOrder-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content border-0">
			<div class="position-absolute top-0 end-0 mt-2 me-3 z-1">
				<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue;">
					<h4 class="fw-semi-bold text-white p-0 m-0" id="textSchedulerTitle">그룹오더 생성</h4>
				</div>
				<div class="p-4">
					<input type="hidden" value="F" id="updateGroupOrderFlag"/>
					<div class="row pt-2">
						<div class="col-12">
							<div class="input-group">
								<span class="input-group-text">그룹오더명</span>
								<input class="form-control" type="text" id="groNm" name="groNm"/>
							</div>
						</div>
					</div>
					<hr/>
					<div class="col-md-12">
							<div class="table-responsive scrollbar" style="height: 300px;">
							<table class="table table-sm mb-0" style="font-size: small;">
								<thead class="bg-200">
									<tr>
										<th class="text-900 align-middle text-left" style="width: 70px;">약품코드</th>
										<th class="text-900 p-0 align-middle text-left" style="width: 120px;">약품명</th>
										<th class="text-900 p-0 align-middle text-center" style="width: 60px;">업체명</th>
										<th class="text-900 py-0 align-middle text-left" style="font-size: 12px; min-width: 10px; width: 50px;">투여경로</th>
										<th class='align-start text-left me-0' style='width: 10px;'></th>
									</tr>
								</thead>
								<tbody id="medicine-body">
									<!-- 그룹오더 처방 검색 시작 -->
									<tr>
										<td class="p-0" colspan="8">
											<div class="search-box w-100" id="groupSearchBox">
												<div class="" style="display: flex; justify-content: space-around;">
													<span class="fas fa-plus search-box-icon"></span>
													<input class="form-control form-control-sm py-0 mt-1 search-input groupInput" type="search" placeholder="약품코드 및 약품명으로 검색" aria-label="Search" style="font-size: 12px; width: 300px; border: none; font-style: italic;"/>
												 	<div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
														<button class="btn btn-link btn-close-falcon p-0" type="button" id="groupCloseBtn" aria-label="Close"></button>
													</div>
										 		</div>
												<div class="dropdown-menu font-base overflow-hidden py-0 w-100" id="groupDropMenu">
				    								<div id="groupMenu" class="list">
				    									<div class="d-flex align-items-center">
				    										<table class="table table-sm table-hover pb-0 mb-0 w-100">
																<tbody id="groupTbody" class="list text-black">
																</tbody>
															</table>
												        </div>
				    								</div>
				    							</div>
											</div>
										</td>
									</tr>
									<!-- 그룹오더 처방 검색 끝 -->
								</tbody>
								<tbody id="groupInsertTable">
								</tbody>
							</table>
						</div>							
					</div>
					<div class="col-md-12">
						<div align="right">
							<button class="btn btn-primary btn-sm" type="button" id="insertGroupBtn" style="background-color: midnightblue; border-color: midnightblue;">등록</button>
							<button class="btn btn-primary btn-sm" type="button" id="updateGroupBtn" style="display: none; background-color: midnightblue; border-color: midnightblue;">수정</button>
							<button class="btn btn-danger btn-sm" type="button" id="deleteGroupBtn" style="display: none;">삭제</button>
							<button class="btn btn-secondary btn-sm" type="button" data-bs-dismiss="modal" id="closeGroupBtn">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  그룹오더 등록 모달 끝 -->

<!-- x-ray 모달창 -->
<!-- <div class="modal fade" id="xrayModal" tabindex="-1" role="dialog" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-dialog-centered" role="document" style="width: 700; max-width: 700px"> -->
<!-- 		<div class="modal-content position-relative"> -->
<!-- 			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1"> -->
<!-- 				<button -->
<!-- 					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" -->
<!-- 					data-bs-dismiss="modal" aria-label="Close"> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body p-0"> -->
<!-- 				<div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue"> -->
<!-- 					<h4 class="mb-1 text-white" id="modalExampleDemoLabel">X-Ray 결과</h4> -->
<!-- 				</div> -->
<!-- 				<div class="p-4 pb-0" id="xrayResult"> -->
					
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button class="btn btn-primary" id="updateBtn" type="button">수정</button> -->
<!-- 				<button class="btn btn-primary" id="deleteBtn" type="button">삭제</button> -->
<!-- 				<button class="btn btn-secondary" type="button" -->
<!-- 					data-bs-dismiss="modal">닫기</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<!-- 이미지 모달창 시작 -->
<div class="modal fade" id="xrayModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 700px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
				<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue;">
					<h4 class="mb-1 text-white font-semi-bold" id="">X-RAY</h4>
				</div>
				<div class="p-3">
					<div class="py-2" style="display: flex; justify-content: center;">
						<ul class="nav nav-tabs ms-1" id="xrayUlTab" role="tablist" style="border: none;">
							<!-- 여길 FOR문 돌려서 a태그 id값이랑 href속성, aria-controls 이 세개를 맞춰줘야한다. -->
						</ul>
					</div>
					
					<div class="card-body p-3" id="">	
						<div class="tab-content " id="xrayDivTab" >
							<!-- 여기도 for문 돌려서 위의 li 값이랑 맞춰야 됨 -->
							<!-- for문 여기까지 -->
						</div>
<!-- 						<div> -->
<!-- 							<button class="btn btn-primary" id="drawBtn">그림그리기</button> -->
<!-- 							<button class="btn btn-danger" id="eraseBtn">지우개</button> -->
<!-- 							<input type="range" id="canvasRange" min="0.1" max="20.0" step="0.1"> -->
<!-- 						</div>						 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 이미지 모달창 끝 -->
</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

// 진료메모 열기
$(function(){
	$("#clinicMemoBtn").on('click',function(){
		
	});
});

// 전화번호 형식 함수
function getTelFormat(tel){
	var tel1 = tel.substring(0,3);
	var tel3 = tel.substring(tel.length - 4);
	var tel2 = tel.substring(3, tel.length - 4);
	var telFormat = tel1 + "-" + tel2 + "-" + tel3;
	return telFormat;
}

//날짜 형식화(.)
function formatDate3(date){
	var year = date.getFullYear().toString().substring(0, 4);
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

// 진단서 날짜 형식화
function cdFormatDate(date){
	var year = date.getFullYear().toString().substring(0, 4);
	var month = String(date.getMonth() + 1).padStart(2, '0');
	var day = String(date.getDate()).padStart(2, '0');
	
	return year + "년 " + month + "월 " + day + "일";
}

function formatDateNoTime(timeStamp){
    var date = new Date(timeStamp);
    
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 문자열로 변환하여 두 자리로 만듭니다.
    var day = date.getDate().toString().padStart(2, '0'); // 일도 마찬가지로 두 자리로 만듭니다.
    
    var formattedDate = year + '년 ' + month + '월 ' + day + "일";
    
    return formattedDate;
}

//진료대기 환자 리스트
$(function(){
	setInterval(updateList, 5000);
	updateList();
	
	function updateList(){
		$.ajax({
			type: "post",
			url: "/mediform/doctor/room/list",
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	        	 xhr.setRequestHeader(header,token);
	        },
	        success : function(data){
				var waitingList = "";
				var doneList = "";
				
	        	$.each(data, function(index, item) {
	        		var rceptNo = item.rceptVO.rceptNo;						// 접수번호
					var statusNo = item.rceptVO.rceptSttus;					// 상태 번호(번호로 필요)
	        		var status = item.rceptVO.rceptSttus;					// 상태
					var rceptClnicAt = item.rceptVO.rceptClnicAt; 			// 진료여부
					var name = item.patientVO.patntNm;					// 환자명
		        	var hlthinsAt = item.patientVO.patntHlthinsAt;		// 건강보험
		        	if(hlthinsAt == "Y"){
		        		hlthinsAt = "보험 O";
					}else{
						hlthinsAt = "보험 X";
					}
					var hsptlzAt = item.patientVO.patntHsptlzAt;
					
					var time = new Date(item.rceptVO.rceptDt);			// 접수 일시
					var hour = time.getHours().toString().padStart(2,'0');
					var minute = time.getMinutes().toString().padStart(2,'0');
					var rcepttime = hour + ":" + minute; 	
					
					var no = item.rceptVO.patntNo;					// 환자 번호
					var birthDay = item.patientVO.patntRrno1.toString()	// 생년월일
					var birth = birthDay.substring(0,2) + "." + birthDay.substring(2,4) + "." + birthDay.substring(4,6);	// 생년월일
					var age = item.patientVO.patntAge;					// 나이
					var gender = item.patientVO.patntSexdstn;			// 성별
					if(gender == "M"){
						gender = "남";
					}else{
						gender = "여";
					}
					var memo = item.rceptVO.rceptReason;				// 내원 이유
					if(memo == null || memo == ""){
						memo = "메모 사항이 없습니다.";
					}
					
					var itemList = "";
					
					if(rceptClnicAt == 'N' && (status == "0" | status == "1" | status == "2" || status == "3" || status == "4")){
		        	
						if(status == "0"){
							status = "진료대기";
							color = "primary";
						}else if(status == "1"){
							status = "진료중";
							color = "success";
						}else if(status == "2"){
							status = "검사대기";
							color = "warning";
						}else if(status == "3"){
							status = "검사중";
							color = "warning";
						}else if(status == "4"){
							status = "검사완료";
							color = "warning";
						}
						
						var rceptPriortBadge = "";
						if(item.rceptVO.rceptPriort == '1'){
							rceptPriortBadge = '<span class="badge badge rounded-pill ms-1 badge-subtle-primary">예약</span>';
						}
						
						itemList += "<div id='" + no + "' class='noFormat patientWaitingList bg-white dark__bg-1100 d-md-flex d-xl-inline-block d-xxl-flex align-items-center p-3 rounded-3 shadow-sm card-view-height gap-1'>";
						itemList += "<div class='d-flex align-items-start align-items-sm-center'>";
						itemList += "<div class='row align-items-center gx-0 gy-2'>";
						itemList += "<div class='col-auto'>";
						itemList += "<div class='row'>";
						itemList += "<div class='col-7'>";
						itemList += "<span class='fas fa-user' data-fa-transform='shrink-3 up-1'></span>";
						itemList += "<span style='font-weight: bold;'>" + name + "</span>";
						itemList += rceptPriortBadge;
						itemList += "</div>";
						itemList += "<div class='col-5' style='padding-right: 10px; display: flex; justify-content: flex-end;'>";
						itemList += "<button class='btn btn-sm btn-outline-" + color + " callbutton' style='padding-right:5px; padding-left:5px; font-size: x-small;' value='" + rceptNo + "' data-statusno='"+statusNo+"'>" + status +"</button>";
						itemList += "</div>";
						itemList += "</div>";
						itemList += "<div class='row' style='font-size: small;'>";
						itemList += "<span class='clickPatntNo'>" + no + " | " + hlthinsAt + " | " + rcepttime + "</span><br/>";
						itemList += "<span>" + birth + " | 만 " + age + "세 | " + gender + "</span>";
						itemList += "</div>";
						itemList += "</div>";
						itemList += "<hr style='margin-bottom: 0px;'/>";
						itemList += "<div class='col-auto'>";
						itemList += "<h6 class='mb-0 text-500 pt-0'>" + memo + "</h6>";
						itemList += "</div>";
						itemList += "</div>";
						itemList += "</div>";
						itemList += "</div>";
							
						waitingList += itemList;
						
						
						// 진료중인데 #rceptNo에 값이 없을 때
        				if(status == "진료중" && ($("#rceptNo").val() == null || $("#rceptNo").val() == "")){
        					
        					// 상세정보 채워주는 기능
        					clickCallBtn(no, rceptNo, 1);
        					watingCallBtn = false;
        				}
					}else if((status == 9 || status == 2 || status == 3 || status == 4 || status == 5 || status == 6 || status == 7 || status == 8 || status == 10) && rceptClnicAt == "Y"){
						status = "진료완료";
						color = "dark";
						
						itemList += "<div id='" + no + "' class='noFormat patientWaitingList bg-white dark__bg-1100 d-md-flex d-xl-inline-block d-xxl-flex align-items-center p-3 rounded-3 shadow-sm card-view-height gap-1'>";
						itemList += "<div class='d-flex align-items-start align-items-sm-center'>";
						itemList += "<div class='row align-items-center gx-0 gy-2'>";
						
						itemList += "<div class='col-auto'>";
						
						itemList += "<div class='row'>";
						
						itemList += "<div class='col-7'>";
						itemList += "<span class='fas fa-user' data-fa-transform='shrink-3 up-1'></span>";
						itemList += "<span style='font-weight: bold;'>" + name + "</span>";
						itemList += "</div>";
						itemList += "<div class='col-5' style='padding-right: 10px; display: flex; justify-content: flex-end;'>";
						itemList += "<button class='btn btn-sm btn-outline-" + color + " callbutton' style='padding-right:5px; padding-left:5px; font-size: x-small;' value='" + rceptNo + "'>" + status +"</button>";
						itemList += "</div>";
						
						itemList += "</div>";
						
						itemList += "<div class='row' style='font-size: small;'>";
						itemList += "<span class='clickPatntNo'>" + no + " | " + hlthinsAt + " | " + rcepttime + "</span><br/>";
						itemList += "<span>" + birth + " | 만 " + age + "세 | " + gender + "</span>";
						itemList += "</div>";
						
						itemList += "</div>";
						
						itemList += "<hr style='margin-bottom: 0px;'/>";
						itemList += "<div class='col-auto'>";
						itemList += "<h6 class='mb-0 text-500 pt-0'>" + memo + "</h6>";
						itemList += "</div>";
						
						itemList += "</div>";
						itemList += "</div>";
						itemList += "</div>";
						
						doneList += itemList;
					}
					
	        	});
				$("#waitingList").empty().append(waitingList);
        	 	$("#doneClinicList").empty().append(doneList);
        	 	
	        },
	        error: function(){
	        	alert("서버오류! 다시 시도해주세요.");
	        }
		});
		
	}


	var thisText = "";
	
	// 진료대기 때 호출 hover
	$(document).on('mouseover', '.callbutton', function() {
		thisText = $(this).text();
		if(thisText == '진료대기' || thisText == '검사완료'){
			$(this).text("호출");
			$(this).css({"font-weight": "bold", "font-size": "x-small"});
		}
	}).on('mouseout', '.callbutton', function() {
		if($(this).text() == '호출'){
			$(this).text(thisText);
			$(this).css({"font-weight": "normal", "font-size": "x-small"});
		}
	});
	
//=== 환자 정보 불러오기 시작 ============================================================================	
	// 호출 중복 방지(호출하면 false로 바뀌고 진료 등록 완료 혹은 검사오더가 완료되면 true로 바뀜)
	var watingCallBtn = true;
	//호출 버튼 클릭시 상세정보(진료대기 호출) (1번 실행)
	$(document).on("click", ".callbutton", function(){
		var callBtn = $(".callbutton");
		callBtn.each(function(i, item){
			if($(this).data("statusno") === 1){
				Swal.fire({
				      icon: 'error',
					  title:'호출',
				      text: '이미 진행중인 진료가 있습니다.',
				      confirmButtonColor: 'blue'
				    });
				watingCallBtn = false;
				return;
			}else{
				
				if(watingCallBtn){
					
					// 진료등록 부분에 값이 있는 지 확인 후 진행(진단내역, 상병, 검사, 치료, 처방)
					var clnicCn = $("#clnicCn").val(); // 진단내역
					var sawlInsertTable1 = $(".sawlInsertTable1").find("tr"); // 주상병
					var sawlInsertTable2 = $(".sawlInsertTable2").find("tr"); // 부상병
					var sawlInsertTable3 = $(".sawlInsertTable3").find("tr"); // 배제된상병
					var hcInsertTable = $(".hcInsertTable").find("tr"); // 검사 오더
					var mtInsertTable = $(".mtInsertTable").find("tr"); // 치료 오더
					var mInsertTable = $(".mInsertTable").find("tr"); // 처방 오더
					// 접수 상태 가져오기
					var statusNo = $(this).data("statusno");
					// 환자번호 가져오기
					var patntNo = $(this).closest(".noFormat").attr("id");
					// 접수번호 가져오기
					var rceptNo = $(this).val();
					if($(this).text() === "호출"){
						if(clnicCn !== null && clnicCn !== "" && clnicCn !== undefined || sawlInsertTable1.length > 0 || sawlInsertTable1.length > 0 || sawlInsertTable2.length > 0 || sawlInsertTable3.length > 0 
								|| hcInsertTable.length > 0 || mtInsertTable.length > 0 || mInsertTable.length > 0 ){
							Swal.fire({
					            icon: 'warning',
					            title: '진료호출',
					            text: '현재 작성중인 진료는 삭제됩니다. 그래도 호출 하시겠습니까?',
					            showCancelButton: true,
					            confirmButtonText: '확인',
					            cancelButtonText: '취소',
					            confirmButtonColor: 'midnightblue',
					            cancelButtonColor: 'red', // cancel 버튼 색깔 지정
					          }).then(result => {
					             if(result.isConfirmed){
					            	clickCallBtn(patntNo, rceptNo, statusNo);
					                
					             }else{
					            	 return;
					             }
					          });
						}else{
							clickCallBtn(patntNo, rceptNo, statusNo);
						}
					
					}
				}
			}
		});
	});
	
	//호출 버튼 클릭시 상세정보 호출(호출 버튼 클릭 안에 쓰임)(2번 실행)
	function clickCallBtn(patntNo, rceptNo, statusNo){
		radioNo1 = 0;
		radioNo2 = radioNo1+1;
		radioNo3 = radioNo2+1;
		idNo = 1;
		number = 1;
		// 호출 (진료대기일 경우)
		if(statusNo == 0){
			// 환자 상세 정보 값 초기화
			cleanPatientInfo();
			// 환자 진료 등록 값 초기화
			cleanClinicInfo();
			// 진료 시작 시간 세팅
			var clnicStartTime = new Date();
 			var clnicStartTimeFormat = moment(clnicStartTime).format('YYYY년 MM월 DD일 HH:mm');
 			$("#clnicTimeInput").val(clnicStartTimeFormat);
			// 접수 번호 세팅
			$("#rceptNo").val(rceptNo);
			// 환자 정보 테이블에 값 넣기(patntNo 사용)
			callBtnSelectPatient(patntNo);
			// 선택된 환자 바이탈 정보 가져오기(patntNo 사용)
			callBtnSelectPatientVital(patntNo);
			// 선택된 환자 진료 기록 날짜 가져오기(patntNo 사용)
			selectClnicTime(patntNo);
			// 환자 상태 변경(진료중)
			statusUpadate(rceptNo, 1);
			
		// 호출 (검사완료일 경우)
		}else if(statusNo == 4){
			// 환자 상세 정보 값 초기화
			cleanPatientInfo();
			// 환자 진료 등록 값 초기화
			cleanClinicInfo();
			// 접수 번호 세팅
			$("#rceptNo").val(rceptNo);
			// 환자 정보 테이블에 값 넣기(patntNo 사용)
			callBtnSelectPatient(patntNo);
			// 선택된 환자 바이탈 정보 가져오기(patntNo 사용)
			callBtnSelectPatientVital(patntNo);
			// 선택된 환자 진료 기록 날짜 가져오기(patntNo 사용)
			// (날짜 가져오면서 값 뿌리는 함수도 연결되어 있다.)
			// x-ray 결과 가져오기도 포함 (검사완료 환자만)
			selectClnicTime(patntNo);
			// 검사 결과 가져오기(검사 완료 환자만)
			selectMEOResult(patntNo, rceptNo);
			// 환자 상태 변경(진료중)
			statusUpadate(rceptNo, 1);
			// 진료 작성에 이전 값 다시 세팅
		
		// 호출하고 페이지를 나갔다가 다시 왔을 때
		}else if(statusNo == 1){
			// 환자 상세 정보 값 초기화
			cleanPatientInfo();
			// 환자 진료 등록 값 초기화
			cleanClinicInfo();
			// 접수 번호 세팅
			$("#rceptNo").val(rceptNo);
			// 환자 정보 테이블에 값 넣기(patntNo 사용)
			callBtnSelectPatient(patntNo);
			// 선택된 환자 바이탈 정보 가져오기(patntNo 사용)
			callBtnSelectPatientVital(patntNo);
			// 선택된 환자 진료 기록 날짜 가져오기(patntNo 사용)
			selectClnicTime(patntNo);
		}
	}
	
	// x-ray 검사 결과
	function selectXrayResult(clnicNo, clnicPatntAt){

		var clnicNo = {
				"clnicNo" : clnicNo
			};
		
		
		$.ajax({
			type : "post",
			url  : "/mediform/doctor/MedicalExaminationOrder/select/xray",
			data : JSON.stringify(clnicNo),
			contentType : "application/json; charset=utf-8",
		    beforeSend : function(xhr){
		        //ajax호출 중 처리
		        //글로벌 변수로 설정한 csrf token 셋팅
		        xhr.setRequestHeader(header,token);
		    },
			success : function(res){
				// 검사 재호출일 때
				if(clnicPatntAt == "Y"){
					if(res.length == 0){ // 검사 결과가 없을때
						
						var xrayResultHtml = "<tr><td>등록된 검사가 없습니다.</td></tr>";
							
					}else{
						// 검사 결과가 있을 때
						
						var xrayResultHtml = "";
						// div에 들어갈 html
						var xrayDivResultHtml = "";
						// 엑스레이 제일 먼저 보일 화면(true, false / 첫화면은 true, 두번째부터 false)
						
						var active = "active";
						var ariaSelect = "true";
						
						////////////////////////////////////////xray버튼수정필요//////////////
						for(var i = 0; i < res.length; i++){
							if(i > 0){
								active = "";
								ariaSelect = "false";
							}
							xrayResultHtml += "<li class='nav-item text-center col-auto me-3' style='width: 40px;'>";
							xrayResultHtml += "<a class='nav-link "+active+" fw-semi-bold py-0' id='xray"+i+"b' data-bs-toggle='tab' href='#tab-xray"+i+"b' role='tab' aria-controls='tab-xray"+i+"b'";
							xrayResultHtml += "aria-selected='"+ariaASelect+"' style='border-bottom: 10px solid; border-radius: 10px;'></a>";
							xrayResultHtml += "</li>";
						}
						$("#xrayResultTab").html(xrayResultHtml);
						
						
						var showActive = "show active";
						
						for(var j = 0; j < res.length; j++){
							if(j > 0){
								showActive = "";
							}
							xrayDivResultHtml += "<div class='tab-pane fade "+showActive+"' id='tab-xray"+j+"b' role='tabpanel' aria-labelledby='b"+j+"xray-tab'>";
							xrayDivResultHtml += "<div style='display: flex; justify-content: center;'>";
							xrayDivResultHtml += "<img class='xrayImages pointer' data-fileflpth='"+res[j].fileFlpth+"' alt='' src='"+res[j].fileFlpth+"' style='height: 185px;'/>";
							xrayDivResultHtml += "</div></div>";
						}
						
						$("#xrayResultImage").html(xrayDivResultHtml);
						
						ariaSelect = "true";	
						active = "active";
						
						
					}
					
				// 검사 완료된 사람
				}else{
					if(res.length == 0){ // 검사 결과가 없을때
						
							
					}else{
						
						// 검사 결과가 있을 때
						// ui에 들어갈 html
						var xrayAResultHtml = "";
						// div에 들어갈 html
						var xrayADivResultHtml = "";
						// 엑스레이 제일 먼저 보일 화면(true, false / 첫화면은 true, 두번째부터 false)
						var active = "active";
						var ariaASelect = "true";
						
							
						for(var i = 0; i < res.length; i++){
							if(i > 0){
								active = "";
								ariaSelect = "false";
							}
							xrayAResultHtml += "<li class='nav-item text-center col-auto me-3' style='width: 60px;'>";
							xrayAResultHtml += "<a class='nav-link "+active+" fw-semi-bold py-0' id='xray"+i+"a' data-bs-toggle='tab' href='#tab-xray"+i+"a' role='tab' aria-controls='tab-xray"+i+"a'";
							xrayAResultHtml += "aria-selected='"+ariaASelect+"' style='border-bottom: 20px solid; border-radius: 10px;'></a>";
							xrayAResultHtml += "</li>";
						}
						$("#xrayUlTab").html(xrayAResultHtml);
						
						
						var showActive = "show active";
						
						for(var j = 0; j < res.length; j++){
							if(j > 0){
								showActive = "";
							}
							xrayADivResultHtml += "<div class='tab-pane fade "+showActive+"' id='tab-xray"+j+"a' role='tabpanel' aria-labelledby='a"+j+"xray-tab'>";
							xrayADivResultHtml += "<div style='display: flex; justify-content: center;'>";
							xrayADivResultHtml += "<img alt='' src='"+res[j].fileFlpth+"' style='width: 480px; height: 600px;'/>";
							xrayADivResultHtml += "</div></div>";
						}
						
						$("#xrayDivTab").html(xrayADivResultHtml);
						
						ariaASelect = "true";	
						active = "active";
							
					}
				}
				
			},
			error : function(err){
			}
		});
	}
	
	// 검사 결과
	function selectMEOResult(patntNo, rceptNo){
		var patientObj = {
			"patntNo" : patntNo,
			"rceptNo" : rceptNo
		};
		
		$.ajax({
			type : "post",
			url  : "/mediform/doctor/MedicalExaminationOrder/select",
			data : JSON.stringify(patientObj),
			contentType : "application/json; charset=utf-8",
		    beforeSend : function(xhr){
		        //ajax호출 중 처리
		        //글로벌 변수로 설정한 csrf token 셋팅
		        xhr.setRequestHeader(header,token);
		    },
			success : function(res){
				$('#exam-result-body').empty();
				if(res.length == 0){ // 검사 결과가 없을때
					
					var meoResultHtml = "<tr class='oneBoard'>";
					meoResultHtml += '<td class="text-center" colspan="5" onclick="event.cancelBubble=true;">검사 내역이 없습니다.</td>';
					meoResultHtml += '</tr>';
					
					$('#exam-result-body').append(meoResultHtml);
						
				}else{
					var meoResultHtml = "";
					$(res).each(function(){
						if(this.hlthchkpCd != "HC003"){
						
							// 검사 결과가 있을 때
							meoResultHtml += "<tr class='' id=''>";					
							meoResultHtml += "<td class='align-middle px-0 py-1 text-center' style='vertical-align: middle' data-mdlrtamount='"+this.mdlrtAmount+"' data-mllwncat='"+this.mllwncAt+"'>" + this.hlthchkpCd + "</td>";
							meoResultHtml += "<td class='align-middle px-0 py-1 text-center' style='width: 35px;'>" + this.hlthchkpNm + "</td>";
							meoResultHtml += "<td class='align-middle text-center px-0 py-1 meoResult' style='max-width: 40px;'>" + this.hlthchkpResult + "</td>";
							meoResultHtml += "</tr>";
						}
						
						
					});
					$('#exam-result-body').append(meoResultHtml);
				}
			},
			error : function(err){
			}
		});
		
	}
///////////////////////////검사완료 호출 시작///////////////////////////
	// 검사 완료 호출 시 진료 작성 값 다시 넣어주기
	function clinicRecall(clnicTime, clnicNo, empNm, atfssDt, clnicCn, clnicMemo,
			sckwndSe, kcd, sckwndKr, sckwndEn, msick,
			mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl,
			medcinCd, prscrptnNm, medcinMfbiz, mdctnCoursUsage, mdctnCpcty, mdctnUnit, mdctnCo, mdctnPd, medcinPc, medcinStandard){
		// 진료 번호 값 넣기
		if(clnicNo !== null && clnicNo !== ""){
			$("#clnicNo").val(clnicNo);
			$("#clnicNo").data("recall", "Y");
		}else{
		}
		// 진료 시간에 값 넣기
		if(clnicTime != null && clnicTime != ""){
			var clnicStartTimeFormat = moment(clnicTime).format('YYYY년 MM월 DD일 HH:mm');
			$("#clnicTimeInput").val(clnicStartTimeFormat);
		}
		// 발병일에 값 넣기
		if(atfssDt != null && atfssDt != ""){
			$("#atfssDt").val(atfssDt);
		}
		// 진단 내역에 값 넣기
		if(clnicCn != null && clnicCn != ""){
			$("#clnicCn").val(clnicCn);
		}
		
		// 검사는 결과테이블에 값 넣기 때문에 여기서 안 씀
		
		// 상병 테이블에 값 세팅
		if(kcd.length > 0){
			for(var i = 0; i < kcd.length; i++){
				selectSAWLAjax(kcd[i], sckwndKr[i], sckwndEn[i], msick[i], sckwndSe[i]);		
			}
		}
		
		// 치료 테이블에 값 세팅
		if(mdlrtCd.length > 0){
			for(var i = 0; i < mdlrtCd.length; i++){
				selectMTAjax(mdlrtCd[i], mdlrtNm[i], mllwncAt[i], mdlrtAmount[i], mdlrtCl[i]);
			}
		}
		// 처방 테이블에 값 세팅
		if(medcinCd.length > 0){
			for(var i = 0; i < medcinCd.length; i++){
				selectMAjax(medcinCd[i], prscrptnNm[i], medcinMfbiz[i], mdctnCoursUsage[i], mdctnUnit[i], medcinPc[i], medcinStandard[i]);
				if(mdctnCpcty[i] != null && mdctnCpcty[i] != "" && mdctnCpcty[i] > 0){
					$(".mdctnCpctyInput:eq('"+i+"')").val(mdctnCpcty[i]);
				}
				if(mdctnCo[i] != null && mdctnCo[i] != "" && mdctnCo[i] > 0){
					$(".mdctnCoInput:eq('"+i+"')").val(mdctnCo[i]);
				}
				if(mdctnPd[i] != null && mdctnPd[i] != "" && mdctnPd[i] > 0){
					$(".mdctnPdInput:eq('"+i+"')").val(mdctnPd[i]);
				}
			}
		}
		
	}
///////////////////////////검사완료 호출 끝///////////////////////////		

		// 검사완료 호출일 때 사용(pastClinic 안에서 사용)
		//검사완료 환자를 호출할 경우 테이블에 다시 값을 넣어줘야 하는데 오더 테이블만으로는 역부족...
		function selectPastTable(clnicTime, clnicNo, empNm, atfssDt, clnicCn, clnicMemo,
				sckwndSe, kcd, sckwndKr, sckwndEn){
			sawObj = {
				"sckwndSeList" : sckwndSe,
				"kcdList" : kcd,
				"sckwndKrList" : sckwndKr,
				"sckwndEnList" : sckwndEn
			}
			
			clinicVO = {
				"clnicNo" : clnicNo,
				"sickAndWoundedVO" : sawObj
			}
			
			
			$.ajax({
				type : "post",
				url  : "/mediform/doctor/clinic/select/pastTable",
				data : JSON.stringify(clinicVO),
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr){
				//ajax호출 중 처리
				//글로벌 변수로 설정한 csrf token 셋팅
				xhr.setRequestHeader(header,token);
				},
				success : function(res){
					
					// 상병
					var msick = [];
					var msickArr = res.sickAndWoundedVO.msick;
						$(msickArr).each(function(i, item){
							if(msickArr.length > 0){
								msick.push(item);
							}
						});
					// 치료
					var mdlrtNm = [];
					var mllwncAt = [];
					var mdlrtAmount = [];
					var mdlrtCl = [];
					var mdlrtCd = [];
					$(res.selectMedicalTreatmentRecordVOList).each(function(){
						if(this.mdlrtNm != null && this.mdlrtNm != ""){
							mdlrtCd.push(this.mdlrtCd);
							mdlrtNm.push(this.mdlrtNm);
							mllwncAt.push(this.mllwncAt);
							mdlrtAmount.push(this.mdlrtAmount);
							mdlrtCl.push(this.mdlrtCl);
							
						}
					});
					
					//처방
					var medcinCd = [];
					var prscrptnNm = [];
					var medcinMfbiz = [];
					var mdctnCoursUsage = [];
					var mdctnCpcty = [];
					var mdctnUnit = [];
					var mdctnCo = [];
					var mdctnPd = [];
					var medcinPc = [];
					var medcinStandard = [];
					$(res.prescriptionOrderVOList).each(function(){
						if(this.medcinMfbiz != null && this.medcinMfbiz != ""){
							medcinCd.push(this.medcinCd);
							prscrptnNm.push(this.prscrptnNm);
							medcinMfbiz.push(this.medcinMfbiz);
							mdctnCoursUsage.push(this.mdctnCoursUsage);
							mdctnCpcty.push(this.mdctnCpcty);
							mdctnUnit.push(this.mdctnUnit);
							mdctnCo.push(this.mdctnCo);
							mdctnPd.push(this.mdctnPd);
							medcinPc.push(this.medcinPc);
							medcinStandard.push(this.medcinStandard);
						}						
						
					});
					
					clinicRecall(clnicTime, clnicNo, empNm, atfssDt, clnicCn, clnicMemo,
							sckwndSe, kcd, sckwndKr, sckwndEn, msick,
							mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl,
							medcinCd, prscrptnNm, medcinMfbiz, mdctnCoursUsage, mdctnCpcty, mdctnUnit, mdctnCo, mdctnPd, medcinPc, medcinStandard);
				// clinicRecall 불러서 값 넣어주기(아니면 여기서 바로 테이블에 값 넣어줘도 될듯???)
				},
					error : function(err){
				}
			});
	}
	
	
	// 진료 날짜 선택시 진료 상세에 값 넣기
	function pastClinicData(clnicTime, clnicNo, empNm, atfssDt, clnicCn, sckwndSe, kcd, sckwndKr, 
							mdlrtCd, mdlrtNm, mdlrtCurer, hlthchkpCd, hlthchkpNm, hlthchkpResult, medcinCd,
							prscrptnNm, mdctnCpcty, mdctnUnit, mdctnCo, mdctnPd, mdctnCoursUsage, clnicMemo){
		// 진료 시간
		
		var clnicTimeFormat = "";
		if(clnicTime == null || clnicTime == ""){
			clnicTimeFormat = "진료 시간이 없습니다.";
      	}else{
      		var date = new Date(clnicTime);
      		var day = formatDate3(date);
      		var time = formatTime(date);
      		clnicTimeFormat = day + " " + time;
      	}
      	$("#pastClnicTime").text(clnicTimeFormat);
      	// 진료 번호
      	$("#pastClnicNo").text(clnicNo);
      	// 담당의
      	$("#pastEmpNm").text(empNm);
      	// 발병일
		if(atfssDt !== null && atfssDt !== "" && atfssDt !== undefined){
			var date = new Date(atfssDt);
			var atfssDate = formatDate3(date);
			$("#pastAtfssDt").text(atfssDate);
		}
      	// 진단내역
      	var cliniCnCard = "";
      	if(clnicCn == null || clnicCn == ""){
      		clnicCn = "-"
      	}
      	cliniCnCard += "<div class='card p-2 m-1'>";
      	cliniCnCard += clnicCn + "</div>";
      	$("#pastClnicCn").html(cliniCnCard);
      	// 상병
      	var sawHtml = "";
      	if(sckwndSe[0] === null || sckwndSe[0] === "" || 1 > sckwndSe.length){
      		sawHtml = "-";
      	}else{
	      	for(var i = 0; i < sckwndSe.length; i++){
	      		var sckwndSeKo = "";
	      		if(sckwndSe[i] == '1'){
	      			sckwndSeKo = "주";
	      		}else if(sckwndSe[i] == '2'){
	      			sckwndSeKo = "부";
	      		}else if(sckwndSe[i] == '3'){
	      			sckwndSeKo = "배제";
	      		}
	      		
	      		sawHtml += "<div class='card p-2 m-1'>";
	      		sawHtml += sckwndSeKo + " | " + kcd[i] + " | " + sckwndKr[i] + "</div>";
	      	}
      	}
      	$("#pastSAW").html(sawHtml);
      	// 치료
      	var mtrHtml = "";
      	if(mdlrtCd[0] === null || mdlrtCd[0] === "" || mdlrtCd.length === 0){
      		mtrHtml = "-";
      	}else{
	      	for(var i = 0; i < mdlrtCd.length; i++){
	      		var curer = "";
	      		if(mdlrtCurer[i] === null || mdlrtCurer[i] === ""){
	      			curer = '<span class="badge badge rounded-pill d-block p-1 badge-subtle-warning">치료사 미배정<span class="fas fa-ban" data-fa-transform="shrink-2"></span></span>'
	      		}else{
	      			curer = '<span class="badge badge rounded-pill d-block p-1 badge-subtle-success">완료<span class="fas fa-check" data-fa-transform="shrink-2"></span></span>'
	      		}
	      		mtrHtml += "<div class='card ps-0 py-1 m-1'>";
	      		mtrHtml += "<div class='row ps-2'>";
	      		mtrHtml += "<div class='col-auto pe-0' style='display: flex; align-items: center;'>";
	      		mtrHtml += mdlrtCd[i] + " | " + mdlrtNm[i] + " | </div><div class='col-auto m-1 ps-0'>" + curer + "</div></div></div>";
	      	}
      	}
      	$("#pastMTR").html(mtrHtml);
      	// 검사
      	
      	var meoHtml = "";
      	if(hlthchkpCd[0] === null || hlthchkpCd[0] === "" || hlthchkpCd.length === 0){
      		meoHtml = "-";
      	}else{
	      	for(var i = 0; i < hlthchkpCd.length; i++){
	      		var result = "";
	      		if(hlthchkpResult[i] === null || hlthchkpResult[i] === "" || hlthchkpResult[i] === undefined || hlthchkpResult[i] == "null"){
	      			result = '<span class="badge badge rounded-pill d-block p-1 badge-subtle-warning">검사 미완료<span class="bi-x-circle-fill"></span></span>'
	      		}else if(hlthchkpCd[i] === "HC003"){
	      			
	      			result = "<a class='xrayATag' data-hlthchkpresult='" + hlthchkpResult[i] + "' data-clnicno='"+clnicNo+"' href='#'>결과보기</a></br>"

	      			result = "<span class='badge badge rounded-pill d-block p-1 badge-subtle-success'><a class='xrayATag' data-hlthchkpresult='" + hlthchkpResult[i] + "' href='#'>결과보기<span class='ms-1 fas fa-check' data-fa-transform='shrink-2'></span></a></span>"

	      		}else {
	      			result =  hlthchkpResult[i];
	      		}
	      		meoHtml += "<div class='card ps-0 py-1 m-1'>";
	      		meoHtml += "<div class='row ps-2'>";
	      		meoHtml += "<div class='col-auto pe-0' style='display: flex; align-items: center;'>";
	      		meoHtml += hlthchkpCd[i] + " | " + hlthchkpNm[i] + " | </div><div class='col-auto m-1 ps-0'>" + result + "</div></div></div>";
	      	}
      	}
      	$("#pastMEO").html(meoHtml);
      	// 처방
      	var poHtml = "";
      	if(medcinCd[0] === null || medcinCd[0] === "" || medcinCd.length === 0){
      		poHtml = "-";
      	}else{
	      	for(var i = 0; i < medcinCd.length; i++){
	      		var dateFormat = "";
	      		if(parseInt(mdctnPd[i]) == 0){
	      			dateFormat = "";
	      		}else{
	      			dateFormat = convertDays(parseInt(mdctnPd[i]));
	      		}
	      		poHtml += "<div class='card p-2 m-1'>";
	      		poHtml += medcinCd[i] + " | " + prscrptnNm[i] + " | 투여량 : " + mdctnCpcty[i] + mdctnUnit[i] + " | " + mdctnCo[i] + "회 | " + dateFormat + " | " + mdctnCoursUsage + "</div>";
	      	}
      	}
      	$("#pastPO").html(poHtml);
      	
      	var clinicMemo1 = "";
      	if(clnicMemo == null || clnicMemo == ""){
      		clinicMemo1 = "-"; 
      	}else{
	      	clinicMemo1 = "<div class='card p-2 m-1'>";
	      	clinicMemo2 += clnicMemo + "</div>";
      	}
      	$("#pastMemo").html(clinicMemo1);
	}
	
	// 진료 날짜 선택시 이벤트 (전처방 ajax 실행)
	// (pastClinic 호출)
	$(document).on("click", ".allClnicTime", function(){
		var clnicNo = $(this).data("clnicno");
		// 검사완료 호출인지 판단하기 위해 쓰는 변수(전처방 ajax에서 어디로 보낼지 선택한다.)
		var recall = false;
		// 전처방 ajax(진료 번호, 검사완료여부(true || false))
		pastClinic(clnicNo, recall);
		
	});
	
	// 진료기록 ajax(진료 번호, 검사완료여부(true || false))
	// (검사완료일 경우 clinicRecall 호출 / 진료대기 호출일 경우 pastClinicData 호출)
	function pastClinic(clnicNo, recall){
		
		var clnicObj = {
			"clnicNo" : clnicNo
		}
		
		$.ajax({
			type : "post",
			url  : "/mediform/doctor/clinic/select",
			data : JSON.stringify(clnicObj),
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				var sckwndSe = [];
				var kcd = [];
				var sckwndKr = [];
				var sckwndEn = [];
				var mdlrtCd = [];
				var mdlrtNm = [];
				var mdlrtCurer = [];
				var hlthchkpCd = [];
				var hlthchkpNm = [];
				var hlthchkpResult = [];
				var medcinCd = [];
				var prscrptnNm = [];
				var mdctnCpcty = [];
				var mdctnUnit = [];
				var mdctnCo = [];
				var mdctnPd = [];
				var mdctnCoursUsage = [];
				
				$(res.sickAndWoundedVOList).each(function(sawI, sawItem){
					if(sawItem.sckwndSe != null && sawItem.sckwndSe != "" && sawItem.sckwndSe == 1){
						sckwndSe.push(sawItem.sckwndSe);
						kcd.push(sawItem.kcd);
						sckwndKr.push(sawItem.sckwndKr);
						sckwndEn.push(sawItem.sckwndEn);
					}else if(sawItem.sckwndSe != null && sawItem.sckwndSe!= "" && sawItem.sckwndSe == 2){
						sckwndSe.push(sawItem.sckwndSe);
						kcd.push(sawItem.kcd);
						sckwndKr.push(sawItem.sckwndKr);
						sckwndEn.push(sawItem.sckwndEn);
					}else if(sawItem.sckwndSe != null && sawItem.sckwndSe!= "" && sawItem.sckwndSe == 3){
						sckwndSe.push(sawItem.sckwndSe);
						kcd.push(sawItem.kcd);
						sckwndKr.push(sawItem.sckwndKr);
						sckwndEn.push(sawItem.sckwndEn);
					}
				});
				$(res.selectMedicalTreatmentRecordVOList).each(function(mtrI, mtrItem){
					var curer = "";
					if(this.mdlrtCd !== null && this.mdlrtCd !== ""){
						mdlrtCd.push(this.mdlrtCd);
						mdlrtNm.push(this.mdlrtNm);
						if(this.mdlrtCurer === null || this.mdlrtCurer === ""){
							curer = "배정된 치료사가 없습니다."
						}else{
							curer = this.mdlrtCurer;
						}
						mdlrtCurer.push(curer);
					}
				});
				// 엑스레이에 보낼 mecCd만 골라내기
				var xrayMecCdResult = [];
				$(res.medicalExaminationOrderVOList).each(function(meoI, meoItem){
					if(this.hlthchkpCd != null && this.hlthchkpCd !=""){
						hlthchkpCd.push(this.hlthchkpCd);
						hlthchkpNm.push(this.hlthchkpNm);
						if(this.hlthchkpCd === "HC003" && (this.hlthchkpResult == null || this.hlthchkpResult == "")){
							hlthchkpResult.push(this.mecCd);
							xrayMecCdResult.push(this.mecCd);
						}else if(this.hlthchkpCd != "HC003" && this.hlthchkpResult == null || this.hlthchkpResult == ""){
							hlthchkpResult.push('null');
						}else{
							hlthchkpResult.push(this.hlthchkpResult);
						}
					}
				});
				$(res.prescriptionOrderVOList).each(function(poI, poItem){
					if(this.prscrptnCd != null && this.prscrptnCd != ""){
						medcinCd.push(this.medcinCd);
						prscrptnNm.push(this.prscrptnNm);
						mdctnCpcty.push(this.mdctnCpcty);
						mdctnUnit.push(this.mdctnUnit);
						mdctnCo.push(this.mdctnCo);
						mdctnPd.push(this.mdctnPd);
						mdctnCoursUsage.push(this.mdctnCoursUsage);
						
					}
				});
				
				if(recall){
					// 검사완료 호출일 때 사용
					selectPastTable(res.clnicTime, clnicNo, res.empNm, res.atfssDt, res.clnicCn, res.clnicMemo, sckwndSe, kcd, sckwndKr, sckwndEn);
					
					// x-ray에 보낼것(mecCd 배열)
					if(xrayMecCdResult.length > 0){
						
						selectXrayResult(clnicNo, 'Y');
					}
				}else{
					// 진료대기 호출일 때 사용
					pastClinicData(res.clnicTime, clnicNo, res.empNm, res.atfssDt, 
								res.clnicCn, sckwndSe, kcd, sckwndKr, mdlrtCd, mdlrtNm, mdlrtCurer,
								hlthchkpCd, hlthchkpNm, hlthchkpResult, medcinCd, prscrptnNm, mdctnCpcty, mdctnUnit,
								mdctnCo, mdctnPd, mdctnCoursUsage, res.clnicMemo);
					
				}
			},
			error : function(err){
			}
		});
	}
	
	// 선택된 환자 진료일 가져오기(patntNo 사용)(검사완료 후 호출일 경우 clinicRecall 호출)
	function selectClnicTime(patntNo){
		
		var patntObj = {
			"patntNo" : patntNo
		}
		
		$.ajax({
			type : "post",
			url  : "/mediform/doctor/clinic/select/time",
			data : JSON.stringify(patntObj),
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				var flag = false;
				var clnicTimesHtml = "";
				$(res).each(function(i, item){
					var clnicTimeFormat = this.clnicTime.split(" ")[0].split("-");
					var year = clnicTimeFormat[0].substring(2,4);
					var clnicTime = year + "." + clnicTimeFormat[1] + "." +clnicTimeFormat[2] ;
					if(this.clnicAt === "Y"){
						clnicTimesHtml += "<tr><td><button id='allClnicTime"+i+"' class='btn btn-sm btn-falcon-default allClnicTime' type='button' data-clnicno='"+this.clnicNo+"' >" + clnicTime + "</button></td></tr>";
						if(flag === false){
							pastClinic(this.clnicNo, false);
							flag = true;
						}
						
					}else if(this.clnicAt === "N"){
						// 검사 완료 재호출 부분임 진료작성 부분에 있는 기록 가져오는 함수 실행 해야함
						pastClinic(this.clnicNo, true);
					}
				});
				$("#allClnicTimeDt").html(clnicTimesHtml);
			},
			error : function(err){
			}
		});
	}
	
	// 선택된 환자 바이탈 정보 가져와서 넣어주기(patntNo 사용)
	function callBtnSelectPatientVital(patntNo){
		
		var patntObj = {
				"patntNo" : patntNo
		}			
		$.ajax({
			type : "post",
			url  : "/mediform/doctor/vitals/select",
			data : JSON.stringify(patntObj),
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	            //ajax호출 중 처리
	            //글로벌 변수로 설정한 csrf token 셋팅
	            xhr.setRequestHeader(header,token);
	        },
			success : function(res){
				// 값이 없을 경우 - 넣어주기 
				var hghrkHhprs = "";
				var lwtrkHhprs = "";
				var bdheat = "";
				if(res.hghrkHhprs == null || res.hghrkHhprs == ""){
					hghrkHhprs = "-";
				}else{
					hghrkHhprs = res.hghrkHhprs;
				}
				if(res.lwtrkHhprs == null || res.lwtrkHhprs == ""){
					lwtrkHhprs = "-";
				}else{
					lwtrkHhprs = res.lwtrkHhprs;
				}
				if(res.bdheat == null || res.bdheat == ""){
					bdheat = "-";
				}else{
					bdheat = res.bdheat;
				}
				$("#hghrkHhprsDt").text(hghrkHhprs);
				$("#lwtrkHhprsDt").text(lwtrkHhprs);
				$("#bdheatDt").text(bdheat);
				
			},
			error : function(err){
			}
		});
		
	}
	
	// 환자정보 테이블에 값 넣기(patntNo 사용)(selectPatientAjax 사용)
	function callBtnSelectPatient(patntNo){
		var patntObj = {
				"patntNo" : patntNo
		}
		
		$.ajax({
			type : "post",
			url  : "/mediform/patient/info",
			data : JSON.stringify(patntObj),
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
					selectPatientAjax(this.patntNo, this.patntNm, this.patntAge, this.patntRrno1, this.patntRrno2, patientBirth,
							this.patntSexdstn, this.patntTelno, this.patntHlthinsAt, this.patntHsptlzAt, this.prtctorNm, this.prtctorTelno, this.patntMemo,
							this.patntHeight, this.patntBdwgh, this.patntBdp);
				});
			},
			error : function(err){
			}
		});
	}
	// 환자 정보 부분 값 초기화
	function cleanPatientInfo(){
		// 환자 번호 값 초기화
		$("#patntNoDt").val("");
		// 환자 이름 값 초기화
		$("#patntNmDt").val(""); 
		// 환자 성별 값 초기화
		$("#patntSexdstnDt").val("");
		// 환자 생년월일 값 초기화
		$("#patntRrno1Dt").val(""); 
		// 환자 나이 값 초기화
		$("#patntAgeDt").val(""); 
		// 환자 연락처 값 초기화
		$("#patntTelnoDt").val(""); 
		// 환자 보험여부 값 초기화
		$("#patntHlthinsAtDt").val(""); 
		// 환자 입원여부 값 초기화
		$("#hsptlzAtDt").val("");
		// 환자 보호자 이름 값 초기화
		$("#prtctorNmDt").val(""); 
		// 환자 보호자 연락처 값 초기화
		$("#prtctorTelnoDt").val(""); 
		// 환자 메모 값 초기화
      	$("#patntMemoDt").val("");
		// 환자 키 값 초기화
      	$("#patntHeightDt").text("");
		// 환자 몸무게 값 초기화
      	$("#patntBdwghDt").text("");
		// 환자 혈액형 값 초기화
      	$("#patntBdpDt").text("");
		// 최고혈압 값 초기화
		$("#hghrkHhprsDt").text("");
		// 최저혈압 값 초기화
		$("#lwtrkHhprsDt").text("");
		// 체온 값 초기화
		$("#bdheatDt").text("");
		// 진료일 값 초기화
      	$("#allClnicTimeDt tr").remove();
		// 진료 시간 값 초기화
      	$("#pastClnicTime").text("");
     	// 진료 번호 값 초기화
      	$("#pastClnicNo").text("");
      	// 담당의 값 초기화
      	$("#pastEmpNm").text("");
      	// 발병일 값 초기화
      	$("#pastAtfssDt").text("");
      	// 진단내역 값 초기화
      	$("#pastClnicCn").text("");
      	// 상병 값 초기화
      	$("#pastSAW").text("");
      	// 검사 값 초기화
      	$("#pastMEO").text("");
      	// 치료 값 초기화
      	$("#pastMTR").text("");
      	// 처방 값 초기화
      	$("#pastPO").text("");
      	// 메모 값 초기화
      	$("#pastMemo").text("");
	}
	
	// 진료 등록 부분 값 초기화
	function cleanClinicInfo(){
		// 진료번호 초기화
		$("#rceptNo").val("");
		// 환자번호 초기화
		$("#patntNoDt").val("");
		// 진단 메모 초기화
		$("#clnicMemoDt").val("");
		// 주상병 테이블 초기화
		$("#sawlInsertTable1 tr").remove();
		// 부상병 테이블 초기화
		$("#sawlInsertTable2 tr").remove();
		// 배제된상병 테이블 초기화
		$("#sawlInsertTable3 tr").remove();
		// 검사 테이블 초기화
		$("#hcInsertTable tr").remove();
		// 치료 테이블 초기화
		$("#mtInsertTable tr").remove();
		// 처방 테이블 초기화
		$("#mInsertTable tr").remove();
		// 진료 시작 시간 초기화
		$("#clnicTimeInput").val("");
		// 진단 내역 초기화
		$("#clnicCn").val("");
		// 발병일 초기화
		$("#atfssDt").val("");
		// 입원여부 체크박스 초기화
		$("#hsptlzAt").prop("checked", false);
		// 검사결과 초기화
		$("#examinationListTable tr").remove();
		// 엑스레이 Ul 초기화
		$("#xrayResultTab").empty();
		// 엑스레이 Div 초기화
		$("#xrayResultImage").empty();
	}
//=== 환자 정보 불러오기 끝 ============================================================================	
	// 환자 검색 관련 시작
	var patientInput = $("#patientInput");
	var patientTbody = $("#patientTbody");
	var patientMenu = $("#patientMenu");
	var patientDropMenu = $("#patientDropMenu");
	var patientTbodyHtml = "";
	
// 	환자 검색 시작
// 		검색창 포커스 아웃일 때 드롭다운 사라지게 만들기
		patientInput.focusout(function(){
			setTimeout(() => {
				$(patientDropMenu).hide();
			}, 100);
		});
	
	// 검색창 포커스인
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
	
	// 환자 keyup 검색
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
	
	// 환자 결과 누르기 이벤트들 시작 ---------------------------------------------
	// 엔터 눌렀을 시 제일 위에 환자 번호를 찾는다.
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
			
			// 환자 정보 값 초기화
			cleanPatientInfo();
			
			// 바이탈 넣어주기
			callBtnSelectPatientVital(patntNo);
			// 환자정보에 값 넣어주기
			callBtnSelectPatient(patntNo);
			// 환자 이전 진료 날짜 생성
			selectClnicTime(patntNo);
			
			patientInput.blur();
			$(patientDropMenu).hide();
		}
	});
	
	// 검색창 목록 클릭 이벤트
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
		
		// 환자 정보 값 초기화
		cleanPatientInfo();
		
		// 바이탈 넣어주기
		callBtnSelectPatientVital(patntNo);
		// 환자정보에 값 넣어주기
		callBtnSelectPatient(patntNo);
		// 환자 이전 진료 날짜 생성
		selectClnicTime(patntNo);
		
		// 환자 검사 결과 조회
		selectMEOResult(patntNo, rceptNo);
		
		patientInput.blur();
		$(patientDropMenu).hide();
	});
	
	// 환자 결과 누르기 이벤트들 끝 ------------------------------------------------
	
	// 환자 검색창에 목록 생성
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
	
	// 환자 상세보기에 값 넣어주기
	function selectPatientAjax(patntNo, patntNm, patntAge, patntRrno1, patntRrno2, patientBirth,
			patntSexdstn, patntTelno, patntHlthinsAt, patntHsptlzAt, prtctorNm, prtctorTelno, 
			patntMemo, patntHeight, patntBdwgh, patntBdp){
		$("#patntNoDt").val(patntNo);
		$("#patntNmDt").val(patntNm); 
		
		if(patntSexdstn == "M"){
			patntSexdstn = "남";
		}else{
			patntSexdstn = "여";
		}
		
		var ptel = getTelFormat(patntTelno);
		
		$("#patntTelDt").val(ptel);
		$("#patntSexdstnDt").val(patntSexdstn);
		
		var birth1 = patntRrno1.toString().slice(0,2);
		var birth2 = patntRrno1.toString().slice(2,4);
		var birth3 = patntRrno1.toString().slice(4,6);
		var birth = birth1 + "." + birth2 + "." + birth3;
		
		$("#patntRrno1Dt").val(birth); 
		$("#patntAgeDt").val(patntAge + "세"); 
		$("#patntTelnoDt").val(patntTelno); 
		if(patntHlthinsAt == "Y"){
			patntHlthinsAt = "O"
		}else if(patntHlthinsAt == "N"){
			patntHlthinsAt = "X"
		}else{
			patntHlthinsAt = "-"
		}
		$("#patntHlthinsAtDt").val(patntHlthinsAt); 
		if(patntHsptlzAt == "Y"){
			patntHsptlzAt = "O"
		}else if(patntHsptlzAt == "N"){
			patntHsptlzAt = "X"
		}else{
			patntHsptlzAt = "-"
		}
		$("#hsptlzAtDt").val(patntHsptlzAt);
		if(prtctorNm == null || prtctorNm == ""){
			prtctorNm = "-";
		}
		$("#prtctorNmDt").val(prtctorNm);
		var prtTel = "";
		if(prtctorTelno == null || prtctorTelno == ""){
			prtTel = "-";
		}else{
			prtTel = getTelFormat(prtctorTelno);
		}
		$("#prtctorTelnoDt").val(prtTel); 
		if(patntMemo == null || patntMemo == ""){
			patntMemo = "특이사항이 없습니다.";
		}
      	$("#patntMemoDt").val(patntMemo);
      	$("#patntHeightDt").text(patntHeight);
      	$("#patntBdwghDt").text(patntBdwgh);
      	$("#patntBdpDt").text(patntBdp);
      	
	}
	
//환자 검색 끝
// 환자 주민등록번호로 생년월일 만들기(주민등록번호1, 주민등록번호2)
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

// 기간을 계산하는 펑션
	function convertDays(days) {
	    var years = Math.floor(days / 365);
	    var months = Math.floor((days % 365) / 30);
	    var remainingDays = days % 365 % 30;
	    var weeks = Math.floor(remainingDays / 7);
	    remainingDays = remainingDays % 7;

		
	    var result = "";
	    if (years > 0) {
	        result += years + "년 ";
	    }
	    if (months > 0) {
	        result += months + "달 ";
	    }
	    if (weeks > 0) {
	        result += weeks + "주 ";
	    }
	    if (remainingDays > 0) {
	        result += remainingDays + "일";
	    }
	    return result;
	}

	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 진료 등록 관련 시작 ============================================================================================================
	
	$("#atfssDt").on("change", function(){
		var atfssDt = $("#atfssDt").val();
		var atfssDtFormat = parseInt(atfssDt.split("-").join(""));

		var date = new Date();
		
		var year = date.getFullYear().toString().substring(0, 4);
		var month = String(date.getMonth() + 1).padStart(2, '0');
		var day = String(date.getDate()).padStart(2, '0');
		var today = parseInt(year + month + day);
		
		if(atfssDtFormat > today){
			Swal.fire({
			      icon: 'error',
				  title:'발병일',
			      text: '금일 이후의 날짜는 설정이 불가능합니다.',
			      confirmButtonColor: 'blue'
			    });
			$("#atfssDt").val("");
			return;
		}
	});
	
	// 입원 체크박스
	var hsptlzAt = $("#hsptlzAt");
	
	// 진료 등록 버튼 클릭시 이벤트
	$("#clnicInsertBtn").on("click", function(){
		
		Swal.fire({
            icon: 'warning',
            title: '진료등록',
            text: '진료를 등록하시겠습니까?',
            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            confirmButtonColor: 'midnightblue',
            cancelButtonColor: 'red', // cancel 버튼 색깔 지정
          }).then(result => {
             if(result.isConfirmed){
            	var btnText = $("#clnicInsertBtn").text();
         		insertClinic(btnText);
             }else{
            	 return false;
             }
          });
	});
	
	
	//검사오더 버튼 클릭시
	$("#hcOrderBtn").on("click",function(){
		Swal.fire({
            icon: 'warning',
            title: '검사오더',
            text: '오더를 등록하시겠습니까?',
            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            confirmButtonColor: 'midnightblue',
            cancelButtonColor: 'red', // cancel 버튼 색깔 지정
          }).then(result => {
             if(result.isConfirmed){
            	 var btnText = $("#hcOrderBtn").text();
         		insertClinic(btnText);
             }else{
            	 return false;
             }
          });
	});
	
	
	// 진료 등록 ajax
	function insertClinic(btnText){
		var nodata = false;
		
		var rceptNo = $("#rceptNo").val();
		var patntNo = $("#patntNoDt").val();
		if(patntNo == null || patntNo == "" || patntNo == undefined){
			Swal.fire({
			      icon: 'error',
				  title:'진료등록',
			      text: '호출된 환자가 없습니다.',
			      confirmButtonColor: 'blue'
			    });
			nodata = true;
		}
		if(nodata){
			return;
		}
		var empNo = $("#loginEmpNo").val();
		var clnicTime = $("#clnicTimeInput").val();
		var clnicTimeParts = clnicTime.split(/[년월일 :]/).filter(function(part) {
		    return part !== ''; // 빈 문자열 제거
		});
		var year = clnicTimeParts[0];
		var month = clnicTimeParts[1];
		var day = clnicTimeParts[2];
		var hours = clnicTimeParts[3];
		var minu = clnicTimeParts[4];
		clnicTime = year + "-" + month +"-" + day +" " + hours + ":" + minu;
		var clnicCn = $("#clnicCn").val();
		if(btnText == '진료등록'){
			var clnicAt = 'Y';
		}else if(btnText == '검사오더'){
			var clnicAt = 'N';
		}
		var beforeClnicNo = "";
		var hsptlzAtVal = "";
		var atfssDt = $("#atfssDt").val();
		if(hsptlzAt.prop('checked')){
			hsptlzAtVal = hsptlzAt.val();
		}else{
			hsptlzAtVal = "N";
		}
		var clnicMemo = $("#clnicMemoDt").val();
		var clinicVO = {};
		var clnicNo = "";
		// 검사 완료시 이미 생긴 진료 번호 받아오기
		if($("#clnicNo").data("recall") == "Y"){
			clnicNo = $("#clnicNo").val();
		}
		
		// 상병 가져오기
		var sawlInsertTable1 = $("#sawlInsertTable1").find("td");
		var sawVO = [];
		var kcd = [];
		var sckwndSe = [];
		var sckwndKr = [];
		var sckwndEn = [];
		
		// 주상병 가져오기
		for(var i = 0; i < 6; i++){
			if(i == 1){
				if($(sawlInsertTable1[1]).text() == null || $(sawlInsertTable1[1]).text() == ""){
					if(btnText == "진료등록"){
						Swal.fire({
						      icon: 'error',
							  title:'진료등록',
						      text: '주상병을 작성해주세요.',
						      confirmButtonColor: 'blue'
						    });
						return;
					}else{
						break;						
					}
				}
				kcd.push($(sawlInsertTable1[1]).text());
			}
			if(i == 3){
				sckwndSe.push($(sawlInsertTable1[3]).find("input[type='radio']:checked").val()); 
			} 
			if(i == 4){
				sckwndKr.push($(sawlInsertTable1[4]).text()); 
			}
			if(i == 5){
				sckwndEn.push($(sawlInsertTable1[5]).text()); 
			}
		}
		var sawlInsertTable2 = $("#sawlInsertTable2").find("tr");
		
		// 부상병 가져오기
		$(sawlInsertTable2).each(function(subI, subItem) {
			var tds = $(subItem).find("td");
			
			if($(tds[1]).text() != null && $(tds[1]).text() != ""){

				kcd.push($(tds[1]).text()); 
				sckwndSe.push($(tds[3]).find("input[type='radio']:checked").val()); 
				sckwndKr.push($(tds[4]).text()); 
				sckwndEn.push($(tds[5]).text());	
			}
			
		});
		
		var sawlInsertTable3 = $("#sawlInsertTable3").find("tr");
		
		// 배제된 상병 가져오기
		$(sawlInsertTable3).each(function(otherI, otherItem) {
			var tds = $(otherItem).find("td");
			
			if($(tds[1]).text() != null && $(tds[1]).text() != ""){

				kcd.push($(tds[1]).text()); 
				sckwndSe.push($(tds[3]).find("input[type='radio']:checked").val()); 
				sckwndKr.push($(tds[4]).text()); 
				sckwndEn.push($(tds[5]).text());	
			}
			
		});
		if(kcd[0] == null || kcd[0] == ""){
			
		}
		// 상병 담아둔 곳
		var sawObj = {
				"rceptNo" : rceptNo,
				"patntNo" : patntNo,
				"clnicNo" : clnicNo,
				"kcdList" : kcd,
				"sckwndSeList" : sckwndSe,
				"sckwndKrList" : sckwndKr,
				"sckwndEnList" : sckwndEn
		};
		
		// 검사 가져오기
		var hcInsertTable = $("#hcInsertTable").find("tr");
		// 검사 코드 가져오기
		var hlthchkpCd = [];
		// 검사 결과 가져오기
		var hlthchkpResult = [];
		// 가격 계산을 위해
		var hlthchkpAmount = [];
		// 검사 총합 금액(엑스레이 제외)
		var hcTotalPrice = 0;
		// 엑스레이 검사 금액
		var xcTotalPrice = 0; 
		
		// 검사 테이블에서 가져온 것
		$(hcInsertTable).each(function(i) {
			var tds = $(this).find("td");

			hlthchkpCd.push($(tds[1]).text()); 
			hlthchkpAmount.push(parseInt($(tds[1]).data("hlthchkpamount"))); 
		});
		
		for(var i = 0; i < hlthchkpAmount.length; i++){
			if(hlthchkpCd[i] == 'HC003'){
				xcTotalPrice += hlthchkpAmount[i];
			}else{
				hcTotalPrice += hlthchkpAmount[i];
			}
		}
		if(btnText == "검사오더"){
			if(hlthchkpCd[0] == null || hlthchkpCd[0] == ""){
				  
			  	  Swal.fire({
				      icon: 'error',
					  title:'검사오더',
				      text: '검사를 등록 해주세요.',
				      confirmButtonColor: 'blue'
				    });
			  	  $(".hCInput").focus();
				  return false;
		    }						
		}
		
		// 검사 담아둔 곳
		var hcObj = {
				"rceptNo" : rceptNo,
				"patntNo" : patntNo,
				"clnicNo" : clnicNo,
				"hlthchkpCdList" : hlthchkpCd,
				"hlthchkpResultList" : hlthchkpResult,
				"xcTotalPrice" : xcTotalPrice,
				"hcTotalPrice" : hcTotalPrice
		}
		
		// 치료 가져오기
		var mtInsertTable = $("#mtInsertTable").find("tr");
		
		var mdlrtCd = [];
		var mdlrtCl = [];
		// 가격 따로 보내주기 위해
		var mdlrtAmount = [];
		
		// 치료 테이블에서 가져오기
		$(mtInsertTable).each(function(i) {
			  var tds = $(this).find("td");

			  mdlrtCd.push($(tds[1]).text());
			  mdlrtCl.push($(tds[1]).data("mdlrtcl"));
			  mdlrtAmount.push(parseInt($(tds[1]).data("mdlrtamount")));
		});
		
		// 급여치료 가격 합
		var mmTotalPrice = 0;
		// 비급여치료 가격 합
		var zzTotalPrice = 0;
		for(var i = 0; i < mdlrtAmount.length; i++){
			if(mdlrtCd[i].substr(0, 2) === "MM"){
				mmTotalPrice += mdlrtAmount[i];
			}else{
				zzTotalPrice += mdlrtAmount[i];
			}
		}
		
		// 치료 담아둔 곳
		var mtObj = {
				"rceptNo" : rceptNo,
				"patntNo" : patntNo,
				"clnicNo" : clnicNo,
				"mdlrtCdList" : mdlrtCd,
				"mmTotalPrice" : mmTotalPrice,
				"zzTotalPrice" : zzTotalPrice
		}
		
		// 처방 가져오기
		var mInsertTable = $("#mInsertTable").find("tr");
		
		var medcinCd = [];
		var prscrptnNm = [];
		var mdctnCpcty = [];
		var mdctnUnit = [];
		var mdctnCo = [];
		var mdctnPd = [];
		var mdctnCoursUsage = [];
		
		// 가격 따로 보내주기 위해
		var medcinPc = [];
		var medcinStandard = [];
		
		
		// 처방 테이블에서 가져오기
		$(mInsertTable).each(function(i) {
			  var tds = $(this).find("td");
			  if(tds.length > 0){
				  // 약품 코드
				  medcinCd.push($(tds[1]).text()); 
				  // 약품명
				  prscrptnNm.push($(tds[2]).text()); 
				  if($(tds[5]).find("input").val() == null || $(tds[5]).find("input").val() == "" ||  $(tds[5]).find("input").val() == 0){
					  Swal.fire({
					      icon: 'error',
						  title:'진료등록',
					      text: '1회 약품 투여 용량을 정해주세요.',
					      confirmButtonColor: 'blue'
					    });
					  $(tds[5]).find("input").focus();
					  nodata = true;
					  return false;
				  }else{
					  // 1회 약품 투여 용량
					  mdctnCpcty.push($(tds[5]).find("input").val()); 
					  
				  }
				  // 1회 약품 투여 단위
				  mdctnUnit.push($(tds[5]).text()); 
				  if($(tds[6]).find("input").val() == null || $(tds[6]).find("input").val() == "" || $(tds[6]).find("input").val() == 0){
					  Swal.fire({
					      icon: 'error',
						  title:'진료등록',
					      text: '1회 약품 투여 횟수를 정해주세요.',
					      confirmButtonColor: 'blue'
					    });
					  $(tds[6]).find("input").focus();
					  nodata = true;
					  return false;
				  }else{
					  // 투여 횟수
					  mdctnCo.push($(tds[6]).find("input").val());
				  }
				  if($(tds[7]).find("input").val() == null || $(tds[7]).find("input").val() == "" || $(tds[7]).find("input").val() == 0){
					  Swal.fire({
					      icon: 'error',
						  title:'진료등록',
					      text: '약품 투여 기간을 정해주세요.',
					      confirmButtonColor: 'blue'
					    });
					  $(tds[7]).find("input").focus();
					  nodata = true;
					  return false;
				  }else{
					  // 투여 기간
					  mdctnPd.push($(tds[7]).find("input").val()); 
				  }
				  // 투여 경로 및 용법
				  mdctnCoursUsage.push($(tds[4]).text()); 
				  // 약품 가격
				  medcinPc.push($(tds[1]).data("medcinpc")); 
				  // 약품 규격
				  medcinStandard.push($(tds[1]).data("medcinstandard"));
				  
			  }
		});
		
		if(nodata){
			return;
		}
		var poTotalPrice = 0;
		var injectionTotalPrice = 0;
		
		for(var i = 0; i < mdctnUnit.length; i++){
			if(mdctnUnit[i] == "리터"){
				injectionTotalPrice += parseInt(medcinPc[i]) * parseInt(mdctnCo[i]) * parseInt(mdctnPd[i]) * parseInt(mdctnCpcty[i]) / parseInt(medcinStandard[i]);                  
	        }else if(mdctnUnit[i] == "앰플"){
	        	injectionTotalPrice += parseInt(medcinPc[i]) * parseInt(mdctnCpcty[i]) * parseInt(mdctnCo[i]) * parseInt(mdctnPd[i]);
	        }else{
	        	poTotalPrice += parseInt(medcinPc[i]) * parseInt(mdctnCpcty[i]) * parseInt(mdctnCo[i]) * parseInt(mdctnPd[i]);
	        }
		}
		// 처방 담아둔 곳
		var mObj = {
				"rceptNo" : rceptNo,
				"patntNo" : patntNo,
				"clnicNo" : clnicNo,
				"medcinCdList" : medcinCd,
				"prscrptnNmList" : prscrptnNm,
				"mdctnCpctyList" : mdctnCpcty,
				"mdctnUnitList" : mdctnUnit,
				"mdctnCoList" : mdctnCo,
				"mdctnPdList" : mdctnPd,
				"mdctnCoursUsageList" : mdctnCoursUsage,
				"poTotalPrice" : poTotalPrice,
				"injectionTotalPrice" : injectionTotalPrice
		}
		
		var rceptClnicAt = "N";
		
		if(btnText == "진료등록"){
			rceptClnicAt = "Y";
		}
		
		if(atfssDt == "" || atfssDt == null){
				clinicVO = {
					"rceptNo" : rceptNo,
					"patntNo" : patntNo,
					"empNo" : empNo,
					"clnicTime" : clnicTime,
					"clnicCn" : clnicCn,
					"clnicAt" : clnicAt,
					"beforeClnicNo" : beforeClnicNo,
					"hsptlzAt" : hsptlzAtVal,
					"clnicMemo" : clnicMemo,
					"clnicFe" : 10000,
					"rceptClnicAt" : rceptClnicAt,
					"sickAndWoundedVO" : sawObj,
					"medicalExaminationOrderVO" : hcObj,
					"medicalTreatmentRecordVO" : mtObj,
					"prescriptionOrderVO" : mObj
				}	
		}else{
			clinicVO = {
					"rceptNo" : rceptNo,
					"patntNo" : patntNo,
					"empNo" : empNo,
					"clnicTime" : clnicTime,
					"clnicCn" : clnicCn,
					"clnicAt" : clnicAt,
					"beforeClnicNo" : beforeClnicNo,
					"hsptlzAt" : hsptlzAtVal,
					"clnicMemo" : clnicMemo,
					"clnicFe" : 10000,
					"atfssDt" : atfssDt,
					"rceptClnicAt" : rceptClnicAt,
					"sickAndWoundedVO" : sawObj,
					"medicalExaminationOrderVO" : hcObj,
					"medicalTreatmentRecordVO" : mtObj,
					"prescriptionOrderVO" : mObj
				}	
		}
		$.ajax({
			type : "post",
	 		url  : "/mediform/doctor/clinic/insert",
	 		data : JSON.stringify(clinicVO),
	 		contentType : "application/json; charset=utf-8",
	         beforeSend : function(xhr){
	             //ajax호출 중 처리
	             //글로벌 변수로 설정한 csrf token 셋팅
	             xhr.setRequestHeader(header,token);
	         },
	 		success : function(res){
	 			if(res == 'FAILED' || res == 'SAWFAILED' || res == 'MEOFAILED' ||
	 					res == 'MTRFAILED' || res == 'POFAILED' || res == 'MANYRESULTFAILED' || res == 'MANYRECEIVEKEYFAILED' || res == 'NOTUPDATE'){
	 				if(res == 'MANYRESULTFAILED' || res == 'MANYRECEIVEKEYFAILED'){
	 					Swal.fire({
						      icon: 'error',
							  title: btnText == '검사오더' ? '검사오더' : '진료등록',
						      text: '진료가 완료된 환자입니다.',
						      confirmButtonColor: 'blue'
						    });
	 				}else{
		 				Swal.fire({
						      icon: 'error',
							  title: btnText == '검사오더' ? '검사오더' : '진료등록',
						      text: '정상적으로 등록되지 않았습니다.',
						      confirmButtonColor: 'blue'
						    });
	 				}
	 				
	 			}else if(res == 'OK'){
	 				Swal.fire({
					      icon: 'success',
						  title: btnText == '검사오더' ? '검사오더' : '진료등록',
					      text: '정상적으로 등록되었습니다.',
					      confirmButtonColor: 'blue'
					    });
	 				// 검사 오더버튼일 때 환자 상태변경
	 				if(btnText == '검사오더'){
	 					// 환자 상태 변경(검사 대기)
	 					statusUpadate(rceptNo, 2);
	 				// 진료 등록 버튼일 때 환자 상태 변경
	 				}else if(btnText == '진료등록'){
	 					// 진료 등록일 때, 검사가 있을 때
	 					if(hlthchkpCd.length > 0){
		 					// 환자 상태 변경(검사대기)
		 					statusUpadate(rceptNo, 2);
		 					
		 				// 진료 등록일 때, 검사 없고 치료는 있을 때	
	 					}else if(mdlrtCl.length > 0 && hlthchkpCd.length == 0){
	 						// 치료코드 중에 물리치료(MM)가 들어간게 있는지 boolean값을 반환
	 						var hasMM = mdlrtCl.some(function(item) {
	 							return item.includes('물리');
	 						});
	 						// 치료구분 중에 물리치료(물리)가 있을 때
	 						if(hasMM){
	 							// 환자 상태 변경(물리치료대기)
	 							statusUpadate(rceptNo, 5);
	 						}else{
	 							// 환자 상태 변경(작업치료대기)
	 							statusUpadate(rceptNo, 7);
	 						}
	 					// 검사도 없고 치료도 없는 상태 (수납대기)
	 					}else if(mdlrtCd.length == 0 && hlthchkpCd.length == 0){
	 						
	 						// 환자 상태 변경(수납대기)
 							statusUpadate(rceptNo, 9);
	 						// 진료등록 클릭 시 진료완료 탭으로 넘기기
	 						// 진료 완료 리스트에 추가
	 						$("#doneClinicList").append($("#"+patntNo));
	 						// 진료 대기 리스트에 삭제
	 						$("#waitingList").remove($("#"+patntNo));
	 						// 환자 번호로 id가 되어 있는 div의 자식 중 버튼요소를 찾아서 텍스트 변경
	 						$("#"+patntNo).find("button").text("진료완료");
	 						// 환자 번호로 id가 되어 있는 div의 자식 중 버튼요소를 찾아서 버튼 클래스 변경(색상 변경)
	 						$("#"+patntNo).find("button").removeClass("btn-outline-primary").addClass("btn btn-sm btn-outline-dark callbutton");
	 					}
	 				}
	 				// 등록이 완료되면 값 다 지우기
		 			cleanClinicInfo();
	 				// 환자리스트 다시 불러오기
		 			watingCallBtn = true;
	 			}
	 		},
	 		error : function(err){
	 		}
		});
			
	}
	
	
	// 환자 상태 변경 ajax
	function statusUpadate(rceptNo, rceptSttus){
		
		var data = {
					"rceptNo" : rceptNo,
					"rceptSttus" : 	rceptSttus
			}
		
		$.ajax({
			type : "post",
	 		url  : "/mediform/doctor/room/update/status",
	 		data : JSON.stringify(data),
	 		contentType : "application/json; charset=utf-8",
	         beforeSend : function(xhr){
	             //ajax호출 중 처리
	             //글로벌 변수로 설정한 csrf token 셋팅
	             xhr.setRequestHeader(header,token);
	         },
	 		success : function(res){
	 			updateList();
	 		},
	 		error : function(err){
	 		}
		});
	}
	
// 진료 등록 관련 끝 ============================================================================================================
// 상병 관련 스크립트 시작=======================================================================================================
	// 상병 검색 관련
	var sawlTbody = $("#sawlTbody");
	var sawlInput = $(".sawlInput");
	var sawlSearchBox = $("#sawlSearchBox");
	var sawlMenu = $("#sawlMenu");
	var sawlDropMenu = $("#sawlDropMenu");
	var idNo = 1;
	var sawlTbodyHtml = "";
	var number = 1;
	
	// 상병 검색 시작
		// 검색창 포커스 아웃일 때 드롭다운 사라지게 만들기
		sawlInput.focusout(function(){
			setTimeout(() => {
				$(sawlDropMenu).hide();
			}, 200);
		});
		
		// 검색창 포커스인
		sawlInput.focusin(function(){
			$(sawlDropMenu).show();
			if(sawlInput.val() == "" || sawlInput.val() == null){
				
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/sickAndWoundedList/list",
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var sawlDropItemHtml = "";
						sawlTbodyHtml = "";
						$(res).each(function(idx, item){
							sawlDropItemHtml = sawlDropItem(this.sickcd, this.krnm, this.sicknm, this.msick)
						});
						$(sawlTbody).html(sawlDropItemHtml);
					},
					error : function(err){
					}
				});
				
			}
		});
		
		// 상병 keyup 검색
		sawlInput.on("keyup",function(event){
			if(event.which != 13){
				var sawlKeyword = sawlInput.val();
				var sawlKeywordObj = { 
						sawlKeyword : sawlKeyword
						};
				// 검색 정보
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/sickAndWoundedList/select",
					data : JSON.stringify(sawlKeywordObj),
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var sawlDropItemHtml = "";
						sawlTbodyHtml = "";
						if(res.length == 0){
							sawlDropItemHtml += "<tr>";
							sawlDropItemHtml += '<td colspan="6" onclick="event.cancelBubble=true;">조회하신 상병이 없습니다.</td>';
							sawlDropItemHtml += '</tr>';
						}else{
							$(res).each(function(idx, item){
								sawlDropItemHtml = sawlDropItem(this.sickcd, this.krnm, this.sicknm, this.msick)
							});
						}
						$(sawlTbody).html(sawlDropItemHtml);
					},
					error : function(err){
					}
				});
			}
		});
		
		// 상병 결과 누르기 이벤트들 시작 ---------------------------------------------
		// 엔터 눌렀을 시 제일 위에 상병 정보를 찾는다.
		$(sawlInput).keypress(function(event){
			if(event.which == 13){
				event.preventDefault();
				var sickcd = sawlTbody.children("tr:eq(0)").data("sickcd");
				var krnm = sawlTbody.children("tr:eq(0)").data("krnm");
				var sicknm = sawlTbody.children("tr:eq(0)").data("sicknm");
				var msick = sawlTbody.children("tr:eq(0)").data("msick");
				if(msick == "" || msick == null){
					msick = "Y";
				}
				// input태그 비우기
				$(sawlInput).val("");
				// 상병 테이블에 넣어주기
				selectSAWLAjax(sickcd, krnm, sicknm, msick, 2);
				
				sawlInput.blur();
				$(sawlDropMenu).hide();
			}
		});
		
		// 검색창 목록 클릭 이벤트
		$("#sawlTbody").on("click","tr", function(){
			console.log("click");
			console.log($(this));
			var clickTr = $(this);
			// 클릭된 요소의 부모인 tr 태그
// 			var clickTr = "";
			
// 			if(targets.is('td')){
// 				clickTr = targets.closest('tr');
// 			}else if(targets.is('tr')){
// 				clickTr = targets;
// 			}
			var sickcd = clickTr.data("sickcd");
			var krnm = clickTr.data("krnm");
			var sicknm = clickTr.data("sicknm");
			var msick = clickTr.data("msick");
			if(msick == "" || msick == null){
				msick = "Y";
			}
			
			// input 태그 비워주기
			$(sawlInput).val("");
			
			selectSAWLAjax(sickcd, krnm, sicknm, msick, 2);
			sawlInput.blur();
			$(sawlDropMenu).hide();
		});
		
		// 상병 결과 누르기 이벤트들 끝 ------------------------------------------------
		// 상병 테이블(sawlInsertTable2)에 넣어주기
      	var radioNo1 = 0;
		var radioNo2 = radioNo1+1;
		var radioNo3 = radioNo2+1;
		
		function selectSAWLAjax(sickcd, krnm, sicknm, msick, sckwndSe){
			
			var checked1 = "";
			var checked2 = "";
			var checked3 = "";
			
			if(sckwndSe != null && sckwndSe == 1){
				checked1 = "checked";
			}else if(sckwndSe != null && sckwndSe == 2){
				checked2 = "checked";
			}else if(sckwndSe != null && sckwndSe == 3){
				checked3 = "checked";
			}
			
			var sawlInsertTableHtml = "";
			sawlInsertTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
			sawlInsertTableHtml += '<td class="align-middle white-space-nowrap pt-1 pb-0" style="display: none;">';
			sawlInsertTableHtml += '<div class="form-check mb-0">';
			sawlInsertTableHtml += '<input class="form-check-input sawlCheckTd" type="checkbox" id="checkbox-'+idNo+'" data-bulk-select-row="data-bulk-select-row" />';
			sawlInsertTableHtml += '</div>';
			sawlInsertTableHtml += '</td>';
			sawlInsertTableHtml += "<td class='align-middle ps-4 text-left' style='max-width: 60px; min-width: 60px;'>" + sickcd + "</td>";
			sawlInsertTableHtml += "<td class='align-middle p-0 text-center' style='max-width: 20px; min-width: 20px;'>" + msick + "</td>";
			sawlInsertTableHtml += "<td class='align-middle p-0 text-center me-1 pb-0 mb-0' style='max-width: 100px; min-width: 100px;'>"
			sawlInsertTableHtml += "<div class='form-check form-check-sm form-check-inline pb-0 mb-0 me-0'>"
									+ "<input type='radio' id='sickRadio"+radioNo1+"' name='sickDivision"+number+"' class='form-check-input mainSick' value='1'";
			if(msick == "N"){
				sawlInsertTableHtml + " disabled";
			}
			sawlInsertTableHtml	+= " "+checked1+">";
			sawlInsertTableHtml	+= "<label class='form-check-label ms-n1 mb-0' for='sickRadio"+radioNo1+"''>주</label>";
			sawlInsertTableHtml	+= "</div>";
			sawlInsertTableHtml	+= "<div class='form-check form-check-sm form-check-inline pb-0 mb-0 me-0'>";
			sawlInsertTableHtml	+= "<input type='radio' id='sickRadio"+radioNo2+"' name='sickDivision"+number+"' class='otherSick form-check-input' value='2' "+checked2+">";
			sawlInsertTableHtml	+= "<label class='form-check-label ms-n1 mb-0' for='sickRadio"+radioNo2+"'>부</label>";
			sawlInsertTableHtml	+= "</div>";
			sawlInsertTableHtml	+= "<div class='form-check form-check-sm form-check-inline pb-0 mb-0 me-0'>";
			sawlInsertTableHtml	+= "<input type='radio' id='sickRadio"+radioNo3+"' name='sickDivision"+number+"' class='otherSick form-check-input' value='3' "+checked3+">";
			sawlInsertTableHtml	+= "<label class='form-check-label ms-n1 mb-0' for='sickRadio"+radioNo3+"'>배제</label>";
			sawlInsertTableHtml	+= "</div>";
			sawlInsertTableHtml	+= "</td>";
			sawlInsertTableHtml += "<td class='align-middle py-0 px-2 text-left' style='max-width: 120px; min-width: 120px;'>" + krnm + "</td>";
			sawlInsertTableHtml += "<td class='align-middle py-0 px-2 text-left' style='max-width: 120px; min-width: 120px;'>" + sicknm + "</td>";
			sawlInsertTableHtml += "<td class='align-middle py-0 px-2 text-end' style='width: 40px;'><div class='pe-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon sawlDel'></div></div></td>";
			sawlInsertTableHtml += "</tr>";
			if(checked1 != null && checked1 != ""){
				$("#sawlInsertTable1").append(sawlInsertTableHtml);
			}else if(checked2 != null && checked2 != ""){
				$("#sawlInsertTable2").append(sawlInsertTableHtml);
			}else if(checked3 != null && checked3 != ""){
				$("#sawlInsertTable3").append(sawlInsertTableHtml);
			}
			idNo++;
			number++;
			radioNo1 += 3;
		}
		
		// 상병 검색창에 목록 생성
		function sawlDropItem(sickcd, krnm, sicknm, msick){
			sawlTbodyHtml += "<tr class='hover-primary pointer'"
				+ "data-sickcd='"+sickcd+"' data-krnm='"+krnm+"' data-sicknm='"+sicknm+"' data-msick='"+msick+"'>";
			sawlTbodyHtml += "<td class='text-left p-0' style='width: 50px;'>"+sickcd+"</td>";
			if(msick == null || msick == ""){
				msick = 'Y';
			}
			sawlTbodyHtml += "<td class='align-middle p-0 text-left' style='width: 20px;'>"+msick+"</td>";
			sawlTbodyHtml += "<td class='align-middle p-0 text-left' style='width: 60px;'></td>";
			sawlTbodyHtml += "<td class='align-middle py-0 px-2 white-space-nowrap' style='text-align:left; overflow: hidden; text-overflow: ellipsis; max-width: 150px;'>"+krnm+"</td>";
			sawlTbodyHtml += "<td class='align-middle py-0 px-2 white-space-nowrap' style='text-align:left; overflow: hidden; text-overflow: ellipsis; max-width: 150px;'>"+sicknm+"</td>";
			sawlTbodyHtml += "</tr>";
			
			return sawlTbodyHtml;
		}
		
	// 상병 검색 끝
	
	
		
		// x 버튼 클릭 삭제기능
		$(document).on("click",".sawlDel", function(event){
			var btnClick = event.target.closest('tr');
			btnClick.remove();			
		});
		
	// 주상병 구분 라디오 이벤트 ------------------------------
		var selectName = "";
		$(document).on("change",".mainSick", function(){
			var mainSick = $(".mainSick");
			
			if(selectName != "" && selectName != null){
				// 이전 주상병 체크된 곳의 부상병 라디오 버튼
				var beforeSelect = $('input[name="'+selectName+'"]:eq(1)');
				// 부상병 라디오 버튼 체크
				beforeSelect.prop('checked', true);
				// 부상병 라디오 버튼이 있는 tr가져오기
				var existingTr = beforeSelect.closest('tr');
				// 부상병 테이블로 옮기기
				$(sawlInsertTable2).append(existingTr);
			}
			
			// 체크된 주상병의 tr 가져오기
			var selectTr = $(this).closest('tr');
			// 체크된 주상병 tr을 주상병 테이블로 옮기기
			$(sawlInsertTable1).append(selectTr);
			
			// 주상병 체크 된 곳의  name 값
			selectName = $(this).attr("name");
			
		});
		// 부상병, 배제된 상병 라디오 클릭시 테이블 옮기는 이벤트
		$(document).on("change",".otherSick", function(){
			var selectVal = $(this).val();
			var selectTr = $(this).closest('tr');
			
			if(selectVal == 2){
				$("#sawlInsertTable2").append(selectTr);
			}else if(selectVal == 3){
				$("#sawlInsertTable3").append(selectTr);
			}
		});
// 상병 관련 스크립트 끝=======================================================================================================
// 검사 관련 스크립트 시작=======================================================================================================
	// 검사 검색 관련
	var hCTbody = $("#hCTbody");
	var hCInput = $(".hCInput");
	var hcSearchBox = $("#hcSearchBox");
	var hcMenu = $("#hcMenu");
	var hcDropMenu = $("#hcDropMenu");
	var idNo = 1;
	var hCTbodyHtml = "";
	
	// 검사 검색 시작
		// 검색창 포커스 아웃일 때 드롭다운 사라지게 만들기
		hCInput.focusout(function(){
			setTimeout(() => {
				$(hcDropMenu).hide();
			}, 200);
		});
		
		// 검색창 포커스인
		hCInput.focusin(function(){
			$(hcDropMenu).show();
			if(hCInput.val() == "" || hCInput.val() == null){
				
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/healthCheckup/list",
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var hcDropItemHtml = "";
						hCTbodyHtml = "";
						$(res).each(function(idx, item){
							hcDropItemHtml = hcDropItem(this.hlthchkpCd, this.hlthchkpNm, this.mllwncAt, this.hlthchkpAmount)
						});
						$(hCTbody).html(hcDropItemHtml);
					},
					error : function(err){
					}
				});
				
			}
		});
		
		// 검사 keyup 검색
		hCInput.on("keyup",function(event){
			if(event.which != 13){
				var hCKeyword = hCInput.val();
				var hCKeywordObj = { 
						hCKeyword : hCKeyword
						};
				// 검색 환자 정보
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/healthCheckup/select",
					data : JSON.stringify(hCKeywordObj),
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var hcDropItemHtml = "";
						hCTbodyHtml = "";
						if(res.length == 0){
							hcDropItemHtml += "<tr class='oneBoard'>";
							hcDropItemHtml += '<td colspan="5" onclick="event.cancelBubble=true;">조회하신 검사가 없습니다.</td>';
							hcDropItemHtml += '</tr>';
						}else{
							$(res).each(function(idx, item){
								hcDropItemHtml = hcDropItem(this.hlthchkpCd, this.hlthchkpNm, this.mllwncAt, this.hlthchkpAmount)
							});
						}
						$(hCTbody).html(hcDropItemHtml);
					},
					error : function(err){
					}
				});
			}
		});
		
		// 검사 결과 누르기 이벤트들 시작 ---------------------------------------------
		// 엔터 눌렀을 시 제일 위에 검사 코드를 찾는다.
		$(hCInput).keypress(function(event){
			if(event.which == 13){
				event.preventDefault();
				var hlthchkpCd = hCTbody.children("tr:eq(0)").data("hccd");
				var hlthchkpNm = hCTbody.children("tr:eq(0)").data("hcnm");
				var mllwncAt = hCTbody.children("tr:eq(0)").data("mllat");
				var hlthchkpAmount = hCTbody.children("tr:eq(0)").data("hlthchkpamount");
				// input태그 비우기
				$(hCInput).val("");
				// 검사 테이블에 넣어주기
				selectHCAjax(hlthchkpCd, hlthchkpNm, mllwncAt, hlthchkpAmount);
				
				hCInput.blur();
				$(hcDropMenu).hide();
			}
		});
		
		// 검색창 목록 클릭 이벤트
		$(hCTbody).on("click", function(){
			var targets = $(event.target);
			// 클릭된 요소의 부모인 tr 태그
			var clickTr = "";
			if(targets.is('td')){
				clickTr = targets.closest('tr');
			}else if(targets.is('tr')){
				clickTr = targets;
			}
			var hlthchkpCd = clickTr.data("hccd");
			var hlthchkpNm = clickTr.data("hcnm");
			var mllwncAt = clickTr.data("mllat");
			var hlthchkpAmount = clickTr.data("hlthchkpamount");
			
			// input 태그 비워주기
			$(hCInput).val("");
			
			selectHCAjax(hlthchkpCd, hlthchkpNm, mllwncAt, hlthchkpAmount);
			hCInput.blur();
			$(hcDropMenu).hide();
		});
		
		// 검사 누르기 이벤트들 끝 ------------------------------------------------
		// 검사 테이블(hcInsertTable)에 넣어주기
		function selectHCAjax(hlthchkpCd, hlthchkpNm, mllwncAt, hlthchkpAmount){
			idNo++;
			var hcInsertTableHtml = "";
			var mllwncAtKo = '-';
			if(mllwncAt == 'Y'){
				mllwncAtKo = '급여';
			}else if(mllwncAt == 'N'){
				mllwncAtKo = '비급여';
			}
			
			hcInsertTableHtml += "<tr style='font-size: 12px;'>";
			hcInsertTableHtml += '<td class="align-middle white-space-nowrap pt-1 pb-0" style="display: none;">';
			hcInsertTableHtml += '<div class="form-check mb-0">';
			hcInsertTableHtml += '<input class="form-check-input hcCheckTd"type="checkbox" id="checkbox-'+idNo+'" data-bulk-select-row="data-bulk-select-row"/>';
			hcInsertTableHtml += '</div>';
			hcInsertTableHtml += '</td>';
			hcInsertTableHtml += "<td class='align-middle py-0 ps-4 text-left' data-hlthchkpamount='"+hlthchkpAmount+"' style='width: 35px;'>" + hlthchkpCd + "</td>";
			hcInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 30px;'>" + hlthchkpNm + "</td>";
			hcInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 40px;'>" + mllwncAtKo + "</td>";
			hcInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 15px;'><div class='pe-2 me-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon hcDel'></div></div></td>";
			hcInsertTableHtml += "</tr>";
			
			$("#hcInsertTable").append(hcInsertTableHtml);
		}
		
		// 검사 검색창에 목록 생성
		function hcDropItem(hlthchkpCd, hlthchkpNm, mllwncAt, hlthchkpAmount){
			var mllwncAtKo = '-';
			if(mllwncAt == 'Y'){
				mllwncAtKo = '급여';
			}else if(mllwncAt == 'N'){
				mllwncAtKo = '비급여';
			}
			
			hCTbodyHtml += "<tr class='pointer' data-hccd='"+hlthchkpCd+"' data-hcnm='"+hlthchkpNm+"'"
							+" data-mllat='"+mllwncAt+"' data-hlthchkpamount='"+hlthchkpAmount+"'>";
			hCTbodyHtml += "<td class='align-middle text-start px-2'></td>";
			hCTbodyHtml += "<td class='align-middle text-start p-0'>"+hlthchkpCd+"</td>";
			hCTbodyHtml += "<td class='align-middle text-start p-0'>"+hlthchkpNm+"</td>";
			hCTbodyHtml += "<td class='align-middle text-start p-0'>"+mllwncAtKo+"</td>";
			hCTbodyHtml += "<td class='align-middle text-right px-3'></td>";
			hCTbodyHtml += "</tr>";
			
			return hCTbodyHtml;
		}
		
	// 검사 검색 끝
	
	
		// x 버튼 클릭 삭제기능
		$(hcInsertTable).on("click",".hcDel", function(event){
			var btnClick = event.target.closest('tr');
			btnClick.remove();			
		});
	
//검사 관련 스크립트 끝=======================================================================================================
// 치료 관련 스크립트 시작=======================================================================================================
	// 치료 검색 관련
	var mtTbody = $("#mtTbody");
	var mtInput = $(".mtInput");
	var mtSearchBox = $("#mtSearchBox");
	var mtMenu = $("#mtMenu");
	var mtDropMenu = $("#mtDropMenu");
	var mtInsertTable = $("#mtInsertTable");
	var idNo = 1;
	var mtTbodyHtml = "";
	
	// 치료 검색 시작
		// 치료창 포커스 아웃일 때 드롭다운 사라지게 만들기
		mtInput.focusout(function(){
			setTimeout(() => {
				$(mtDropMenu).hide();
			}, 200);
		});
		
		// 치료창 포커스인
		mtInput.focusin(function(){
			$(mtDropMenu).show();
			if(mtInput.val() == "" || mtInput.val() == null){
				
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/medicalTreatment/list",
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var mtDropItemHtml = "";
						mtTbodyHtml = "";
						$(res).each(function(idx, item){
							mtDropItemHtml = mtDropItem(this.mdlrtCd, this.mdlrtNm, this.mllwncAt, this.mdlrtAmount, this.mdlrtCl)
						});
						$(mtTbody).html(mtDropItemHtml);
					},
					error : function(err){
					}
				});
				
			}
		});
		
		// 치료 keyup 검색
		mtInput.on("keyup",function(event){
			if(event.which != 13){
				var mtKeyword = mtInput.val();
				var mtKeywordObj = { 
						mtKeyword : mtKeyword
						};
				// 치료 환자 정보
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/medicalTreatment/select",
					data : JSON.stringify(mtKeywordObj),
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var mtDropItemHtml = "";
						mtTbodyHtml = "";
						if(res.length == 0){
							mtDropItemHtml += "<tr class='text-center'>";
							mtDropItemHtml += '<td colspan="5" onclick="event.cancelBubble=true;">조회하신 치료가 없습니다.</td>';
							mtDropItemHtml += '</tr>';
						}else{
							$(res).each(function(idx, item){
								mtDropItemHtml = mtDropItem(this.mdlrtCd, this.mdlrtNm, this.mllwncAt, this.mdlrtAmount, this.mdlrtCl)
							});
						}
						$(mtTbody).html(mtDropItemHtml);
					},
					error : function(err){
					}
				});
			}
		});
		
		// 치료 결과 누르기 이벤트들 시작 ---------------------------------------------
		// 엔터 눌렀을 시 제일 위에 치료 코드를 찾는다.
		$(mtInput).keypress(function(event){
			if(event.which == 13){
				event.preventDefault();
				var mdlrtCd = mtTbody.children("tr:eq(0)").data("mtcd");
				var mdlrtNm = mtTbody.children("tr:eq(0)").data("mtnm");
				var mllwncAt = mtTbody.children("tr:eq(0)").data("mtmllat");
				var mdlrtAmount = mtTbody.children("tr:eq(0)").data("mdlrtamount");
				var mdlrtCl = mtTbody.children("tr:eq(0)").data("mdlrtcl");
				// input태그에 선택된 이름 넣어주기
				$(mtInput).val("");
				// 치료 테이블에 넣어주기
				selectMTAjax(mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl);
				
				mtInput.blur();
				$(mtDropMenu).hide();
			}
		});
		
		// 치료창 목록 클릭 이벤트
		$(mtTbody).on("click", function(){
			var targets = $(event.target);
			// 클릭된 요소의 부모인 tr 태그
			var clickTr = "";
			
			if(targets.is('td')){
				clickTr = targets.closest('tr');
			}else if(targets.is('tr')){
				clickTr = targets;
			}
			var mdlrtCd = clickTr.data("mtcd");
			var mdlrtNm = clickTr.data("mtnm");
			var mllwncAt = clickTr.data("mtmllat");
			var mdlrtAmount = clickTr.data("mdlrtamount");
			var mdlrtCl = clickTr.data("mdlrtcl");
			// input 태그 비워주기
			$(mtInput).val("");
			
			selectMTAjax(mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl);
			mtInput.blur();
			$(mtDropMenu).hide();
		});
		
		// 치료 결과 누르기 이벤트들 끝 ------------------------------------------------
		// 치료 테이블(mtInsertTable)에 넣어주기
		function selectMTAjax(mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl){
			idNo++;
			var mtInsertTableHtml = "";
	      	
			var mllwncAtKo = "";
			if(mllwncAt == 'Y'){
				mllwncAtKo = "급여";
			}else if(mllwncAt == 'N'){
				mllwncAtKo = "비급여";
			}
			
			mtInsertTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
			mtInsertTableHtml += '<td class="align-middle white-space-nowrap pt-1 pb-0" style="display: none;">';
			mtInsertTableHtml += '<div class="form-check mb-0">';
			mtInsertTableHtml += '<input class="form-check-input mtCheckTd" type="checkbox" id="checkbox-'+idNo+'" data-bulk-select-row="data-bulk-select-row" />';
			mtInsertTableHtml += '</div>';
			mtInsertTableHtml += '</td>';
			mtInsertTableHtml += "<td class='align-middle py-0 ps-4 text-left' style='width: 60px;' data-mdlrtamount='"+mdlrtAmount+"' data-mdlrtcl='"+mdlrtCl+"'>" + mdlrtCd + "</td>";
			mtInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 60px;'>"+mdlrtCl+"</td>";
			mtInsertTableHtml += "<td class='align-left p-0 text-left' style='width: 100px;'>" + mdlrtNm + "</td>";
			mtInsertTableHtml += "<td class='align-middle p-0 text-left me-10' style='width: 50px;'>" + mllwncAtKo + "</td>";
			mtInsertTableHtml += "<td class='align-middle p-0 text-left me-10' style='width: 50px;'><div class='pe-2 me-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon mtDel'></div></div></td>";
			mtInsertTableHtml += "</tr>";
			
			mtInsertTable.append(mtInsertTableHtml);
		}
		
		// 치료 검색창에 목록 생성
		function mtDropItem(mdlrtCd, mdlrtNm, mllwncAt, mdlrtAmount, mdlrtCl){
			var mllwncAtKo = "";
			if(mllwncAt == 'Y'){
				mllwncAtKo = "급여";
			}else if(mllwncAt == 'N'){
				mllwncAtKo = "비급여";
			}
			
			mtTbodyHtml += "<tr class='hover-primary pointer'"
				+ "data-mtcd='"+mdlrtCd+"' data-mtnm='"+mdlrtNm+"' data-mtmllat='"+mllwncAt+"' data-mdlrtamount='"+mdlrtAmount+"' data-mdlrtcl='"+mdlrtCl+"'>";
			mtTbodyHtml += "<td class='align-start py-0 text-left' style='width: 55px;'>"+mdlrtCd+"</td>";
			mtTbodyHtml += "<td class='align-start p-0 text-left' style='width: 60px;'>"+mdlrtCl+"</td>";
			mtTbodyHtml += "<td class='align-start py-0 px-2 white-space-nowrap' style='text-align:left; overflow: hidden; text-overflow: ellipsis; max-width: 150px;'>"+mdlrtNm+"</td>";
			mtTbodyHtml += "<td class='align-start p-0 text-left' style='width: 65px;'>"+mllwncAtKo+"</td>";
			mtTbodyHtml += "<td class='align-start p-0 text-left' style='width: 60px;'></td>";
			mtTbodyHtml += "</tr>";
			
			return mtTbodyHtml;
		}
		
	// 치료 검색 끝
	
	
		// x 버튼 클릭 삭제기능
		$(mtInsertTable).on("click",".mtDel", function(event){
			var btnClick = event.target.closest('tr');
			btnClick.remove();			
		});
		
// 치료 관련 스크립트 끝=======================================================================================================	
// 처방 관련 스크립트 시작=======================================================================================================
	// 처방 검색 관련
	var mTbody = $("#mTbody");
	var mInput = $(".mInput");
	var mSearchBox = $("#mSearchBox");
	var mMenu = $("#mMenu");
	var mDropMenu = $("#mDropMenu");
	var mInsertTable = $("#mInsertTable");
	var idNo = 1;
	var mTbodyHtml = "";
	
	// 처방 검색 시작
		// 처방창 포커스 아웃일 때 드롭다운 사라지게 만들기
		mInput.focusout(function(){
			setTimeout(() => {
				$(mDropMenu).hide();
			}, 200);
		});
		
		// 검색창 포커스인
		mInput.focusin(function(){
			$(mDropMenu).show();
			if(mInput.val() == "" || mInput.val() == null){
				
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/medicine/list",
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var mDropItemHtml = "";
						mTbodyHtml = "";
						$(res).each(function(idx, item){
							mDropItemHtml = mDropItem(this.medcinCd, this.medcinNm, this.medcinMfbiz, this.mdctnCours, this.medcinUnit, this.medcinPc, this.medcinStandard);
						});
						$(mTbody).html(mDropItemHtml);
					},
					error : function(err){
					}
				});
				
			}
		});
		
		// 처방 keyup 검색
		mInput.on("keyup",function(event){
			if(event.which != 13){
				var mKeyword = mInput.val();
				var mKeywordObj = { 
						mKeyword : mKeyword
						};
				// 처방 환자 정보
				$.ajax({
					type : "post",
					url  : "/mediform/doctor/medicine/select",
					data : JSON.stringify(mKeywordObj),
					contentType : "application/json; charset=utf-8",
			        beforeSend : function(xhr){
			            //ajax호출 중 처리
			            //글로벌 변수로 설정한 csrf token 셋팅
			            xhr.setRequestHeader(header,token);
			        },
					success : function(res){
						var mDropItemHtml = "";
						mTbodyHtml = "";
						if(res.length == 0){
							mDropItemHtml += "<tr class='text-center'>";
							mDropItemHtml += '<td colspan="5" onclick="event.cancelBubble=true;">조회하신 약품이 없습니다.</td>';
							mDropItemHtml += '</tr>';
						}else{
							$(res).each(function(idx, item){
								mDropItemHtml = mDropItem(this.medcinCd, this.medcinNm, this.medcinMfbiz, this.mdctnCours, this.medcinUnit, this.medcinPc, this.medcinStandard)
							});
						}
						$(mTbody).html(mDropItemHtml);
					},
					error : function(err){
					}
				});
			}
		});
		
		// 처방 결과 누르기 이벤트들 시작 ---------------------------------------------
		// 엔터 눌렀을 시 제일 위에 처방 코드를 찾는다.
		$(mInput).keypress(function(event){
			if(event.which == 13){
				event.preventDefault();
				var medcinCd = mTbody.children("tr:eq(0)").data("medcincd");
				var medcinNm = mTbody.children("tr:eq(0)").data("medcinnm");
				var medcinMfbiz = mTbody.children("tr:eq(0)").data("medcinmfbiz");
				var mdctnCours = mTbody.children("tr:eq(0)").data("mdctncours");
				var medcinUnit = mTbody.children("tr:eq(0)").data("medcinunit");
				var medcinPc = mTbody.children("tr:eq(0)").data("medcinpc");
				var medcinStandard = mTbody.children("tr:eq(0)").data("medcinstandard");
				// input태그에 선택된 이름 넣어주기
				$(mInput).val("");
				// 처방 테이블에 넣어주기
				selectMAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc , medcinStandard);
				
				mInput.blur();
				$(mDropMenu).hide();
			}
		});
		
		// 검색창 목록 클릭 이벤트
		$(mTbody).on("click", function(){
			var targets = $(event.target);
			// 클릭된 요소의 부모인 tr 태그
			var clickTr = "";
			
			if(targets.is('td')){
				clickTr = targets.closest('tr');
			}else if(targets.is('tr')){
				clickTr = targets;
			}
			var medcinCd = clickTr.data("medcincd");
			var medcinNm = clickTr.data("medcinnm");
			var medcinMfbiz = clickTr.data("medcinmfbiz");
			var mdctnCours = clickTr.data("mdctncours");
			var medcinUnit = clickTr.data("medcinunit");
			var medcinPc = clickTr.data("medcinpc");
			var medcinStandard = clickTr.data("medcinstandard");
			// input 태그 비워주기
			$(mInput).val("");
			
			selectMAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard);
			mInput.blur();
			$(mDropMenu).hide();
		});
		
		// 처방 결과 누르기 이벤트들 끝 ------------------------------------------------
		// 처방 테이블(mInsertTable)에 넣어주기
		function selectMAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard){
			
			idNo++;
			var mInsertTableHtml = "";
	      
			mInsertTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
			mInsertTableHtml += '<td class="align-middle white-space-nowrap pt-1 pb-0" style="display: none;">';
			mInsertTableHtml += '<div class="form-check mb-0">';
			mInsertTableHtml += "<input class='form-check-input mCheckTd' type='checkbox' id='checkbox-'"+idNo+"' data-bulk-select-row='data-bulk-select-row'/>";
			mInsertTableHtml += '</div>';
			mInsertTableHtml += '</td>';
			mInsertTableHtml += "<td class='align-middle ps-4 text-left' style='width: 50px;' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>" + medcinCd + "</td>";
			mInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 120px;'>" + medcinNm + "</td>";
			mInsertTableHtml += "<td class='align-middle p-0 text-left me-1' style='width: 60px;'>" + medcinMfbiz + "</td>";
			mInsertTableHtml += "<td class='align-middle py-0 px-2 text-left' style='width: 50px;'>" + mdctnCours + "</td>";
			mInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			mInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnCpctyInput form-control form-control-sm text-center' value='' />";
			mInsertTableHtml += "<span class='text-center'>"+medcinUnit+"</span>";
			mInsertTableHtml += "</td>";
			mInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			mInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnCoInput form-control form-control-sm text-center' value='' />";
			mInsertTableHtml += "<span class='text-center'>회</span>";
			mInsertTableHtml += "</td>";
			mInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			mInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnPdInput form-control form-control-sm text-center' value='' />";
			mInsertTableHtml += "<span class='text-center'>일</span>";
			mInsertTableHtml += "</td>";
			mInsertTableHtml += "<td class='align-end py-0 px-2 text-end' style='width: 50px;'><div class='pe-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon mDel'></div></div></td>";
			mInsertTableHtml += "</tr>";
			
			mInsertTable.append(mInsertTableHtml);
		}
		
		// 처방 검색창에 목록 생성
		function mDropItem(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard){
			mTbodyHtml += "<tr class='hover-primary pointer'"
				+ "data-medcincd='"+medcinCd+"' data-medcinnm='"+medcinNm+"' data-medcinmfbiz='"+medcinMfbiz+"' data-mdctncours='"+mdctnCours+"'"
				+ "data-medcinunit='"+medcinUnit+"' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>";
			
			mTbodyHtml += "<td class='align-middle py-0 ps-4 text-left' style='width: 20px;'>"+medcinCd+"</td>";
			mTbodyHtml += "<td class='align-middle py-0 white-space-nowrap' style='text-align:left; overflow: hidden; text-overflow: ellipsis; max-width: 120px;'>"+medcinNm+"</td>";
			mTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 70px;'>"+medcinMfbiz+"</td>";
			mTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 60px;'>"+mdctnCours+"</td>";
			mTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 30px;'></td>";
			mTbodyHtml += "</tr>";
			
			return mTbodyHtml;
		}
		
	// 처방 검색 끝
	
	
		// x 버튼 클릭 삭제기능
		$(mInsertTable).on("click",".mDel", function(event){
			var btnClick = event.target.closest('tr');
			btnClick.remove();			
		});
		
		

// 처방 관련 스크립트 끝=================================================================

// 전체 삭제버튼 기능(한개로 모든 곳에 적용 가능)
$(".allDelBtn").on("click", function(event){
	// 클릭된 버튼
	var clickDelBtn = event.target;
	// 클릭된 버튼의 부모 중 테이블 찾기
	var delTable = $(clickDelBtn).closest("table");
	// 부모 테이블 중 tbody자식 찾기
	var delTbody = delTable.find("tbody");
	
	// tbody 만큼 돌리기
	delTbody.each(function() {
		// 돌리면서 아이디를 찾은 후
		var tbodyId = $(this).attr("id");
		// 아이디가 일치하면 그 테이블의 tr 자식을 삭제
		if(tbodyId == "mInsertTable" || tbodyId == "sawlInsertTable1" || tbodyId == "sawlInsertTable2" || tbodyId == "sawlInsertTable3" 
				|| tbodyId == "hcInsertTable" || tbodyId == "mtInsertTable"){
			$(this).find("tr").remove();
		}
	});
	
});
	
// 캔버스 시작 ====================================================================================================================================
	
	
	var canvas = "";
	var context = "";
	// x-ray 모달 이벤트(검사결과를 클릭할 시)
	$(document).on("click",".xrayATag", function(){
		$("#xrayUlTab").empty();
		$("#xrayDivTab").empty();
		
		var mecCd = $(this).data("hlthchkpresult");
		var clnicNo = $("#pastClnicNo").text();
		
		selectXrayResult(clnicNo,'N');
		$("#xrayModal").modal('show');
		
	});
   
	$(document).on("click",".xrayImages", function(){
		$("#xrayUlTab").empty();
		$("#xrayDivTab").empty();
		
		$("#xrayModal").modal('show');
		
		var xrays = $(".xrayImages");
		
		var xrayResultHtml = "";
		var xrayDivResultHtml = "";
		
		var active = "active";
		var ariaASelect = "true";
		
		for(var i = 0; i < xrays.length; i++){
			if(i > 0){
				active = "";
				ariaSelect = "false";
			}
			xrayResultHtml += "<li class='nav-item text-center col-auto me-3' style='width: 60px;'>";
			xrayResultHtml += "<a class='nav-link "+active+" fw-semi-bold py-0' id='xray"+i+"a' data-bs-toggle='tab' href='#tab-xray"+i+"a' role='tab' aria-controls='tab-xray"+i+"a'";
			xrayResultHtml += "aria-selected='"+ariaASelect+"' style='border-bottom: 20px solid; border-radius: 10px;'></a>";
			xrayResultHtml += "</li>";
		}
		
		$("#xrayUlTab").html(xrayResultHtml);
		
		var showActive = "show active";
		
		for(var j = 0; j < xrays.length; j++){
			if(j > 0){
				showActive = "";
			}
			var xraySrc = $(xrays[j]).data("fileflpth");
			
			xrayDivResultHtml += "<div class='tab-pane fade "+showActive+"' id='tab-xray"+j+"a' role='tabpanel' aria-labelledby='a"+j+"xray-tab'>";
			xrayDivResultHtml += "<div style='display: flex; justify-content: center;'>";
			xrayDivResultHtml += "<img alt='' src='"+xraySrc+"' style='width: 480px; height: 600px;'/>";
			xrayDivResultHtml += "</div></div>";
		}
		
		$("#xrayDivTab").html(xrayDivResultHtml);
		
		ariaASelect = "true";	
		active = "active";
		
	});
	
	
// 	function canvasF(){
// 		var allCanvas = $(".xrayCanvas");
// 		console.log("all Canvas : ", allCanvas);
// 		var canvasLength = allCanvas.length;
// 		var canvas = 
// 	    var img = new Image();
// 	    img.src = "";

// 	    for(var i = 0; i < canvasLength; i++){
// 		    canvas = $(".xrayCanvas")[i];
// 		    context = canvas.getContext("2d");
// 			canvasPath = $(".xrayCanvas")[i].data("fileflpth");
// 		    img.src = canvasPath;
// 		}
	    
// 	    let isDrawing = false;
// 	    let drawMode = false;
	
		
// 	    var imgWidth = 480;
// 	    var imgHeight = 600;
	    
	    
	    
// 	    img.onload = function () {
// 	    	context.drawImage(img, 0, 0, imgWidth, imgHeight);  // 이미지를 캔버스에 그립니다.
// 		};
			
// 	}
  
    
// 	lineCap 캔버스 펜 끝 모양 바꾸기
	
// 	$(document).on("keydown", ".xrayCanvas", function(event){
// 		var keyCd = event.keyCode;
		
// 		// 1번을 누를 때 색상
// 		if(keyCd == 49){
// 			context.strokeStyle = "red";
// 		// 2번을 누를 때 색상
// 		}else if(keyCd == 50){
// 			context.strokeStyle = "blue";
// 		// 3번을 누를 때 색상
// 		}else if(keyCd == 51){
// 			context.strokeStyle = "green";
// 		}else if(keyCd == 97){
// 			context.lineWidth = 10;
// 		}else if(keyCd == 98){
// 			context.lineWidth = 20;
// 		}else if(keyCd == 99){
// 			context.lineWidth = 30;
// 		}else if(keyCd == 96){
// 			context.lineWidth = 5;
// 		}else if(keyCd == 52){
// 			context.lineWidth = "black";
// 		}
// 	});
	
//     function enableDrawing() {
//         canvas.style.cursor = 'url("pencil-cursor.png"), auto';
//         drawMode = true;
//     }

//     function disableDrawing() {
//         canvas.style.cursor = 'default';
//         drawMode = false;
//     }

//     $("#drawBtn").click(function () {
//         if (drawMode) {
//             disableDrawing();
//             $(this).text("그림그리기 시작");
//         } else {
//             enableDrawing();
//             $(this).text("그림그리기 중지");
//         }
//     });

//     $(document).on("mousedown", function (e) {
//         if (drawMode) {
//             isDrawing = true;
//             context.beginPath();
//             context.moveTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
//         }
//     });

//     $(document).on("mousemove",".xrayCanvas", function (e) {
//         if (isDrawing) {
//             context.lineTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
//             context.stroke();
//         }
//     });

//     $(document).on("mouseup",".xrayCanvas", function () {
//         isDrawing = false;
//     });

//     $(document).on("mouseleave",".xrayCanvas", function () {
//         isDrawing = false;
//     });
	
//////////////////////////////////////////////////////	
	
// 이미지 오픈 이벤트
//    function openImg(){
//       $("#image-modal").modal('show');
//    }

//     var canvas = $(".XrayCanvas");
//     var context = canvas.getContext("2d");
//     let isDrawing = false;
//     let drawMode = false;

//     var img = new Image();
//     img.src = "";
// //     img.src = '/resources/image/xray/hand.jpg';
   
//     var imgWidth = 480;
//     var imgHeight = 600;
    
    
    
//     img.onload = function () {
//        context.drawImage(img, 0, 0, imgWidth, imgHeight);  // 이미지를 캔버스에 그립니다.
//    };
   
// //    lineCap 캔버스 펜 끝 모양 바꾸기
   
//    $(document).on("keydown", function(event){
//       var keyCd = event.keyCode;
      
//       // 1번을 누를 때 색상
//       if(keyCd == 49){
//          context.strokeStyle = "red";
//       // 2번을 누를 때 색상
//       }else if(keyCd == 50){
//          context.strokeStyle = "blue";
//       // 3번을 누를 때 색상
//       }else if(keyCd == 51){
//          context.strokeStyle = "green";
//       }else if(keyCd == 97){
//          context.lineWidth = 10;
//       }else if(keyCd == 98){
//          context.lineWidth = 20;
//       }else if(keyCd == 99){
//          context.lineWidth = 30;
//       }else if(keyCd == 96){
//          context.lineWidth = 5;
//       }else if(keyCd == 52){
//          context.lineWidth = "black";
//       }
//    });
   
//     function enableDrawing() {
//         canvas.style.cursor = 'url("pencil-cursor.png"), auto';
//         drawMode = true;
//     }

//     function disableDrawing() {
//         canvas.style.cursor = 'default';
//         drawMode = false;
//     }

//     $("#drawBtn").click(function () {
//         if (drawMode) {
//             disableDrawing();
//             $(this).text("그림그리기 시작");
//         } else {
//             enableDrawing();
//             $(this).text("그림그리기 중지");
//         }
//     });

//     canvas.addEventListener("mousedown", function (e) {
//         if (drawMode) {
//             isDrawing = true;
//             context.beginPath();
//             context.moveTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
//         }
//     });

//     canvas.addEventListener("mousemove", function (e) {
//         if (isDrawing) {
//             context.lineTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
//             context.stroke();
//         }
//     });

//     canvas.addEventListener("mouseup", function () {
//         isDrawing = false;
//     });

//     canvas.addEventListener("mouseleave", function () {
//         isDrawing = false;
//     });
 // 캔버스 끝 ====================================================================================================================================   
    
// 제증명 시작 ==================================================================================================================================	 
	// 모달에서 닫기 버튼이랑 저장 버튼을 누를 시 
	$(".modalOthersBtn").on("click", function(){
		setTimeout(() => {
			$("#diagnosisForm").css("display", "none");
			$("#mtcForm").css("display", "none");
			$("#prescriptionForm").css("display", "none");
			$("#hcBtn").css("display", "none");
		}, 100);
		
	});
	
 	$("#certificatesInsertBtn").on("click", function(){
 		
 		var patntNo = $("#cdPatntNoDt").text();
		var rceptNo = $("#cdRceptNoDt").text();
		var clnicNo = $("#cdClnicNoDt").text();
		// 발행 일시
		
		var cdDate = $("#cdHcrtfDtDt2").text();
		var date = new Date(cdDate);
		var year = date.getFullYear().toString().substring(0, 4);
		var month = String(date.getMonth() + 1).padStart(2, '0');
		var day = String(date.getDate()).padStart(2, '0');
		
		var hcrtfDt = year+"-"+month+"-"+day;
		
		// 서류 분류 가져오는 과정
		var hcrtfPapersClNoFormat = $("#cdHcrtfPapersClDt").text();
		hcrtfPapersClFormat = hcrtfPapersClNoFormat.split(" ");
		hcrtfPapersCl = hcrtfPapersClFormat.join("");
 		
		// 의사 소견
		var hcrtfDocNote = $("#cdDocNoteDtTa").val();
		
		if(hcrtfDocNote == null || hcrtfDocNote == "" || hcrtfDocNote == undefined){
			Swal.fire({
			      icon: 'error',
				  title: '진단서',
			      text: '소견을 작성해주세요.',
			      confirmButtonColor: 'blue'
			    });
			$("#certificates-modal").modal();
			$("#cdDocNoteDtTa").focus();
			
			return;
		}
		// 용도
		var hcrtfPrpos = $("#cdHcrtfPrposDtTa").val();
		if(hcrtfPrpos == null || hcrtfPrpos == "" || hcrtfPrpos == undefined){
			Swal.fire({
			      icon: 'error',
				  title: '진단서',
			      text: '용도를 작성해주세요.',
			      confirmButtonColor: 'blue'
			    });
			$("#certificates-modal").modal();
			$("#cdHcrtfPrposDtTa").focus();
			return;
		}
		// 비고
		var hcrtfRm = $("#cdHcrtfRmDtTa").val();
		
		// 추정여부
		var prsmpAt = $(".paRadio:checked").val();
		if(prsmpAt == null || prsmpAt == "" || prsmpAt == undefined){
			Swal.fire({
			      icon: 'error',
				  title: '진단서',
			      text: '추정여부를 체크해주세요.',
			      confirmButtonColor: 'blue'
			    });
			$("#certificates-modal").modal();
			$("#cdHcrtfRmDtTa").focus();
			return;
		}
		
		var hospitalCertificatesVO = {
 				"hcrtfPapersCl" : hcrtfPapersCl,
 				"hcrtfDt" : hcrtfDt,
 				"hcrtfDocNote" : hcrtfDocNote,
 				"hcrtfPrpos" : hcrtfPrpos,
 				"hcrtfRm" : hcrtfRm,
 				"prsmpAt" : prsmpAt,
 				"clnicNo" : clnicNo,
 				"rceptNo" : rceptNo,
 				"patntNo" : patntNo
 		}
		
		$.ajax({
			type : "post",
			url  : "/mediform/common/diagnosis/insert",
			data : JSON.stringify(hospitalCertificatesVO),
			contentType : "application/json; charset=utf-8",
		    beforeSend : function(xhr){
		        //ajax호출 중 처리
		        //글로벌 변수로 설정한 csrf token 셋팅
		        xhr.setRequestHeader(header,token);
		    },
			success : function(res){
				if(res == "OK"){
					Swal.fire({
					      icon: 'success',
						  title: '진단서',
					      text: '정상적으로 등록되었습니다.',
					      confirmButtonColor: 'blue'
					    });
				}else{
					Swal.fire({
					      icon: 'error',
						  title: '진단서',
					      text: '정상적으로 등록되지 않았습니다.',
					      confirmButtonColor: 'blue'
					    });
				}
			},
			error : function(err){
				
			}
		});
		
 	});
 
// 	제증명 드롭다운 div를 가져와 버튼을 누르면 클릭된 버튼의 정보를 가져온다.
	$(".certificatesBtn").on("click", "button", function(){
		
		var patntNo = $("#patntNoDt").val();
		var clnicNo = $("#pastClnicNo").text();
		
		var clnicNoObj = {
				"clnicNo" : clnicNo
		}
		
		// 진단서 클릭시
		if($(this).text() === "진단서"){
			// 모달 띄우기(모달은 하나)
			$(this).modal();
			
			$("#diagnosisForm").css("display", "block");
			$(".hcBtn").css("display", "block");
			
			if(patntNo == "" || patntNo == null || patntNo == undefined || 
					clnicNo == null || clnicNo == "" || clnicNo == undefined){
				$(".paRadio").css("display", "none");
				$("#cdDocNoteDtTa").css("display", "none");
				$("#cdHcrtfPrposDtTa").css("display", "none");
				$("#cdHcrtfRmDtTa").css("display", "none");
				return;
	 		}
			
			$.ajax({
				type : "post",
				url  : "/mediform/common/diagnosis/select",
				data : JSON.stringify(clnicNoObj),
				contentType : "application/json; charset=utf-8",
			    beforeSend : function(xhr){
			        //ajax호출 중 처리
			        //글로벌 변수로 설정한 csrf token 셋팅
			        xhr.setRequestHeader(header,token);
			    },
				success : function(res){
					if(res.length == 0){ // 검사 결과가 없을때
							
					}else{ // 검사 결과가 있을 때
						// 환자번호
						$("#cdPatntNoDt").text(res.patntNo);
						$("#cdRceptNoDt").text(res.rceptNo);
						$("#cdClnicNoDt").text(res.clnicNo);
						
						// 발행일시(등록일시)(연번호)
						if(res.hcrtfDt == null || res.hcrtfDt == "" || res.hcrtfDt == undefined){
							var today = new Date();
							var todayFormat2 = cdFormatDate(today);
							
							var year = today.getFullYear();
						    var month = (today.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 문자열로 변환하여 두 자리로 만듭니다.
						    var day = today.getDate().toString().padStart(2, '0'); // 일도 마찬가지로 두 자리로 만듭니다.
							
							$("#cdhcrtfDtDt").text(year + month + day);
							$("#cdHcrtfDtDt2").text(todayFormat2);
						}else{
							
							var year = res.hcrtfDt.toString().substring(0, 4);
							var month = res.hcrtfDt.toString().substring(5, 2);
							var day = res.hcrtfDt.toString().substring(8, 2);
							
							$("#cdhcrtfDtDt").text(year + month + day);
							
							var hcrtfDtFormat = cdFormatDBDate(res.hcrtfDt);
							
							$("#cdHcrtfDtDt2").text(hcrtfDtFormat);
						}

					   	// 파일번호
					   if(res.fileNo == null || res.fileNo == "" || res.fileNo ==undefined){
					      $("#cdFileNoDt").text("");
					   }else{
					      $("#cdFileNoDt").text(res.fileNo);
					   }
					   
					   // 환자 이름
					   if(res.patntNm == null || res.patntNm == "" || res.patntNm == undefined){
					      
					   }else{
					      $("#cdPatntNmDt").text(res.patntNm);
					   }
					   
					   // 주민등록번호 관련
					   if(res.patntRrno1 == null || res.patntRrno1 == "" || res.patntRrno1 == undefined){
					      
					   }else{
					      if(res.patntRrno2 == null || res.patntRrno2 == "" || res.patntRrno2 == undefined){
					         
					      }else{
					         $("#cdPatntRrno").text(res.patntRrno1+"-"+res.patntRrno2);
					      }
					   }
					   // 주소 관련
					   if(res.patntZip == null || res.patntZip == "" || res.patntZip == undefined){
					         
					   }else{
					      $("#cdZipDt").text(res.patntZip);
					      if(res.patntAdres1 == null || res.patntAdres1 == "" || res.patntAdres1 == undefined){
					            
					      }else{
					         $("#cdPatntAddress1Dt").text(res.patntAdres1);
					         if(res.patntAdres2 == null || res.patntAdres2 == "" || res.patntAdres2 == undefined){
					            
					         }else{
					            $("#cdPatntAddress2Dt").text(res.patntAdres2);
					         }
					      }
					   }
					   
					   // 환자 연락처
					   if(res.patntTelno == null || res.patntTelno == "" || res.patntTelno == undefined){
					      
					   }else{
						   var telFormat = getTelFormat(res.patntTelno);
					      $("#cdPatntTelNoDt").text(telFormat);
					   }
					   
					   // 추정여부
					   if(res.prsmpAt == null || res.prsmpAt == "" || res.prsmpAt == undefined){
						   $(".paRadio").css("display", "block");
						   $("#prsmpAtYSpan").css("display", "none");
						   $("#prsmpAtNSpan").css("display", "none");
					   }else{
					      $(".paRadio").css("display", "none");
					      if(res.prsmpAt == "Y"){
					         $("#prsmpAtYSpan").text("[V]");
					         $("#prsmpAtNSpan").text("&#xa0&#xa0");
					      }else if(res.prsmpAt == "N"){
					         $("#prsmpAtNSpan").text("[N]");
					         $("#prsmpAtYSpan").text("&#xa0&#xa0");
					      }
					   }
					   
					   // 발병일
					   if(res.atfssDt == null || res.atfssDt == "" || res.atfssDt == undefined){
					      
					   }else{
						   var atfssDtFormat = formatDateNoTime(res.atfssDt);
							$("#cdAtfssDt").text(atfssDtFormat);					      
			 		   }
					   // 진료시간
					   var clnicTimeFormat = "";
					   if(res.clnicTime == null || res.clnicTime == "" || res.clnicTime == undefined){
						   
					   }else{
						   clnicTimeFormat = formatDateNoTime(res.clnicTime);
						   
						   $("#cdClnicTimeDt").text(clnicTimeFormat);
					   }
					   
					   // 입원일
					   if(res.hsptlzDe == null || res.hsptlzDe == "" || res.hsptlzDe == undefined){
						   
					   }else{
						   var hsptlzDeFormat = formatDateNoTime(res.hsptlzDe);
						   $("#cdHsptlzDeDt").text(hsptlzDeFormat);
					   }
					   
					   // 퇴원일
					   if(res.realLhstl == null || res.realLhstl == "" || res.realLhstl == undefined){
						   
					   }else{
						   var realLhstlFormat = formatDateNoTime(res.realLhstl);
						   $("#cdRealLhstlDt").text(realLhstlFormat);
					   }
					   
   						// 의사 소견
						if(res.docNote == null || res.docNote == "" || res.docNote == undefined){
							$("#cdDocNoteDtSpan").css("display", "none");
							$("#cdDocNoteDtTa").css("display", "block");
						}else {
							$("#cdDocNoteDtTa").css("display", "none");
							$("#cdDocNoteDtSpan").css("display", "block");
							$("#cdDocNoteDtSpan").text(res.docNote);
						}
   						
   						// 용도
   						if(res.hcrtfPrpos == null || res.hcrtfPrpos == "" || res.hcrtfPrpos == undefined){
   							$("#cdHcrtfPrposDt").css("display", "none");
   							$("#cdHcrtfPrposDtTa").css("display", "block");
   						}else{
   							$("#cdHcrtfPrposDtTa").css("display", "none");
   							$("#cdHcrtfPrposDt").css("display", "block");
   							$("#cdHcrtfPrposDt").text(res.hcrtfPrpos);
   						}
   						
   						// 비고
   						if(res.hcrtfRm == null || res.hcrtfRm == "" || res.hcrtfRm == undefined){
   							$("#cdHcrtfRmDtTa").css("display", "block");
   							$("#cdHcrtfRmDt").css("display", "none");
   						}else{
   							$("#cdHcrtfRmDt").text(res.hcrtfRm);
   							$("#cdHcrtfRmDtTa").css("display", "none");
   						}
   						
   						// 전문의면허번호
						if(res.empDoctrLcnsNo == null || res.empDoctrLcnsNo == "" || res.empDoctrLcnsNo == undefined){
   							
   						}else{
   							$("#cdEmpDoctrLcnsNoDt").text(res.empDoctrLcnsNo);
   						}
   						
   						// 의사이름
						if(res.empNm == null || res.empNm == "" || res.empNm == undefined){
   							
   						}else{
   							$("#cdEmpNmDt").text(res.empNm);
   						}
   						
   						// 상병관련
						var kcdHtml = "";
						var mainSickNm = "";
						var otherSickHtml = "";
						$(res.sickAndWoundedVOList).each(function(){
							
							if(this.sckwndSe == 1){
								if(this.sckwndKr != null && this.sckwndKr != "" && this.sckwndEn != null && this.sckwndEn != ""){
									mainSickNm = "# " + this.sckwndKr + "   " + this.sckwndEn;
								}
							}else {
								if(this.sckwndKr != null && this.sckwndKr != "" && this.sckwndEn != null && this.sckwndEn != ""){
									otherSickHtml += "# " + this.sckwndKr + "   " + this.sckwndEn + "<br>";
								}
							}
							kcdHtml += this.kcd + "<br>"
						});
						$("#cdMainSickDt").html(mainSickNm);
						$("#cdSubSickDt").html(otherSickHtml);
						$("#cdKcdDt").html(kcdHtml);
						
						// 치료 관련
						var mtrHtml = "";
						
						$(res.selectMedicalTreatmentRecordVOList).each(function(){
							
							if(this.mdlrtNm != null && this.mdlrtNm != "" ){
								var formatDtMtr = "";
								
								if(this.mdlrtDt == null || this.mdlrtDt == ""){
									formatDtMtr = "(치료 예정)"
								}else{
									formatDtMtr = formatDateNoTime(this.mdlrtDt);
								}
								mtrHtml += "<tr>";
								mtrHtml += "<td style='width:135px; text-align: center;'>"+ formatDtMtr + "</td>"
								mtrHtml += "<td colspan='2' style='width:135px;'> # "+ this.mdlrtNm + "</td>"
								mtrHtml += "</tr>";
							}
						});
						$("#cdMTRTable").html(mtrHtml);
						
						// 검사 관련
						var meoHtml = "";
						
						$(res.medicalExaminationOrderVOList).each(function(){
							var formatDtMeo = "";
							if((this.hlthchkpDt == null || this.hlthchkpDt == "" ) && this.hlthchkpCd != "HC003"){
								formatDtMeo = "(검사 예정)"
							}else if((this.hlthchkpDt == null || this.hlthchkpDt == "" ) && this.hlthchkpCd == "HC003"){
								formatDtMeo = clnicTimeFormat;
							}else{
								formatDtMeo = formatDateNoTime(this.hlthchkpDt);
							}
							var hlthchkpResultDt = this.hlthchkpResult;
							if(hlthchkpResultDt == null || hlthchkpResultDt == ""){
								hlthchkpResultDt = "";
							}
							
							meoHtml += "<tr>";
							meoHtml += "<td style='width:135px; text-align: center;'>"+ formatDtMeo + "</td>"
							meoHtml += "<td style='width:135px;'> # "+ this.hlthchkpNm + "</td>"
							meoHtml += "<td>"+ hlthchkpResultDt + "</td>"
							meoHtml += "</tr>";
						});
						$("#cdMEOTable").html(meoHtml);
					}
				},
				error : function(err){
				}
			});
			
		}
	 });
	 
// 제증명 끝 ==================================================================================================================================	 
	
// 제일 큰 펑션
}); 

// 그룹오더
$(function(){
	var selectedIds = [];
	
	// 그룹오더 체크
	$('.groupOrderCheck').on('click', function () {
	    var clickedId = this.id;
	    var index = selectedIds.indexOf(clickedId);

	    if (this.checked) {
	        if (index === -1) {
	            selectedIds.push(clickedId);
	        }
	    } else {
	        if (index !== -1) {
	            selectedIds.splice(index, 1);
	        }
	    }
	});

	// 그룹오더 폴더 체크
	$('.groupOrderCheckAll').on('click', function () {
	    var dataTarget = $(this).data('target');
	    var targetCheckboxes = $('ul.groupOrderList' + dataTarget + ' input.groupOrderCheck');
	    var targetData = targetCheckboxes.map(function () {
	        return {
	            id: this.id,
	            contentNm: $(this).data('groupcontentnm'),
	            medcinMfbiz: $(this).data('groupmedcinmfbiz'),
	            mdctnCours: $(this).data('groupmdctncours'),
	            medcinPc: $(this).data('groupMedcinPc'),
	            medcinStandard: $(this).data('groupMedcinStandard'),
	            medcinUnit: $(this).data('groupmedcinunit')
	        };
	    }).get();

	    if (this.checked) {
	        selectedIds = selectedIds.concat(targetData);
	    } else {
	        targetData.forEach(function (data) {
	            var index = selectedIds.findIndex(function (item) {
	                return item.id === data.id;
	            });

	            if (index !== -1) {
	                selectedIds.splice(index, 1);
	            }
	        });
	    }
	});
	
	// 그룹오더 등록버튼 클릭시
	$("#insertGroupOrderBtn").on('click',function(){
		groupOrderReset();
		$("#new-groupOrder-modal").modal('show');
	});
	
    // 오더 등록 버튼 클릭시
   	var groupInsertTableHtml = "";
    $("#orderAjaxBtn").on('click',function(){
    	groupInsertTableHtml = "";
    	
    	selectedIds.forEach(function(data) {
	        var medcinCd = data.id;
	        var medcinNm = data.contentNm;
	        var medcinMfbiz = data.medcinMfbiz;
	        var mdctnCours = data.mdctnCours;
	        var medcinPc = data.medcinPc;
	        var medcinStandard = data.medcinStandard;
	        var medcinUnit = data.medcinUnit;
			
	        idNo++;
			groupInsertTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
			groupInsertTableHtml += "<td class='align-middle ps-4 text-left' style='width: 50px;' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>" + medcinCd + "</td>";
			groupInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 120px;'>" + medcinNm + "</td>";
			groupInsertTableHtml += "<td class='align-middle p-0 text-left me-1' style='width: 60px;'>" + medcinMfbiz + "</td>";
			groupInsertTableHtml += "<td class='align-middle py-0 px-2 text-left' style='width: 50px;'>" + mdctnCours + "</td>";
			groupInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			groupInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnCpctyInput form-control form-control-sm text-center' value='' />";
			groupInsertTableHtml += "<span class='text-center'>"+medcinUnit+"</span>";
			groupInsertTableHtml += "</td>";
			groupInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			groupInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnCoInput form-control form-control-sm text-center' value='' />";
			groupInsertTableHtml += "<span class='text-center'>회</span>";
			groupInsertTableHtml += "</td>";
			groupInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 50px;'>";
			groupInsertTableHtml += "<input type='text' style='font-size: 12px;' class='mdctnPdInput form-control form-control-sm text-center' value='' />";
			groupInsertTableHtml += "<span class='text-center'>일</span>";
			groupInsertTableHtml += "</td>";
			groupInsertTableHtml += "<td class='align-end py-0 px-2 text-end' style='width: 50px;'><div class='pe-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon mDel'></div></div></td>";
			groupInsertTableHtml += "</tr>";
			
	    });
		$("#mInsertTable").append(groupInsertTableHtml);
		
    	groupInsertTableHtml = "";
    	selectedIds = [];
    	$('.groupOrderCheck, .groupOrderCheckAll').prop('checked', false);
    });
    
    var groupTbody = $("#groupTbody");
	var groupInput = $(".groupInput");
	var groupSearchBox = $("#groupSearchBox");
	var groupMenu = $("#groupMenu");
	var groupDropMenu = $("#groupDropMenu");
	var groupInsertTable = $("#groupInsertTable");
	var idNo = 1;
	var groupTbodyHtml = "";
    
 // 그룹오더 처방 검색 시작
	// 처방검색 포커스 아웃
// 	groupInput.focusout(function(){
// 		setTimeout(() => {
// 			$(groupDropMenu).hide();
// 		}, 200);
// 	});
	
	// 그룹오더 검색창 포커스인
	groupInput.focusin(function(){
		$(groupDropMenu).show();
		if(groupInput.val() == "" || groupInput.val() == null){
			
			$.ajax({
				type : "post",
				url  : "/mediform/doctor/medicine/list",
				contentType : "application/json; charset=utf-8",
		        beforeSend : function(xhr){
		            xhr.setRequestHeader(header,token);
		        },
				success : function(res){
					var groupTbodyHtml = "";
					groupTbodyHtml = "";
					$(res).each(function(idx, item){
						groupTbodyHtml = groupDropItem(this.medcinCd, this.medcinNm, this.medcinMfbiz, this.mdctnCours, this.medcinUnit, this.medcinPc, this.medcinStandard);
					});
					$("#groupTbody").html(groupTbodyHtml);
				},
				error : function(err){
				}
			});
			
		}
	});
	
	// 그룹오더 처방 keyup 검색
	groupInput.on("keyup",function(event){
		if(event.which != 13){
			var groupKeyword = groupInput.val();
			var groupKeywordObj = { 
				mKeyword : groupKeyword
			};
			
			// 그룹오더 처방 환자 정보
			$.ajax({
				type : "post",
				url  : "/mediform/doctor/medicine/select",
				data : JSON.stringify(groupKeywordObj),
				contentType : "application/json; charset=utf-8",
		        beforeSend : function(xhr){
		            xhr.setRequestHeader(header,token);
		        },
				success : function(res){
					var groupDropItemHtml = "";
					groupTbodyHtml = "";
					if(res.length == 0){
						groupDropItemHtml += "<tr class='text-center'>";
						groupDropItemHtml += '<td colspan="5" onclick="event.cancelBubble=true;">조회하신 약품이 없습니다.</td>';
						groupDropItemHtml += '</tr>';
					}else{
						$(res).each(function(idx, item){
							groupDropItemHtml = groupDropItem(this.medcinCd, this.medcinNm, this.medcinMfbiz, this.mdctnCours, this.medcinUnit, this.medcinPc, this.medcinStandard)
						});
					}
					$("#groupTbody").html(groupDropItemHtml);
				},
				error : function(err){
				}
			});
		}
	});
	
	// 그룹오더 처방 결과 누르기 이벤트 시작
	// 그룹오더 엔터시
	$(groupInput).keypress(function(event){
		if(event.which == 13){
			event.preventDefault();
			var medcinCd = groupTbody.children("tr:eq(0)").data("medcincd");
			var medcinNm = groupTbody.children("tr:eq(0)").data("medcinnm");
			var medcinMfbiz = groupTbody.children("tr:eq(0)").data("medcinmfbiz");
			var mdctnCours = groupTbody.children("tr:eq(0)").data("mdctncours");
			var medcinUnit = groupTbody.children("tr:eq(0)").data("medcinunit");
			var medcinPc = groupTbody.children("tr:eq(0)").data("medcinpc");
			var medcinStandard = groupTbody.children("tr:eq(0)").data("medcinstandard");
			
			$(groupInput).val("");

			selectGroupAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc , medcinStandard);
			
			groupInput.blur();
			$(groupDropMenu).hide();
		}
	});
	
	// 검색창 목록 클릭 이벤트
	$(groupTbody).on("click", function(){
		var targets = $(event.target);
		// 클릭된 요소의 부모인 tr 태그
		var clickTr = "";
		
		if(targets.is('td')){
			clickTr = targets.closest('tr');
		}else if(targets.is('tr')){
			clickTr = targets;
		}
		var medcinCd = clickTr.data("medcincd");
		var medcinNm = clickTr.data("medcinnm");
		var medcinMfbiz = clickTr.data("medcinmfbiz");
		var mdctnCours = clickTr.data("mdctncours");
		var medcinUnit = clickTr.data("medcinunit");
		var medcinPc = clickTr.data("medcinpc");
		var medcinStandard = clickTr.data("medcinstandard");

		$(groupInput).val("");
		
		selectGroupAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard);
		groupInput.blur();
		$(groupDropMenu).hide();
	});

	// 그룹오더 테이블에 넣어주기
	function selectGroupAjax(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard){
		idNo++;
		var groupInsertTableHtml = "";
      
		groupInsertTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
		groupInsertTableHtml += '<td class="align-middle white-space-nowrap pt-1 pb-0" style="display: none;">';
		groupInsertTableHtml += '<div class="form-check mb-0">';
		groupInsertTableHtml += "<input class='form-check-input mCheckTd' type='checkbox' id='checkbox-'"+idNo+"' data-bulk-select-row='data-bulk-select-row'/>";
		groupInsertTableHtml += '</div>';
		groupInsertTableHtml += '</td>';
		groupInsertTableHtml += "<td class='align-middle ps-4 text-left' style='width: 50px;' data-groupMedcinCd='" + medcinCd + "' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>" + medcinCd + "</td>";
		groupInsertTableHtml += "<td class='align-middle p-0 text-left' style='width: 120px;'>" + medcinNm + "</td>";
		groupInsertTableHtml += "<td class='align-middle p-0 text-left me-1' style='width: 60px;'>" + medcinMfbiz + "</td>";
		groupInsertTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 20px;'>" + mdctnCours + "</td>";
		groupInsertTableHtml += "<td class='align-end py-0 px-2 text-end' style='width: 20px;'><div class='pe-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon groupDel'></div></div></td>";
		groupInsertTableHtml += "</tr>";
		
		groupInsertTable.append(groupInsertTableHtml);
	}
	
	// 그룹오더 검색창에 목록 생성
	function groupDropItem(medcinCd, medcinNm, medcinMfbiz, mdctnCours, medcinUnit, medcinPc, medcinStandard){
		groupTbodyHtml += "<tr class='hover-primary pointer'"
			+ "data-medcincd='"+medcinCd+"' data-medcinnm='"+medcinNm+"' data-medcinmfbiz='"+medcinMfbiz+"' data-mdctncours='"+mdctnCours+"'"
			+ "data-medcinunit='"+medcinUnit+"' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>";
		
		groupTbodyHtml += "<td class='align-middle py-0 ps-4 text-left' style='width: 20px;'>"+medcinCd+"</td>";
		groupTbodyHtml += "<td class='align-middle py-0 white-space-nowrap' style='text-align:left; overflow: hidden; text-overflow: ellipsis; max-width: 120px;'>"+medcinNm+"</td>";
		groupTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 70px;'>"+medcinMfbiz+"</td>";
		groupTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 40px;'>"+mdctnCours+"</td>";
		groupTbodyHtml += "<td class='align-middle py-0 text-left' style='width: 10px;'></td>";
		groupTbodyHtml += "</tr>";
		
		return groupTbodyHtml;
	}
	
	// x 버튼 클릭 삭제기능
	$(groupInsertTable).on("click",".groupDel", function(event){
		var btnClick = event.target.closest('tr');
		btnClick.remove();			
	});
	
	// 검색 닫기 버튼 클릭시 드롭박스 닫기
	$("#groupCloseBtn").on('click',function(){
		$("#groupDropMenu").hide();
	});

	$("#closeGroupBtn").on('click',function(){
		$("#new-groupOrder-modal").hide();
		groupOrderReset();
	});
	
	// 그룹오더 등록 클릭시
	$("#insertGroupBtn").on('click', function() {
	    var contentCdList = [];
		var groNm = $("#groNm").val();
		var empNo = $("#loginEmpNo").val();
        $("#groupInsertTable tr").each(function() {
            var medcinCd = $(this).find('[data-groupMedcinCd]').attr('data-groupMedcinCd');
            contentCdList.push(medcinCd);
        });
	    
		if(groNm == null || groNm == ""){
			Swal.fire({
				title: "그룹오더명 입력",
				text: "그룹오더명을 입력해주세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
			return false;
		}
		if(contentCdList.length == 0  || contentCdList.length < 0){
			Swal.fire({
				title: "약품 입력",
				text: "그룹오더에 등록할 약품을 입력하세요!",
				icon: 'error',
				confirmButtonColor: 'gray',
				confirmButtonText: '닫기'
			});
			return false;
		}
        
	    var doctorGroupOrderVO = {
    		groNm: groNm,
    		empNo: empNo,
    		contentCdList: contentCdList
		};
	    
	    $.ajax({
	 		type : "post",
			url : "/mediform/doctor/clinic/insert/groupOrder",
			data : JSON.stringify(doctorGroupOrderVO),
	 		contentType : "application/json; charset=utf-8",
	 		async: false,
	        beforeSend : function(xhr){            
	            xhr.setRequestHeader(header,token);
	        },
	 		success : function(result) {
 			 	if(result == "OK"){
 			 		Swal.fire({
 			            icon: 'success',
 			            title: '등록 성공',
 			            text: '정상적으로 등록되었습니다.',
 			            confirmButtonText: '확인',
 			            confirmButtonColor: 'midnightblue',
 			          }).then(result => {
 			        	 location.reload();
 			          });
	            }else{
	            	Swal.fire({
 			            icon: 'error',
 			            title: '등록 실패',
 			            text: '등록에 실패하였습니다.',
 			            confirmButtonText: '닫기',
 			           	confirmButtonColor: 'gray',
 			          }).then(result => {
 			        	 location.reload();
 			          });
	            }
	 		},
	 		error: function(){
	 			
	 		}
	 	});
	
	});
	
	// 그룹오더 수정 시
	$(".updateGroupOrderBtn").on('click',function(){
		$("#textSchedulerTitle").text("그룹오더 수정");
		$("#insertGroupBtn").hide();
		$("#insertGroupBtn").css('display','none');
		$("#updateGroupBtn").show();
		$("#updateGroupBtn").css('display','inline-block');
		$("#deleteGroupBtn").show();
		$("#deleteGroupBtn").css('display','inline-block');
		$("#groupInsertTable").text("");
		
		var cd = $(this).val();
		var nm = $(this).data('gronm');
		$("#groNm").val(nm);
		$("#updateGroupBtn").val(cd);
		$("#deleteGroupBtn").val(cd);
		
		var groupCdObj = {
			groCd: cd
		};
		
		$.ajax({
	 		type : "post",
			url : "/mediform/doctor/clinic/medicine/select",
			data : JSON.stringify(groupCdObj),
	 		contentType : "application/json; charset=utf-8",
	 		async: false,
	        beforeSend : function(xhr){            
	            xhr.setRequestHeader(header,token);
	        },
	 		success : function(data) {
 			 	console.log(data);
 			 	
 			 	var groupUpdateTableHtml = "";
	 			if(data.length !== 0){
	 				
	 				$.each(data, function(index, item) {
		 				var medcinCd = item.medcinCd;
		 				var medcinNm = item.medcinNm;
		 				var medcinStandard = item.medcinStandard;
		 				var medcinPc = item.medcinPc;
		 				var medcinMfbiz = item.medcinMfbiz;
		 				var mdctnCours = item.mdctnCours;
		 				
		 				groupUpdateTableHtml += "<tr class='hover-primary' style='font-size: 12px;'>";
		 				groupUpdateTableHtml += "<td class='align-middle ps-4 text-left' style='width: 50px;' data-groupMedcinCd='" + medcinCd + "' data-medcinpc='"+medcinPc+"' data-medcinstandard='"+medcinStandard+"'>" + medcinCd + "</td>";
		 				groupUpdateTableHtml += "<td class='align-middle p-0 text-left' style='width: 120px;'>" + medcinNm + "</td>";
		 				groupUpdateTableHtml += "<td class='align-middle p-0 text-left me-1' style='width: 60px;'>" + medcinMfbiz + "</td>";
		 				groupUpdateTableHtml += "<td class='align-middle py-0 px-2 text-center' style='width: 20px;'>" + mdctnCours + "</td>";
		 				groupUpdateTableHtml += "<td class='align-end py-0 px-2 text-end' style='width: 20px;'><div class='pe-1' style='display: flex; justify-content: flex-end;'><div class='btn-close-falcon groupDel'></div></div></td>";
		 				groupUpdateTableHtml += "</tr>";
	 				});
	 				
					$("#groupInsertTable").append(groupUpdateTableHtml);
					
	 			}	
		 	},
	 		error: function(){
 			}
	 		
		});
		
		// 그룹오더 리스트 업데이트
		$("#updateGroupBtn").on('click',function(){
			var contentCdList = [];
			var groCd = $(this).val();
			var groNm = $("#groNm").val();
			var empNo = $("#loginEmpNo").val();
		    
	        $("#groupInsertTable tr").each(function() {
	            var medcinCd = $(this).find('[data-groupMedcinCd]').attr('data-groupMedcinCd');
	            contentCdList.push(medcinCd);
	        });
	        
	        if(groNm == null || groNm == ""){
				Swal.fire({
					title: "그룹오더명 입력",
					text: "그룹오더명을 입력해주세요!",
					icon: 'error',
					confirmButtonColor: 'gray',
					confirmButtonText: '닫기'
				});
				return false;
			}
			if(contentCdList.length == 0  || contentCdList.length < 0){
				Swal.fire({
					title: "약품 입력",
					text: "수정할 그룹오더 약품을 입력하세요!",
					icon: 'error',
					confirmButtonColor: 'gray',
					confirmButtonText: '닫기'
				});
				return false;
			}
	        
		    var doctorGroupOrderVO = {
		    		groCd: groCd,
		    		groNm: groNm,
		    		empNo: empNo,
		    		contentCdList: contentCdList
			};
// 			console.log(doctorGroupOrderVO);
		    
		    $.ajax({
		 		type : "post",
				url : "/mediform/doctor/clinic/update/groupOrder",
				data : JSON.stringify(doctorGroupOrderVO),
		 		contentType : "application/json; charset=utf-8",
		 		async: false,
		        beforeSend : function(xhr){            
		            xhr.setRequestHeader(header,token);
		        },
		 		success : function(result) {
	 			 	if(result == "OK"){
	 			 		Swal.fire({
	 			            icon: 'success',
	 			            title: '수정 성공',
	 			            text: '정상적으로 삭제되었습니다.',
	 			            confirmButtonText: '확인',
	 			            confirmButtonColor: 'midnightblue',
	 			          }).then(result => {
	 			        	 location.reload();
	 			          });
		            }else{
		            	Swal.fire({
	 			            icon: 'error',
	 			            title: '수정 실패',
	 			            text: '수정에 실패하였습니다.',
	 			            confirmButtonText: '닫기',
	 			           	confirmButtonColor: 'gray',
	 			          }).then(result => {
	 			        	 location.reload();
	 			          });
		            }
		 		},
		 		error: function(){
		 		}
		 	});
		});
		
		
		// 그룹오더 삭제
		$("#deleteGroupBtn").on('click',function(){
			var contentCdList = [];
			var groCd = $(this).val();
		    
	        $("#groupInsertTable tr").each(function() {
	            var medcinCd = $(this).find('[data-groupMedcinCd]').attr('data-groupMedcinCd');
	            contentCdList.push(medcinCd);
	        });
	        
		    var doctorGroupOrderVO = {
		    		groCd: groCd
			};
		    
		    $.ajax({
		 		type : "post",
				url : "/mediform/doctor/clinic/delete/groupOrder",
				data : JSON.stringify(doctorGroupOrderVO),
		 		contentType : "application/json; charset=utf-8",
		 		async: false,
		        beforeSend : function(xhr){            
		            xhr.setRequestHeader(header,token);
		        },
		 		success : function(result) {
	 			 	if(result == "OK"){
	 			 		Swal.fire({
	 			            icon: 'success',
	 			            title: '삭제 성공',
	 			            text: '정상적으로 삭제되었습니다.',
	 			            confirmButtonText: '확인',
	 			            confirmButtonColor: 'midnightblue',
	 			          }).then(result => {
	 			        	 location.reload();
	 			          });
		            }else{
		            	Swal.fire({
	 			            icon: 'error',
	 			            title: '삭제 실패',
	 			            text: '삭제에 실패하였습니다.',
	 			            confirmButtonText: '닫기',
	 			           	confirmButtonColor: 'gray',
	 			          }).then(result => {
	 			        	 location.reload();
	 			          });
		            }
		 		},
		 		error: function(){
		 		}
		 	});
		});
		
	});


});

// 그룹오더 폼 초기화
function groupOrderReset(){
	$("#groNm").val("");
	$("#groupTbody").text("");
	$("#groupInsertTable").text("");
	$("#textSchedulerTitle").text("그룹오더 생성");
	$("#insertGroupBtn").show();
	$("#insertGroupBtn").css('display','inline-block');
	$("#updateGroupBtn").hide();
	$("#updateGroupBtn").css('display','none');
	$("#deleteGroupBtn").hide();
	$("#deleteGroupBtn").css('display','none');
}

</script>

</html>