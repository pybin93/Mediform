<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<style>
.oneRoom:hover {
	background-color: lightgray !important;
}

#chatInsertArea {
	position: sticky !important;
	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}
.marquee-content {
    white-space: nowrap;
    overflow: hidden;
    width: 100%; /* 뷰포트 너비로 설정 */
    animation: marqueeAnimation 15s linear infinite; 
}

.marquee-text {
    display: inline-block; 
    animation: marqueeAnimation 15s linear infinite;
}

@keyframes marqueeAnimation { 
    from { /*  애니메이션의 시작 상태 */
        transform: translateX(100%); 
    }
    to { /*  애니메이션의 끝 상태 */
        transform: translateX(-200%); 
    }
}



</style>

<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<c:set var="sessionUserNo" value="${customUser.employee.empNo}" />

<input type="hidden" id="sessionUserId" value="${customUser.username}" />
<input type="hidden" id="sessionUserNm"
	value="${customUser.employee.empNm}" />
<input type="hidden" id="sessionUserProfile"
	value="${customUser.employee.empProfile}" />

<!-- 
	########### 헤더 가이드 ################
	추후 공지사항 메시지 스케줄 마이메뉴 만들어지면 링크 추가!!!!!
	시큐리티 세션정보 통해서 프로필 이미지 경로 추가!!!
 -->


<nav
	class="navbar navbar-light navbar-glass navbar-top navbar-expand-lg" style="margin: 0px; padding: 0px;">

<button
	class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3"
	type="button" data-bs-toggle="collapse"
	data-bs-target="#navbarStandard" aria-controls="navbarStandard"
	aria-expanded="false" aria-label="Toggle Navigation">
	<span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
</button>
<a class="navbar-brand me-1 me-sm-3" href="/mediform/nurse/home">
	<div class="d-flex align-items-center">

		<!--     -->
		<!-- 이미지에 a태그 사용해서 각자 홈페이지로 하이퍼링크 만들기!!!!!!!!!    -->
		<!--     -->

		<a href="/mediform/nurse/home" id="home"> <img class="me-2"
			src="/resources/image/LOGO.JPG" alt="" width="180" />
		</a>



	</div>
</a>
<div class="collapse navbar-collapse scrollbar" id="navbarStandard">
	<ul class="navbar-nav" data-top-nav-dropdowns="data-top-nav-dropdowns">

		<!--  -->
		<!-- 메뉴바 버튼's -->
		<!-- 버튼 글자는 최대 4글자까지!!! -->
		<!--  -->


		<div class="box bg-1">
			
			<button class="button menu" id="patient" type="button" data-text="환자관리">
				<span>환자관리</span>
			</button>
			<button class="button menu" id="order" type="button" data-text="오더수행">
				<span>오더수행</span>
			</button>
			<button class="button menu" id="room" type="button" data-text="병동관리">
				<span>병동관리</span>
			</button>
			<button class="button menu" id="medicine" type="button" data-text="약품관리">
				<span>약품관리</span>
			</button>
			<button class="button menu" id="xRay" type="button" data-text="X-RAY">
				<span>X-RAY</span>
			</button>
	        <div class="marquee-content"style="width:30%; position: fixed; top: 8%; left: 50%; transform: translate(-50%, -50%); z-index: 9999;"> 
	            <p class="marquee-text" id="wsmsg" style="margin-bottom: 5px;" ></p>
	        </div>
		</div>
	
		<!--  -->
		<!-- 끝 : 메뉴바 버튼's -->
		<!--  -->

	</ul>
	
</div>
<ul
	class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">


	<!-- 다크모드 설정 : 디스플레이 none으로 해서 화면단에 출력 안됨! -->
	<li class="nav-item ps-2 pe-0">
		<div class="dropdown theme-control-dropdown" style="display: none">
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


<!-- 게시판 아이콘 : 추후 게시판 페이지 링크 추가!!! -->
<li class="nav-item d-none d-sm-block"><a class="nav-link px-0"
	href="/mediform/admin/board/list"> <svg
			xmlns="http://www.w3.org/2000/svg" width="40" height="30"
			fill="currentColor" class="bi bi-clipboard2" viewBox="0 0 16 16">
	  <path
				d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1h-.5Z" />
	  <path
				d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5Z" />
	</svg>
</a></li>
<!-- 끝 :게시판 아이콘 -->

<li>&nbsp;&nbsp;</li>

<!-- 일정 달력 아이콘 : 추후 일정 페이지 링크 추가!!! -->
<li class="nav-item d-none d-sm-block"><a class="nav-link px-0"
	href="/mediform/scheduler/main"> <svg xmlns="http://www.w3.org/2000/svg" width="30"
			height="30" fill="currentColor" class="bi bi-calendar-event"
			viewBox="0 0 16 16">
	  <path
				d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z" />
	  <path
				d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z" />
	</svg>
</a></li>
<!-- 끝 :일정 달력 아이콘 -->

<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>

<!-- 알림 아이콘 : 알림 기능 추가되면 수정 -->
<li class="nav-item dropdown"><a
	class="nav-link px-0 fa-icon-wait"
	id="navbarDropdownNotification" role="button"
	data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
	data-hide-on-body-scroll="data-hide-on-body-scroll"> <svg
			xmlns="http://www.w3.org/2000/svg" width="30" height="30"
			fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
		  <path
				d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z" />
		</svg>
</a>

	<div
		class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg"
		aria-labelledby="navbarDropdownNotification">
		<div class="card card-notification shadow-none">
			<div class="card-header">
				<div class="row justify-content-between align-items-center">
					<div class="col-auto">
						<h6 class="card-header-title mb-0">MEDIFORM 알림</h6>
					</div>
					<div class="col-auto ps-0 ps-sm-3">
						<a class="card-link fw-normal" href="javascript:updateAlarmRead()">전체 읽음</a>
					</div>
				</div>
			</div>
			<div class="scrollbar-overlay" style="max-height: 19rem">
				<div class="list-group list-group-flush fw-normal fs--1" id="alarm_area">
					<div class="list-group-title border-bottom" id="alarm_new">ALARM</div>
				</div>
			</div>
		</div>
	</div></li>
<!-- 끝 : 알림 -->

<li>&nbsp;&nbsp;&nbsp;</li>


<!-- 채팅 -->
		<li class="nav-item dropdown"><a
			class="chatting-dropdown-toggle nav-link notification-indicator notification-indicator-primary px-0 fa-icon-wait"
			id="chatting" role="button" data-bs-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"
			data-hide-on-body-scroll="data-hide-on-body-scroll"> <svg
					xmlns="http://www.w3.org/2000/svg" width="30" height="30"
					fill="currentColor" class="bi bi-chat" viewBox="0 0 16 16">
				  <path
						d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z" />
				</svg>

		</a>

			<div id="chattingMenuWindow"
				class="chatting-dropdown-menu dropdown-menu Sdropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg"
				aria-labelledby="chatting">


				<div class="card card-notification"
					style="width: 380px; height: 550px;">
					<div class="card-header row">
						<div class="col-6">
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item text-center col-6"><a
									class="nav-link active fw-semi-bold" id="friend-tab"
									data-bs-toggle="tab" href="#tab-friend" role="tab"
									aria-controls="tab-home" aria-selected="true">친구</a></li>
								<li class="nav-item text-center col-6"><a
									class="nav-link fw-semi-bold" id="profile-tab"
									data-bs-toggle="tab" href="#tab-chat" role="tab"
									aria-controls="tab-chat" aria-selected="false">채팅</a></li>
							</ul>
						</div>
						<div class="col-3"></div>
						<div class="col-3">
							<button id="makeRoom" class="btn btn-outline-primary btn-sm">+</button>
						</div>


					</div>


					<div id="chattindMenu" class="row card-body pt-0">
						<div class="tab-content" id="myTabContent">

							<!-- 친구목록 -->
							<div class="tab-pane fade show active" id="tab-friend"
								role="tabpanel" aria-labelledby="friend-tab">

								<div class="table-container"
									style="overflow-y: auto; max-height: 480px;">
									<table class="table table-sm">
										<thead>
											<tr id="" class="bg-light">
												<th colspan="3" class="col-2" scope="col">친구 <span
													id="friendCount"></span>명
												</th>
											</tr>
										</thead>
										<tbody id="friendSpace"
											style="overflow-y: auto; max-height: 420px;">

											<!-- 친구 리스트 출력 (ajax) -->

										</tbody>
									</table>
								</div>

							</div>
							<!-- 친구 목록 끝 -->

							<!-- 채팅방 리스트 -->
							<div class="tab-pane fade" id="tab-chat" role="tabpanel"
								aria-labelledby="tab-chat">

								<div class="table-container"
									style="overflow-y: auto; max-height: 480px;">
									<table class="table table-sm">
										<thead>
											<tr id="" class="bg-light">
												<th colspan="3" class="col-2" scope="col">채팅방 <span
													id="roomCount"></span>개
												</th>
											</tr>
										</thead>
										<tbody id="roomSpace"
											style="overflow-y: auto; max-height: 420px;">


										</tbody>
									</table>
								</div>
							</div>
							<!-- 채팅방 리스트 끝 -->
						</div>
					</div>


				</div>




			</div> <!-- 채팅메뉴끝 --> <!-- 실제 채팅방 -->
			<div id="chattingWindow"
				class="dropdown-menu Sdropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg"
				aria-labelledby="chatting">
				<input type="hidden" id="chattingRoomNoHidden" value="" />
				<div class="card card-notification"
					style="width: 380px; height: 550px;">

					<div
						class="row d-flex position-relative p-3 border-bottom mb-3 align-items-center">
						<!-- 채팅방 헤더 -->
						<a class="col-1" href="#"> <svg id="memberList"
								xmlns="http://www.w3.org/2000/svg" width="20" height="20"
								fill="currentColor" class="bi bi-people-fill"
								viewBox="0 0 16 16">
							  <path
									d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z" />
							</svg>
						</a> <span class="col-10" id="chatRoomHeader"></span>
						<button id="closeChattingBtn"
							class="col-1 btn-close btn-sm btn-outline-primary"
							aria-label="Close"></button>
					</div>
					<div class="row bg-white" id="dropdownMenu" style="display: none;">
						<ul id="memberSpace">



						</ul>
					</div>
					<div id="chattingArea" class="chat-content-scroll-area scrollbar">


					</div>
					<!-- 채팅 입력창 -->
					<div class="row" id="chatInsertArea">
						<div class="col-12 input-group chat-editor-area">
							<input class="input-group-append d-none" type="file"
								name="chatFileUpload" id="chatFileUpload" /> <label
								class="input-group-append chat-file-upload cursor-pointer"
								for="chatFileUpload"><span class="fas fa-paperclip"></span></label>
							<input id="chatContent" type="text" class="form-control" />
							<!-- 							<div class="emojiarea-editor outline-none scrollbar" contenteditable="true"></div> -->
							<!-- 			                <div class="btn btn-link emoji-icon" data-picmo="data-picmo" data-picmo-input-target=".emojiarea-editor"><span class="far fa-laugh-beam"></span></div> -->
							<button id="sendChattingBtn"
								class="input-group-append btn btn-sm btn-send shadow-none"
								type="submit">Send</button>
						</div>
					</div>
					<!-- 채팅 입력창 끝 -->

				</div>
			</div></li>









	<li>&nbsp;&nbsp;&nbsp;</li>


	<!-- 프로필 이미지 누르면 마이페이지 로그아웃 드롭 다운 -->
	<li class="nav-item dropdown"><a class="nav-link pe-0 ps-2"
		id="navbarDropdownUser" role="button" data-bs-toggle="dropdown"
		aria-haspopup="true" aria-expanded="false">
			<div class="avatar avatar-xl">
				<img class="rounded-circle" src="${customUser.employee.empProfile}"
					alt="" />
			</div>
	</a>
		<div
			class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end py-1"
			aria-labelledby="navbarDropdownUser">

			<a class="dropdown-item text-center" href="/mediform/common/mypage">
				<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14"
					fill="currentColor" class="bi bi-person-circle"
					viewBox="0 0 16 16">
					  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
					  <path fill-rule="evenodd"
						d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
					</svg> <span>마이페이지</span>
			</a>
			<div class="dropdown-divider"></div>
			<a class="dropdown-item text-center" href="/mediform/login"> <svg
					xmlns="http://www.w3.org/2000/svg" width="16" height="16"
					fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
				  <path
						d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z" />
				  <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
				</svg> <span>Logout</span>
			</a>
		</div></li>
	<!-- 끝 : 프로필  -->

	</ul>
</nav>

<div class="modal fade" id="makeRoomModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 450px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 py-3 ps-4 pe-6"
					style="background-color: midnightblue">
					<h4 class="mb-1 text-white" id="modalExampleDemoLabel">방 만들기</h4>
				</div>
				<div class="table-container"
					style="overflow-y: auto; max-height: 400px;">
					<table class="table table-sm">
						<thead>
							<tr id="" class="bg-light">
								<th colspan="3" class="col-2" scope="col">선택된 친구 <span
									id="friendCount1">0</span>명
								</th>
							</tr>
						</thead>
						<tbody id="friendSpace1"
							style="overflow-y: auto; max-height: 360px;">

							<!-- 친구 리스트 출력 (ajax) -->

						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="makeRoomBtn" type="button">방만들기</button>
				<button class="btn btn-secondary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="makeRoomNameModal" tabindex="-1"
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
				<div class="rounded-top-3 py-3 ps-4 pe-6"
					style="background-color: midnightblue">
					<h4 class="mb-1 text-white" id="modalExampleDemoLabel">방 만들기</h4>
				</div>
				<div class="p-4 pb-0">
					<div class="text-center fw-semi-bold">
						<input type="text" id="roomName" /> <br>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="makeRoomBtn1" type="button">방만들기</button>
				<button class="btn btn-secondary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<div id="insertPatient" style="display:none;">${insertPatient }</div>

<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">

var socket = null;

$(document).ready(function(){
	
	//웹소켓 연결~~
	sock = new SockJS("<c:url value="/echo-ws"/>");
	socket = sock;
	
	
	// 데이터를 전달 받았을 떄
	sock.onmessage = onMessage; // toast 생성

});



//toast 생성 및 추가

function onMessage(evt){
	
	var data = evt.data;
    // toast
    let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
    toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
    toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
    toast += "<span aria-hidden='true'>&times;</span></button>";
    toast += "</div> <div class='toast-body'>" + data + "</div></div>";
    $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
    $(".toast").toast({"animation": true, "autohide": false});
    $('.toast').toast('show');
    
};



$('#notifySendBtn').click(function(e){
    let modal = $('.modal-content').has(e.target);
    let type = '70';
    let target = modal.find('.modal-body input').val();
    let content = modal.find('.modal-body textarea').val();
    let url = '${contextPath}/member/notify.do';
    // 전송한 정보를 db에 저장	
    $.ajax({
        type: 'post',
        url: '${contextPath}/member/saveNotify.do',
        dataType: 'text',
        data: {
            target: target,
            content: content,
            type: type,
            url: url
        },
        success: function(){    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
            socket.send("관리자,"+target+","+content+","+url);	
        }
    });
    modal.find('.modal-body textarea').val('');	// textarea 초기화
});


//<!-- ====================== 날씨 (api) ==================================-->
	$.getJSON( 'http://api.openweathermap.org/data/2.5/forecast?id=1835224&appid=f1eb091d104b725e551b2a5540e3337f&units=metric',
	function(data) {
		var $minTemp = Math.floor(data.list[0].main.temp_min);
        var $maxTemp = Math.floor(data.list[0].main.temp_max);
        var $cTemp = Math.floor(data.list[0].main.temp);
		var $now = new Date($.now());
		var $cDate = $now.getFullYear() + '/'
				+ ($now.getMonth() + 1) + '/' + $now.getDate()
				+ '/' + $now.getHours() + ':'
				+ $now.getMinutes();
		var $wIcon = data.list[0].weather[0].icon;

		var $now = new Date($.now());
		//    alert($now.getFullYear() + '/' + $now.getMonth() + 1 + '/' + $now.getDate() 
		//    + '/'  + $now.getHours() + ':' + $now.getMinutes());

		$('.clowtemp').text('최저 온도 : ' + $minTemp + '°C');
		$('.ctemp').text( $cTemp + '°C');
		$('.chightemp').text('최고 온도 : ' + $maxTemp + '°C');
		$('.cdate').text($cDate);
		$('h2').prepend($cDate);
		$('.cicon').html('<img src="https://openweathermap.org/img/w/' + $wIcon + '.png" />');

	});
//<!-- =============================실시간 날씨 정보 끝 ============================= -->
$(document).ready(function() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content")

	
	console.log("현재 세션에 로그인한 아이디 >>> " + sessionUserId);
	
	var friendSpace = $("#friendSpace");
	var friendCount = $("#friendCount");
	
	var makeRoom = $("#makeRoom");
	var makeRoomModal = $("#makeRoomModal");
	
	var friendSpace1 = $("#friendSpace1");
	var friendCount1 = $("#friendCount1");
	
	var makeRoomBtn = $("#makeRoomBtn");
	
	var roomSpace = $("#roomSpace");
	var roomCount = $("#roomCount");
	
	document.getElementById('chattingWindow').style.display = 'none';
	
	var closeChattingBtn = $("#closeChattingBtn");
	
	
	function scrollToBottom(){
		$("#chattingArea").scrollTop($("#chattingArea")[0].scrollHeight);
	}
	
	window.onload = function () {
        scrollToBottom();
    }
	
	
	
    $(".chatting-dropdown-toggle").click(function() {
	      $(".chatting-dropdown-menu").toggle(); // 드롭다운 토글
	      $("#chattingArea").html("");
	      console.log("토글 이벤트");
	      var sessionUserId = $("#sessionUserId").val();
	      // 친구 리스트 가져오기
	      $.ajax({
	   		type : "post",
	  		url : "/mediform/common/chatting/friend/list",
	   		contentType : "application/json; charset=utf-8",
	   		async: false,
	          beforeSend : function(xhr){            
	              xhr.setRequestHeader(header,token);
	          },
	   		success : function(res) {
	   			
	   			var freindListHtml = "";
	   			
	   			if(res.length == 0){
	   				console.log("친구 없음!");
	   				
	   			}else{
	   				console.log("친구 있음");
	   				friendCount.html(res.length);
	   				
	   				$(res).each(function(){
	   					
	   					var department = "";
	   					
	   					if(this.empSe === "a"){
	   						department = "원무과";
	   					}else if(this.empSe === "d"){
	   						department = "의사";
	   					}else if(this.empSe === "n"){
	   						department = "간호사";
	   					}else if(this.empSe === "t"){
	   						department = "치료사";
	   					}else if(this.empSe === "m"){
	   						department = "관리자";
	   					}else if(this.empSe === "k"){
	   						department = "병원장";
	   					}
	   					
	  					if(this.empNo != sessionUserId){
	  						
		   					freindListHtml += "<tr class='oneFriend' id='' style='height: 55px;'>";
		   	 				freindListHtml += "	<td class='col-3' style='vertical-align: middle'>";
		   	 				freindListHtml += "		<img class='rounded-circle' src='" + this.empProfile + "' alt='' style='width:40px; height:40px;'/>";
		   	 				freindListHtml += "	</td>";
		   	 				freindListHtml += "	<td class='col-5' style='vertical-align: middle'>" + this.empNm +"</td>";
		   	 				freindListHtml += "	<td class='col-4 text-center' style='vertical-align: middle'>";
		   	 				freindListHtml += department;
		   	 				freindListHtml += "	</td>";
		   	 				freindListHtml += "</tr>";
	  					}else{
	  						console.log(this.empNo + "///" + sessionUserId);
	  					}
	   				});
	   				
	   				
	   				friendSpace.html(freindListHtml);
	   				
	   				
	   			}
	   			
	   			
	   		}
	   	});
	    // 친구 리스트 가져오기 끝
	    
	      var sessionUserId = $("#sessionUserId").val();
	      
	      var chatUser = {
	    	  sessionUserId : sessionUserId
	      }
	      
	      console.log("세션 아이디 : " + sessionUserId)
	      
	      
	      chattRoomList();
	      
	      function chattRoomList(){
	    	  
	    	// 채팅방 리스트 가져오기
		      $.ajax({
			   		type : "post",
			  		url : "/mediform/common/chatting/room/list",
			  		data : JSON.stringify(chatUser),
			   		contentType : "application/json; charset=utf-8",
			   		async: false,
			          beforeSend : function(xhr){            
			              xhr.setRequestHeader(header,token);
			          },
			   		success : function(res) {
			   			
			   			var roomListHtml = "";
			   			
			   			if(res.length == 0){
			   				console.log("채팅방 없음!");
			   				
			   			}else{
			   				console.log("채팅방 있음");
			   				roomCount.html(res.length);
			   				
			   				// 채팅방 리스트 출력
			   				$(res).each(function(){
			   					
			   					
			   					var today = new Date();

				   				// 날짜와 시간을 특정 형식으로 표시하려면 다음과 같이 할 수 있습니다.
				   				var yearT = today.getFullYear(); // 연도
				   				var monthT = today.getMonth() + 1; // 월 (0부터 시작하므로 +1을 해야 실제 월을 얻을 수 있습니다)
				   				var dayT = today.getDate(); // 일
			   					
			   					
			   					var dateString = this.chttDe;
								var date = new Date(dateString);
								var year = date.getFullYear();
								var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
								var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅
								var hours = date.getHours().toString().padStart(2, '0'); // 시간
								var minutes = date.getMinutes().toString().padStart(2, '0'); // 분
								
								var formattedDate = "";
								if(yearT === year && monthT === month && dayT === day){
									console.log("오늘 채팅 있음");
									formattedDate = hours + ":" + minutes;
								}else if(yearT === year && monthT === month && parseInt(dayT) === parseInt(day+1)){
									formattedDate = "어제";
								}else{
									console.log("오늘 채팅 없음");
									formattedDate = month + "월" + day + "일";
								}
								
								var chttRoomIndxNum = parseInt(this.chttRoomIndx);
								var chttLastNum = parseInt(this.chttLast);
			   					
			   					roomListHtml += "<tbody class='oneRoom' id='" + this.chttRoomNo + "'>";
			   					roomListHtml += "	<tr id='' style='height: 25px;'>";
			   					roomListHtml += "		<td rowspan='2' class='col-3' style='vertical-align: middle'>";
			   					roomListHtml += "			<img class='rounded-circle' src='${customUser.employee.empProfile}' alt='' style='width:40px; height:40px;'/>";
			   					roomListHtml += "		</td>";
			   					roomListHtml += "		<td class='col-6 fw-semi-bold text-black' style='vertical-align: middle'>" + this.indvdlSetupRoomNm + "</td>";
			   					roomListHtml += "		<td class='col-3 text-center' style='vertical-align: middle'>";
			   					roomListHtml +=				"<span class='small-text' style='font-size: 8px;'>" + formattedDate + "</span>";
			   					roomListHtml += "		</td>";
			   					roomListHtml += "	</tr>";
			   					roomListHtml += "	<tr class='' id='' style='height: 25px;'>";
			   					roomListHtml += "		<td class='col-7'>";
			   					roomListHtml += 			"<span class='small-text' style='font-size: 13px;'>" + this.chttCn + "</span>";
			   					roomListHtml += "		</td>";
			   					roomListHtml += "		<td class='col-2 text-center' style='vertical-align: middle'>";
			   					
			   					
			   					if(parseInt(chttRoomIndxNum - chttLastNum) > 0){
			   						roomListHtml +=         	"<span class='badge rounded-pill bg-danger'>" + (chttRoomIndxNum - chttLastNum) + "</span>";
			   					}
			   					
			   					roomListHtml += "		</td>";
			   					roomListHtml += "	</tr>";
			   					roomListHtml += "</tbody>";
			   					
			   				});
			   				
			   				roomSpace.html(roomListHtml);
			   				
			   				// 채팅방 리스트 출력 끝
			   			}
			   		}
		      });
	    	  
	    }
	      
	      
      
    });
	// 채팅방 리스트 가져오기 끝
    
	// 방만들기 클릭 이벤트 - 모달
    makeRoom.on("click", function(){
    	
    	makeRoomModal.modal("show");
    	
   		var checkboxes = document.querySelectorAll('input[name=selectFriend]:checked');
    	
    	var selectedCount = 0;
   	    console.log("selectedCount : " + selectedCount);

    	
   	    // ??? 선택된 친구수가 안 바뀜
   	 	checkboxes.forEach(function(checkbox) {
	   	    console.log("체크박스들 : " + checkboxes);
	   	    
	   	 	checkbox.addEventListener('change', function() {
	   	        if (this.checked) {
	   	            selectedCount++; // 체크박스가 선택되면 카운트 증가
	   	        } else {
	   	            selectedCount--; // 체크박스가 선택 해제되면 카운트 감소
	   	        }
	   	       	console.log("선택된 친구 수 : " + selectedCount);

	   	     	friendCount1.html(selectedCount);
	   	    });
   	        
   	 	});
   		// 선택된 친구수 변경 끝
    	
    	
   	    // 친구 목록 아작스
    	$.ajax({
	   		type : "post",
	  		url : "/mediform/common/chatting/friend/list",
	   		contentType : "application/json; charset=utf-8",
	   		async: false,
	          beforeSend : function(xhr){            
	              xhr.setRequestHeader(header,token);
	          },
	   		success : function(res) {
	   			
	   			var freindListHtml1 = "";
	   			
	   			if(res.length == 0){
	   				console.log("친구 없음!");
	   				
	   			}else{
	   				console.log("친구 있음");
	   				
	   				$(res).each(function(){
	   					
	   					var department = "";
	   					
	   					if(this.empSe === "a"){
	   						department = "원무과";
	   					}else if(this.empSe === "d"){
	   						department = "의사";
	   					}else if(this.empSe === "n"){
	   						department = "간호사";
	   					}else if(this.empSe === "t"){
	   						department = "치료사";
	   					}else if(this.empSe === "m"){
	   						department = "관리자";
	   					}else if(this.empSe === "k"){
	   						department = "병원장";
	   					}
	   					
	   					var sessionUserId = $("#sessionUserId").val();
	   					
	   					if(this.empNo != sessionUserId){
		   					freindListHtml1 += "<tr class='oneFriend' id='' style='height: 55px;'>";
		   					freindListHtml1 += "	<td class='col-1' style='vertical-align: middle'>"
		   					freindListHtml1 += "		<input type='checkbox' name='selectFriend' value='" + this.empNo + "' />"
		   					freindListHtml1 += "	</td>"
		   	 				freindListHtml1 += "	<td class='col-3' style='vertical-align: middle'>";
		   	 				freindListHtml1 += "		<img class='rounded-circle' src='" + this.empProfile + "' alt='' style='width:40px; height:40px;'/>";
		   	 				freindListHtml1 += "	</td>";
		   	 				freindListHtml1 += "	<td class='col-4' style='vertical-align: middle'>" + this.empNm +"</td>";
		   	 				freindListHtml1 += "	<td class='col-4 text-center' style='vertical-align: middle'>";
		   	 				freindListHtml1 += department;
		   	 				freindListHtml1 += "	</td>";
		   	 				freindListHtml1 += "</tr>";
	   					}
	   				});
	   				
	   				
	   				friendSpace1.html(freindListHtml1);
	   				
	   			}
	   			
	  			console.log("");
	   		}
	   	});
    	// 친구 목록 아작스 끝
    });
 	// 방만들기 클릭 이벤트 끝 - 모달
	

    // 방만들기 버튼 클릭 이벤트
    makeRoomBtn.on("click", function(){
    	
    	var sessionUserId = $("#sessionUserId").val();
    	
    	var makeRoomNameModal = $("#makeRoomNameModal");
    	
    	// 방 이름 설정
    	makeRoomNameModal.modal("show");
    	
    	var makeRoomBtn1 = $("#makeRoomBtn1");
    	
    	// 방만들기
    	makeRoomBtn1.on("click", function(){
    		
    		 var selectedFriendValues = []; // 선택된 사람들
       	 
	       	 var checkboxes = document.querySelectorAll('input[name=selectFriend]:checked');
	       	
	       	 checkboxes.forEach(function(checkbox) {
	       	 	selectedFriendValues.push(checkbox.value);
	       	        
	       	 });
	       	selectedFriendValues.push(sessionUserId);
	       	
	       	 console.log("체크된 사람들 : " + selectedFriendValues)

	       	 var roomName = $("#roomName").val();
	       	 
	       	 console.log("방이름 : " + roomName);
	       	 
	       	 if (selectedFriendValues.length > 0) {
	       		 
	       		 // 채팅방 만들기 inset 아작스
	       		 $.ajax({
	       		 		type : "post",
	       				url : "/mediform/common/chattingroom/insert?roomname="+roomName,
	       				data : JSON.stringify(selectedFriendValues),
	       		 		contentType : "application/json; charset=utf-8",
	       		 		async: false,
	       		        beforeSend : function(xhr){            
	       		            xhr.setRequestHeader(header,token);
	       		        },
	       		 		success : function(result) {
	       					console.log("result : " + result);
	       					if(result === "success"){
	       						
	       						makeRoomNameModal.modal("hide");
	       						makeRoomModal.modal("hide");
	       						
	       						// 모달
	       						Swal.fire({
	       					      icon: 'success',
	       					      title: '채팅방 생성',
	       					      text: '채팅방이 생성되었습니다',
	       					      confirmButtonText: '확인',
	       					      confirmButtonColor: 'midnightblue',
	       					    });
	       						// 모달 끝
	       					}
	       					
	       		 		}
	       		 	});
	       			// 채팅방 만들기 inset 아작스 끝
	       		 
	       	 }else{
	       		 
	       	 }
    		
    	});
    	// 방만들기 끝
    	 
    });
    // 방만들기 클릭이벤트 끝
    

    
 // 채팅방을 클릭해서 채팅방을 열기 => 해당 채팅방의 채팅 내역을 아작스로 데이터 가져오기
    $("#roomSpace").on("click", ".oneRoom", function(){
  	    $("#chattingArea").html("");
			console.log("채팅방,, 크,,클릭!!");
			
			
			
			document.getElementById('chattingMenuWindow').style.display = 'none';
			document.getElementById('chattingWindow').style.display = 'block';
			
			var clickedElement = $(this);
			var clickedElementID = clickedElement.attr("id"); // 클릭한 요소의 ID 속성을 가져옵니다.
			console.log("클릭한 요소의 ID(<<<방번호>>>): " + clickedElementID);
			
			
			var sendChattingBtn = $("#sendChattingBtn");
			var chatContent = $("#chatContent");
			
			var chattingRoomNoHidden = $("#chattingRoomNoHidden");
			
			chattingRoomNoHidden.val(clickedElementID);
			
			
			
			var chatObject = {
					chttRoomNo : clickedElementID
			}

			
			selectChat();
			
			function selectChat(){
				
				$("#chattingArea").html("");
				
				$.ajax({
			 		type : "post",
					url : "/mediform/common/chattingMember/select",
					data : JSON.stringify(chatObject),
			 		contentType : "application/json; charset=utf-8",
			 		async: false,
			        beforeSend : function(xhr){            
			            xhr.setRequestHeader(header,token);
			        },
			 		success : function(res) {
						console.log("res.chttRoomNm >>> " + res.chttRoomNm);
						$("#chatRoomHeader").html(res.chttRoomNm);
						
						var memberList = res.memberList;
						console.log("멤버리스트 >>> " + memberList);
						
						var str = "";
						var memberSpace = $("#memberSpace");
						
						$(memberList).each(function(){
							
							str += "<li>" + this.empNm + "</li>";
							
						});

						memberSpace.html(str);
			 		}
			 	});
				
				
				
				
				$.ajax({
			 		type : "post",
					url : "/mediform/common/chatting/select",
					data : JSON.stringify(chatObject),
			 		contentType : "application/json; charset=utf-8",
			 		async: false,
			        beforeSend : function(xhr){            
			            xhr.setRequestHeader(header,token);
			        },
			 		success : function(res) {
						
			 			$("#chatRoomHeader").html();
			 			
			 			
			 			
						$(res).each(function(){
			 				
			 				var cur_session = $("#sessionUserId").val();
				 			
			 				var date = new Date(this.chttDe);
							
							var hours = date.getHours();
							var minutes = date.getMinutes();
							var formattedTime = hours.toString().padStart(2, '0') + ":" + minutes.toString().padStart(2, '0');
							
							
//	 							console.log("로그인한 세션 아이디 : " + cur_session);
//	 							console.log("채팅 보낸 아이디 : " + this.empNo);
							
							if(cur_session === this.empNo){
									
								
								var str = "";
								str += "<div class='d-flex p-3'>";
								str += " <div class='flex-1 d-flex justify-content-end'>";
								str += "  <div class='w-100 w-xxl-75'>";
								str += "   <div class='hover-actions-trigger d-flex flex-end-center'>";
								
								
								
								
								if(this.chttAtchmnfl != null){
			   					
									var fileKind = ""
									if(this.chttExtsn != null){
										
										var chttExtsnStr = this.chttExtsn;
										
										fileKindArray = chttExtsnStr.split("/");
										
										var fileKind = fileKindArray[0];
										console.log("첨부파일 있음!");
										console.log("파일 종류 (확장명) >>>>> " + fileKind);
										
									}
									
						
									if(fileKind === "image"){
										console.log("이미지 파일 있음");
										str += "    <div class='bg-primary text-white p-2 rounded-2 chat-message' data-bs-theme='light'>";
				   						str +=				"<img width='100px;' src=" + this.chttAtchmnfl + "/>"
				   						str += "     <a href='../assets/img/chat/1.jpg' data-gallery='gallery-3'>";
										str += "      <img class='rounded' src='' alt='' width='150'>";
										str += "     </a>";
										str += "    </div>";
									}else{
										console.log("일반 파일 있음");
										console.log("채팅 고유 인덱스 >>> " + this.chttIndx);
										var chttIndx = this.chttIndx;
										str += "    <div class='bg-secondary text-white p-2 rounded-2 chat-message' data-bs-theme='light'>";
										str +=				this.chttFileNm;
										str +=				"<a href='${pageContext.request.contextPath}/chatting/download.do?${_csrf.parameterName }=${_csrf.token }&chttIndx="+chttIndx+"'> ";
										str +=				"	<span class='btn btn-success btn-sm float-right'> ";
										str +=				"		<i class='fas fa-download'></i>";
										str +=				"	</span>";
										str +=				"</a>";
										str += "     <a href='../assets/img/chat/1.jpg' data-gallery='gallery-3'>";
										str += "      <img class='rounded' src='' alt='' width='150'>";
										str += "     </a>";
										str += "    </div>";
									}
			   					
								
								
								}else{
									str += "    <div class='bg-primary text-white p-2 rounded-2 chat-message' data-bs-theme='light'>";
			   						str += "<p class='mb-0'>" + this.chttCn + "</p>";
			   						str += "     <a href='../assets/img/chat/1.jpg' data-gallery='gallery-3'>";
									str += "      <img class='rounded' src='' alt='' width='150'>";
									str += "     </a>";
									str += "    </div>";
			   					}

								
								str += "   </div>";
								str += "   <div class='text-400 fs--2 text-end'>";
								str += formattedTime;
								str += "    <span class='fas fa-check ms-2 text-success'></span>";
								str += "   </div>";
								str += "  </div>";
								str += " </div>";
								str += "</div>";
								
								console.log("어펜드 직전!!!");
								
								$("#chattingArea").append(str);
							
				 			}else{
								
				 				
				 				var str = "";
								str += "<div class='d-flex p-3'>";
								str += " <div class='avatar avatar-l me-2'>";
								str += "  <img class='rounded-circle' src='" + this.empProfile + "' alt='' />";
								str += " </div>";
								str += " <div class='flex-1'>";
								str += "  <div class='w-xxl-75'>";
								str += "   <div class='hover-actions-trigger d-flex align-items-center'>";
								
								
								
								if(this.chttAtchmnfl != null){
									
									var fileKind = ""
									if(this.chttExtsn != null){
											
										var chttExtsnStr = this.chttExtsn;
											
										fileKindArray = chttExtsnStr.split("/");
											
										var fileKind = fileKindArray[0];
										console.log("첨부파일 있음!");
										console.log("파일 종류 (확장명) >>>>> " + fileKind);
											
									}
									
									if(fileKind === "image"){
										console.log("이미지 파일 있음");
										str += "    <div class='chat-message bg-200 p-2 rounded-2'>";
				   						str +=				"<img width='100px;'src=" + this.chttAtchmnfl + "/>"
				   						str += "    </div>";
				   						
									}else{
										console.log("일반 파일 있음");
										console.log("채팅 고유 인덱스 >>> " + this.chttIndx);
										str += "    <div class='chat-message bg-400 p-2 rounded-2'>";
										str +=				this.chttFileNm;
										str +=				"<a href='${pageContext.request.contextPath}/chatting/download.do?${_csrf.parameterName }=${_csrf.token }&chttIndx="+this.chttIndx+"'> ";
										str +=				"	<span class='btn btn-success btn-sm float-right'> ";
										str +=				"		<i class='fas fa-download'></i>";
										str +=				"	</span>";
										str +=				"</a>";
										str += "    </div>";
									}
			   						
			   						
			   					}else{
			   						str += "    <div class='chat-message bg-200 p-2 rounded-2'>";
			   						str += this.chttCn;
			   						str += "    </div>";
			   					}
								
								
								str += "   </div>";
								str += "   <div class='text-400 fs--2'>";
								str += "    <span>" + formattedTime + "</span>";
								str += "   </div>";
								str += "  </div>";
								str += " </div>";
								str += "</div>";
				 				
								$("#chattingArea").append(str);
				 				
							}
			 				
			 			
			 			});
						$("#chattingArea").append("<div id='focus'></div>")
						
						
			 		}	
			 			
			 	});
			}
			
			
			
			
			$("#chattingArea").on("change", "#focus", function(){
					console.log("chage 이벤트(채팅 업로드!!! >> 다음에 focus 되어야됨!)");
					$(this).focus();
				})
				
				
				var hoverLink = document.getElementById("memberList");
				var dropdownMenu = document.getElementById("dropdownMenu");
				
				memberList.addEventListener("mouseover", function() {
					console.log("호버이벤트!!!!");
				  	dropdownMenu.style.display = "block";
				});

				memberList.addEventListener("mouseout", function() {
					console.log("호버이벤트!!!!");
				  	dropdownMenu.style.display = "none";
				});
				
				dropdownMenu.addEventListener("mouseover", function() {
					console.log("호버이벤트!!!!");
				  	dropdownMenu.style.display = "block";
				});

				dropdownMenu.addEventListener("mouseout", function() {
					console.log("호버이벤트!!!!");
				 	dropdownMenu.style.display = "none";
				});
				
			sendChattingBtn.on("click", function(){
				
				console.log("보내기 버튼 클릭 이벤트까지 옴!!!");
				sendMessage();
				// 채팅 보내기 인풋 박스 초기화
				scrollToBottom();
				chatContent.val("");
			});
			
			var chttRoomNo = $("#chattingRoomNoHidden").val(); // 방번호

			// 소켓 생성!
			
			console.log("1...");
			
			var currentDomainName = window.location.hostname;
			
			var sock = new WebSocket("ws://localhost/chatting/" + chttRoomNo);
// 				var sock = new SockJS("http://192.168.144.9:80/chatting/" + chttRoomNo);
// 				sock.onopen = function(evt){
// 					console.log("Websocket 연결 완료!");
// 				}
			
// 				var sock = new SockJS('http://192.168.144.9/chatting');
// 				sock.send("test");
			sock.onopen = onOpen;
			sock.onmessage = onMessage;
			sock.onclose = onClose;
			
			
// 				console.log("### sock : " + sock);

			function sendMessage(){
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				// 소켓으로 보낼 데이터와 DB에 insert할 데이터
				var empProfile = $("#sessionUserProfile").val(); // 프로필 이미지
				var empNo = $("#sessionUserId").val(); // 아이디
				var empNm = $("#sessionUserNm").val(); // 이름
				var chatContent = $("#chatContent").val(); // 내용
				var currentDate = new Date(); // 보낸 시간
				
				var chttRoomNo = $("#chattingRoomNoHidden").val(); // 방번호
				
				// 데이터 콘솔 확인
				console.log("*** 프로필 : " + empProfile);
				console.log("*** 사번 : " + empNo);
				console.log("*** 이름 : " + empNm);
				console.log("*** 내용 : " + chatContent);
				console.log("*** 날짜 시간 : " + currentDate);
				console.log("*** 방번호 : " + chttRoomNo);
				
				
				var chatObject = {
						empNo : empNo,
						chttCn : chatContent,
						chttRoomNo : chttRoomNo
				};

				console.log("$('#chatFileUpload').val()   >>>>>   " + $('#chatFileUpload').val())
				
				
				var formData = new FormData();
					
				var inputFile = $("input[name='chatFileUpload']");
					
				var files = inputFile[0].files;
				
				for(var i = 0; i < files.length; i++){
					
					formData.append("uploadFile", files[i])
					
				}
				
				console.log("files 크기 >>> " + files.length);
				
				if(files.length != 0){
					
					console.log("파일 보내기~");
					
					
					console.log("파일 >>> " + files);
					
					
					
					$.ajax({
				 		type : "post",
						url : "/mediform/common/chatting/file/insert?empNo=" + empNo + "&chttCn=" + chatContent + "&chttRoomNo=" + chttRoomNo,
						data : formData,
						processData: false,
				 		contentType : false,
				 		async: false,
				        beforeSend : function(xhr){            
				            xhr.setRequestHeader(header,token);
				        },
				 		success : function(result) {
							console.log("아작스 파일 전송 성공!!!");
							// 알러트 창 추가
							$("#chatInsertArea").val("");
							$("#chatFileUpload").val("");
							selectChat();
							
				 		},
				 		error : function(res){
				 		}
				 	});
					
					
					
				}else{
					
					console.log("일반 텍스트 보내기~");
					
					sock.send(empProfile + "s:p:l" + empNm + "s:p:l" + chatContent + "s:p:l" + currentDate);
					
					if(chatContent != null){
						console.log("채팅 not null");
						$.ajax({
					 		type : "post",
							url : "/mediform/common/chatting/insert",
							data : JSON.stringify(chatObject),
					 		contentType : "application/json; charset=utf-8",
					 		async: false,
					        beforeSend : function(xhr){            
					            xhr.setRequestHeader(header,token);
					        },
					 		success : function(result) {
								console.log("채팅 insert 성공!");
								$("#chatInsertArea").val("");
					 		}
					 	});
						
						
					}else{
						console.log("채팅 null!");
					}
					
					
					
				}
				
			}

			//소켓에서 메시지를 받았을 때
			function onMessage(msg) {
				
				console.log("onMessage 소켓에서 메시지 받기 성공!!!");
				
				var empNm = $("#sessionUserNm").val();
				var data = msg.data;
				var name = null; 
				var message = null;
				var profile = null;
				var chattingDate = null
				
				var arr = data.split("s:p:l");
				
				for(var i=0; i<arr.length; i++){
					console.log('arr[' + i + ']: ' + arr[i]);
				}
				
				var cur_session = empNm; //현재 세션에 로그인 한 사람
				console.log("cur_session : " + cur_session);
				
				profile = arr[0];
				name = arr[1];
				message = arr[2];
				chattingDate = arr[3];
				
				var date = new Date(chattingDate);
				
				var hours = date.getHours();
				var minutes = date.getMinutes();
				
				var formattedTime = hours.toString().padStart(2, '0') + ":" + minutes.toString().padStart(2, '0');
				
				console.log("^^^로그인한 계정^^^(onMessage) : " + empNm);
				console.log("^^^보낸사람 이름^^^(onMessage) : " + name);
				console.log("^^^프로필 경로^^^(onMessage) : " + profile);
				console.log("^^^메세지^^^(onMessage) : " + message);
				
				
			    // 보내는 사람을 분류
			    // 내가 보낼 때
				if(name == cur_session){
					console.log("")
					var str = "";
					str += "<div class='d-flex p-3'>";
					str += " <div class='flex-1 d-flex justify-content-end'>";
					str += "  <div class='w-100 w-xxl-75'>";
					str += "   <div class='hover-actions-trigger d-flex flex-end-center'>";
					str += "    <div class='bg-primary text-white p-2 rounded-2 chat-message' data-bs-theme='light'>";
					str += "     <p class='mb-0'>" + message + "</p>";
					str += "     <a href='../assets/img/chat/1.jpg' data-gallery='gallery-3'>";
					str += "      <img class='rounded' src='' alt='' width='150'>";
					str += "     </a>";
					str += "    </div>";
					str += "   </div>";
					str += "   <div class='text-400 fs--2 text-end'>";
					str += formattedTime;
					str += "    <span class='fas fa-check ms-2 text-success'></span>";
					str += "   </div>";
					str += "  </div>";
					str += " </div>";
					str += "</div>";
					
					
					$("#chattingArea").append(str);
				}
			    // 다른 사람이 보냈을 때
				else{
					
					var str = "";
					str += "<div class='d-flex p-3'>";
					str += " <div class='avatar avatar-l me-2'>";
					str += "  <img class='rounded-circle' src='" + profile + "' alt='' />";
					str += " </div>";
					str += " <div class='flex-1'>";
					str += "  <div class='w-xxl-75'>";
					str += "   <div class='hover-actions-trigger d-flex align-items-center'>";
					str += "    <div class='chat-message bg-200 p-2 rounded-2'>";
					str += message;
					str += "    </div>";
					str += "   </div>";
					str += "   <div class='text-400 fs--2'>";
					str += "    <span>" + formattedTime + "</span>";
					str += "   </div>";
					str += "  </div>";
					str += " </div>";
					str += "</div>";
					
// 						<div class='d-flex p-3'>
// 							<div class='avatar avatar-l me-2'>
// 								<img class='rounded-circle' src='../assets/img/team/2.jpg' alt='' />
// 							</div>
// 							<div class='flex-1'>
// 								<div class='w-xxl-75'>
// 									<div class='hover-actions-trigger d-flex align-items-center'>
// 										<div class='chat-message bg-200 p-2 rounded-2'>
// 											What are you doing?What are you doing?
// 										</div>
// 									</div>
// 									<div class='text-400 fs--2'>
// 										<span>11:54 am</span>
// 									</div>
// 								</div>
// 							</div>
// 						</div>
					
					
					
					$("#chattingArea").append(str);
					scrollToBottom();
				}
				
			}

			var socketAddress = "";

			//채팅창에 들어왔을 때
			function onOpen(evt) {
				console.log("Open...!");
				 socketAddress = evt.target.url;
			}


			// 소켓꿔질때 (채팅 나갈 때) : !!!!*** 읽은 위치를 여기에서 업데이트 추가!!! >>> 완료
			function onClose(evt) {
				
				var cur_session = $("#sessionUserId").val();
				// ws://localhost/chatting/" + chttRoomNo
				
				console.log("Close()...!");
				
				console.log("닫히는 소켓 주소 >>> " + socketAddress);
				
				var parts = socketAddress.split('/');
				var chttRoomNo = parts[parts.length - 1]
				
				console.log("채팅방 번호 >>> " + chttRoomNo);
				
				var chatUpdateObject = {
						
					empNo : cur_session,
					chttRoomNo : chttRoomNo
						
				};
				
				$.ajax({
			 		type : "post",
					url : "/mediform/common/chattingMember/update",
					data : JSON.stringify(chatUpdateObject),
			 		contentType : "application/json; charset=utf-8",
			 		async: false,
			        beforeSend : function(xhr){            
			            xhr.setRequestHeader(header,token);
			        },
			 		success : function(result) {
						console.log("");
			 		}
			 	});
				
				
			}
			
			 // 채팅창을 닫을 때 : !!!!*** 채팅방 리스트 최근 보낸 메시지 최신화 업데이트하기 
		      closeChattingBtn.on("click", function(){
		    	  document.getElementById('chattingWindow').style.display = 'none';
		    	  document.getElementById('chattingMenuWindow').style.display = 'block';
		    	  onClose();
		    	  chattRoomList();
		  	 });
			
	 });
    var sessionUserId = $("#sessionUserId").val();
    
    var chatUser = {
  	  sessionUserId : sessionUserId
    }
    function chattRoomList(){
  	  
    	// 채팅방 리스트 가져오기
	      $.ajax({
		   		type : "post",
		  		url : "/mediform/common/chatting/room/list",
		  		data : JSON.stringify(chatUser),
		   		contentType : "application/json; charset=utf-8",
		   		async: false,
		          beforeSend : function(xhr){            
		              xhr.setRequestHeader(header,token);
		          },
		   		success : function(res) {
		   			
		   			var roomListHtml = "";
		   			
		   			if(res.length == 0){
		   				console.log("채팅방 없음!");
		   				
		   			}else{
		   				console.log("채팅방 있음");
		   				roomCount.html(res.length);
		   				
		   				// 채팅방 리스트 출력
		   				$(res).each(function(){
		   					
		   					
		   					var today = new Date();

			   				// 날짜와 시간을 특정 형식으로 표시하려면 다음과 같이 할 수 있습니다.
			   				var yearT = today.getFullYear(); // 연도
			   				var monthT = today.getMonth() + 1; // 월 (0부터 시작하므로 +1을 해야 실제 월을 얻을 수 있습니다)
			   				var dayT = today.getDate(); // 일
		   					
		   					
		   					var dateString = this.chttDe;
							var date = new Date(dateString);
							var year = date.getFullYear();
							var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 해주고 2자리로 포맷팅
							var day = date.getDate().toString().padStart(2, '0'); // 일도 2자리로 포맷팅
							var hours = date.getHours().toString().padStart(2, '0'); // 시간
							var minutes = date.getMinutes().toString().padStart(2, '0'); // 분
							
							var formattedDate = "";
							if(yearT === year && monthT === month && dayT === day){
								console.log("오늘 채팅 있음");
								formattedDate = hours + ":" + minutes;
							}else if(yearT === year && monthT === month && parseInt(dayT) === parseInt(day+1)){
								formattedDate = "어제";
							}else{
								console.log("오늘 채팅 없음");
								formattedDate = month + "월" + day + "일";
							}
							
							var chttRoomIndxNum = parseInt(this.chttRoomIndx);
							var chttLastNum = parseInt(this.chttLast);
		   					
		   					roomListHtml += "<tbody class='oneRoom' id='" + this.chttRoomNo + "'>";
		   					roomListHtml += "	<tr id='' style='height: 25px;'>";
		   					roomListHtml += "		<td rowspan='2' class='col-3' style='vertical-align: middle'>";
		   					roomListHtml += "			<img class='rounded-circle' src='${customUser.employee.empProfile}' alt='' style='width:40px; height:40px;'/>";
		   					roomListHtml += "		</td>";
		   					roomListHtml += "		<td class='col-6 fw-semi-bold text-black' style='vertical-align: middle'>" + this.indvdlSetupRoomNm + "</td>";
		   					roomListHtml += "		<td class='col-3 text-center' style='vertical-align: middle'>";
		   					roomListHtml +=				"<span class='small-text' style='font-size: 8px;'>" + formattedDate + "</span>";
		   					roomListHtml += "		</td>";
		   					roomListHtml += "	</tr>";
		   					roomListHtml += "	<tr class='' id='' style='height: 25px;'>";
		   					roomListHtml += "		<td class='col-7'>";
		   					roomListHtml += 			"<span class='small-text' style='font-size: 13px;'>" + this.chttCn + "</span>";
		   					roomListHtml += "		</td>";
		   					roomListHtml += "		<td class='col-2 text-center' style='vertical-align: middle'>";
		   					
		   					
		   					if(parseInt(chttRoomIndxNum - chttLastNum) > 0){
		   						roomListHtml +=         	"<span class='badge rounded-pill bg-danger'>" + (chttRoomIndxNum - chttLastNum) + "</span>";
		   					}
		   					
		   					roomListHtml += "		</td>";
		   					roomListHtml += "	</tr>";
		   					roomListHtml += "</tbody>";
		   					
		   				});
		   				
		   				roomSpace.html(roomListHtml);
		   				
		   				// 채팅방 리스트 출력 끝
		   			}
		   		}
	      });
    	  
    }

});









// 웹소켓 실시간 알람 
$(function(){

//	connenction();
	var empNo = '${sessionUserNo}';
	var data = {
			empNo : empNo
	}
	
});


let ws;    // 전역변수
(function (){
	

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	
	var currentDomainName = window.location.hostname;
	ws = new WebSocket("ws://" + currentDomainName + "/alarm");
    var insertPatient = $("#insertPatient").text();
	ws.onopen = function(){
		console.log('체킁 연결되었낭? : connection opend.');
		
		//if(insertPatient != null && insertPatient === "insertPatient"){
		//	var msg = "신규 환자가 등록되었습니다."
		//	ws.send(msg);
		//}
		
		// 최초로 첫번째는 DB 에서 알람 목록을 가져오고 그 뒤로는 웹소켓을 통해 알람을 내려받는다
		$.ajax({
			type : "post",
			url : "/mediform/alarm/selectAlarmList.do",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success : function(result) {
				console.log(result);
				
				for(var i = 0; i < result.length; i++) {
					setAlarm(result[i].alarmCn);	
				}
			}
		});
	};
	
	ws.onmessage = function(event) {
		
		console.log("서버에서 받은 값:", event.data);
		
		setAlarm(event.data);
	};
	
	ws.onclose = function(event){
		console.log('Info : 세션 연결 종료');
	};
	
	ws.onerror = function(error){console.log('Error : ', error);};
})();
	
	
function setAlarm(cn) {
	
	var iconName = "";
	var contents = "";
	
	var alarmGubun = cn.split('|')[0];
	var alarmText = cn.split('|')[1];
	
	if(alarmGubun == 'NEW_PATIENT') {
		iconName = "patient.jpg";
	} else if(alarmGubun == 'NEW_BOARD') {
		iconName = "board.png";
	}
	
	var alarmHtml = '';                                                                             
	alarmHtml += '<div class="list-group-item div-alarm-erase">                                                     ';
	alarmHtml += '<a class="notification notification-flush notification-unread" href="#!">         ';
	alarmHtml += '	<div class="notification-avatar">                                               ';
	alarmHtml += '		<div class="avatar avatar-2xl me-3">                                        ';
	alarmHtml += '			<img class="rounded-circle" src="/resources/image/alarm/' + iconName + '" alt="">';
	alarmHtml += '		</div>                                                                      ';
	alarmHtml += '	</div>                                                                          ';
	alarmHtml += '	<div class="notification-body">                                                 ';
	alarmHtml += '		<p class="mb-1">                                                            ';
	alarmHtml += alarmText;
	alarmHtml += '		</p>                                                                        ';
	alarmHtml += '	</div>                                                                          ';
	alarmHtml += '</a>                                                                              ';
	alarmHtml += '</div>                                                                            ';
	
	$('#alarm_new').after(alarmHtml);
	
	// 해당 영역에 메시지를 띄움
	var marqueeContent = $(".marquee-content");
    marqueeContent.empty(); // 기존 내용 비우기
    marqueeContent.addClass("animating").text(alarmText); //wsmsg에 text(event.data) 내용넣기
    setTimeout(function() {
        marqueeContent.removeClass("animating").empty(); // 애니메이션 후 내용 비우기
    }, 50000); // 애니메이션 기간 (15초) 이후에 애니메이션 클래스를 제거하고 내용을 비움
	
	// 한번 더 DB조회
	//ajax
	//success();
	
    // 알람 아이콘에 파란색 띄움
    $('#navbarDropdownNotification').addClass('notification-indicator notification-indicator-primary');
}

// 로그인한 사용자의 모든 알람을 읽음 처리한다.
function updateAlarmRead() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		type : "post",
		url : "/mediform/alarm/updateAlarmRead.do",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		success : function(result) {
			
			// 현재 알람 목록을 다 삭제한다.
			$('.div-alarm-erase').remove();
			
			// 뱃지에 파란색 동그라미 없앤다.
			$('#navbarDropdownNotification').removeClass('notification-indicator notification-indicator-primary');
		}
	});
}
	

$(function() {
	var patient = $("#patient");
	var order = $("#order");
	var room = $("#room");
	var medicine = $("#medicine");
	var xRay = $("#xRay");

	// 환자관리
	patient.on("click", function() {
		location.href = "/mediform/nurse/patient/list";
	});

	// 오더수행 (기존 n.record)
	order.on("click", function() {
		location.href = "/mediform/nurse/acting/main";
	});

	//병동관리
	room.on("click", function() {
		location.href = "/mediform/nurse/room";
	});

	// 약품관리
	medicine.on("click", function() {
		location.href = "/mediform/nurse/medicine/list/select";
	});

	xRay.on('click', function() {
		location.href = "/mediform/nurse/xray/view";
	});

});
</script>









