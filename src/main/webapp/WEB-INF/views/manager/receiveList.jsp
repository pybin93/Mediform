<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메디폼 │ 행정관리자</title>
<style type="text/css">
#header{
	font-weight: bold;
}

.text-nowrap{
	cursor: pointer;
}

#searchBtn, #spanCss{
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%; /* 부모 요소의 높이를 100%로 설정하여 세로 가운데 정렬합니다. */
}

#pagingArea {
    display: flex;
    justify-content: center;
    align-items: center;
}

</style>

<!-- html2canvas -->
<script src="${pageContext.request.contextPath }/resources/assets/js/html2canvas/jspdf.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/html2canvas/bluebird.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/html2canvas/html2canvas.min.js"></script>

</head>
<body>

<div class="row" >
	
	<!-- list (실상 영수증 list) -->
	<div class="col-lg-7">
		<div class="card" style="height: 820px;">
	       <div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
	         <div class="row flex-between-end">
	           <div class="col-auto align-self-center">
	             <h5 class="mb-0 text-white fw-semi-bold" id="header">
	             	<c:choose>
	             		<c:when test="${searchType eq 'unpaid' }">
	             			미수납 내역
	             		</c:when>
	             		<c:otherwise>
	             			수납 내역
	             		</c:otherwise>
	             	</c:choose>
	             
	             </h5>
	           </div>
	           <div class="col-auto ms-auto">
	           </div>
	         </div>
	       </div>
	       <div class="card-body pt-0">
	         <div class="row" style="margin-top:20px; margin-bottom: 20px;">
			    <form action="/mediform/manager/receive/list/select" method="post" id="searchForm" style="display: flex;">
				   <div style="display: flex; margin-left: 20px;">   
				   		<input type="hidden" name="page" id="page" /> 
				        <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="searchType" name="searchType" style="width: initial; ">
				            <option value="all" <c:if test="${searchType eq 'all'}">selected</c:if>>전체</option>
				            <option value="com" <c:if test="${searchType eq 'com'}">selected</c:if>>수납완료</option>
				            <option value="part" <c:if test="${searchType eq 'part'}">selected</c:if>>부분수납</option>
				            <option value="unpaid" <c:if test="${searchType eq 'unpaid'}">selected</c:if>>미수납</option>
				        </select>
			        	<div class="input-group" id="empSearchBox" style="display: flex;">
				            <input class="searchInput form-control search-input" aria-label="search" type="search" placeholder="환자명을 입력해 주세요." 
				            id="searchWordBox"  value="${searchWord }" name="searchWord"/>
				        </div>
			       </div>
			       &nbsp; 
         			<div style="display: flex; justify-content: flex-end;">
         				<input type="date" id="selectDate1" name="startDate" value="<fmt:formatDate value='${startDate }' pattern='yyyy-MM-dd'/>"> 
         				<span id="spanCss">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
         				<input type="date" id="selectDate2" name="endDate" value="<fmt:formatDate value='${endDate }' pattern='yyyy-MM-dd'/>">
         				&nbsp;
         				<button class="btn btn-outline-secondary me-1 mb-1"  type="button" id="searchBtn">검색</button> 
					</div>
			        <sec:csrfInput />
			    </form>
	         </div>
	         <div class="tab-content">
	           <div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" id="dom-1123d529-5101-4101-b597-dac496b93923">
	             <div class="table-responsive scrollbar" style="height: 630px;">
	                 <c:choose>
	                 	<c:when test="${searchType eq 'unpaid' }">
	                 		<table class="table table-hover table-striped overflow-hidden">
	                 			<thead>
	                 				<tr style="height: 55px;">
	                 					<th class=" text-start" scope="col">수납여부</th>
	                 					<th class=" text-center" scope="col">수진자명</th>
	                 					<th class=" text-center" scope="col">성별</th>
	                 					<th class=" text-center" scope="col">진료일시</th>
	                 					<th class=" text-center" scope="col">미수금액(원)</th>
	                 				</tr>
	                 			</thead>
	                 			<tbody>
	                 			<c:set value="${pagingVO.dataList }" var="unpaidList"/>
	                 			<c:choose>
			                 		<c:when test="${empty unpaidList }">
				                 		<td class="text-nowrap text-center" colspan="6" scope="col">해당 내역이 존재하지 않습니다.</td>
				                 	</c:when>
			                 		<c:otherwise>
			                 			<c:forEach items="${unpaidList }" var="unpaid">
					                   		<tr class="unpaidDetail align-middle" id="${unpaid.rcivNo }" style="height: 55px;">
					                     		<td class="text-nowrap text-start">
								                     <c:choose>
								                     	<c:when test="${unpaid.rcivAt eq 0}">
								                     		미수납
								                     	</c:when>
								                     	<c:when test="${unpaid.rcivAt eq 1}">
								                     		수납
								                     	</c:when>
								                     	<c:otherwise>
								                     		부분 수납
								                     	</c:otherwise>
								                     </c:choose>
					                     		</td>
								                     <td class="text-nowrap text-center">${unpaid.patntNm }</td>
								                     <td class="text-nowrap text-center">
								                     <c:choose>
								                     	<c:when test="${unpaid.patntSexdstn eq 'M'}">남성</c:when>
								                     	<c:otherwise>여성</c:otherwise>
								                     </c:choose>
								                     
								                     </td>
								                     <td class="text-nowrap text-center">
								                     	<fmt:formatDate value="${unpaid.clnicTime }" pattern="yyyy.MM.dd HH:mm"/>
								                     </td>
								                     <td class="text-nowrap text-end">
								                     	<fmt:formatNumber type="number" value="${unpaid.missingAmount}" pattern="#,##0" />
								                     </td>
					                   			</tr>
			                 			</c:forEach>
			                 		</c:otherwise>
			                 	</c:choose>
	                 			</tbody>
	                 		</table>
	                 	</c:when>
	                 	
	                 	
	                 	<c:otherwise>
			               <table class="table table-hover table-striped overflow-hidden">
			                 <thead>
			                   <tr style="height: 55px;">
			                     <th class=" text-start" scope="col">수납여부</th>
			                     <th class=" text-center" scope="col">수진자명</th>
			                     <th class=" text-center" scope="col">수납방법</th>
			                     <th class=" text-center" scope="col">수납일시</th>
			                     <th class="text-center" scope="col">수납금액(원)</th>
			                   </tr>
			                 </thead>
			                 <tbody>
			                 <c:set value="${pagingVO.dataList }" var="receiveList"/>
			                 <c:choose>
			                 	<c:when test="${empty receiveList }">
			                 		<td class="text-nowrap text-center" colspan="5" scope="col">해당 내역이 존재하지 않습니다.</td>
			                 	</c:when>
			                 	<c:otherwise>
			                 		<c:forEach items="${receiveList }" var="receive">
					                   <tr class="receiveDetail align-middle" id="${receive.rciptNo }" style="height: 55px;">
					                     <td class="text-nowrap text-start">
					                     <c:choose>
					                     	<c:when test="${receive.rcivAt eq 0}">
					                     		미수납
					                     	</c:when>
					                     	<c:when test="${receive.prearngeAmount eq receive.ipocdAmountBefore + receive.ipocdAmount }">
					                     		수납
					                     	</c:when>
					                     	<c:when test="${receive.prearngeAmount > receive.ipocdAmountBefore + receive.ipocdAmount}">
					                     		부분 수납
					                     	</c:when>
					                     </c:choose>
					                     </td>
					                     <td class="text-nowrap text-center">${receive.patntNm }</td>
					                     <td class="text-nowrap text-center">${receive.paymthd }</td>
					                     <td class="text-nowrap text-center">
					                     	<fmt:formatDate value="${receive.ipocdDttm }" pattern="yyyy.MM.dd HH:mm"/>
					                     </td>
					                     <td class="text-nowrap text-end">
					                     	<fmt:formatNumber type="number" value="${receive.ipocdAmount}" pattern="#,##0" />
					                     </td>
					                   </tr>
			                 		</c:forEach>
			                 	</c:otherwise>
			                 </c:choose>
			                 </tbody>
			               </table>
	                 	</c:otherwise>
	                 </c:choose>
	             </div>
	           </div>
	         </div>
	         <div class="clearfix col-auto align-self-center pagingArea" id="pagingArea">
				${pagingVO.pagingHTML }
			</div>
	       </div>
	     </div>
	</div>
	<div class="col-lg-5" >
		<div class="card" style="height: 820px;" id="pdfDiv">
	       <div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
	         <div class="row flex-between-end">
	           <div class="col-auto align-self-center">
	             <h5 class="mb-0 text-white fw-semi-bold" id="header">상세보기</h5>
	           </div>
	           <div class="col-auto ms-auto">
	           </div>
	         </div>
	       </div>
	       <div class="card-body pt-0 d-flex justify-content-center" style="margin-left: 40px;">
	         <div class="tab-content">
	           <div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-1123d529-5101-4101-b597-dac496b93923" id="dom-1123d529-5101-4101-b597-dac496b93923">
	             <!-- =========================== 상세조회 시작 =========================== -->
					<div style="text-align: right; margin-bottom: 30px; margin-top: 30px; margin-right: 33px;" id="temp">
					  <button class="btn btn-falcon-default me-1 mb-1" type="button" style="font-size: 8px; width: 90px; height: 35px;" id="pdfBtn">
					    <span class="text-800 fs-1 bi-download">PDF</span>
					  </button>
					</div> 
	             <!-- THIS -->
					<div class="row card-body pt-0">
						<div class="tab-content">
							<div class="row">
								<div class="col-6">
									<div class="row input-group">
										<input
											class="fw-semi-bold col-6 bg-secondary-subtitle-subtle text-black text-center form-control"
											id="" name="" type="text" value="이름" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="patntNm" name="patntNm"
												type="text" value="" disabled />
										</div>
									</div>
								</div>
								<div class="col-6">
									<div class="row input-group">
										<input
											class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="성별" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="patntSexdstn" name="patntSexdstn"
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
											class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="생년월일" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="patntRrno1" name="patntRrno1"
												type="text" value="" disabled />
										</div>
									</div>
								</div>
								<div class="col-6">
									<div class="row input-group">
										<input
											class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="나이" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="patntAge" name="patntAge"
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
											class="fw-semi-bold col-3 mb-2 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="주소" disabled />
										<div class="col-9 input-group-append p-0 m-0">
											<input class="text-black form-control bg-white" id="patntAdres1" name="patntAdres1"
												type="text" value="" disabled />
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="row input-group">
										<div class="col-3"></div>
										<div class="col-9 input-group-append p-0 m-0">
											<input class="text-black form-control bg-white" id="patntAdres2" name="patntAdres2"
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
											class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="전화번호" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="patntTelno" name="patntTelno"
												type="text" value="" disabled />
										</div>
									</div>
								</div>
								
								<div class="col-6">
									<div class="row input-group">
										<input
											class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="건강 보험" disabled />
										<div class="col-6 input-group-append p-0 m-0">
											<input
												class="text-black text-center form-control px-0 bg-white"
												id="patntHlthinsAt" name="patntHlthinsAt" type="text" value="" disabled />
										</div>
									</div>
								</div>
							</div>
							<br>
							
							<c:choose>
								<c:when test="${searchType eq 'unpaid' }">
									<div class="row">	
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="보호자이름" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control px-0 bg-white"
														id="prtctorNmUnpaid" name="prtctorNmUnpaid" type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="보호자연락처" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control px-0 bg-white"
														id="prtctorTelnoUnpaid" name="prtctorTelnoUnpaid" type="text" value="" disabled />
												</div>
											</div>
										</div>
									</div>
									<br/>
									<div class="row">	
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="진료 일시" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control px-0 bg-white"
														id="clnicTimeUnpaid" name="clnicTimeUnpaid" type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="수납 총액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control px-0 bg-white"
														id="recivTotamtUnpaid" name="recivTotamtUnpaid" type="text" value="" disabled />
												</div>
											</div>
										</div>
									</div>
										<br/>
										<div class="row">	
											<div class="col-6">
												<div class="row input-group">
													<input
														class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
														id="" name="" type="text" value="수진자 부담액" disabled />
													<div class="col-6 input-group-append p-0 m-0">
														<input class="text-black text-end form-control px-0 bg-white"
															id="prearngeAmountUnpaid" name="prearngeAmountUnpaid" type="text" value="" disabled />
													</div>
												</div>
											</div>
											<div class="col-6">
												<div class="row input-group">
													<input
														class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
														id="" name="" type="text" value="미수 금액" disabled />
													<div class="col-6 input-group-append p-0 m-0">
														<input class="text-black text-end form-control px-0 bg-white"
															id="missingAmountUnpaid" name="missingAmountUnpaid" type="text" value="" disabled />
													</div>
												</div>
											</div>
										</div>
										<br/>
										<div class="row">	
											<div class="col-12">
												<div class="row input-group">
													<input
														class="fw-semi-bold col-2 bg-secondary-subtitle text-black text-center form-control"
														id="" name="" type="text" value="환자 메모" disabled />
													<div class="col-10 input-group-append p-0 m-0">
														<input class="text-black text-center form-control px-0 bg-white"
															id="patntMemoUnpaid" name="patntMemoUnpaid" type="text" value="" disabled />
													</div>
												</div>
											</div>
										</div>
								</c:when>
								<c:otherwise>
									<div class="row">
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="수납 구분" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control bg-white" id="rcivAt" name="rcivAt"
														type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="수납 총액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control bg-white" id="recivTotamt" name="recivTotamt"
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
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="수진자 부담액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control bg-white" id="prearngeAmount" name="prearngeAmount"
														type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="납부 금액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control bg-white" id="ipocdAmount" name="ipocdAmount"
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
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="누적 수납 금액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control bg-white" id="rcivAmount" name="rcivAmount"
														type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="미수 금액" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-end form-control bg-white" id="missingAmount" name="missingAmount"
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
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="분할 수납 일시" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control bg-white" id="ipocdDttm" name="ipocdDttm"
														type="text" value="" disabled />
												</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row input-group">
												<input
													class="fw-semi-bold col-6 bg-secondary-subtitle text-black text-center form-control"
													id="" name="" type="text" value="수납 완료 일시" disabled />
												<div class="col-6 input-group-append p-0 m-0">
													<input class="text-black text-center form-control bg-white" id="rcivDttm" name="rcivDttm"
														type="text" value="" disabled />
												</div>
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
							<br>
							<div class="row">
								<div class="col-12">
									<div class="row input-group">
										<input
											class="fw-semi-bold col-3 bg-secondary-subtitle text-black text-center form-control"
											id="" name="" type="text" value="수납 메모" disabled />
										<div class="col-9 input-group-append p-0 m-0">
											<input class="text-black text-center form-control bg-white" id="recivMemo" name="recivMemo"
												type="text" value="" disabled />
										</div>
									</div>
								</div>
							</div>
							<br>
						</div>
					</div>
	           </div>
	         </div>
	       </div>
	     </div>
	</div>
    <!--  상세조회 종료 -->
</div>

<script type="text/javascript">
$(function(){
	
	var token = $("input[name='_csrf']").val();
	var header = $("input[name='_csrf_header']").val();
	
	// 전화번호 형식을 변경하는 함수
    function formatPhoneNumber(phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
	
	// yyyy/MM/dd 형식으로 숫자 데이터를 날짜로 변환
	function formatDateNoTime(timeStamp){
	    var date = new Date(timeStamp);
	    
	    var year = date.getFullYear();
	    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 문자열로 변환하여 두 자리로 만듭니다.
	    var day = date.getDate().toString().padStart(2, '0'); // 일도 마찬가지로 두 자리로 만듭니다.
	    
	    var formattedDate = year + '.' + month + '.' + day;
	    
	    return formattedDate;
	}
	
	// 8,000 형식으로 만들기
	function formatWonNumber(number){
		var formatNumber = number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return formatNumber;
	}
	
	// 00년생 처리 함수
	function formatBirthday(number){
		
		// 변환된 생년월일을 담을(리턴할) 변수
		var formatRrno1 = "";
		// 주민번호 앞자리에 0이 들어간 길이
		// number가 정수형이므로 문자열로 바꾼뒤 length구함
		var zeroLength = 6 - number.toString().length;
		
		// 0의 길이만큼 앞자리 생성
		if(zeroLength > 0){
			for(var i = 0; i < zeroLength; i++){
				formatRrno1 += "0";
			}
		}
		
		// 생성된 앞자리 + 원래 주민번호 앞자리
		formatRrno1 += number;
		
        return formatRrno1;
	}
	
	/* 미수납 상세 조회  스크립트 */
	var unpaidDetail = $('.unpaidDetail');
	unpaidDetail.on('click', function(){
		
		var rcivNo = $(this).attr('id');
// 		console.log("rcivNo : " + rcivNo );
		var data = {
			rcivNo : rcivNo  	
		};
		
		$.ajax({
			type : "post",
			url : "/mediform/manager/unpaid/detail",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(rst) {
// 					console.log(rst);
// 					console.log(rst.rcivDttm);
					// 영역 비우기 시작
					$('#patntNm').val("");
					$('#patntSexdstn').val("");
					$('#patntRrno1').val("");
					$('#patntAge').val("");
					$('#patntAdres1').val("");
					$('#patntAdres2').val("");
					$('#patntTelno').val("");
					$('#patntHlthinsAt').val("");
					$('#prtctorNmUnpaid').val("");
					$('#prtctorTelnoUnpaid').val("");
					$('#clnicTimeUnpaid').val("");
					$('#recivTotamtUnpaid').val("");
					$('#prearngeAmountUnpaid').val("");
					$('#missingAmountUnpaid').val("");
					$('#patntMemoUnpaid').val("");
					$('#recivMemo').val("");
					// 영역 비우기 끝


					$('#patntNm').val(rst.patntNm);
					
					var patntSexdstnStr = "";
					if(rst.patntSexdstn != null && rst.patntSexdstn == "M"){
						patntSexdstnStr = "남성";
					}else{
						patntSexdstnStr = "여성";
					}
					$('#patntSexdstn').val(patntSexdstnStr);
					
					$('#patntRrno1').val(formatBirthday(rst.patntRrno1));
					$('#patntAge').val(rst.patntAge);
					$('#patntAdres1').val(rst.patntAdres1);
					$('#patntAdres2').val(rst.patntAdres2);
					$('#patntTelno').val(formatPhoneNumber(rst.patntTelno));
					$('#patntHlthinsAt').val(rst.patntHlthinsAt);
					$('#prtctorNmUnpaid').val(rst.prtctorNm);
					$('#prtctorTelnoUnpaid').val(formatPhoneNumber(rst.prtctorTelno));
					
					var formatclnicTimeUnpaid = formatDateNoTime(rst.clnicTime);
					$('#clnicTimeUnpaid').val(formatclnicTimeUnpaid);
					
					var formatrecivTotamtUnpaid = formatWonNumber(rst.recivTotamt);
					$('#recivTotamtUnpaid').val(formatrecivTotamtUnpaid + "원");
					
					var formatPrearngeAmountUnpaid = formatWonNumber(rst.prearngeAmount);
					$('#prearngeAmountUnpaid').val(formatPrearngeAmountUnpaid + "원");
					
					var formatMissingAmountUnpaid = formatWonNumber(rst.missingAmount);
					$('#missingAmountUnpaid').val(formatMissingAmountUnpaid + "원");
					
					$('#patntMemoUnpaid').val(rst.patntMemo);
					$('#recivMemo').val(rst.recivMemo);
					
				
			}
		});
		
		
		
	});
	
	
	/* 수납 상세 조회 스크립트 */
	var receiveDetail = $('.receiveDetail');
	receiveDetail.on('click', function(){
		
		var rciptNo = $(this).attr('id');
		var data = {
			rciptNo : rciptNo  	
		};
		
		$.ajax({
			type : "post",
			url : "/mediform/manager/receive/detail",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(rst) {
// 					console.log(rst);
				/* 영역 비우기 시작 */
				$('#patntNm').val("");
				$('#patntSexdstn').val("");
				$('#patntRrno1').val("");
				$('#patntAge').val("");
				$('#patntAdres1').val("");
				$('#patntAdres2').val("");
				$('#patntTelno').val("");
				$('#patntHlthinsAt').val("");
				$('#rcivAt').val("");
				$('#ipocdAmount').val("");
				$('#recivTotamt').val("");
				$('#prearngeAmount').val("");
				$('#rcivAmount').val("");
				$('#missingAmount').val("");
				$('#rcivDttm').val("");
				$('#recivMemo').val("");
				$('#ipocdDttm').val("");
				/* 영역 비우기 끝 */

				
				$('#patntNm').val(rst.patntNm);
				
				var patntSexdstn = rst.patntSexdstn;
				var patntSexdstnStr = "";
				if(patntSexdstn != null && patntSexdstn == "M"){
					patntSexdstnStr = "남성";
				}else{
					patntSexdstnStr = "여성";
				}
				
				$('#patntSexdstn').val(patntSexdstnStr);
				$('#patntRrno1').val(formatBirthday(rst.patntRrno1));
				$('#patntAge').val(rst.patntAge);
				$('#patntAdres1').val(rst.patntAdres1);
				$('#patntAdres2').val(rst.patntAdres2);
				$('#patntTelno').val(formatPhoneNumber(rst.patntTelno));
				
				var patntHlthinsAt = rst.patntHlthinsAt;
				var patntHlthinsAtStr = "";
				if(patntHlthinsAt != null && patntHlthinsAt == "Y"){
					patntHlthinsAtStr = "O";
				}else{
					patntHlthinsAtStr = "X";
				}
				$('#patntHlthinsAt').val(patntHlthinsAtStr);
				
				
				var rcivAt = rst.rcivAt;
				// 미수 금액
				var missingAmountValue = rst.missingAmount;
				
				// 환자 부담액
				var prearngeAmount = rst.prearngeAmount;
				
				var rcivAtStr = "";
				if(rcivAt != null){
					if(rcivAt == "0"){
						rcivAtStr = "미수납";
					}else if(missingAmountValue === 0){
						rcivAtStr = "수납";
					}else if(missingAmountValue > 0){
						rcivAtStr = "부분 수납";
					}
				}
				
				$('#rcivAt').val(rcivAtStr);
				
				var formatIpocdAmount = formatWonNumber(rst.ipocdAmount);
				$('#ipocdAmount').val(formatIpocdAmount + "원");
				
				var formatRecivTotamt = formatWonNumber(rst.recivTotamt);
				$('#recivTotamt').val(formatRecivTotamt + "원");
				
				var formatPrearngeAmount = formatWonNumber(rst.prearngeAmount);
				$('#prearngeAmount').val(formatPrearngeAmount + "원");
				
				var formatRcivAmount = formatWonNumber(rst.ipocdAmountBefore);
				$('#rcivAmount').val(formatRcivAmount  + "원");
				
				var formatMissingAmount = formatWonNumber(rst.missingAmount);
				$('#missingAmount').val(formatMissingAmount  + "원");
				
				console.log(rst.rcivDttm);
				if(rst.rcivDttm == null || rst.rcivDttm == ""){
					var formatRcivDttm = "";
				}else{
					var formatRcivDttm = formatDateNoTime(rst.rcivDttm);
				}
				$('#rcivDttm').val(formatRcivDttm);
				
				$('#recivMemo').val(rst.recivMemo);
				
				var formatIpocdDttm = formatDateNoTime(rst.ipocdDttm);
				$('#ipocdDttm').val(formatIpocdDttm);
			}
		});
		
	});
	
	/* ---------------------------------------- */
	// 페이징 처리
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	// 검색 버튼 이벤트
	var searchBtn = $('#searchBtn');
	searchBtn.on('click', function(){
		searchForm.submit();
	});
	
	// 해당 검색창에서 엔터 누르면 이벤트 발생
	$("#searchWordBox").on("keydown", function(e) {
	    if (e.key === "Enter") { 
	    	searchForm.submit();
	    }
	});
	
	// 미수납 선택시 페이지 이동
	var searchType = $('#searchType');
	searchType.on('change', function(){
		searchForm.submit();
	});
	
	pagingArea.on("click", "a", function(event){
		
		event.preventDefault();
		var pageNo = $(this).data("page")
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	
	/* ---------------------------------------- */
	
	/* 검색 x버튼 누르면 검색창 초기화 */
	var searchXbtn = $('.btn-close-falcon-container');
	searchXbtn.on('click', function(){
		event.preventDefault();
		$('.fuzzy-search').val("");
	});
	
	// 날짜 유효성 검사
	$('#selectDate1').on('change', function() {
        var date1 = new Date($(this).val());
        var date2 = new Date($('#selectDate2').val());

        if (date1 > date2) {
        	Swal.fire({
			      icon: 'error',
			      title: 'error',
			      html: '입력한 날짜 범위가 올바르지 않습니다. <br> 시작 날짜는 종료 날짜보다 이전이어야 합니다.',
			      confirmButtonColor: 'blue'
			    });
            $(this).val(''); // 값을 변경하지 않음
        }
    });

    // selectDate2 값 변경 감지
    $('#selectDate2').on('change', function() {
        var date1 = new Date($('#selectDate1').val());
        var date2 = new Date($(this).val());

        if (date2 < date1) {
        	Swal.fire({
			      icon: 'error',
			      title: 'error',
			      html: '입력한 날짜 범위가 올바르지 않습니다. <br> 종료 날짜는 시작 날짜보다 이후여야 합니다.',
			      confirmButtonColor: 'blue'
			    });
            $(this).val(''); // 값을 변경하지 않음
        }
    });	
    
    
    
    // 상세 내역 캡처
    var pdfBtn = $('#pdfBtn');
    function pdfPrint(){
    	
//		 	var pdfDiv = $('#temp');
	 	var pdfDiv = $('#pdfDiv');
	 	
	 	// A4 가로 크기 (mm 단위)
	 	var a4Width = 210;
	 	
        // 현재 document.body의 html을 A4 크기에 맞춰 PDF로 변환
        html2canvas(pdfDiv, {
        	y: 200,
            onrendered: function (canvas) {
                // 캔버스를 이미지로 변환
                var imgData = canvas.toDataURL('image/png');

                var imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
                var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
                var imgHeight = canvas.height * imgWidth / canvas.width;
                var heightLeft = imgHeight;

                var doc = new jsPDF('p', 'mm');
                var position = 0;

                // 첫 페이지 출력
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;

                // 한 페이지 이상일 경우 루프 돌면서 출력
                while (heightLeft >= 20) {
                    position = heightLeft - imgHeight;
                    doc.addPage();
                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;
                }
                // 파일 저장
                doc.save('수납상세조회.pdf');

                //이미지로 표현
//	                document.write('<img src="'+imgData+'" />');
            }
        });
        
       		 pdfBtn.show();
    }
 
 
 pdfBtn.on('click', function(){
	 $('body').find('svg').each(function() {
		    $(this).attr('width', this.getBoundingClientRect().width);
		    $(this).attr('height', this.getBoundingClientRect().height);
		    $(this).css('width', null);
		    $(this).css('height', null);
	 });
	 
	 pdfBtn.hide();
	 pdfPrint();
 });
    
    
    
});
</script>
</body>
</html>