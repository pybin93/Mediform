<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set value="등록" var="name"/>
<c:if test = "${status eq 'u' }">
	<c:set value="수정" var="name"/>
</c:if>


<div class="card" style="height: 750px;">
	<div class="card-header border-bottom" style="background-color: midnightblue;">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h5 class="mb-0 text-white fw-semi-bold" id="header">공지사항 새글등록</h5>
			</div>			
		</div>
	</div>

	<form id="insertForm" action="/mediform/admin/board/insert" method="post" enctype="multipart/form-data">
		<c:if test="${status eq 'u' }">
			<input type="hidden" name="ntbdNo" id="ntbdNo" value="${notice.ntbdNo }"/>
		</c:if>
		
		<div class="card-body">
			<div class="row form-group">
					<h5 class="fw-semi-bold">제목</h5> 
				<div class="col-10">
					<input type="text"
					id="ntbdSj" name="ntbdSj" value="${notice.ntbdSj }"
					class="form-control" placeholder="제목을 입력해주세요">
				</div>
				<div class="col-2">
					<input type="radio" class="btn-check" name="ntbdIpcrAt" value="0" id="success-outlined" autocomplete="off" checked>
					<label class="btn btn-outline-success" for="success-outlined">일반</label>
					&nbsp;
					<input type="radio" class="btn-check" name="ntbdIpcrAt" value="1" id="warning-outlined" autocomplete="off">
					<label class="btn btn-outline-warning" for="warning-outlined">중요</label>	
					&nbsp;
					<input type="radio" class="btn-check" name="ntbdIpcrAt" value="2" id="danger-outlined" autocomplete="off">
					<label class="btn btn-outline-danger" for="danger-outlined">긴급</label>	
				</div>
				
				
			</div>
			<br>
			<div class="form-group">
				<div class="row">
					<h5 class="fw-semi-bold">내용</h5> 
					
				</div>
				<textarea id="ntbdCn" name="ntbdCn" class="form-control" rows="50" style="height: 450px;">${notice.ntbdCn }</textarea>
			</div>
			<div class="form-group">
				<div class="custom-file">
	
					<input type="file" class="custom-file-input" id="atchBoFile"
						name="atchBoFile" multiple="multiple"> 
						
				</div>
			</div>
	
		</div>
		
		<sec:csrfInput/>
	</form>
	<br>
	<c:if test="${status eq 'u' }">
	<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
		<c:if test="${not empty notice.fileList }">
			<c:forEach items="${notice.fileList }" var="noticeFile"
				varStatus="vs">
				&nbsp;&nbsp;&nbsp;
				<li>
					<div class="mailbox-attachment-info">
						<a href="#" class="mailbox-attachment-name"> 
							<i class="fas fa-paperclip"></i>
							${noticeFile.fileNm }
						</a> 
						<span class="mailbox-attachment-size clearfix mt-1"> 
							<span class="btn btn-default btn-sm float-right attachmentFileDel"
							id="span_${noticeFile.fileNo }"> 
								<i class="fas fa-times"></i>
							</span>
						</span>
					</div>
				</li>
			</c:forEach>
		</c:if>
	</ul>
	</c:if>
	<!-- 게시물 등록 버튼 -->
	<div class="card-footer bg-white">
		<div class="row">
			<div class="col-10">
				<button id="inputContent" class="btn btn-success me-1 mb-1" type="button">자동완성</button>
			</div>
			<div class="col-1"></div>
			<div class="col-1">
				<div class="col-auto align-self-center">
					<c:if test="${status eq 'u' }">
						<button id="cancelBtn" class="btn btn-outline-primary me-1 mb-1" type="button">취소</button>
					</c:if>
						<button id="insertBtn" class="btn btn-primary me-1 mb-1" type="button" value="${name }" style="background-color : midnightblue; border-style: none;">${name }</button>
				</div>
			</div>
		</div>
	</div>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

$(function(){
	
	CKEDITOR.replace("ntbdCn", {
			
	 	filebrowserUploadUrl:"/imageUpload.do?${_csrf.parameterName}=${_csrf.token}"
			
	});	
	
	var insertForm = $("#insertForm");
	var insertBtn = $("#insertBtn");
	var cancelBtn = $("#cancelBtn")
	
	
	var inputContent = $("#inputContent");
	
	inputContent.on("click", function(){
		
		$("#ntbdSj").val("코로나 마스크 착용에 대한 정부 권고조치 사항");
		$("#ntbdCn").val("정부에서 코로나 재확산에 따른 방역 정책으로 인한 병원 내에서의 마스크 착용을 권고하였습니다. \n 의료진 여러분들 마스크 착용과 소독을 항상 습관화해주시기 바랍니다.");
		
		
		
		
	});
	
	
	insertBtn.on("click", function(){
	
		// 예외처리
		
		
		if($(this).val() == "수정"){
			insertForm.attr("action", "/mediform/admin/board/update");
		}
		
		insertForm.submit();
		
	});
	
	cancelBtn.on("click", function(){
		
		var ntbdNo = $("#ntbdNo").val();
		location.href = "/mediform/admin/board/detail?ntbdNo=" + ntbdNo;
		
	});
	
	$(".attachmentFileDel").on("click", function(){
		console.log("파일 삭제 버튼 클릭!");
		
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var noticeFileNo = id.substring(idx + 1);
		var ptrn = "<input type='text' name='delNoticeNo' value='%V' hidden='hidden'/>"
		$("#insertForm").append(ptrn.replace("%V", noticeFileNo));
		$(this).parents("li:first").hide();
		
	});
	
})




</script>

    