<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />


<c:set value="" var="status"/>
	<c:if test = "${noticeBoardVO.ntbdIpcrAt eq '1' }">
		<c:set value="<span class='badge bg-success'>공지사항</span>" var="status"/>
	</c:if>
	<c:if test = "${noticeBoardVO.ntbdIpcrAt eq '2' }">
		<c:set value="<span class='badge bg-success'>전파사항</span>" var="status"/>
	</c:if>


<div class="card" style="height: 750px;">
	<div class="card-header border-bottom" style="background-color: midnightblue;">
		<div class="row flex-between-end">
			<div class="col-10 align-self-center">
					  
				<h3 class="mb-0 text-white" id="header">&nbsp;&nbsp;${noticeBoardVO.ntbdSj }&nbsp;&nbsp;${status} </h3>
				<br>
				<div class="row">
					<div class="col-3">
						
						<span class="fw-semi-bold text-white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							작성자
						</span> &nbsp;&nbsp;
						 <span class="text-white">${noticeBoardVO.empNm }</span>
					</div>
					<div class="col-3">
						 <span class="fw-semi-bold text-white">작성일</span> &nbsp;&nbsp; 
						 <span class="text-white">
						 	<fmt:formatDate value="${noticeBoardVO.ntbdDay }" pattern="yyyy년 MM월 dd일 HH:mm"/>
						</span>
					</div>
					<div class="col-3">
						 <c:if test="${not empty noticeBoardVO.ntbdUpdde }">
						 	<span class="fw-semi-bold text-white">수정일</span> &nbsp;&nbsp; 
							 <span class="text-white">
							 	<fmt:formatDate value="${noticeBoardVO.ntbdUpdde }" pattern="yyyy년 MM월 dd일 HH:mm"/>
							</span>
						 </c:if>
					</div>
					<div class="col-3">
						 <span class="fw-semi-bold text-white">조회수</span> &nbsp;&nbsp; 
						 <span class="text-white">
						 	${noticeBoardVO.ntbdRdcnt }
						</span>
					</div>
					
				</div>			
			</div>
			<div class="row col-2">
				<c:if test="${customUser.employee.empSe eq 'a' }">
					<div class="col-4">
						<button id="delBtn" class="btn btn-falcon-default me-1 mb-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="삭제" type="button"><span class="fab fa-bitbucket text-danger fs-2"></span></button>
					</div>
					<div class="col-4">
						<button id="upBtn" class="btn btn-falcon-default me-1 mb-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="수정" type="button"><span class="far fa-edit text-warning fs-2"></span></button>
					</div>
				</c:if>
				<c:if test="${customUser.employee.empSe ne 'a' }">
					<div class="col-8">
					</div>
				</c:if>
					<div class="col-4">
						<button onclick="location.href='/mediform/admin/board/list'" class="btn btn-falcon-default me-1 mb-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="목록" type="button"><span class="far fa-file-alt text-primary fs-2"></span></button>
					</div>
				
			</div>
		</div>
	</div>


	<div class="row card-body pt-0">
		<div class="col-1"></div>
		<div class="col-10">
			<br><br><br>
			${noticeBoardVO.ntbdCn }
		</div>
		<div class="col-1"></div>
	</div>
	<div class="card-footer bg-white">
		<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
			<c:if test="${not empty noticeBoardVO.fileList }">
				<c:forEach items="${noticeBoardVO.fileList }" var="noticeFile" varStatus="vs">
					<li>
						<div class="mailbox-attachment-info">
							<a href="#" class="mailbox-attachment-name"> 
								<i class="fas fa-paperclip"></i> 
								${noticeFile.fileNm }
							</a> 
							<span class="mailbox-attachment-size clearfix mt-1"> 
								<c:url value="/notice/download.do?${_csrf.parameterName }=${_csrf.token }" var="downloadURL">
									<c:param name="fileNo" value="${noticeFile.fileNo }" />
								</c:url> 
								<a href="${downloadURL }"> 
									<span class="btn btn-default btn-sm float-right"> 
										<i class="fas fa-download"></i>
									</span>
								</a>
							</span>
						</div>
					</li>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
				</c:forEach>
			</c:if>
		</ul>
	</div>
</div>
<form action="/mediform/admin/board/delete" method="post" id="noticeForm">
	<input type="hidden" name="ntbdNo" value="${noticeBoardVO.ntbdNo }">
	<sec:csrfInput/>
</form>

<script type="text/javascript">

	var upBtn = $("#upBtn");
	var delBtn =$("#delBtn");
	var noticeForm = $("#noticeForm");
	
	
	upBtn.on("click", function(){
		
		console.log("수정 버튼 클릭!!!");
		noticeForm.attr("method","get");
	    noticeForm.attr("action", "/mediform/admin/board/update");
	    noticeForm.submit();
		
	});
	
	delBtn.on("click", function(){
		
		
		Swal.fire({
		      icon: 'warning',
		      title: '삭제',
		      text: '삭제를 진행하시겠습니까?',
		      showCancelButton: true,
		      confirmButtonText: '확인',
		      cancelButtonText: '취소',
		      confirmButtonColor: 'midnightblue',
		      cancelButtonColor: 'red', // cancel 버튼 색깔 지정
		    }).then(result => {
		    	if(result.isConfirmed){
		    		noticeForm.submit();
		    		}
		    });
	});
	


</script>












