<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>	

<!-- 
	########### 헤더 가이드 ################
	로고 눌렀을 시에 각자 파트의 홈 화면 a 태그 주기(빈화면)
	추후 공지사항 메시지 스케줄 마이메뉴 만들어지면 링크 추가!!!!!
	시큐리티 세션정보 통해서 프로필 이미지 경로 추가!!!

 -->

<nav class="navbar navbar-light navbar-glass navbar-top navbar-expand-lg">

	<button
		class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3"
		type="button" data-bs-toggle="collapse"
		data-bs-target="#navbarStandard" aria-controls="navbarStandard"
		aria-expanded="false" aria-label="Toggle Navigation">
		<span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
	</button>
	<a class="navbar-brand me-1 me-sm-3" href="/mediform/patient/home">
		<div class="d-flex align-items-center">
		
		<!--     -->
		<!-- 이미지에 a태그 사용해서 각자 홈페이지로 하이퍼링크 만들기!!!!!!!!!    -->
		<!--     -->
			<img class="me-2" src="/resources/image/mediformMainLogo.png" alt="" width="180" />
		
		</div>
	</a>
	<div class="collapse navbar-collapse scrollbar" id="navbarStandard">
		<ul class="navbar-nav" data-top-nav-dropdowns="data-top-nav-dropdowns">
			
			<!--  -->
			<!-- 메뉴바 버튼's -->
			<!-- 버튼 글자는 최대 4글자까지!!! -->
			<!--  -->
			
			<div class="box bg-1">
	          <button class="button menu" id="patient" type="button" data-text="환자"><span>환자</span></button>
			</div>
			<div class="box bg-1">
	          <button class="button menu" id="pagingPatient" type="button" data-text="페이징 환자"><span>페이징 환자</span></button>
			</div>

		
			<!--  -->
			<!-- 끝 : 메뉴바 버튼's -->
			<!--  -->
			
		</ul>
	</div>
	
	<ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
		
		<!-- 다크모드 설정 : 디스플레이 none으로 해서 화면단에 출력 안됨! -->
		<li class="nav-item ps-2 pe-0">
			<div class="dropdown theme-control-dropdown" style="display:none">
				<a
					class="nav-link d-flex align-items-center dropdown-toggle fa-icon-wait fs-0 pe-1 py-0"
					href="#" role="button" id="themeSwitchDropdown"
					data-bs-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fas fa-sun fs-2"
					data-fa-transform="shrink-2"
					data-theme-dropdown-toggle-icon="light"></span><span
					class="fas fa-moon fs-2" data-fa-transform="shrink-3"
					data-theme-dropdown-toggle-icon="dark"></span><span
					class="fas fa-adjust fs-2" data-fa-transform="shrink-2"
					data-theme-dropdown-toggle-icon="auto"></span></a>
				<div
					class="dropdown-menu dropdown-menu-end dropdown-caret border py-0 mt-3"
					aria-labelledby="themeSwitchDropdown">
					<div class="bg-white dark__bg-1000 rounded-2 py-2">
						<button class="dropdown-item d-flex align-items-center gap-2"
							type="button" value="light" data-theme-control="theme">
							<span class="fas fa-sun"></span>Light<span
								class="fas fa-check dropdown-check-icon ms-auto text-600"></span>
						</button>
						<button class="dropdown-item d-flex align-items-center gap-2"
							type="button" value="dark" data-theme-control="theme">
							<span class="fas fa-moon" data-fa-transform=""></span>Dark<span
								class="fas fa-check dropdown-check-icon ms-auto text-600"></span>
						</button>
						<button class="dropdown-item d-flex align-items-center gap-2"
							type="button" value="auto" data-theme-control="theme">
							<span class="fas fa-adjust" data-fa-transform=""></span>Auto<span
								class="fas fa-check dropdown-check-icon ms-auto text-600"></span>
						</button>
					</div>
				</div>
			</div>
		</li>
		<!-- 끝 : 다크 모드 설정 -->
		
		
		<!-- 일정 달력 아이콘 : 추후 일정 페이지 링크 추가!!! -->
		<li class="nav-item d-none d-sm-block">
			<a class="nav-link px-0" href="">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-calendar-event" viewBox="0 0 16 16">
			  <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
			  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
			</svg>
			</a>
		</li>
		<!-- 끝 :일정 달력 아이콘 -->
		
		<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
				
		<!-- 알림 아이콘 : 알림 기능 추가되면 수정 -->		
		<li class="nav-item dropdown">
			<a class="nav-link notification-indicator notification-indicator-primary px-0 fa-icon-wait"
			id="navbarDropdownNotification" role="button"
			data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
			data-hide-on-body-scroll="data-hide-on-body-scroll">
			
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
				  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
				</svg>
			</a>
			
			<div
				class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg"
				aria-labelledby="navbarDropdownNotification">
				<div class="card card-notification shadow-none">
					<div class="card-header">
						<div class="row justify-content-between align-items-center">
							<div class="col-auto">
								<h6 class="card-header-title mb-0">Notifications</h6>
							</div>
							<div class="col-auto ps-0 ps-sm-3">
								<a class="card-link fw-normal" href="#">Mark all as read</a>
							</div>
						</div>
					</div>
					<div class="scrollbar-overlay" style="max-height: 19rem">
						<div class="list-group list-group-flush fw-normal fs--1">
							<div class="list-group-title border-bottom">NEW</div>
							<div class="list-group-item">
								<a class="notification notification-flush notification-unread"
									href="#!">
									<div class="notification-avatar">
										<div class="avatar avatar-2xl me-3">
											<img class="rounded-circle"
												src="/resources/assets/img/team/1-thumb.png" alt="" />

										</div>
									</div>
									<div class="notification-body">
										<p class="mb-1">
											<strong>Emma Watson</strong> replied to your comment : "Hello
											world 😍"
										</p>
										<span class="notification-time"><span class="me-2"
											role="img" aria-label="Emoji">💬</span>Just now</span>

									</div>
								</a>

							</div>
							<div class="list-group-item">
								<a class="notification notification-flush notification-unread"
									href="#!">
									<div class="notification-avatar">
										<div class="avatar avatar-2xl me-3">
											<div class="avatar-name rounded-circle">
												<span>AB</span>
											</div>
										</div>
									</div>
									<div class="notification-body">
										<p class="mb-1">
											<strong>Albert Brooks</strong> reacted to <strong>Mia
												Khalifa's</strong> status
										</p>
										<span class="notification-time"><span
											class="me-2 fab fa-gratipay text-danger"></span>9hr</span>

									</div>
								</a>

							</div>
							<div class="list-group-title border-bottom">EARLIER</div>
							<div class="list-group-item">
								<a class="notification notification-flush" href="#!">
									<div class="notification-avatar">
										<div class="avatar avatar-2xl me-3">
											<img class="rounded-circle"
												src="/resources/assets/img/icons/weather-sm.jpg" alt="" />

										</div>
									</div>
									<div class="notification-body">
										<p class="mb-1">The forecast today shows a low of
											20&#8451; in California. See today's weather.</p>
										<span class="notification-time"><span class="me-2"
											role="img" aria-label="Emoji">🌤️</span>1d</span>

									</div>
								</a>
							</div>
						</div>
					</div>
					<div class="card-footer text-center border-top">
						<a class="card-link d-block"
							href="../../app/social/notifications.html">View all</a>
					</div>
				</div>
			</div>
		</li>
		<!-- 끝 : 알림 -->	
		
		<li>&nbsp;&nbsp;&nbsp;</li>
	
		<li class="nav-item d-none d-sm-block">
			<a class="nav-link px-0" href="">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-chat" viewBox="0 0 16 16">
			  <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"/>
			</svg>
			</a>
		</li>
		
		<li>&nbsp;&nbsp;&nbsp;</li>
			
		<!-- 프로필 이미지 누르면 마이페이지 로그아웃 드롭 다운 -->	
		<li class="nav-item dropdown">
			<a class="nav-link pe-0 ps-2" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<div class="avatar avatar-xl">
					<img class="rounded-circle" src="/resources/assets/img/team/3-thumb.png" alt="" />
				</div>
			</a>
			<div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end py-1" aria-labelledby="navbarDropdownUser">

					<a class="dropdown-item text-center" href="../pages/user/settings.html">
						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
						  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
						  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
						</svg>
						<span>마이페이지</span>
					</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item text-center" href="/mediform/logout">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
					  <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/>
					  <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
					</svg>
						<span>Logout</span>
					</a>
			</div>
		</li>
		<!-- 끝 : 프로필  -->
		
	</ul>
</nav>
<script>
$(function(){
	$("#patient").on("click",function(){
		location.href = "/mediform/patient/list";
	});
	
	$("#pagingPatient").on("click",function(){
		location.href = "/mediform/patient/paginglist";
	});
	
});
</script>