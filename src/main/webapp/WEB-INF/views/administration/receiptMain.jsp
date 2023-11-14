<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<style>
.table thead {
	position: sticky;
	top: 0;
	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}
</style>

<c:set var="reservationPatient" value=""/>

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
				<div class="row card-body pt-0 pl-5">
					<div class="tab-content">
	
						<br>
						<div class="row">
							<div class="col-4">
								<div class="row input-group">
									<input
										class="fw-semi-bold col-6 bg-secondary-subtitle-subtle text-black text-center form-control"
										id="" name="" type="text" value="이름" disabled />
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
										id="" name="" type="text" value="성별" disabled />
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
										id="" name="" type="text" value="생년월일" disabled />
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
										id="" name="" type="text" value="전화번호" disabled />
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
										id="" name="" type="text" value="나이" disabled />
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
										id="" name="" type="text" value="건강보험" disabled />
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
										id="" name="" type="text" value="주소" disabled />
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
										id="" name="" type="text" value="특이사항" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<input class="text-black form-control bg-white" id="patntMemo" name="patntMemo"
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
										id="" name="" type="text" value="접수메모" disabled />
									<div class="col-10 input-group-append p-0 m-0">
										<textarea class="form-control" rows="2" id="rceptReason" name="rceptReason"
											placeholder="접수메모를 입력해 주세요"></textarea>
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
										id="" name="" type="text" value="예약일정"
										style="background-color: midnightblue" disabled />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="table-container scrollbar"
									style="overflow-y: auto; max-height: 150px;">
									<table class="table table-sm table-striped"
										style="height: 130px;">
										<thead>
											<tr id="" class="bg-light">
												<th class="col-3 text-center" scope="col">예약날짜</th>
												<th class="col-3 text-center" scope="col">예약시간</th>
												<th class="col-2 text-center" scope="col">담당의</th>
												<th class="col-4 text-center" scope="col">증상</th>
											</tr>
										</thead>
										<tbody style="overflow-y: auto; max-height: 120px;" id="reservationListTable">
											
											
											
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
										id="" name="" type="text" value="진료배정" disabled />
									<div class="col-8 input-group-append p-0 m-0">
										<select class="form-select" aria-label="Default select example"
											id="selectOption">
											<option selected value="">진료배정</option>
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
										<select class="form-select" aria-label="Default select example" name="rceptClnc" id="rceptClnc1">
											<option value="진료실" selected>진료실</option>
											<option value="d1">1 진료실 허준</option>
											<option value="d2">2 진료실 우태원</option>
											<option value="d3">3 진료실 남민주</option>
											<option value="d4">4 진료실 장기려</option>
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
										<select class="form-select" aria-label="Default select example" name="rceptClnc" id="rceptClnc2">
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
										<select class="form-select" aria-label="Default select example" name="rceptClnc" id="rceptClnc3">
											<option selected="">작업치료실</option>
											<option value="t1">1 치료실</option>
											<option value="t2">2 치료실</option>
											<option value="t3">3 치료실</option>
											<option value="t4">4 치료실</option>
										</select>
									</div>
								</div>
							</div>
	
	
						</div>
	
						<br>
						<div class="row mt-3">
							<div class="col-8"></div>
							<div class="col-2">
								<div class="form-check form-switch">
									<input class="form-check-input" id="rceptPriort" name="rceptPriort"
										type="checkbox" value="0"/> 
										<label class="form-check-label"
										for="flexSwitchCheckDefault">예약</label>
								</div>
							</div>
							<div class="col-2">
								<button class="btn btn-primary text-white" id="receiptBtn" type="button" style="background-color : midnightblue; border-style: none;">접수</button>
								&nbsp;&nbsp;
							</div>
							<br> <br> <br> <br>
						</div>
	
					</div>
				</div>
				
				<input type="hidden" id="rceptSttus" name="rceptSttus" value="0"/>
				
			</form>
		</div>

	</div>



	<div class="col-7">


		<div class="card border border-secondary" style="height: 820px;">
			<div>
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item text-center col-6"><a
						class="nav-link active fw-semi-bold" id="home-tab"
						data-bs-toggle="tab" href="#tab-home" role="tab"
						aria-controls="tab-home" aria-selected="true">진료실</a></li>
<!-- 					<li class="nav-item text-center col-4"><a -->
<!-- 						class="nav-link fw-semi-bold" id="profile-tab" -->
<!-- 						data-bs-toggle="tab" href="#tab-profile" role="tab" -->
<!-- 						aria-controls="tab-profile" aria-selected="false">물리치료실</a></li> -->
					<li class="nav-item text-center col-6"><a class="nav-link"
						id="contact-tab" data-bs-toggle="tab" href="#tab-contact"
						role="tab" aria-controls="tab-contact" aria-selected="false">작업치료실</a>
					</li>
				</ul>
			</div>

		<c:set value="${waitingList }" var="waitingList"/>

			<div class="row card-body pt-0">
				<div class="tab-content border border-top-0 p-3" id="myTabContent">

					<!-- 진료실 탭 -->
					<div class="tab-pane fade show active" id="tab-home"
						role="tabpanel" aria-labelledby="home-tab">

						<div class="row">

							<div class="col-6">

								<div class="card border border-3 border-secondary" id="d1" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="111">1 진료실 [허준 전문의]</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 240px;">
													<table class="table table-sm table-striped">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 220px;">
														
															<c:set value="1" var="count1"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 'd1' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count1}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																			<c:set value="${count1+1 }" var="count1"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>														

														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>


							</div>

							<div class="col-6">

								<div class="card border border-3 border-secondary" id="d2" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="222">2 진료실 [우태원 전문의]</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 240px;">
													<table class="table table-sm table-striped">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 220px;">
															<c:set value="1" var="count2"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 'd2' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count2}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																		<c:set value="${count2+1 }" var="count2"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>	



														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>



							</div>


						</div>

						<br>

						<div class="row">

							<div class="col-6">

								<div class="card border border-3 border-secondary" id="d3" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="333">3 진료실 [남민주 전문의]</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 240px;">
													<table class="table table-sm table-striped">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 220px;">
														
															
														
															<c:set value="1" var="count3"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 'd3' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count3}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																		<c:set value="${count3+1 }" var="count3"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>	



														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>


							</div>

							<div class="col-6">
								<div class="card border border-3 border-secondary" id="d4" style="height: 360px;">

									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="444">4 진료실 [장기려 전문의]</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 240px;">
													<table class="table table-sm table-striped">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 220px;">
														<c:set value="1" var="count4"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 'd4' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count4}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																		<c:set value="${count4+1 }" var="count4"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>	


														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>
							</div>


						</div>



					</div>


					<!-- 물리치료실 탭 -->
<!-- 					<div class="tab-pane fade" id="tab-profile" role="tabpanel" -->
<!-- 						aria-labelledby="profile-tab"> -->
<!-- 						가나다라마바사 -->
<!-- 						<button class="btn btn-primary" type="button" -->
<!-- 							data-bs-toggle="modal" data-bs-target="#error-modal">Launch -->
<!-- 							demo modal</button> -->
<!-- 					</div> -->


					<!-- 작업치료실 탭 -->
					<div class="tab-pane fade" id="tab-contact" role="tabpanel"
						aria-labelledby="contact-tab">
						
						
						<div class="row">

							<div class="col-6">

								<div class="card border border-2 border-secondary" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="111">1 치료실</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 200px;">
													<table class="table table-sm table-striped"
														style="height: 180px;">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 180px;">
														
															<c:set value="1" var="count5"/>	
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 't1' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count5}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																			<c:set value="${count5+1 }" var="count5"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>														

														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>


							</div>

							<div class="col-6">

								<div class="card border border-2 border-secondary" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="222">2 치료실</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>

												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 200px;">
													<table class="table table-sm table-striped"
														style="height: 180px;">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 180px;">
															<c:set value="1" var="count6"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 't2' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count6 }</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																		<c:set value="${count6+1 }" var="count6"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>	



														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>
								



							</div>


						</div>
						<br>
						<div class="row">

							<div class="col-6">

								<div class="card border border-2 border-secondary" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="111">3 치료실</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 200px;">
													<table class="table table-sm table-striped"
														style="height: 180px;">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 180px;">
														
															<c:set value="1" var="count7"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 't3' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count7}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																			<c:set value="${count7+1 }" var="count7"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>														

														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>


							</div>
							
							<div class="col-6">

								<div class="card border border-2 border-secondary" style="height: 360px;">
									<div class="card-header border-bottom p-2"
										style="height: 35px; background-color: midnightblue">
										<div class="row">
											<div class="col-12 align-self-center">
												<h5 class="text-center text-white mb-0 fw-semi-bold"
													id="222">4 치료실</h5>
											</div>

										</div>
									</div>

									<div class="row card-body pt-0">
										<div class="tab-content">
<!-- 											<div class="tab-pane preview-tab-pane active" role="tabpanel" -->
<!-- 												aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" -->
<!-- 												id="dom-1123d529-5101-4101-b597-dac496b93923"> -->
											<div>
												<br>
												<div class="table-container scrollbar"
													style="overflow-y: auto; max-height: 200px;">
													<table class="table table-sm table-striped"
														style="height: 180px;">
														<thead>
															<tr id="" class="bg-light">
																<th class="col-2" scope="col">no</th>
																<th class="col-3 text-center" scope="col">환자명</th>
																<th class="col-2 text-center" scope="col">구분</th>
																<th class="col-5 text-center" scope="col">생년월일</th>
															</tr>
														</thead>
														<tbody style="overflow-y: auto; max-height: 180px;">
														<c:set value="1" var="count8"/>
															<c:choose>
																<c:when test="">
																
																
																
																</c:when>
																<c:otherwise>
																	<c:forEach items="${waitingList }" var="waiting" varStatus="loop">
																		<c:if test="${waiting.rceptClnc == 't4' }">
																			<tr class="oneBoard" id="">
																				<td class="" style="vertical-align: middle">${count8}</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntNm }
																					
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					<c:if test="${waiting.rceptPriort == '1' }">
																						<span class='badge rounded-pill badge-subtle-primary'>예약</span>
																					</c:if>
																				</td>
																				<td class="text-center" style="vertical-align: middle">
																					${waiting.patntRrno1 }
																				</td>
																			</tr>
																			<c:set value="${count8+1 }" var="count8"/>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>	



														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>


								</div>



							</div>


						</div>
						
						
					</div>
			
						

				</div>
			</div>

		</div>

	</div>

</div>







<!-- 접수 성공 모달창 -->

<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue">
          <h4 class="mb-1 text-white" id="modalExampleDemoLabel">접수</h4>
        </div>
        <div class="p-4 pb-0">
          <div class="text-center fw-semi-bold">
          		<h5 id="modalText">접수되었습니다</h5>
          	<br>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal" onclick="window.location.href = '/mediform/admin/receipt/list'">닫기</button>
      </div>
    </div>
  </div>
</div>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<script type="text/javascript">

function formatPhoneNumber(phoneNumber) {
    return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}



$(function() {

	
	
	
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
	
		var tabLinks = document
				.querySelectorAll('.nav-link');
		tabLinks.forEach(function(link) {
			link.classList.remove('active');
		});
	
		var tabContents = document
				.querySelectorAll('.tab-pane');
		tabContents.forEach(function(content) {
			content.classList.remove('show', 'active');
		});
	
		
		if (selectedValue === '1') {
			document.getElementById('home-tab').classList.add('active');
			document.getElementById('home-tab').ariaSelected=true;
			document.getElementById('tab-home').classList.add('show', 'active');
			$("#tab-home").find(".tab-pane").addClass("active");
		} else if (selectedValue === '2') {
			document.getElementById('profile-tab').classList.add('active');
			document.getElementById('profile-tab').ariaSelected=true;
			document.getElementById('tab-profile').classList.add('show', 'active');
			$("#tab-profile").find(".tab-pane").addClass("active");
		} else if (selectedValue === '3') {
			document.getElementById('contact-tab').classList.add('active');
			document.getElementById('contact-tab').ariaSelected=true;
			document.getElementById('tab-contact').classList.add('show', 'active');
			$("#tab-contact").find(".tab-pane").addClass("active");
		}

	});
	
	
	
	document.getElementById('rceptClnc1').addEventListener('change',function() {
		
		document.getElementById('d1').classList.add('border-secondary');
		document.getElementById('d2').classList.add('border-secondary');
		document.getElementById('d3').classList.add('border-secondary');
		document.getElementById('d4').classList.add('border-secondary');
		
		var dRoom = this.value;
		console.log("선택 방 : " + dRoom);
		
		if (dRoom === 'd1') {
			console.log("d1선택");
			document.getElementById('d1').classList.remove('border-secondary');
			document.getElementById('d1').classList.add('border-primary');
		} else if (dRoom === 'd2') {
			console.log("d1선택");
			document.getElementById('d2').classList.remove('border-secondary');
			document.getElementById('d2').classList.add('border-primary');
		} else if (dRoom === 'd3') {
			console.log("d1선택");
			document.getElementById('d3').classList.remove('border-secondary');
			document.getElementById('d3').classList.add('border-primary');
		} else if (dRoom === 'd4') {
			console.log("d1선택");
			document.getElementById('d4').classList.remove('border-secondary');
			document.getElementById('d4').classList.add('border-primary');
		}else{
			console.log("???");
		}
		
	});
	

});
	
	
	
// 환자 검색 관련 시작
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
	
	patientInput.blur();
	$(patientDropMenu).hide();
	selectPatientAjax(patntNo);
	selectReservationAjax(patntNo);
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
	
	
	
	
	
	
////////////////////////////////////////////////////////////////////////////////////////////////////	
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
////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
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

						(formattedDate);
						
						reservationListHtml += "<tr class='oneBoard' id=''>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + formattedDate + "</td>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + this.rpatntTime + "</td>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + this.empNm + "</td>";
						reservationListHtml += "	<td class='text-center' style='vertical-align: middle'>" + this.rsvtResn + "</td>";
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
	
	
	
	var patntNoAll = ""
	
	function selectPatientAjax(patntNo){
		
		$("#patntNm").val("");
		$("#patntSexdstn").val("");
		$("#patntRrno1").val("");
		$("#patntTelno").val("");
		$("#patntAge").val("");
		$("#patntHlthinsAt").val("");
		$("#patntAdres1").val("");
		$("#patntAdres2 ").val("");
		$("#patntMemo").val("");
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		patntNoAll = patntNo
		
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
				
				
				 let patntRrno1Str = (res.patntRrno1).toString();
                 while (patntRrno1Str.length < 6) {
                	 patntRrno1Str = '0' + patntRrno1Str;
                 }
                 $("#patntRrno1").val(patntRrno1Str);
                 
				$("#patntTelno").val(formatPhoneNumber(res.patntTelno));
				$("#patntAge").val(res.patntAge+"세");
				$("#patntHlthinsAt").val(patntHlthinsAt);
				$("#patntAdres1").val(res.patntAdres1);
				$("#patntAdres2 ").val(res.patntAdres2);
				$("#patntMemo").val(res.patntMemo);
				
				
			},
			error : function(err){
				console.log("err에러 : " + err);
			}
			
		});
	// 환자 정보 ajax 끝
	
		
	
}
	
	// 접수 버튼 클릭시 접수 insert ajax
	
	
	var receiptBtn = $("#receiptBtn");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$("#rceptPriort").on("change", function() {
	    if ($(this).is(":checked")) {
	        $(this).val("1");
	    } else {
	        $(this).val("0");
	    }
	    console.log("예약 여부 :: " +$("#rceptPriort").val())
	});
	
	receiptBtn.on("click", function(){
		
		
		var patientObj = {
				patntNo : patntNoAll
				};
		
		console.log("접수 버튼 클릭!!!");
		
		var modalText = $("#modalText");
		var rceptSttus = "";
		var rceptReason = $("#rceptReason").val();
		var rceptPriort = $("#rceptPriort").val();
		var selectOption = $("#selectOption").val();
		var rceptClnc = "";
		
		if(selectOption == "1"){
			rceptClnc = $("#rceptClnc1").val();
			rceptSttus = 0;
		}else if(selectOption == "2"){
			rceptClnc = $("#rceptClnc2").val();
			rceptSttus = 5;
		}else if(selectOption == "3"){
			rceptClnc = $("#rceptClnc3").val();
			rceptSttus = 7;
		}
		
		
		console.log("rceptClnc >>> " + rceptClnc);
		
		
		
		
		if(selectOption === "" || selectOption == null){
			Swal.fire({
			      icon: 'error',
			      title: '진료',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
				    	return false;
			    	});
		}
		
		
		if(rceptClnc === "진료실" || rceptClnc == null){
			console.log("진료실 null >>> rceptClnc >>> " + rceptClnc);
			Swal.fire({
			      icon: 'error',
			      title: '진료',
			      text: '진료실 또는 치료실을 선택해주세요',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    });
		}else{
			
			console.log("진료실 선택함");
			
			var patientObj = {
					patntNo : patntNoAll,
					rceptReason : rceptReason,
					rceptPriort : rceptPriort,
					rceptClnc : rceptClnc,
					rceptSttus : rceptSttus
					};
			
			
			
			$.ajax({
		 		type : "post",
				url : "/mediform/admin/rcept/select",
				data : JSON.stringify(patientObj),
		 		contentType : "application/json; charset=utf-8",
		 		async: false,
		        beforeSend : function(xhr){            
		            xhr.setRequestHeader(header,token);
		        },
		 		success : function(res) {
					console.log("접수되어 있는 건수!!! >>> " + res);
					
					if(res > 0){
						
						Swal.fire({
						      icon: 'error',
						      title: '접수',
						      text: '현재 접수되어 있는 환자입니다',
						      confirmButtonColor: 'blue',
						    }).then(result => {
						    	
						   		return false;
						    	
						    })
						
					}else{
						
						$.ajax({
							type : "post",
							url  : "/mediform/admin/rcept/insert",
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
								      title: '접수',
								      text: '정상적으로 접수되었습니다',
								      confirmButtonColor: 'blue',
								    }).then(result => {
								    	if(result.isConfirmed){
									    	location.href = "/mediform/admin/rcept/list";
								    	}
									 });
								
							},
							error : function(err){
								console.log("err에러 : " + err);
							}
							
						});
						
						
						
					}
		 		
		 		}
		 	});
			
		}
		
		
		
		
		
		
		
		
		
		
	});
	
	
	
	
	
</script>







