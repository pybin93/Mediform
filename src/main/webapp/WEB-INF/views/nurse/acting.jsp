<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PatientList</title>
<style type="text/css">
#vital-column {
	width: 60%;
}

th {
	background-color: midnightblue;
	color: white;
}

.pointer {
	cursor: pointer;
}

.card {
	overflow-y: auto;
}

/* 프린트 출력 (pdf 저장)*/
@media print {
	body * {
		display: none;
	}
	#qrContent {
		display: block !important;
	}
}

#patientoPvTable th {
	width: 100px;
	height: 20px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

/* 환자 접수상태 버튼 css - 접수상태랑 호출 크기 맞출라고*/
.callbutton {
	width: 60px;
	height: 30px;
	padding: 1px 5px;
	font-size: x-small;
}

thisButton.css {
	width: 60px;
	height: 30px;
	padding: 1px 5px;
	font-size: x-small;
}

.table thead {
	position: sticky;
	top: 0;
	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}

/* 환자 접수상태 버튼 css 끝*/
.card-header {
	position: sticky;
	top: 0;
	z-index: 1;
}

.table thead {
	position: sticky;
	top: 0;
	z-index: 1;
}

.patientInfoCss {
	font-size: small;
	border: none;
	box-shadow: none;
	background-color: none;
	background: initial;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-2">
			<div class="card border border-secondary" style="height: 820px;">

				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">환자리스트</h5>
					</div>
				</div>
				<div class="card border scrollbar" style="height: 800px;">
					<div>
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item text-center col-6"><a
								class="nav-link active fw-semi-bold" id="waiting-tab"
								data-bs-toggle="tab" href="#tab-waiting" role="tab"
								aria-controls="tab-waiting" aria-selected="true">검사대기</a></li>
							<li class="nav-item text-center col-6"><a
								class="nav-link fw-semi-bold" id="done-tab" data-bs-toggle="tab"
								href="#tab-done" role="tab" aria-controls="tab-done"
								aria-selected="false">검사완료</a></li>
						</ul>
					</div>
					<div>
						<div class="row card-body" style="padding: 0px; height: 650px;">
							<div class="tab-content" id="myTabContent">

								<!-- 검사대기 탭 시작 -->
								<div class="col-12 tab-pane fade show active p-0"
									id="tab-waiting" role="tabpanel" aria-labelledby="waiting-tab">
									<div class="col-12"
										style="display: flex; justify-content: flex-end;"></div>
									<div
										class="list bg-body-tertiary scrollbar d-flex flex-column gap-1 "
										id="waitingList" style="overflow-y: auto; max-height: 650px;">
										<!-- 내용 ajax 비동기 생성 -->
									</div>
								</div>
								<!-- 검사대기 탭 끝 -->

								<!-- 검사완료 탭 시작 -->
								<div class="col-12 tab-pane fade" id="tab-done" role="tabpanel"
									aria-labelledby="done-tab">
									<div class="list bg-body-tertiary d-flex flex-column gap-1 "
										id="doneClinicList"
										style="overflow-y: auto; max-height: 650px;"></div>
								</div>
								<!-- 검사완료 탭 끝 -->

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 상세정보 및 진료기록 -->
		<div class="col-4">

			<div class="card border border-secondary" style="height: 210px;">

				<div class="card-header border-bottom p-2" style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">환자 상세정보</h5>
					</div>
				</div>

					<div class="card-body scrollbar m-0 p-0">
				
					<div class="row mt-1" style="width: 600px;">
						<div class="col-6 pe-0" >
							<div class="input-group input-group-sm">
								<span class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">환자번호</span>
								<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntNoDt" readonly="readonly"/>
							</div>
						</div>
						<div class="col-6 ps-0"  style="width:300px;">
							<div class="input-group input-group-sm">
								<span class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">환자명</span>
								<input class="form-control patientInfoCss patient-content pe-0" type="text" id="patntNmDt" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="row" style="width: 600px;">
						<div class="col-6 pe-0">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">생년월일</span>
								<input class="form-control patientInfoCss patient-content pe-0"
									type="text" id="patntRrno1Dt" readonly="readonly" />
							</div>
						</div>
						<div class="col-6 ps-0" style="width:300px;">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0"
									style="letter-spacing: 4px;">나 이</span> <input
									class="form-control patientInfoCss patient-content pe-0"
									type="text" id="patntAgeDt" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="row" style="width: 600px;">
						<div class="col-6 pe-0">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0"
									style="letter-spacing: 13px;">성별</span> <input
									class="form-control patientInfoCss patient-content pe-0"
									type="text" id="patntSexdstnDt" readonly="readonly" />
							</div>
						</div>
						<div class="col-6 ps-0" style="width:300px;">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">환자연락처</span>
								<input class="form-control patientInfoCss patient-content pe-0"
									type="text" id="patntTelnoDt" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="row" style="width: 600px;">
						<div class="col-6 pe-0">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">보험여부</span>
								<input class="form-control patientInfoCss patient-content pe-0"
									type="text" id="patntHlthinsAtDt" readonly="readonly" />
							</div>
						</div>
						<div class="col-6 ps-0" style="width:300px;">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0"
									style="letter-spacing: 4px;">입원여부</span> <input
									class="form-control patientInfoCss patient-content pe-0"
									type="text" id="hsptlzAtDt" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="row" style="width: 600px;">
						<div class="col-6 pe-0">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">보호자연락처</span>
								<input class="form-control patientInfoCss patient-content pe-0"
									type="text" id="prtctorTelnoDt" readonly="readonly" />
							</div>
						</div>
						<div class="col-6 ps-0" style="width:300px;">
							<div class="input-group input-group-sm">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0">보호자이름</span>
								<input class="form-control patientInfoCss patient-content pe-0"
									type="text" id="prtctorNmDt" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="row" style="width: 600px;">
						<div class="col">
							<div class="input-group input-group-sm mb-2">
								<span
									class="input-group-text fw-semi-bold patientInfoCss patientCss2 pe-0"
									style="display: flex; align-items: flex-start;">특이사항</span>
								<textarea class="form-control patientInfoCss patient-content"
									cols="2" id="patntMemoDt" readonly="readonly"></textarea>
							</div>
						</div>
						</div>
					</div>
				<!-- 환자 정보 끝 -->
			</div>


			<!--  신체계측 및 바이타아ㅏ아아아알 -->
			<div class="card border border-secondary"
				style="height: 70px; margin-top: 5px;">

				<div class="card-body scrollbar m-0 p-0">

					<div class="row">
						<table class="table mb-0 p-0 data-table fs--1 "
							id="patientoPvTable">
							<thead class="bg-200 m-0">
								<tr>
									<th class="text-800 text-center p-2">키</th>
									<th class="text-800 text-center p-2">몸무게</th>
									<th class="text-800 text-center p-2">혈액형</th>
									<th class="text-800 text-center p-2">최고혈압</th>
									<th class="text-800 text-center p-2">최저혈압</th>
									<th class="text-800 text-center p-2">체온</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="patntHeightDt" name="patntHeight" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="patntBdwghDt" name="patntBdwgh" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="patntBdpDt" name="patntBdp" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="hghrkHhprsDt" name="hghrkHhprs" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="lwtrkHhprsDt" name="lwtrkHhprs" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
									<td style="padding: 0px;"><input
										class="form-control bg-white text-black text-center"
										id="bdheatDt" name="bdheat" type="text" value=""
										style="font-size: 0.8rem; border: none; box-shadow: none;"
										disabled /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>



			<!-- 진료기록  -->
			<div class="card border scrollbar border-secondary"
				style="height: 530px; margin-top: 5px;"">
				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">검사 및 처방
							오더</h5>
					</div>
				</div>
				<div class="card-body" style="padding: 0px; padding-top: 20px;">

					<div class="row">
						<div class="col-auto"
							style="padding-left: 20px; padding-right: 5px;">
							<div class="card"
								style="height: 465px; min-width: 82px; max-width: 105px;">
								<div class="card-header p-1"
									style="border-bottom: 1px solid #ededed; background-color: midnightblue;">
									<div class="" style="display: flex; justify-content: center;">
										<div class="fw-semi-bold text-white text-center"
											style="font-size: 14px;">진료날짜</div>
									</div>
								</div>
								<div id="clinicRecord" class="list-group"
									style="width: 105px; padding: 0;"></div>
							</div>

						</div>

						<div class="col-auto"
							style="padding-left: 0px; padding-right: 20px;">
							<div class="card scrollbar" style="height: 465px; width: 485px;">
								<div class="card-header p-1"
									style="border-bottom: 1px solid #ededed; background-color: midnightblue; position: sticky;">
								</div>
								<div class="col-auto" id="clnic-list"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--  =================================검사시행 및 바코드================================   -->
		<div class="col-3">

			<!--  검사 시행 -->
			<div class="card border border-secondary" style="height: 370px;">
				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">검사 시행</h5>
					</div>
				</div>


				<div class="card-body">
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
					</div>
					<div class="table-responsive scrollbar mx-nx1 mt-3">

						<div class="table mb-0 overflow-hidden data-table fs--4">
							<table class="table mb-0 data-table fs--1 ">
								<thead class="bg-200 m-0">
									<tr>
										<th class="text-center" scope="col">검사코드</th>
										<th class="text-center" scope="col">검사명</th>
										<th class="text-center" scope="col">Actions</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-center">HC001</td>
										<td class="text-center">혈액검사</td>
										<td class="text-center">
											<div>
												<button class="btn btn-link p-0 hcAction" type="button">
													<span class="material-icons text-secondary fs-2">add_task</span>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<td class="text-center">HC002</td>
										<td class="text-center">소변검사</td>
										<td class="text-center">
											<div>
												<button class="btn btn-link p-0 hcAction" type="button">
													<span class="material-icons text-secondary fs-2">add_task</span>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<td class="text-center">HC003</td>
										<td class="text-center">X-RAY</td>
										<td class="text-center">
											<div>
												<button class="btn btn-link p-0" type="button"
													id="hcAction3">
													<span class="material-icons text-secondary fs-2">add_task</span>
												</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!--  환자 식별 qr코드 -->
			<div class="card border border-secondary" style="height: 450px;">
				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">환자 식별
							QR코드</h5>
					</div>
				</div>
				<div class="card-body">
					<div class="table-responsive scrollbar mx-nx1 mt-3" id="qrTable">
						<ul class="nav nav-tabs" id="qrTab" role="tablist">
							<li class="nav-item"><a class="nav-link active" id="qrTab1"
								data-bs-toggle="tab" role="tab" aria-controls="tab-home"
								aria-selected="true">QR코드 생성 </a></li>
						</ul>
						<div class="tab-content border border-top-0 p-3" id="qrContent">
							<div class="tab-pane fade show active" id="generateQr"
								role="tabpanel" aria-labelledby="barcodeTab1">
								<div class="qr-body d-flex flex-column align-items-center">
									<img
										src="https://quickchart.io/qr?text=//localhost/mediform/nurse/acting?patnt &dark=fff&light=000&ecLevel=H"
										id="qr" alt="" style="display: none;">
									<button class="btn btn-primary mt-2 btn-sm" id="printQr"
										onclick="return window.print();"
										style="display: none; background: midnightblue; border: none;">출력</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!--  오더 및 검사 -->
		<div class="col-3">

			<div class="card border border-secondary" style="height: 820px;">


				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="col-12 align-self-center">
						<h5 class="text-white mb-0 fw-semi-bold" id="header">오더 및 검사
							결과</h5>
					</div>
				</div>


				<div class="card-body scrollbar" style="padding-top: 0;">
					<div class="table-responsive scrollbar mt-1" id="orderExam">
						<ul class="mb-0 treeview scrollbar" id="treeviewExample"
							style="height: 1000px;">
							<li class="treeview-list-item"><a data-bs-toggle="collapse"
								href="#treeviewExample-1-1" role="button" aria-expanded="true">
									<p class="treeview-text" style="font-size: 18px;">검사</p>
							</a>
								<ul class="collapse treeview-list" id="treeviewExample-1-1"
									data-show="false">
									<li class="treeview-list-item"><a
										data-bs-toggle="collapse" href="#treeviewExample-2-1"
										role="button" aria-expanded="false">
											<p class="treeview-text" style="font-size: 17px;">입원검사</p>
									</a>
										<ul class="collapse treeview-list" id="treeviewExample-2-1"
											data-show="true">
											<li class="treeview-list-item"><a
												data-bs-toggle="collapse" href="#treeviewExample-3-1"
												role="button" aria-expanded="false">
													<p class="treeview-text" style="font-size: 16px;">혈액검사</p>
											</a>
												<ul class="collapse treeview-list" id="treeviewExample-3-1"
													data-show="true">
													<li class="treeview-list-item">
														<div class="treeview-item">
															<a class="flex-1" href="#!">
																<div class="input-group mb-1">
																	<input type="text" id="bloodResult"
																		class="form-control form-control-sm"
																		placeholder="결과를 입력해 주세요" style="width: 160px;">
																	<button class="btn btn-secondary btn-sm" type="button"
																		id="bBtn"
																		style="background-color: midnightblue; width: 55px;">저장</button>
																	<div id="result" style="width: 70px;"></div>
																</div>
															</a>
														</div>
													</li>
												</ul></li>
											<li class="treeview-list-item"><a
												data-bs-toggle="collapse" href="#treeviewExample-3-2"
												role="button" aria-expanded="true">
													<p class="treeview-text" style="font-size: 16px;">소변검사</p>
											</a>
												<ul class="collapse treeview-list" id="treeviewExample-3-2"
													data-show="true">
													<li class="treeview-list-item">
														<div class="treeview-item">
															<a class="flex-1" href="#!">
																<div class="input-group mb-1">
																	<input type="text" id="peaResult"
																		class="form-control form-control-sm"
																		placeholder="결과를 입력해 주세요" style="width: 160px;">
																	<button class="btn btn-secondary btn-sm" type="button"
																		id="pBtn"
																		style="background-color: midnightblue; width: 55px;">저장</button>
																	<div id="result" style="width: 70px;"></div>
																</div>
															</a>
														</div>
													</li>
												</ul></li>
										</ul></li>



									<!--  x-ray 검사결과 (file) -->

									<li class="treeview-list-item"><a
										data-bs-toggle="collapse" href="#treeviewExample-2-2"
										role="button" aria-expanded="true">
											<p class="treeview-text" style="font-size: 16px;">X-RAY</p>
									</a>
										<ul class="collapse treeview-list" id="treeviewExample-2-2"
											data-show="true">
											<li class="treeview-list-item">
												<div class="treeview-item mt-1">
													<form id="xrayForm"
														action="/mediform/nurse/acting/xray/insert" method="post"
														enctype="multipart/form-data">
														<div class="input-group mb-1" style="width: 260px;">
															<input type="file" id="atchXrayFile"
																class="form-control form-control-sm" name="atchXrayFile"
																multiple="multiple">
															<button type="button" id="xrayBtn"
																class="btn btn-secondary btn-sm"
																style="background-color: midnightblue;">저장</button>
															<div id="result"></div>
															<input type="hidden" id="xrayMecCdHidden" name="mecCd"
																value=""> <input type="hidden"
																id="xrayRceptNoHidden" name="rceptNo" value="">
														</div>
														<sec:csrfInput />
													</form>
												</div>
											</li>
										</ul></li>
								</ul></li>

							<!-- ================= 주사 ================= -->
							<li class="treeview-list-item mt-2"><a
								data-bs-toggle="collapse" href="#treeviewExample-1-2"
								role="button" aria-expanded="false">
									<p class="treeview-text" style="font-size: 17px;">주사</p>

							</a>
								<ul class="collapse treeview-list" id="treeviewExample-1-2"
									data-show="true">
									<li class="treeview-list-item">
										<div class="treeview-item">
											<button class="btn btn-secondary btn-sm" type="button"
												id="iBtn" style="background-color: green;">처치 완료</button>
											<div id="result"></div>
										</div>
									</li>
								</ul></li>

							<!-- ==============바이탈 ================= -->

							<li class="treeview-list-item mt-3"><a
								data-bs-toggle="collapse" href="#treeviewExample-1-2"
								role="button" aria-expanded="true">
									<p class="treeview-text" style="font-size: 17px;">바이탈</p>
							</a>
								<ul class="collapse treeview-list" id="treeviewExample-1-2"
									data-show="true">
									<li class="treeview-list-item mt-2">
										<div class="treeview-item">
											<a class="flex-1" href="#!">
												<p class="treeview-text" style="font-size: 16px;">
													<span class="me-2 fas fa-file-archive text-warning"></span>
													최고혈압
												</p>
												<div class="input-group mb-1" style="width:290px;">
													<input type="text" id="HpResult"
														class="form-control form-control-sm"
														placeholder="결과를 입력해 주세요">
												</div>
											</a>
										</div>
									</li>
									<li class="treeview-list-item">
										<div class="treeview-item mt-2">
											<a class="flex-1" href="#!">
												<p class="treeview-text" style="font-size: 16px;">
													<span class="me-2 fas fa-file text-primary"></span> 최저혈압
												</p>
												<div class="input-group mb-1" style="width:290px;">
													<input type="text" id="LpResult"
														class="form-control form-control-sm"
														placeholder="결과를 입력해 주세요">
												</div>
											</a>
										</div>
									</li>
									<li class="treeview-list-item">
										<div class="treeview-item mt-2">
											<a class="flex-1" href="#!">
												<p class="treeview-text" style="font-size: 16px;">
													<span class="me-2 fas fa-file-pdf text-danger"></span> 체온
												</p>
												<div class="input-group mb-1" style="width:290px;">
													<input type="text" id="TemResult"
														class="form-control form-control-sm"
														placeholder="결과를 입력해 주세요">
												</div>
												<button class="btn btn-secondary btn-sm mt-3" id="vBtn"
													type="button" style="background-color: midnightblue;">저장</button>
												<div id="result" />
											</a>
										</div>
									</li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>

<script src="vendors/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="../../../resources/assets/js/nurse/jquery-barcode.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />

<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var selectedPatntNo;

console.log('1');

	//검사대기 환자 리스트
	$(function(){
		console.log('6');
	
		$.ajax({
			type: "get",
			url: "/mediform/doctor/room/list/waiting",
			contentType : "application/json; charset=utf-8",
	        beforeSend : function(xhr){
	        	 xhr.setRequestHeader(header,token);
	        },
	        success : function(data){
				var waitingList = "";
				var doneList = "";
				console.log(data);
				
				$.each(data, function(index, item) {
	        		var rceptNo = item.rceptVO.rceptNo;						// 접수번호
					var status = item.rceptVO.rceptSttus;					// 상태
					var rceptClnicAt = item.rceptVO.rceptClnicAt;			//재호출 여부
					var name = item.patientVO.patntNm;					// 환자명
					
		        	var hlthinsAt = item.patientVO.patntHlthinsAt;		// 건강보험
		        	if(hlthinsAt == "Y"){
		        		hlthinsAt = "보험 유";
					}else{
						hlthinsAt = "보험 무";
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
					if(memo == "null" || memo == undefined){
						memo = "진료 메모가 없습니다";
					}
					
					var itemList = "";
					
					if(status == "2" | status == "3" ){
		        		
						if(status == "2"){
							status = "검사대기";
							color = "warning";
						}else if(status == "3"){
							status = "검사중";
							color = "success";
						}
						
						itemList += "<div id='" + no + "' class='noFormat patientWaitingList bg-white dark__bg-1100 d-md-flex d-xl-inline-block d-xxl-flex align-items-center p-3 rounded-3 shadow-sm card-view-height gap-1'>";
						itemList += "<div class='d-flex align-items-start align-items-sm-center'>";
						itemList += "<div class='row align-items-center gx-0 gy-2'>";
						itemList += "<div class='col-auto'>";
						itemList += "<div class='row'>";
						itemList += "<div class='col-7'>";
						itemList += "<span class='fas fa-user' data-fa-transform='shrink-3 up-1'></span>";
						itemList += " <span style='font-weight: bold;'>" + name + "</span>";
						itemList += "</div>";
						itemList += "<div class='col-5' style='padding-right: 10px; display: flex; justify-content: flex-end;'>";
						itemList += "<button class='btn btn-sm btn-outline-" + color + " callbutton' style='padding-right:5px; padding-left:5px; font-size: x-small;' id='" + rceptClnicAt + "' value='" + rceptNo + "'>" + status +"</button>";
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
						
						console.log("rceptClnicAt>>>>>>>>>>>>>>" + rceptClnicAt);
						
						waitingList += itemList;
					
					}else if(status == "4" | status == "5"){
						
						if(status == "4"){
							status = "검사완료";
							color = "dark";
						}else if(status == "5"){
							status = "치료대기";
							color = "primary";
						}
						
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
	        	Swal.fire({
				      icon: 'warning',
				      title: '검사 완료',
				      text: '모든 검사가 완료되었습니다!',
				      confirmButtonColor: 'midnightblue'
				    });
	        }
		});
	});
	
			// 검사대기 때 호출 hover
			$(document).on('mouseover', '.callbutton:contains("검사대기")', function() {
				$(this).text("호출");
				$(this).css({"font-weight": "bold", "font-size": "x-small"});
			}).on('mouseout', '.callbutton:contains("호출")', function() {
				$(this).text("검사대기");
				$(this).css({"font-weight": "normal", "font-size": "x-small"});
			});
			
			
			// 호출 버튼 클릭시
			$(document).on('click', '.callbutton', function() {
			    var $thisButton = $(this);  // 현재 클릭한 버튼
			    var rceptNo = $thisButton.val();
			    
			    var updateObject = {};
			    var rceptClnicAtPatient = $(this).attr("id");
			    
			    console.log(">>>rceptClnicAt<<< ::: " + rceptClnicAtPatient);
			    
			    
			    // 검사대기 버튼을 눌렀을 때
			    if ($thisButton.text() === "호출" || $thisButton.text() === "검사대기") {
			        updateObject = {
			            rceptNo: rceptNo,
			            rceptSttus: 3  // 검사중 상태값
			        };
			        $thisButton.text("검사중");
			        $thisButton.removeClass("btn-outline-warning").addClass("btn-outline-success");
			
			    // 검사중 버튼을 눌렀을 때
			    } else if ($thisButton.text() === "검사중") {
			        updateObject = {
			            rceptNo: rceptNo,
			            rceptSttus: 4  // 검사완료 상태값
			        };
			        $thisButton.text("검사완료");
			        $thisButton.removeClass("btn-outline-success").addClass("btn-outline-dark");
			        location.reload();
			    } else if ($thisButton.text() === "검사완료") {
// 			        if (rceptClnicAtPatient === 'Y') {
			            updateObject = {
			                rceptNo: rceptNo,
			                rceptSttus: 5  
			            };
			            $thisButton.text("치료대기");
			            $thisButton.removeClass("btn-outline-dark").addClass("btn-outline-primary");
// 			        }
			    }

			    console.log(updateObject);
				
				$.ajax({
					type: "post",
					url: "/mediform/doctor/room/update/status",
					data: JSON.stringify(updateObject),
					contentType: "application/json; charset=utf-8",
			        beforeSend: function(xhr){
			        	 xhr.setRequestHeader(header,token);
			        },
			        success: function(data){
						console.log(data);
			        },
			        error: function(){
			        	alert("서버오류! 다시 시도해주세요.");	
			        }
				});
			});
			

	// 진료기록 (날짜별로 보기)
	function showSection(id) {
	    let sections = document.querySelectorAll('[id^="clnic-section-"]');
	    sections.forEach(section => {
	        section.style.display = 'none';
	    });
	
	    document.getElementById('clnic-section-' + id).style.display = 'block';
	}

	
	function handleClick() {
        // 클릭한 요소의 아이디를 가져옵니다.
        var elementId = $(this).attr('id');
        alert("클릭한 요소의 아이디: " + elementId);
      }	
	$('#waitingList .patientWaitingList').click(handleClick);
	
//환자 상세 정보 및 진료기록 불러오기

$(function(){

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var $waitingList = $("#waitingList"); // div태그
	
	var patientWaitingList = $(".patientWaitingList");
	// 대기 리스트 중 환자 이름 선택하면 상세 정보로 값 넘기기
	
	$waitingList.on("click", ".patientWaitingList", function() {
		
		var selectedPatientNo = $(this).attr("id");
		// this => 내가 클릭한 div.patientWaitingList 의 블럭
		
		console.log("대기환자 클릭이벤트>>>>>!!!")
		
		var _patntNo = $(this).attr("id");
		$("#patientDetail").data("patntno", _patntNo);
		console.log("patntNo >>>>>> " + _patntNo);
		
		// 환자 상세정보 조회
        selectPatientAjax(_patntNo);
		
		// 환자 바이탈 조회
		selectPatientVital(_patntNo);

		// 환자 진료기록 조회
		selectAllClinic(_patntNo);
		
		
		// 환자 바이탈 insert
		insertPatientVital(_patntNo);
		
		// 환자 검사결과 insert
		insertPatientExam();
		
		
	});	
});

// 환자 진료기록 조회
function selectAllClinic(_patntNo) {

	var _patientObj = {
		patntNo : _patntNo
	};

	// 진료일시 목록 초기화
	$('#clinicRecord').empty();
	
	// 진료상세내용 목록 초기화
	$('#clnic-list').empty();
		
	// 환자 진료 기록 조회 ajax 시작
	$.ajax({
		type : "post",
		url  : "/mediform/doctor/allClinic",
		data : JSON.stringify(_patientObj),
		contentType : "application/json; charset=utf-8",
		async: false,
        beforeSend : function(xhr){
            //ajax호출 중 처리
            //글로벌 변수로 설정한 csrf token 셋팅
            xhr.setRequestHeader(header,token);
        },
		success : function(res){

			if(res.length == 0){ // 진료 내역이 없을때
					
				var _clinicListHtml1 = "<tr class='oneBoard' id=''>";
				_clinicListHtml1 += "	<td colspan='4' class='text-center' style='vertical-align: middle'>" + "진료 내역이 없습니다" + "</td>";
				_clinicListHtml1 += "</tr>";
				$('#clnic-list').html(_clinicListHtml1);
					
			}else{
				var clinicLatest = $(res)[0].clnicNo;
				console.log(">>>>>>>>>>>>>>>>>>>>ㅇㅇㅇㅇㅇㅇㅇㅇ" + clinicLatest );
				// 진료 내역이 있으면 loop 돌면서 진료날짜 목록하고 진료상세내역 목록을 생성해서 append
				$(res).each(function(index, item){
						
					var dateString = item.clnicTime;
					var date = new Date(dateString);
					var year = date.getFullYear();
					var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
					var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅

					// 원하는 형식으로 조합
					var formattedDate = year + '.' + month + '.' + day;

					console.log("의사 사번 :>>> " + item.empNo);
						
					///////////////////////////////////////////////////
					// 사번 >>> if문 추가
					///////////////////////////////////////////////////
						
					// 진료일시 목록 생성
					var _clnicDate = '<span class="clinicLatest list-group-item list-group-item-action" style="font-size: small; cursor: pointer;" onclick="showSection(\'' + item.clnicNo + '\')">' + formattedDate + '</span>';
					$('#clinicRecord').append(_clnicDate);
					
					
					var _clinicListHtml = "";

					_clinicListHtml += '<div id="clnic-section-' + item.clnicNo + '" style="display: none;">                                      ';
					_clinicListHtml += '	<div class="table-container scrollbar">                                                           			  ';
					_clinicListHtml += '		<table class="table table-bordered table-striped fs--1 mb-0">                       			  ';
					_clinicListHtml += '			<thead>                                                                         			  ';
					_clinicListHtml += '				<tr class="bg-light">                                                       			  ';
					_clinicListHtml += '					<th class="text-left"                                                   			  ';
					_clinicListHtml += '						style="font-size: small; width: 130px; height: 50px;">진료번호 </th> 				  ';
					_clinicListHtml += '					<th class="text-left"                                                   			  ';
					_clinicListHtml += '						style="font-size: small; width: 380px; height: 50px;">' + item.clnicNo + '</th>	  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '			</thead>                                                                        			  ';
					_clinicListHtml += '			<tbody style="overflow-y: auto; max-height: 180px;">                            			  ';
					_clinicListHtml += '				<tr>                                                                        			  ';
					_clinicListHtml += '					<td class="text-left"                                                   			  ';
					_clinicListHtml += '						style="font-size: small; width: 130px; height: 50px;">담당의 </td> 				  ';
					_clinicListHtml += '					<td class="text-left"                                                   			  ';
					_clinicListHtml += '						style="font-size: small; width: 380px; height: 50px;">' + item.employeeVO.empNm + '</td>	  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '				<tr>                                                                        			  ';
					_clinicListHtml += '					<td class="text-left" style="font-size: small;"><a                      			  ';
					_clinicListHtml += '						data-bs-toggle="collapse" href="#collapseExample1-' + item.clnicNo + '"           ';
					_clinicListHtml += '						role="button" aria-expanded="false"                                 			  ';
					_clinicListHtml += '						aria-controls="collapseExample">진단내역</a></td>                   				  ';
					_clinicListHtml += '					<td>                                                                    			  ';
					_clinicListHtml += '						<div class="collapse show" id="collapseExample1-' + item.clnicNo + '">                 ';
					_clinicListHtml += '							<div class="card card-body border p-2">' + item.clnicCn + '</div>';
					_clinicListHtml += '						</div>                                                              			  ';
					_clinicListHtml += '					</td>                                                                   			  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '				<tr>                                                                        			  ';
					_clinicListHtml += '					<td class="text-left" style="font-size: small;"><a                      			  ';
					_clinicListHtml += '						data-bs-toggle="collapse" href="#collapseExample2-' + item.clnicNo + '"           ';
					_clinicListHtml += '						role="button" aria-expanded="false"                                 			  ';
					_clinicListHtml += '						aria-controls="collapseExample">검사내역</a></td>                   				  ';
					_clinicListHtml += '					<td>                                                                    			  ';
					
					
					
					item.medicalExaminationOrderVOList.forEach(function(medicalItem2) {
					    var medicalText = '검사 내역이 없습니다.';
					    if (medicalItem2 && medicalItem2.hlthchkpCd) {
					        medicalText = medicalItem2.hlthchkpCd;
					        if (medicalItem2.hlthchkpCd === "HC001") {
					            medicalText += '  |  혈액검사';
					        } else if (medicalItem2.hlthchkpCd === "HC002") {
					            medicalText += '  |  소변검사';
					        } else if (medicalItem2.hlthchkpCd === "HC003") {
					            medicalText += '  |  X-RAY 검사';
					        }
					    }
					    
					    _clinicListHtml += '                        <div class="collapse show" id="collapseExample2-' + item.clnicNo + '">';
					    _clinicListHtml += '                            <div class="card card-body border p-2" style="display: inline-block; width: 100%;">' + medicalText + '</div>';
					    _clinicListHtml += '                        </div>';
					});
					
					_clinicListHtml += '					</td>                                                                   			  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '				<tr>                                                                        			  ';
					_clinicListHtml += '					<td class="text-left" style="font-size: small;"><a                      			  ';
					_clinicListHtml += '						data-bs-toggle="collapse" href="#collapseExample3-' + item.clnicNo + '"           ';
					_clinicListHtml += '						role="button" aria-expanded="false"                                 			  ';
					_clinicListHtml += '						aria-controls="collapseExample">처방내역</a></td>                   				  ';
					_clinicListHtml += '					<td>                                                                    			  ';
					
					item.prescriptionOrderVOList.forEach(function(medicalItem4) {
					    var prescriptionText = '처방 내역이 없습니다.';
					    if (medicalItem4 && medicalItem4.prscrptnNm) {
					        prescriptionText = medicalItem4.prscrptnNm;
					        if (medicalItem4.mdctnCoursUsage || medicalItem4.mdctnCpcty) {
					            prescriptionText += '  |  ';
					            if (medicalItem4.mdctnCoursUsage) {
					                prescriptionText += '경로 : ' + medicalItem4.mdctnCoursUsage;
					            }
					            if (medicalItem4.mdctnCoursUsage && medicalItem4.mdctnCpcty) {
					                prescriptionText += '  |  ';
					            }
					            if (medicalItem4.mdctnCpcty) {
					                prescriptionText += '용량 : ' + medicalItem4.mdctnCpcty;
					            }
					        }
					    }

					    _clinicListHtml += '                        <div class="collapse show" id="collapseExample3-' + item.clnicNo + '">                 ';
					    _clinicListHtml += '                            <div class="card card-body border p-2">' + prescriptionText + '</div>';
					    _clinicListHtml += '                        </div>                                                              			  ';
					});
					
					_clinicListHtml += '					</td>                                                                   			  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '				<tr>                                                                        			  ';
					_clinicListHtml += '					<td class="text-left" style="font-size: small;"><a                      			  ';
					_clinicListHtml += '						data-bs-toggle="collapse" href="#collapseExample4-' + item.clnicNo + '"           ';
					_clinicListHtml += '						role="button" aria-expanded="false"                                 			  ';
					_clinicListHtml += '						aria-controls="collapseExample">치료내역</a></td>                   				  ';
					_clinicListHtml += '					<td>                                                                    			  ';
					
			item.medicalTreatmentVOList.forEach(function(medicalItem5) {
			    if (medicalItem5) {
			        var treatmentText = medicalItem5.mdlrtCd + '  |  ' + medicalItem5.mdlrtNm;
			        _clinicListHtml += '                        <div class="collapse show" id="collapseExample4-' + item.clnicNo + '">';
			        _clinicListHtml += '                            <div class="card card-body border p-2">' + treatmentText + '</div>';
			        _clinicListHtml += '                        </div>';
			    } else {
			        _clinicListHtml += '                        <div class="collapse show" id="collapseExample4-' + item.clnicNo + '">';
			        _clinicListHtml += '                            <div class="card card-body border p-2">치료내역이 없습니다</div>';
			        _clinicListHtml += '                        </div>';
			    }
			});
			
					_clinicListHtml += '					</td>                                                                   			  ';
					_clinicListHtml += '				</tr>                                                                       			  ';
					_clinicListHtml += '			</tbody>                                                                       				  ';
					_clinicListHtml += '		</table>                                                                       					  ';
					_clinicListHtml += '	</div>                                                                       						  ';
					_clinicListHtml += '</div>                                                                       							  ';
					
					var $html = $(_clinicListHtml);
					$html.data(item);
					
					$('#clnic-list').append($html);
				});
				showSection(clinicLatest);
			}
		},
		error : function(err){
			console.log(err.status)
		}
	});
}

// 전화번호에 하이픈 추가~
function formatPhoneNumber(phoneNumber) {
    if (phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
    return phoneNumber;
}

// 환자 상세정보 조회
function selectPatientAjax(_patntNo) {
	
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    var _patientObj = {
        patntNo: _patntNo
    };

    // 환자 정보 ajax 시작
    $.ajax({
        type: "post",
        url: "/mediform/patient/info",
        data: JSON.stringify(_patientObj),
        contentType: "application/json; charset=utf-8",
        async: false,
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(res) {
            // 환자 상세 정보
            $("#patntNoDt").val(res.patntNo);
            $("#patntNmDt").val(res.patntNm);
            $("#patntSexdstnDt").val(res.patntSexdstn == "M" ? "남" : "여");
            $("#patntRrno1Dt").val(res.patntRrno1);
            $("#patntTelnoDt").val(formatPhoneNumber(res.patntTelno));
            $("#patntAgeDt").val(res.patntAge + "세");
            $("#patntHlthinsAtDt").val(res.patntHlthinsAt == "Y" ? "O" : "X");
            $("#prtctorNmDt").val(res.prtctorNm);
            $("#prtctorTelnoDt").val(formatPhoneNumber(res.prtctorTelno));
            $("#patntHeightDt").val(res.patntHeight + "cm");
            $("#patntBdwghDt").val(res.patntBdwgh + "kg");
            $("#patntBdpDt").val(res.patntBdp + "형");
            $("#patntMemoDt").val(res.patntMemo);
            $("#hsptlzAtDt").val(res.hsptlzAt == "Y" ? "O" : "X");

        },
        error: function(err) {
            console.log("Error:", err);
        }
    });
}

// 환자 바이탈 조회
function selectPatientVital(_patntNo) {
	
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    var _patientObj = {
        patntNo: _patntNo
    };
    
 	// 바이탈 목록 초기화
    $("#hghrkHhprsDt").val("-");
    $("#lwtrkHhprsDt").val("-");
    $("#bdheatDt").val("-");
    
    // 환자 바이탈  ajax 시작
    $.ajax({
        type: "post",
        url: "/mediform/nurse/acting/vital",
        data: JSON.stringify(_patientObj),
        contentType: "application/json; charset=utf-8",
        async: false,
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(res) {

            var latestData = res[0];

            // 해당 환자 바이탈 정보 업데이트
            $("#vitalCdDt").val(latestData.vitalCd ? latestData.vitalCd : "-");								// 바이탈코드
            $("#hghrkHhprsDt").val(latestData.hghrkHhprs ? (latestData.hghrkHhprs + "mmHg") : "-");			// 최고혈압
            $("#lwtrkHhprsDt").val(latestData.lwtrkHhprs ? (latestData.lwtrkHhprs + "mmHg") : "-");			// 최저혈압
            $("#bdheatDt").val(latestData.bdheat ? (latestData.bdheat + "도") : "-");						// 체온
            $("#vitalDateDt").val(latestData.vitalDate ? latestData.vitalDate : "-");						// 작성일시
        },
        error: function(err) {
            console.log("Error:", err);
        }
    });
}



// 환자 바이탈 결과 입력
function insertPatientVital(_patntNo) {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    
    $("#vBtn").on("click", function() {
    	
    	var _selectedData = $('[id^=clnic-section]:visible').data();
    	
        var vitalData = {
        		 patntNo: _selectedData['patntNo'],
        		 empNo: _selectedData['empNo'],
                 hghrkHhprs: $("#HpResult").val(),
                 lwtrkHhprs: $("#LpResult").val(),
                 bdheat: $("#TemResult").val()
        };

	     console.log(vitalData);

        
        $.ajax({
            url : "/mediform/nurse/acting/vital/insert",
            method : "POST",
            data : JSON.stringify(vitalData),
            contentType : "application/json; charset=utf-8",
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            success : function(response) {
				
				$("#HpResult").val(''); 
				$("#LpResult").val('');
				$("#TemResult").val('');
				
				selectPatientVital(_patntNo);
				
				Swal.fire({
				      icon: 'success',
				      title: '바이탈',
				      text: '환자 바이탈이 저장되었습니다',
				      confirmButtonColor: 'midnightblue'
				    });
			},
			error : function(err) {
				Swal.fire({
				      icon: 'warning',
				      title: '바이탈',
				      text: '바이탈 입력에 실패했습니다.',
				      confirmButtonColor: 'midnightblue'
				    });
			}
        });
    });
}


// 환자 검사결과 입력
function insertPatientExam(_patntNo) {
		

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	
	$("#bBtn, #pBtn").on("click", function() {
		
		var buttonId = this.id; 
		
		var _selectedData = $('[id^=clnic-section]:visible').data();
	
		var mecArr = [];
		
		var examData = {
				patntNo: _selectedData['patntNo'],
				clnicNo: _selectedData['clnicNo'], 
				rceptNo: _selectedData['rceptNo']
			};

		console.log(">>>>>>>> 진료 번호 >>>>>" + _selectedData['clnicNo']);
		
		
		 switch (this.id) {
         case "bBtn":
        	 examData.hlthchkpCd = 'HC001';
        	 examData.hlthchkpResult = $("#bloodResult").val();
             break;
         case "pBtn":
        	 examData.hlthchkpCd = 'HC002';
        	 examData.hlthchkpResult = $("#peaResult").val();
             break;
	     }
	
	     if ($.trim(examData.hlthchkpResult) == '') {
// 	         alert("결과를 입력하세요!");
	         Swal.fire({
 			      icon: 'warning',
 			      title: '검사',
 			      text: '결과를 입력해주세요!',
 			      confirmButtonColor: 'midnightblue'
 			    });
	         return;
	     }
	     
	     console.log(examData);
	     
	     // 검사코드 불러오는 AJAX
	     $.ajax({
				url : "/mediform/nurse/acting/exam/select",
				method : "POST",
				data : JSON.stringify(examData),
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(res) {
					
					$(res).each(function(){
						console.log("검사 코드 >>>>>>> " + this.mecCd);
						
						var mecCd = this.mecCd;
						console.log("변수에 넣은 검사 코드 >>> " + mecCd);
						
						examData.mecCd = this.mecCd;
							
						console.log(examData);
						
							var uMeoObj = {
									mecCd: mecCd
									}
							
							console.log("검사 코드만 들어간 JSON >>> " + uMeoObj);
							switch (this.id) {
					         case "bBtn":
					        	 uMeoObj.hlthchkpCd = 'HC001';
					        	 uMeoObj.hlthchkpResult = $("#bloodResult").val();
					             break;
					         case "pBtn":
					        	 uMeoObj.hlthchkpCd = 'HC002';
					        	 uMeoObj.hlthchkpResult = $("#peaResult").val();
					             break;
						     }
							
							
							console.log("검사 결과 추가한 JSON >>> " + uMeoObj);
							
							// 해당 mecCd에 혈액검사, 소변검사 update AJAX 추가하기
							console.log(">>>>> 검사 update 실행 전 <<<<<")
							// 검사 오더 update AJAX
							$.ajax({
								url : "/mediform/nurse/acting/exam/update",
								method : "POST",
								data : JSON.stringify(examData),
								contentType : "application/json; charset=utf-8",
								beforeSend : function(xhr) {
									xhr.setRequestHeader(header, token);
								},
								success : function(response) {
									
										switch (buttonId) {
								        case "bBtn":
								            $("#bloodResult").val('');
								            break;
								        case "pBtn":
								            $("#peaResult").val(''); 
								            break;
								    console.log(">>>>> 검사 update 완료 <<<<<")
								    }
								},
								error : function(err) {
									alert("Error: " + err);
								}
							});
							// 검사 오더 update AJAX 끝
					});
						switch (buttonId) {
				        case "bBtn":
				            $("#bloodResult").val('');
				            break;
				        case "pBtn":
				            $("#peaResult").val(''); 
				            break;
				    }
						
				   var resultContainer = $("#" + buttonId).next("#result");
			       resultContainer.text("저장완료");
			       resultContainer.css("text-align", "right");
			       resultContainer.css("color", "limegreen");
			       resultContainer.css("font-weight", "bold");
			       resultContainer.css("font-size", "16px");
			       
				},
				error : function(err) {
					alert("Error: " + err);
				}
			});
	 		// 검사코드 불러오는 AJAX 끝
	});
	
	
	// 엑스레이 사진 업로드 
	$("#xrayBtn").on("click", function(){
		
		console.log("클릭 이벤트!!")
		
		var xrayForm = $("#xrayForm");
		
		var _selectedData = $('[id^=clnic-section]:visible').data();
		
		
		var examData = {
				patntNo: _selectedData['patntNo'],
				clnicNo: _selectedData['clnicNo'], 
				rceptNo: _selectedData['rceptNo']
			};
		
		var xrayPatntNo = _selectedData['patntNo'];
		
		var xrayClnicNo = _selectedData['clnicNo'];
		
		var xrayRceptNo = _selectedData['rceptNo'];
		
		console.log("환자번호 >>> " + xrayPatntNo);
		console.log("진료번호 >>> " + xrayClnicNo);
		console.log("접수번호 >>> " + xrayRceptNo);
		
		// 아작스로 파일을 넘길 때는 FormData로 넘기기
		var formData = new FormData();

		// 담은 파일을 저장
		var inputFile = $("input[name='atchXrayFile']")

		// 파일 여러개일 경우 => 배열 형태로 담기
		var files = inputFile[0].files;

		console.log(files);
		
		// 배열에 담긴 파일 formData에 담기
		for(var i = 0;  i < files.length; i++){
			formData.append("uploadFile", files[i])
		}
		
		
		// 검사코드 불러오는 AJAX
	     $.ajax({
				url : "/mediform/nurse/acting/exam/select",
				method : "POST",
				data : JSON.stringify(examData),
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(res) {
					
					$(res).each(function(){
						
						if(this.hlthchkpCd === "HC003"){
							console.log("검사 코드 >>>>>>> " + this.mecCd);
							
							$("#xrayMecCdHidden").val(this.mecCd);
							$("#xrayRceptNoHidden").val(xrayRceptNo);
							
							console.log("파일과 함꼐 넘길 접수 번호 >>> " + xrayRceptNo);
							console.log("파일과 함께 넘길 검사오더 코드 >>>" + this.mecCd)
							
							$.ajax({
						 		type : "post",
								url : "/mediform/nurse/acting/xray/insert?rceptNo=" + xrayRceptNo + "&mecCd=" + this.mecCd,
								data : formData,
								processData: false,
						 		contentType : false,
						 		async: false,
						        beforeSend : function(xhr){            
						            xhr.setRequestHeader(header,token);
						        },
						 		success : function(result) {
									console.log("아작스 파일 전송 성공!!!");
								 var resultContainer = $("#xrayBtn").next("#result");
							       resultContainer.text("저장완료");
							       resultContainer.css("text-align", "right");
							       resultContainer.css("color", "limegreen");
							       resultContainer.css("font-weight", "bold");
							       resultContainer.css("font-size", "16px");
									
						 		},
						 		error : function(res){
						 			alert("아작스 파일 전송 실패!!! 실패는 성공의 어머니!");
						 		}
						 	});
// 							xrayForm.submit();
						}
					});
				},
				error : function(err) {
					alert("Error: " + err);
				}
			});
	 		// 검사코드 불러오는 AJAX 끝
	});
}


$(document).ready(function() {
    $("#iBtn").click(function() {
        var resultContainer = $("#iBtn").next("#result");
        resultContainer.text("처치 완료");
        resultContainer.css("text-align", "right");
        resultContainer.css("color", "limegreen");
        resultContainer.css("font-weight", "bold");
        resultContainer.css("font-size", "16px");
    });
});



// 검사시행 actions 아이콘 누르면 바코드 툴력
// function generateBarcode() {
//     event.stopPropagation();

//     Swal.fire({
//         title: '검사를 시행하시겠습니까',
//         imageUrl: '/resources/image/alert.png',
//         imageWidth: 400,
//         imageHeight: 200,
//         imageAlt: 'Custom image',
//         showCancelButton: true,
//         confirmButtonColor: '#3085d6',
//         cancelButtonColor: '#d33',
//         confirmButtonText: '승인',
//         cancelButtonText: '취소',

//     }).then((result) => {
//         if (result.isConfirmed) {
//             document.querySelector('#barcodeTab a[href="#generateBarcode"]').click();

//             // 바코드 생성
            
//             var _selectedData = $('[id^=clnic-section]:visible').data();
            
//             var barcode = "HC" + _selectedData['patntNo'];
//             $("#barcode").barcode(barcode, "code128", {
//                 barWidth: 2,
//                 barHeight: 70,
//                 fontSize: 20
//             });

//             // 바코드가 생성된 후 버튼 표시
//             document.getElementById('printBarcode').style.display = 'block';
//         }
//     });
// }


// 검사시행에서 actions 아이콘을 클릭시 
   var buttons = document.querySelectorAll('.hcAction');
    buttons.forEach(function(button) {
        button.addEventListener('click', function() {
            Swal.fire({
                title: '검사를 시행하시겠습니까?',
                imageUrl: '/resources/image/alert.png',
	            imageWidth: 400,
	            imageHeight: 200,
                showCancelButton: true,
                confirmButtonColor: 'midnightblue',
                cancelButtonColor: 'red',
                confirmButtonText: '승인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.isConfirmed) {
                    // alert창 확인 버튼을 클릭한 경우
                    document.getElementById('qr').style.display = 'inline';
                    document.getElementById('printQr').style.display = 'block';
                }
            });
        });
    });
    
// document.getElementById('hcAction2').addEventListener('click', generateBarcode);

//검사시행에서 x-ray action버튼 누르면 페이지 이동
document.getElementById('hcAction3').addEventListener('click', function() {
    window.location.href = "/mediform/nurse/xray/view";
});

//바코드 출력(print)
document.getElementById('printQr').addEventListener('click', function() {
    Swal.fire({
        title: 'QR코드가 출력되었습니다',
        imageUrl: '/resources/image/alert.png',
        imageWidth: 400,
        imageHeight: 200,
        imageAlt: 'Custom image',
        showCancelButton: false,
        confirmButtonColor: 'midnightblue',
        confirmButtonText: '확인'
    });
});

	
</script>

</html>