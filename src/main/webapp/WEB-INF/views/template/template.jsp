<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<!-- 
${customUser.employee.직원변수명}

 -->


<!-- 폼태그 안에 넣기 -->
<!-- 
<sec:csrfInput/>    
-->
     
<!-- AJAX 사용 시 스크립트 영역 밖에 선언하기 -->    
<!-- 
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
-->

<!-- AJAX 사용시 스크립트 영역 안에 변수로 선언 -->
<!-- 
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content")
-->

<!-- AJAX  -->
<!-- 

$.ajax({
 		type : "post",
		url : "",
		data : JSON.stringify(chatObject),
 		contentType : "application/json; charset=utf-8",
 		async: false,
        beforeSend : function(xhr){            
            xhr.setRequestHeader(header,token);
        },
 		success : function(result) {
			console.log("");
 		}
 	});

 -->

