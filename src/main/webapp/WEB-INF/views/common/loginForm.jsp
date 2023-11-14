<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
a {
	text-decoration-line: none !important;
}

body {
	 background-image: url('../../../resources/image/login/backgroundIMG1.jpg');
	 background-size: 100% auto;
	 background-repeat: no-repeat;
	 background-position: center center;
}

</style>


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
<title>메디폼 │ 로그인</title>


    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../../resources/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../../resources/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../../resources/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../../resources/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="../../../resources/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../../resources/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="../../../resources/assets/js/config.js"></script>
    <script src="../../../resources/vendors/simplebar/simplebar.min.js"></script>


    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
    <link href="../../../resources/vendors/simplebar/simplebar.min.css" rel="stylesheet">
    <link href="../../../resources/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
    <link href="../../../resources/assets/css/theme.min.css" rel="stylesheet" id="style-default">
    <link href="../../../resources/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
    <link href="../../../resources/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
    <script>
      var isRTL = JSON.parse(localStorage.getItem('isRTL'));
      if (isRTL) {
        var linkDefault = document.getElementById('style-default');
        var userLinkDefault = document.getElementById('user-style-default');
        linkDefault.setAttribute('disabled', true);
        userLinkDefault.setAttribute('disabled', true);
        document.querySelector('html').setAttribute('dir', 'rtl');
      } else {
        var linkRTL = document.getElementById('style-rtl');
        var userLinkRTL = document.getElementById('user-style-rtl');
        linkRTL.setAttribute('disabled', true);
        userLinkRTL.setAttribute('disabled', true);
      }
	</script>
</head>


  <body>

    <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
      <div class="container" data-layout="container">
        <script>
          var isFluid = JSON.parse(localStorage.getItem('isFluid'));
          if (isFluid) {
            var container = document.querySelector('[data-layout]');
            container.classList.remove('container');
            container.classList.add('container-fluid');
          }
        </script>
        <div class="row flex-center min-vh-100 py-6">
          <div class="col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
            <div class="card">
              <div class="card-body p-4 p-sm-5">
              	<a class="d-flex flex-center mb-4" href="/mediform/login"><span class="font-sans-serif fw-bolder fs-5 d-inline-block">MediForm</span></a>
                <div class="row flex-between-center mb-2">
                  <div class="col-auto">
                    <h5>Log in</h5>
                  </div>
                </div>
                <form action="/login" method="post" id="loginForm">
                  <div class="mb-3">
                    <input class="form-control" type="text" id="empNo" name="username" placeholder="사번을 입력해 주세요." />
                  </div>
                  <div class="mb-3">
                    <input class="form-control" type="password" id="empPw" name="password" placeholder="비밀번호를 입력해 주세요." />
                  </div>
                  <div class="row flex-between-center">
                    <div class="col-auto">
                      <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="basic-checkbox"/>
                        <label class="form-check-label mb-0" for="basic-checkbox">아이디 저장</label>
                      </div>
                    </div>
                    <div class="col-auto"><a class="fs--1" href="/mediform/password/find">비밀번호 찾기</a></div>
                  </div>
                  <div class="mb-3">
                    <button type="button" class="btn btn-primary d-block w-100 mt-3" id="loginBtn">로그인</button>
                  </div>
                  <div class="row">
                  	<div class="col-1"></div>
                    <button type="button" class="col-2 btn btn-outline-success" id="aBtn"><span class="fw-semi-bold">원무과</span></button>
                    &nbsp;<button type="button" class="col-2 fw-semi-bold btn btn-outline-secondary" id="dBtn"><span class="fw-semi-bold">의사</span></button>
                    &nbsp;<button type="button" class="col-2 fw-semi-bold btn btn-outline-info" id="nBtn"><span class="fw-semi-bold">간호사</span></button>
                    &nbsp;<button type="button" class="col-2 fw-semi-bold btn btn-outline-warning" id="tBtn"><span class="fw-semi-bold">치료사</span></button>
                    &nbsp;<button type="button" class="col-2 fw-semi-bold btn btn-outline-danger" id="mBtn"><span class="fw-semi-bold">관리자</span></button>
                    <div class="col-1"></div>
                  </div>
                  <sec:csrfInput/>
                </form>
                <div class="position-relative mt-4">
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>


    <!-- ===============================================-->
    <!--    JavaScripts-->
    <!-- ===============================================-->
    <script src="../../../resources/vendors/popper/popper.min.js"></script>
    <script src="../../../resources/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="../../../resources/vendors/anchorjs/anchor.min.js"></script>
    <script src="../../../resources/vendors/is/is.min.js"></script>
    <script src="../../../resources/vendors/fontawesome/all.min.js"></script>
    <script src="../../../resources/vendors/lodash/lodash.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="../../../resources/vendors/list.js/list.min.js"></script>
    <script src="../../../resources/assets/js/theme.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  </body>
<script type="text/javascript">
$(function(){
	
	var loginForm = $("#loginForm");
	var loginBtn = $("#loginBtn");
	
	loginBtn.on("click", function(){
		
		var id = $("#empNo").val();
		var pw = $("#empPw").val();

		// 기본유효성 검사 진행
		
		loginForm.submit();
	});
	
	$("#aBtn").on("click", function(){
		
		$("#empNo").val("a20230084");
		$("#empPw").val("1234");
		
	});
	
	$("#dBtn").on("click", function(){
		
		$("#empNo").val("d20230085");
		$("#empPw").val("1234");
		
	});
	
	$("#nBtn").on("click", function(){
		
		$("#empNo").val("n20230090");
		$("#empPw").val("1234");
		
	});
	
	$("#tBtn").on("click", function(){
		
		$("#empNo").val("t20230098");
		$("#empPw").val("1234");
		
	});
	
	$("#mBtn").on("click", function(){
		
		$("#empNo").val("m20230105");
		$("#empPw").val("1234");
		
	});
	
	var empPw = $('#empPw');
	empPw.on("keypress", function(event) {
        // Enter 키의 keyCode는 13입니다.
        if (event.keyCode === 13) {
            event.preventDefault(); // 기본 엔터 행동 방지
            loginForm.submit();
        }
    });
	
});


</script>  
  
  
  
  
</html>




