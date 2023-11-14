<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--  
	
	* <script src="vendors/jquery/jquery.min.js"></script> 추가  

	* 70행 참고 
		id="tableEample"줘야함  / 테이블이 여러개면 1,2,3으로 구분지으면 됨                              				  						
 	
 	
 	* 70행 참고 
 		data-list에 '{"valueNames":["code","name","mfbiz","unit","count","price"],"page":10,"pagination":true}' 
	 	 	=> "page":10 - 한페이지에 10개 행
	 	 	=> valuenames - 각자 원하는대로 / th, td에 각각 넣어줘야힘  
	  
 	* 93행 참고
 	 	<th class="text-800 text-center sort" data-sort="code"> 													 
 			=> sort정렬  
 		
 	* 112행 참고
 		<td class="code text-center fw-semi-bold sessions" val-type="medcinCd">${medicine.medcinCd }</td>		 
 			=> class에 해당되는 valueName주기!!  val-type은 내가 개인적으로 사용하는거라 무시무시
 		
 	*  100행 참고 
 		<tbody class="list" id="table-crm-location-session" class="bg-200">									
 			=> tbody 클래스 list 넣어줘야함. 무조건 list. 저기에 숫자만 추가해도 안먹는거같음
 		
 		
 	* 124행 참고 (pagination)
 		<div class="d-flex justify-content-center mt-3">
			<button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev">
				<span class="fas fa-chevron-left"></span>
			</button>
			<ul class="pagination mb-0"></ul>
			<button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next">
				<span class="fas fa-chevron-right"> </span>
			</button>
		</div>
		
		=> 이건 현재 내가 사용하고 있는 페이지 버튼 
		
		
	* 74행 참고 (searchbox)
		<form>
			<div class="input-group mb-2">
				<input class="form-control search-input fuzzy-search" type="search" placeholder="검색할 약품명을 적어주세요" aria-label="search" />
				<div class="input-group-text bg-transparent">
					<span class="fas fa-search search-box-icon"></span>
				</div>
			</div>
		</form>
		
		=> 약품관리 쪽 searchbox (아무래도 같은 디자인으로 통일하는게 좋을거 같음) 
		
		이것만 넣어줘도 페이징이랑 검색 정렬 다 가능하구  추가적으로 기능 넣고 싶으신 분들은 
		  - falcon / modules / components / Jquery 참고
		  - 그 외 Tables / advance tables도 참고하기 좋음
--> 


<!-- 약품재고현황 테이블 example -->
<div id="tableExample2" data-list='{"valueNames":["code","name","mfbiz","unit","count","price"],"page":10,"pagination":true}'>
	<div class="row justify-content-between g-0">
		<div class="col-sm-5 mb-3">
			<!-- 약품 검색창 -->
			<form>
				<div class="input-group mb-2">
					<input class="form-control search-input fuzzy-search" 	type="search" placeholder="검색할 약품명을 적어주세요" aria-label="search" />
					<div class="input-group-text bg-transparent">
						<span class="fas fa-search search-box-icon"></span>
					</div>
				</div>
			</form>
		</div>
		<div class="col-auto mb-3">
			<!-- 약품 신청 버튼 -->
			<button class="btn btn-sm btn-falcon-default rounded-pill mb-1" id="addMedcin">약품 신청</button>
		</div>
	</div>
	<div class="table-responsive scrollbar mx-nx1 mt-3" id="tableExample2">
		<table class="table table-bordered table-striped fs--1 mb-0" id="medicineTable">
			<thead class="bg-200">
				<tr>
					<th class="text-800 sort"><i class="far fa-square"></i></th>
					<th class="text-800 text-center sort" data-sort="code">약품코드</th>
					<th class="text-800 text-center sort" data-sort="name">약품명</th>
					<th class="text-800 text-center sort" data-sort="mfbiz">제조업체</th>
					<th class="text-800 text-center sort" data-sort="unit">단위</th>
					<th class="text-800 text-center sort" data-sort="count">수량</th>
					<th class="text-800 text-center sort" data-sort="price">금액(원)</th>
			</thead>
			<tbody class="list" id="table-crm-location-session" class="bg-200">
				<c:set value="${medicineList }" var="medicineList" />
				<c:choose>
					<c:when test="${empty medicineList }">
						<tr>
							<td colspan="17" align="center">약품정보가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${medicineList }" var="medicine">
							<tr>
								<td><input type="checkbox" name="selectedMedicine"></td>
								<td class="code text-center fw-semi-bold sessions" val-type="medcinCd">${medicine.medcinCd }</td>
								<td class=" name text-left fw-semi-bold sessions" val-type="medcinNm"">${medicine.medcinNm }</td>
								<td class=" mfbiz text-center" val-type="medcinMfbiz">${medicine.medcinMfbiz }</td>
								<td class="unit text-left" val-type="medcinUnit">${medicine.medcinUnit }</td>
								<td class="count text-center <c:if test="${medicine.medcinInvntry < 6}">text-danger</c:if>" val-type="medcinInvntry">${medicine.medcinInvntry }</td>
								<td class="price text-right" val-type="medcinPc">${medicine.medcinPc }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div class="d-flex justify-content-center mt-3">
			<button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev">
				<span class="fas fa-chevron-left"></span>
			</button>
			<ul class="pagination mb-0"></ul>
			<button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next">
				<span class="fas fa-chevron-right"> </span>
			</button>
		</div>
	</div>
</div>


</body>
</html>