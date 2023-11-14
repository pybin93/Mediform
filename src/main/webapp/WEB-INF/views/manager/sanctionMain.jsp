<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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

#empSelectBox, #conSelectBox, #comSelectBox {
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
	margin-left: 20px;
	margin-right: 20px;
}

.profileImg {
	width: 150px; /* 원하는 가로 크기로 설정 */
	height: 150px; /* 원하는 세로 크기로 설정 */
	object-fit: cover; /* 이미지 비율 유지하면서 부족한 부분을 채움 */
}

.sanctionTrList, .completeTrList {
	cursor: pointer;
}
</style>
</head>
<body>
<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<input type="hidden" name="myEmpNo" id="myEmpNo" value="${customUser.employee.empNo}"/>
<input type="hidden" id="msg" value="${msg }">
<div class="row">
	
<!-- 발주서 목록 -->
<div class="col-6">
	<div class="card border border-secondary" style="height: 820px;">
		<div>
			<div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
	         <div class="row flex-between-end">
	           <div class="col-auto align-self-center">
	             <h5 class="mb-0 text-white fw-semi-bold" id="header">발주 목록</h5>
	           </div>
	           <div class="col-auto ms-auto">
	           </div>
	         </div>
	       </div>
   		</div>

   		<!-- 발주리스트 -->
   		<div class="tab-pane active mt-3" id="tab-profile" role="tabpanel" aria-labelledby="profile-tab">
   			<div id="tableExample3" data-list='{"valueNames":["porderCd","porderCt","porderDate","porderEmpno", "empNm","porderTotal"],"page":10,"pagination":true}'>
				<div class="row justify-content-start g-0 mb-2" style="margin-left: 20px; margin-top: 20px;">
				  <div class="col-auto ">
				    <div class="row align-items-center">
					  <div class="input-group col-12 d-flex align-items-center">
					    <input class="form-control search-input " type="search" placeholder="발주자명을 입력해 주세요." aria-label="search" name="" id="sanctionSearchWord"/>
					    <input type="date" style="margin-left: 7px; height: 36px;" id="sanctionStartDate" name="startDate" value="<fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd' />">
					    <span id="spanCss">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
					    <input type="date" style="height: 36px;" id="sanctionEndDate" name="endDate" value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd' />">
					    &nbsp;
					    <button class="btn btn-outline-secondary" style="height: 36px;" type="button" id="sanctionSearchBtn">검색</button>
					    <input type="hidden" name="page" id="sanctionPage" />
					  </div>
					</div>

				  </div>
				</div>



		        <div class="table-responsive scrollbar" style="height: 600px;">
		        	<table class="table table-bordered table-striped fs--1 mb-0" id="purchaseTable">
           				<thead class="bg-200">
		                <tr style="height: 55px;">
			                <th class="text-900  text-center" data-sort="porderCd">No</th>
			                <th class="text-900  text-center" data-sort="porderCt">구분</th>
			                <th class="text-900  text-center" data-sort="porderDate">주문일</th>
			                <th class="text-900  text-center" data-sort="porderEmpno">발주자사번</th>
			                <th class="text-900  text-center" data-sort="empNm">발주자명</th>
			                <th class= "text-900  text-center" data-sort="porderTotal">발주금액</th>
		                </tr>
           				</thead>
           				<tbody class="list sanctionTbody" id="table-crm-location-session">
		                  
			            </tbody>
			          </table>
		        </div>
		        <div class="d-flex justify-content-center mt-3 card-footer col-auto align-self-center pagingArea" id="sanctionPagingArea" style="padding-top: 0px;">
				</div>
			      </div>
			    </div>
			  </div>
			</div>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<div class="col-6">
		<div class="card border border-secondary" style="height: 820px;">
			<div>
				<div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
		         <div class="row flex-between-end">
		           <div class="col-auto align-self-center">
		             <h5 class="mb-0 text-white fw-semi-bold" id="header">처리 내역</h5>
		           </div>
		           <div class="col-auto ms-auto">
		           </div>
		         </div>
		       </div>
	   		</div>
	
	  		<!-- 발주리스트 -->
	  		<div class="tab-pane active mt-3" id="tab-profile" role="tabpanel" aria-labelledby="profile-tab">
   			<div id="tableExample3" data-list='{"valueNames":["comPorderCd","comPorderCt","comPorderDate","comPorderEmpno","comEmpNm","comPorderConfm", "comPorderTotal"],"page":10,"pagination":true}'>
				<div class="row justify-content-start g-0 mb-2" style="margin-left: 20px; margin-left: 20px; margin-top: 20px;">
				  <div class="col-auto ">
				    <div class="row align-items-center">
					  <div class="input-group col-12 d-flex align-items-center">
					    <div class="search-container" style="width: 100px;">
					      <select class="form-select form-select-sm" style="height: 36px; padding-right: 0px; " name="searchType" id="comSearchType">
					        <option value="ALL" <c:if test="${searchType eq 'all'}">selected</c:if>>전체</option>
					        <option value="Y" <c:if test="${searchType eq 'yes'}">selected</c:if>>승인</option>
					        <option value="N" <c:if test="${searchType eq 'no'}">selected</c:if>>반려</option>
					      </select>
					    </div>
					    <input class="form-control search-input fuzzy-search" type="search" placeholder="발주자명을 입력해 주세요." aria-label="search" id="comSearchWord"/>
					    <input type="date" style="margin-left: 7px; height: 36px;" id="comStartDate" name="comStartDate" value="<fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd' />">
					    <span id="spanCss">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
					    <input type="date" style="height: 36px;" id="comEndDate" name="comEndDate" value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd' />">
					    &nbsp;
					    <button class="btn btn-outline-secondary" style="height: 36px;" type="button" id="comSearchBtn">검색</button>
					    <input type="hidden" name="page" id="comPage" />
					  </div>
					</div>
	
				  </div>
				</div>
				<div class="table-responsive scrollbar" style="height: 600px;">
		        	<table class="table table-bordered table-striped fs--1 mb-0" id="purchaseTable">
           				<thead class="bg-200">
		                <tr style="height: 55px;">
			                <th class="text-900  text-center" data-sort="comPorderConfm">승인여부</th>
			                <th class="text-900  text-center" data-sort="">결재자명</th>
			                <th class="text-900  text-center" data-sort="comPorderCd">No</th>
			                <th class="text-900  text-center" data-sort="">처리일시</th>
			                <th class="text-900  text-center" data-sort="comPorderEmpno">발주자사번</th>
			                <th class="text-900  text-center" data-sort="comEmpNm">발주자명</th>
			                <th class= "text-900  text-center" data-sort="comPorderTotal">발주금액</th>
		                </tr>
           				</thead>
           				<tbody class="list sanctionTbody" id="table-crm-location-session-com">
		                  
			            </tbody>
			          </table>
			        </div>
	
					<div class="d-flex justify-content-center mt-3 card-footer col-auto align-self-center pagingArea" id="comPagingArea" style="padding-top: 0px;">
					</div>	
			        <!-- d-flex justify-content-center mt-3 -->
			      </div>
			    </div>
			  </div>
			</div>
	</div>
	
	
	
	
	
	
	
	
	
	
<!-- 처리 내역 상세 조회 모달 시작 -->
<div class="modal fade" id="complete-modal" tabindex="-1"
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
				<div class="rounded-top-3 py-3 ps-4 pe-6 " style="background-color: midnightblue">
					<h4 class="modalHeader mb-1 text-white" id="modalExampleDemoLabel">처리 내역 상세 보기</h4>
				</div>
				<div class="p-4 pb-0">
					<div class="row">
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for=completePorderCdModal>발주번호</label> <input
								class="form-control" id="completePorderCdModal" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderCtModal">구분</label> <input
								class="form-control" id="completePorderCtModal" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderDateModal">신청일</label> <input
								class="form-control" id="completePorderDateModal" type="text" name=""
								readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderEmpnoModal">기안자</label>
							<input class="form-control" id="completePorderEmpnoModal" type="text"
								name="" readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderAuth1Modal">1차 결재자</label>
							<input class="form-control" id="completePorderAuth1Modal" type="text"
								name="empEmail" readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderAuth1Modal">최종 결재자</label>
							<input class="form-control" id="completePorderAuth2Modal" type="text"
								name="empEmail" readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="completePorderConfmModal">승인 여부</label>
							<input class="form-control" id="completePorderConfmModal" type="text"
								name="" readonly="readonly" />
						</div>
						<div class="col-8 mb-3 form-group" style="display: none;" id="rjctResnNone">
							<label class="col-form-label" for="completeRjctResnModal">반려 사유</label>
							<input class="form-control" id="completeRjctResnModal" type="text"
								name="" readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-12 mb-3 form-group">
							<label class="col-form-label" for="">신청 약품 내역</label>
							<table style="width: 1140px;">
								<thead class="bg-200">
									<tr>
										<th class="text-900 text-center">약품코드</th>
										<th class="text-900 text-center">약품명</th>
										<th class="text-900 text-center">업체</th>
										<th class="text-900 text-center">단위</th>
										<th class="text-900 text-center">수량</th>
										<th class="text-900 text-end">가격(개당)</th>
										<th class="text-900 text-end">총 가격</th>
										<th class="text-900 text-center">재고량</th>
										<th class="text-900 text-center">비고</th>
									</tr>
								</thead>
								<tbody id="completeModalBody">
									<!-- 여기에 추가하삼 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" id="" data-bs-dismiss="modal">닫기</button>
				<!-- 닫기 버튼 활성화 속성 : data-bs-dismiss="modal" -->
			</div>
		</div>
	</div>
</div>
<!-- 처리 내역 상세 조회 모달 끝 -->


<!-- 결재 내역 상세 조회 모달 시작 -->
<div class="modal fade" id="sanction-modal" tabindex="-1"
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
				<div class="rounded-top-3 py-3 ps-4 pe-6" style="background-color: midnightblue; font-weight: bold;">
					<h4 class="modalHeader text-white" id="modalExampleDemoLabel">약품 신청 내역 상세 보기</h4>
				</div>
				<div class="p-4 pb-0">
					<div class="row">
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for=porderCdModal>발주번호</label> <input
								class="form-control" id="porderCdModal" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="porderCtModal">구분</label> <input
								class="form-control" id="porderCtModal" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-4 mb-3 form-group">
							<label class="col-form-label" for="porderDateModal">신청일</label> <input
								class="form-control" id="porderDateModal" type="text" name=""
								readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-3 mb-3 form-group">
							<label class="col-form-label" for="porderEmpnoModal">기안자사번</label>
							<input class="form-control" id="porderEmpnoModal" type="text"
								name="" readonly="readonly" />
						</div>
						<div class="col-3 mb-3 form-group">
							<label class="col-form-label" for="empNmModal">기안자명</label> <input
								class="form-control" id="empNmModal" type="text" name=""
								readonly="readonly" />
						</div>
						<div class="col-3 mb-3 form-group">
							<label class="col-form-label" for="porderAuth1Modal">1차 승인자</label>
							<input class="form-control" id="porderAuth1Modal" type="text"
								name="empEmail" readonly="readonly" />
						</div>
						<div class="col-3 mb-3 form-group">
							<label class="col-form-label" for="porderAuth1NmModal">1차 승인자명</label>
							<input class="form-control" id="porderAuth1NmModal" type="text"
								name="empEmail" readonly="readonly" />
						</div>
					</div>
					<div class="row">
						<div class="col-12 mb-3 form-group">
							<label class="col-form-label" for="">신청 약품 내역</label>
							<table style="width: 1140px;">
								<thead class="bg-200">
									<tr>
										<th class="text-900 text-center">약품코드</th>
										<th class="text-900 text-center">약품명</th>
										<th class="text-900 text-center">업체</th>
										<th class="text-900 text-center">단위</th>
										<th class="text-900 text-center">수량</th>
										<th class="text-900 text-end">가격(개당)</th>
										<th class="text-900 text-end">총 가격</th>
										<th class="text-900 text-center">재고량</th>
										<th class="text-900 text-center">비고</th>
									</tr>
								</thead>
								<tbody id="sanctionModalBody">
									<!-- 여기에 추가하삼 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" id="agreeBtn" style="background-color: midnightblue; border: 1px midnightblue solid">승인</button>
				<button class="btn btn-danger" type="button" id="rejectBtn">반려</button>
				<!-- 닫기 버튼 활성화 속성 : data-bs-dismiss="modal" -->
			</div>
		</div>
	</div>
</div>
<!-- 결재 내역 상세 조회 모달 끝 -->

<!-- 반려사유 모달  탬플릿 시작 -->
<div class="modal fade" id="reject-modal" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 500px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6 " style="background-color: midnightblue; font-weight: bold;">
					<h4 class="text-white" id="modalExampleDemoLabel">반려</h4>
				</div>
				<div class="p-4 pb-0">
					<div class="mb-3 form-group">
						<label class="col-form-label" for="reason">반려사유</label> 
						<input class="form-control" id="reason" type="text" name="RjctResn" placeholder="반려사유를 입력해 주세요." />
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" id="rejectUpdate" style="background-color: midnightblue; border: 1px midnightblue solid">등록</button>
				<!-- 닫기 버튼 활성화 속성 : data-bs-dismiss="modal" -->
				<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 반려사유 모달 탬플릿 끝 -->

<!-- 승인 폼 -->
<form action="/mediform/manager/sanction/approval" method="post" id="sanctionForm">
	<input type="hidden" id="sanctionFormPorderCd" name="porderCd" value="">
	<input type="hidden" id="sanctionFormPorderAuth2" name="porderAuth2" value="${customUser.employee.empNo}">
	<input type="hidden" id="sanctionFormPorderConfm" name="porderConfm" value="">
	<sec:csrfInput />
</form>

<!-- 반려 폼 -->
<form action="/mediform/manager/sanction/reject" method="post" id="rejectForm">
	<input type="hidden" id="rejectFormPorderCd" name="porderCd" value="">
	<input type="hidden" id="rejectFormPorderAuth2" name="porderAuth2" value="${customUser.employee.empNo}">
	<input type="hidden" id="rejectFormPorderConfm" name="porderConfm" value="">
	<input type="hidden" id="rejectRjctResn" name="rjctResn" value="">
	<sec:csrfInput />
</form>

</body>
<!-- table 시작-->
<!-- table 끝-->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />
<!-- alert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$(document).ready(function() {
		
		sanctionPageOpen();
		completePageOpen();
		
		function completePageOpen(){
			var searchWord = $('#comSearchWord').val();
			var searchType = $('#comSearchType').val();
			var startDate = $('#comStartDate').val();
			var endDate = $('#comEndDate').val();
			var page = 1;
			
			completeSanctionAjax(searchType, searchWord, startDate, endDate, page);
		}
		
		// 페이지 오픈과 동시에 리스트 띄워주기
		function sanctionPageOpen(){
			var searchWord = $('#sanctionSearchWord').val();
			var startDate = $('#sanctionStartDate').val();
			var endDate = $('#sanctionEndDate').val();
			var page = $('#sanctionPage').val();
			
			if(page == 0 || page < 1){
				page = 1;
			}
			
			sanctionAjax(searchWord, startDate, endDate, page );
		}
		
        msgFunction();
        
        $('.priceFormat').each(function() {
            // 현재 td 요소의 텍스트 내용 가져오기
            var number = $(this).text();
            // 전화번호 형식 변경
            var formattedPrice = formatWonNumber(number);
            // 변경된 내용으로 업데이트
            $(this).text(formattedPrice);
        });
        
        
        // 처리 내역 상세 보기
        $('#table-crm-location-session-com').on('click', '.completeTrList', function(){
        	var porderCd = $(this).attr('id');
            var data = {
           		porderCd: porderCd
            };
            
            $.ajax({
    		    type: "post",
    		    url: "/mediform/manager/sanction/completeList/detail/select",
    		    data: JSON.stringify(data),
    		    contentType: "application/json; charset=utf-8",
    		    beforeSend: function(xhr) {
    		        xhr.setRequestHeader(header, token);
    		    },
    		    success: function(response) {
    		    	// 반려 사유 div요소 hide로 초기화
    		    	$('#rjctResnNone').hide();
//     		        console.log("ajax 성공");
//     		        console.log(response);
    		        
    		        // 목록 데이터 업데이트
    		        var completeModalBody = $("#completeModalBody");
    		        completeModalBody.empty();
    		        var porderEmp =  response.empNm + "(" + response.porderEmpno +")";
    		        var porderAuth1 =  response.porderAuth1Nm + "(" + response.porderAuth1 +")";
    		        var porderAuth2 =  response.porderAuth2Nm + "(" + response.porderAuth2 +")";
    		        var porderConfm = "";
    		        if(response.porderConfm != null && response.porderConfm == "Y"){
    		        	porderConfm = "승인";
    		        }else{
    		        	porderConfm = "반려";
    		        }
    		        
    		        // 반려 처리 되어 있는 값일 시...
    		        if(response.porderConfm != null && response.porderConfm == "N"){
//     		        	console.log(response.porderConfm);
    		        	// 반려 사유에 값을 넣고
	    		        $('#completeRjctResnModal').val(response.rjctResn);
    		        	// 해당 div요소를 show로 바꿔줌
	    		        $('#rjctResnNone').show();
    		        }
    		        
    		        $('#completePorderConfmModal').val(porderConfm);
    		        $('#completePorderCdModal').val(response.porderCd);
    		        $('#completePorderCtModal').val(response.porderCt);
    		        var formatPorderDate = formatDate(response.porderDate);
    		        $('#completePorderDateModal').val(formatPorderDate);
    		        $('#completePorderEmpnoModal').val(porderEmp);
    		        $('#completePorderAuth1Modal').val(porderAuth1);
    		        $('#completePorderAuth2Modal').val(porderAuth2);
    		        
    		        // 총 합계를 위한 변수
    		        var totalPriceSum = 0;
    		        var sanctionDetailList = response.sanctionDetailList;
    		        if (sanctionDetailList.length === 0) {
    		        	completeModalBody.append("<tr><td colspan='8' align='center'>신청된 발주 목록이 없습니다.</td></tr>");
    		        } else {
    		            $.each(sanctionDetailList, function(index, item) {
    		            	var formatMedcinPc = formatWonNumber(item.medcinPc);
    		            	var priceSum = item.podetailAmount * item.medcinPc;
    		            	totalPriceSum += priceSum;
    		            	
    		            	var formatPriceSum = formatWonNumber(priceSum);
    		            	var row = $("<tr>")
    		                    .append($("<td>").text(item.medcinCd).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinNm).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinMfbiz).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinUnit).addClass("text-center"))
    		                    .append($("<td>").text(item.podetailAmount).addClass("text-center"))
    		                    .append($("<td>").text(formatMedcinPc).addClass("text-end"))
    		                    .append($("<td>").text(formatPriceSum).addClass("text-end"))
    		                    .append($("<td>").text(item.medcinInvntry).addClass("text-center"))
    		                    .append($("<td>").text(item.podetailMemo).addClass("text-center"));
    		            	
    		            	completeModalBody.append(row);
    		            });
    		            // 총 합계를 위한 열
    		            var totalRow = $("<tr>").addClass("bg-200");
    		            totalRow.append($("<th colspan='5'>").text(""));
    		            totalRow.append($("<th>").text("총 가격 합계").addClass("text-end"));
    		            totalRow.append($("<th>").text(formatWonNumber(totalPriceSum) + "원").addClass("text-end"));
    		            totalRow.append($("<th>")); 
    		            totalRow.append($("<th>")); 
    		            completeModalBody.append(totalRow);
    		        }
    		        
    		        $('#complete-modal').modal("show");
    		        
    		    }
    		});
            
        });
        
        
        
        
    	// 신청 내역 상세조회를 위한 모달창 show
    	$('#table-crm-location-session').on('click', '.sanctionTrList', function(){
//     		console.log("클릭");
    		var porderCd = $(this).attr('id');
            var data = {
           		porderCd: porderCd
            };
            
            $.ajax({
    		    type: "post",
    		    url: "/mediform/manager/sanction/detail/select",
    		    data: JSON.stringify(data),
    		    contentType: "application/json; charset=utf-8",
    		    beforeSend: function(xhr) {
    		        xhr.setRequestHeader(header, token);
    		    },
    		    success: function(response) {
//     		        console.log("ajax 성공");
//     		        console.log(response);
    		        
    		        // 목록 데이터 업데이트
    		        var sanctionModalBody = $("#sanctionModalBody");
    		        sanctionModalBody.empty();
    		        
    		        // 승인/반려를 위한 폼에 해당 값을 넣어줌
    		        $('#sanctionFormPorderCd').val(response.porderCd);
    		        $('#rejectFormPorderCd').val(response.porderCd);

    		        $('#porderCdModal').val(response.porderCd);
    		        $('#porderCtModal').val(response.porderCt);
    		        var formatPorderDate = formatDate(response.porderDate);
    		        $('#porderDateModal').val(formatPorderDate);
    		        $('#porderEmpnoModal').val(response.porderEmpno);
    		        $('#empNmModal').val(response.empNm);
    		        $('#porderAuth1Modal').val(response.porderAuth1);
    		        $('#porderAuth1NmModal').val(response.porderAuth1Nm);
    		        
    		        // 총 합계를 위한 변수
    		        var totalPriceSum = 0;
    		        var sanctionDetailList = response.sanctionDetailList;
    		        if (sanctionDetailList.length === 0) {
    		        	sanctionModalBody.append("<tr><td colspan='8' align='center'>신청된 발주 목록이 없습니다.</td></tr>");
    		        } else {
    		            $.each(sanctionDetailList, function(index, item) {
    		            	var formatMedcinPc = formatWonNumber(item.medcinPc);
    		            	var priceSum = item.podetailAmount * item.medcinPc;
    		            	totalPriceSum += priceSum;
    		            	
    		            	var formatPriceSum = formatWonNumber(priceSum);
    		            	var row = $("<tr>")
    		                    .append($("<td>").text(item.medcinCd).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinNm).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinMfbiz).addClass("text-center"))
    		                    .append($("<td>").text(item.medcinUnit).addClass("text-center"))
    		                    .append($("<td>").text(item.podetailAmount).addClass("text-center"))
    		                    .append($("<td>").text(formatMedcinPc).addClass("text-end"))
    		                    .append($("<td>").text(formatPriceSum).addClass("text-end"))
    		                    .append($("<td>").text(item.medcinInvntry).addClass("text-center"))
    		                    .append($("<td>").text(item.podetailMemo).addClass("text-center"));
    		            	sanctionModalBody.append(row);
    		            });
    		            // 총 합계를 위한 열
    		            var totalRow = $("<tr>").addClass("bg-200");
    		            totalRow.append($("<th colspan='5'>").text(""));
    		            totalRow.append($("<th>").text("총 가격 합계").addClass("text-end"));
    		            totalRow.append($("<th>").text(formatWonNumber(totalPriceSum) + "원").addClass("text-end"));
    		            totalRow.append($("<th>")); 
    		            totalRow.append($("<th>")); 
    		            sanctionModalBody.append(totalRow);
    		        }
    		        
    		        $('#sanction-modal').modal("show");
    		        
    		    }
    		});
    	});
    	 
    var myEmpNo = $('#myEmpNo').val();	// 관리자 사번
    
    
    
    // 반려 버튼 클릭시
    $('#rejectBtn').on('click', function(){
    	
    	$('#reject-modal').modal("show");
    	
    	$('#rejectUpdate').on('click', function(){
    		var reason = $('#reason').val();
    		if(reason == null && reason == ""){
    			Swal.fire({
  			      icon: 'error',
  			      title: '처리 실패',
  			      text: '반려 사유를 입력해 주세요.',
  			      confirmButtonColor: 'midnightblue'
  			    });
    		}else{
		    	Swal.fire({
				      icon: 'info',
				      title: '결재 반려',
				      text: '해당 결재 내역을 반려 처리 하시겠습니까?',
				      confirmButtonText : '반려',
				      confirmButtonColor: 'midnightblue',
			          showCloseButton: false, // X 버튼 숨김
			          showCancelButton: true, // 취소 버튼 표시
			          cancelButtonText: '닫기', // 취소 버튼 텍스트를 '닫기'로 설정
				    }).then(result => {
				    	if(result.isConfirmed){
				    		$('#rejectRjctResn').val(reason);
				    		$('#rejectFormPorderConfm').val("N");
				    		$('#rejectForm').submit();
				    	}
				    });
    		}
    		
    	});
    	
    });
    
    // 승인 버튼 클릭시
    $('#agreeBtn').on('click', function(){
    	Swal.fire({
		      icon: 'info',
		      title: '결재 승인',
		      text: '해당 결재 내역을 승인 처리 하시겠습니까?',
		      confirmButtonText : '승인',
		      confirmButtonColor: 'midnightblue',
	          showCloseButton: false, // X 버튼 숨김
	          showCancelButton: true, // 취소 버튼 표시
	          cancelButtonText: '닫기', // 취소 버튼 텍스트를 '닫기'로 설정
		    }).then(result => {
		    	if(result.isConfirmed){
		    		$('#sanctionFormPorderConfm').val("Y");
		    		$('#sanctionForm').submit();
		    	}
		    });
    });
    
    
    	 
        
        
    });
	
	// 8,000 형식으로 만들기
	function formatWonNumber(number){
		var formatNumber = number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return formatNumber;
	}
    
 	// 전화번호 형식을 변경하는 함수
    function formatPhoneNumber(phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
	
	// 토큰
	var token = $("input[name='_csrf']").val();
	var header = $("input[name='_csrf_header']").val();
	
	// 메세지 모달 함수
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
	
	// 타임스탬프 날짜 변환 함수(시,분,초 포함) 
	// yyyy/MM/dd hh:mm
	function formatDate(timeStamp){
	    var date = new Date(timeStamp);
	
	    var year = date.getFullYear();
	    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 두 자리로 만듭니다.
	    var day = date.getDate().toString().padStart(2, '0'); // 일도 두 자리로 만듭니다.
	    var hours = date.getHours().toString().padStart(2, '0'); // 시도 두 자리로 만듭니다.
	    var minutes = date.getMinutes().toString().padStart(2, '0'); // 분도 두 자리로 만듭니다.
// 	    var seconds = date.getSeconds().toString().padStart(2, '0'); // 초도 두 자리로 만듭니다.
	
	    var formattedDate = year + '.' + month + '.' + day + ' ' + hours + ':' + minutes;
	
	    return formattedDate;
	}
	
	// 처리 내역 검색창에 입력시
	var comSearchWord = $('#comSearchWord');
	comSearchWord.on('input', function(){
		var searchWord = comSearchWord.val();
		var searchType = $('#comSearchType').val();
		var startDate = $('#comStartDate').val();
		var endDate = $('#comEndDate').val();
		var page = 1;
		
		completeSanctionAjax(searchType, searchWord, startDate, endDate, page);
		
	});
	
	// 검색창에 입력시
	var sanctionSearchWord = $('#sanctionSearchWord');
	sanctionSearchWord.on('input', function(){
		var searchWord = $('#sanctionSearchWord').val();
		var startDate = $('#sanctionStartDate').val();
		var endDate = $('#sanctionEndDate').val();
		var page = $('#sanctionPage').val();
		
		if(page == 0 || page < 1){
			page = 1;
		}
		
		sanctionAjax(searchWord, startDate, endDate, page );
		
	});
	
	// 처리 내역 필터시 
	$('#comSearchType').on('change', function(){
		var searchWord = $('#comSearchWord').val();
		var searchType = $('#comSearchType').val();
		var startDate = $('#comStartDate').val();
		var endDate = $('#comEndDate').val();
		var page = 1;
		
		completeSanctionAjax(searchType, searchWord, startDate, endDate, page);
	});
	
	
	// 처리 내역 리스트에서 검색 버튼 눌었을 시
	var comSearchBtn = $('#comSearchBtn');
	comSearchBtn.on('click', function(){
		var searchWord = comSearchWord.val();
		var searchType = $('#comSearchType').val();
		var startDate = $('#comStartDate').val();
		var endDate = $('#comEndDate').val();
		var page = 1;
		
		completeSanctionAjax(searchType, searchWord, startDate, endDate, page);
	});
	
	// 발주 내역 리스트에서 검색 버튼 눌렀을 시
	var sanctionSearchBtn = $('#sanctionSearchBtn');
	sanctionSearchBtn.on('click', function(){
		var searchWord = $('#sanctionSearchWord').val();
		var startDate = $('#sanctionStartDate').val();
		var endDate = $('#sanctionEndDate').val();
		var page = $('#sanctionPage').val();
		
		if(page == 0 || page < 1){
			page = 1;
		}
		
// 		console.log("sanctionSearchBtn click...!");
// 		console.log("searchWord : " + searchWord);
// 		console.log("startDate : " + startDate);
// 		console.log("endDate : " + endDate);
// 		console.log("page : " + page);
		
		sanctionAjax(searchWord, startDate, endDate, page );
		
	});
	
	/* 신청 내역 페이징 */
	var sanctionPagingArea = $('#sanctionPagingArea');
		sanctionPagingArea.on("click", "a", function(event){
		event.preventDefault();
		
		var searchWord = $('#sanctionSearchWord').val();
		var startDate = $('#sanctionStartDate').val();
		var endDate = $('#sanctionEndDate').val();
		var page = $(this).data("page");
		
// 		console.log("page click");
// 		console.log("page : "  + page);
		
		sanctionAjax(searchWord, startDate, endDate, page);
	});
	
	/* 처리 내역 페이징 */
	var comPagingArea = $('#comPagingArea');
		comPagingArea.on("click", "a", function(event){
		event.preventDefault();
		
		var searchWord = $('#comSearchWord').val();
		var searchType = $('#comSearchType').val();
		var startDate = $('#comStartDate').val();
		var endDate = $('#comEndDate').val();
		var page = $(this).data("page");
		completeSanctionAjax(searchType, searchWord, startDate, endDate, page);
		
	});
	
	
	// 신청 내역 출력을 ajax로 하기 위한 함수 시작
	function sanctionAjax(searchWord, startDate, endDate, page){
		
		var data = {
				searchWord : searchWord, 
				startDate : startDate, 
				endDate : endDate,
				page : page
			};
		
// 		console.log("ajax직전 page : " + page);
		
		// AJAX 요청
		$.ajax({
		    type: "post",
		    url: "/mediform/manager/sanction/list/select",
		    data: JSON.stringify(data),
		    contentType: "application/json; charset=utf-8",
		    beforeSend: function(xhr) {
		        xhr.setRequestHeader(header, token);
		    },
		    success: function(response) {
// 		        console.log("ajax 성공");
// 		        console.log(response);
		        
		        // 페이징 정보 업데이트
		        $("#sanctionPagingArea").html(response.pagingHTML);
		        
		        // 목록 데이터 업데이트
		        var dataList = response.dataList;
		        var tableBody = $("#table-crm-location-session");
		        tableBody.empty();
		        
		        if (dataList.length === 0) {
		            tableBody.append("<tr><td colspan='7' align='center'>신청된 발주 목록이 없습니다.</td></tr>");
		        } else {
		            $.each(dataList, function(index, item) {
		            	var formatPorderDate = formatDate(item.porderDate);
		            	var formatPorderTotal = formatWonNumber(item.porderTotal);
		            	var row = $("<tr>").attr("id", item.porderCd).addClass("sanctionTrList")
		                    .append($("<td>").text(item.porderCd).addClass("text-center"))
		                    .append($("<td>").text(item.porderCt).addClass("text-center"))
		                    .append($("<td>").text(formatPorderDate).addClass("text-center"))
		                    .append($("<td>").text(item.porderEmpno).addClass("text-center"))
		                    .append($("<td>").text(item.empNm).addClass("text-center"))
		                    .append($("<td>").text(formatPorderTotal).addClass("text-end"));
// 		                    .append($("<td>").text(item.porderConfm).addClass("porderConfm"));
						row.css("height", "50px");
		                tableBody.append(row);
		            });
		        }
		    }
		});
	}
	// 목록 출력을 ajax로 하기 위한 함수 종료
	
	
	
	
	
	
	// 처리 내역 확인을 위한 ajax 시작
	function completeSanctionAjax(searchType, searchWord, startDate, endDate, page){
			
			var data = {
					searchType : searchType, 
					searchWord : searchWord, 
					startDate : startDate, 
					endDate : endDate,
					page : page
				};
			
	// 		console.log("ajax직전 page : " + page);
			
			// AJAX 요청
			$.ajax({
			    type: "post",
			    url: "/mediform/manager/sanction/completion/list/select",
			    data: JSON.stringify(data),
			    contentType: "application/json; charset=utf-8",
			    beforeSend: function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
			    success: function(response) {
// 			        console.log("ajax 성공");
// 			        console.log(response);
			        
			        // 페이징 정보 업데이트
			        $("#comPagingArea").html(response.pagingHTML);
			        
			        // 목록 데이터 업데이트
			        var dataList = response.dataList;
			        var tableBody = $("#table-crm-location-session-com");
			        tableBody.empty();
			        
			        if (dataList.length === 0) {
			            tableBody.append("<tr><td colspan='7' align='center'>신청된 발주 목록이 없습니다.</td></tr>");
			        } else {
			            $.each(dataList, function(index, item) {
			            	var formatPorderConfmDt = formatDate(item.porderConfmDt);
			            	var formatPorderTotal = formatWonNumber(item.porderTotal);
			            	var formatConfm = "";
			            	if(item.porderConfm != null && item.porderConfm == "Y"){
			            		formatConfm = "승인";
			            	}else{
			            		formatConfm = "반려";
			            	}
			            	var row = $("<tr>").attr("id", item.porderCd).addClass("completeTrList")
			                    .append($("<td>").text(formatConfm).addClass("text-center"))
			                    .append($("<td>").text(item.porderAuth2Nm).addClass("text-center"))
			                    .append($("<td>").text(item.porderCd).addClass("text-center"))
			                    .append($("<td>").text(formatPorderConfmDt).addClass("text-center"))
			                    .append($("<td>").text(item.porderEmpno).addClass("text-center"))
			                    .append($("<td>").text(item.empNm).addClass("text-center"))
			                    .append($("<td>").text(formatPorderTotal).addClass("text-end"));
			            	
			            	row.css("height", "50px");
			                tableBody.append(row);
			            });
			        }
			    }
			});
		}
	// 처리 내역 확인을 위한 ajax 끝
	
	
	


});
</script>
</html>