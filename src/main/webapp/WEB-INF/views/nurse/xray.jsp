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
<title>메디폼 │ 간호</title>
</head>
<style>
#myCam {
	width: 1180px;
	height: 600px;
}

.table thead {
	position: sticky;
	top: 0;
	z-index: 1; /* 다른 콘텐츠 위로 표시하기 위해 z-index를 설정합니다. */
}
</style>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->

<!-- 카메라 사용을 위한 peerjs -->
<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>

<!-- 캡처 -->
<script src="http://html2canvas.hertzen.com/dist/html2canvas.js"></script>

<!-- alert -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<body>

	<div class="row">
		<!-- x-ray -->
		<div class="col-lg-8 mt-1">
			<div class="card" style="height: 820px;">
				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="row">
						<div class="col-12 align-self-center">
							<h5 class="text-white mb-0 fw-semi-bold" id="header">X-RAY</h5>
						</div>

					</div>
				</div>
				<div class="card-body pt-0">
					<div class="row">
						<div class="d-flex justify-content-end mt-2">
							<button class="btn btn-falcon-primary me-1 mb-1" id="camOnBtn">CAM
								ON</button>
							<button class="btn btn-falcon-primary me-1 mb-1" id="camOffBtn"
								style="display: none;">CAM OFF</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12" id="videoDiv">
							<video id="myCam"
								poster="${pageContext.request.contextPath }/resources/image/login/backgroundIMG1.jpg"
								playsinline autoplay muted></video>
						</div>
					</div>
				</div>
			</div>
		</div>








		<!-- 음성 -->
		<div class="col-lg-4 mt-1">
			<div class="card" style="height: 820px;">
				<div class="card-header border-bottom p-2"
					style="height: 35px; background-color: midnightblue">
					<div class="row">
						<div class="col-12 align-self-center">
							<h5 class="text-white mb-0 fw-semi-bold" id="header">
								음성</h5>
						</div>

					</div>
				</div>
				<div class="card-body pt-0">

					<!-- ----------------- content ----------------- -->

					<!-- 음성 방송 리스트 -->
					<div class="row align-self-center">
						<div class="table-container scrollbar"
							style="overflow-y: auto; max-height: 350px;">
							<table class="table " style="height: 320px;">
								<thead>
									<tr id="" class="bg-light">
										<th class="col-3 text-center" scope="col">No</th>
										<th class="col-9 text-center" scope="col">항목</th>
									</tr>
								</thead>
								<tbody id="voiceListArea"
									style="overflow-y: auto; max-height: 430px;">


								</tbody>
							</table>
						</div>
					</div>
					<!-- 음성 방송 리스트  끝-->

					<br>

					<!-- 버튼 영역 -->
					<div class="row">
						<div class="col-6"></div>
						<div class="d-flex justify-content-end">
							<button id="insertVoiceBtn" class="btn btn-secondary btn-sm me-1"
								style="background-color: green; border: none;">추가</button>
							<button id="updateVoiceBtn" class="btn btn-secondary btn-sm me-1"
								style="background-color: midnightblue; border: none;">수정</button>
							<button id="deleteVoiceBtn" class="btn btn-secondary btn-sm me-1"
								style="background-color: red; border: none;">삭제</button>

						</div>
					</div>
					<!-- 버튼 영역 끝 -->


					<br>

					<!-- 음성 방송 영역 -->
					<div class="row align-self-center form-floating mb-3" style="position: relative;">
						<textarea class="form-control pt-5" id="voiceOutTextArea" rows="7" style="height: 200px; overflow: auto;"> </textarea>
						<label for="floatingInput" style="font-size: 20px; font-weight: bolder;">방송 내역</label>						
						
					</div>
					<!-- 음성 방송 영역 끝-->


					<!-- 방송 하기 버튼 영역 -->
					<div class="row">
						<button class="btn btn-secondary" id="voiceoutBtn"
							style="background-color: midnightblue;" type="button">방송 시작</button>
					</div>
					<!-- 방송 하기 버튼 영역 끝 -->
					<br> <br>

					<!-- ----------------- content ----------------- -->

				</div>
			</div>
		</div>
	</div>




	<!-- 음성 출력 추가 모달 -->
	<div class="modal fade" id="voiceoutInsertModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document"
			style="width: 650; max-width: 650px; height: 450px; max-height: 450px;">
			<div class="modal-content position-relative">
				<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
					<button
						class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-0">
					<div class="rounded-top-3 py-3 ps-4 pe-6"
						style="background-color: midnightblue">
						<h4 class="mb-1 text-white" id="modalExampleDemoLabel">안내방송
							등록</h4>
					</div>
					<div class="p-4 pb-0">

						<div class="row">
							<h4 class="fw-semi-bold">제목</h4>
						</div>

						<div class="row">
							<input type="text" class="form-control" id="voiceTitle" />
						</div>

						<br>

						<div class="row">
							<h4 class="fw-semi-bold">내용</h4>
						</div>

						<div class="row">
							<textarea class="form-control" id="voiceContent" rows="20"></textarea>
						</div>
						<input type="hidden" value="" id="hiddenId" />
					</div>
					<br>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="voiceoutInsertBtn"
						type="button">등록</button>
					<button class="btn btn-secondary" type="button"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 음성 출력 추가 모달 -->














	<script type="text/javascript">

$(document).ready(function() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content")
    // 페이지가 로드될 때 실행될 함수
    // 원하는 동작을 여기에 작성
	var voiceout = $("#voiceout");
	var voiceListArea = $("#voiceListArea");
	var hiddenId = $("#hiddenId");
	
	
	voiceout.modal("show");
	
	printList();
    
	// 리스트 출력 함수
	function printList(){
		
		var voiceListHtml = "";
		voiceListArea.html(voiceListHtml);
		
		
		
		$.ajax({
	 		type : "post",
			url : "/mediform/nurse/xray/voiceOutput/list",
	 		contentType : "application/json; charset=utf-8",
	 		async: false,
	        beforeSend : function(xhr){            
	            xhr.setRequestHeader(header,token);
	        },
	 		success : function(res) {
				
	 			
	 			if(res.length == 0){
	 				console.log("음성 리스트 없음!");
	 			}else{
	 				console.log("음성 리스트 있음!");
	 				
	 				var inx = 1;
	 				
	 				$(res).each(function(){
	 					
	 					voiceListHtml += "<tr class='oneBoard' id='" + this.voiceOtptCd + "'>";
	 					voiceListHtml += "  <td class='text-center' style='vertical-align: middle'>";
	 					voiceListHtml += inx;
	 					voiceListHtml += "  </td>";
	 					voiceListHtml += "  <td class='text-center' style='vertical-align: middle'>";
	 					voiceListHtml += this.voiceOtptNm;
	 					voiceListHtml += "  </td>";
	 					voiceListHtml += "</tr>";
	 					
	 					inx += 1;
	 					
	 				});
	 				
	 				voiceListArea.html(voiceListHtml);
	 			}
	 			
	 		}
	 	});
		
		
		
		// 목록 중 하나 클릭하면 옆 텍스트 area에  내용 출력하기!
		var oneBorad = $(".oneBoard");
		oneBorad.on("click", function(){
			hiddenId.val("");
			console.log("음성 하나 클릭 완료!!!");
			var voiceId = $(this).attr("id");
			hiddenId.val(voiceId);
			console.log("클릭한 음성 목록 ID >>> " + voiceId);
			
			var voiceIdObj = {
					
					voiceOtptCd : voiceId
					
			}
			
			var voiceOutTextArea = $("#voiceOutTextArea");
			
			// 클릭햇을 때 해당 아이디에 해당하는 내용 가져오는 ajax
			$.ajax({
		 		type : "post",
				url : "/mediform/nurse/xray/voiceOutput/select",
				data : JSON.stringify(voiceIdObj),
		 		contentType : "application/json; charset=utf-8",
		 		async: false,
		        beforeSend : function(xhr){            
		            xhr.setRequestHeader(header,token);
		        },
		 		success : function(res) {
					console.log("출력할 내용(ajax 에서 가져옴)>>> " + res.voiceOtptCn);
					voiceOutTextArea.val(res.voiceOtptCn);
		 		}
		 	});
			// 클릭햇을 때 해당 아이디에 해당하는 내용 가져오는 ajax 끝!
			
			
		});
		// 목록 중 하나 클릭하면 옆 텍스트 area에  내용 출력하기 끝!!!
		
		
		
		
	}
	// 리스트 출력 함수
	
	
	
	
	
	
	
	$(function(){
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content")

		
		var insertVoiceBtn = $("#insertVoiceBtn");
		var updateVoiceBtn = $("#updateVoiceBtn");
		var deleteVoiceBtn = $("#deleteVoiceBtn");
		
		var voiceoutInsertModal = $("#voiceoutInsertModal");
		
		var voiceoutInsertBtn = $("#voiceoutInsertBtn");
		
		
		deleteVoiceBtn.on("click", function(){
			
			var deleteId = hiddenId.val();
			console.log(deleteId);
			
			// 알러트 창 -> 확인을 눌렀을 경우 삭제처리
			Swal.fire({
			      icon: 'warning',
			      title: '음성 방송 삭제',
			      text: '해당 음성 방송을 삭제하시겠습니까?',
			      confirmButtonText: '확인',
			      confirmButtonColor: 'midnightblue',
			    }).then(result => {
			    	if(result.isConfirmed){
				    	
			    		var deleteObj = {
			    				
			    			voiceOtptCd : deleteId
			    				
			    		}
			    		
			    		// 음성 방송 삭제 기능 아작스
			    		$.ajax({
					 		type : "post",
							url : "/mediform/nurse/xray/voiceOutput/delete",
							data : JSON.stringify(deleteObj),
					 		contentType : "application/json; charset=utf-8",
					 		async: false,
					        beforeSend : function(xhr){            
					            xhr.setRequestHeader(header,token);
					        },
					 		success : function(result) {
								
					 			Swal.fire({
								      icon: 'success',
								      title:'음성 방송 삭제 완료',
								      text: '음성 방송 삭제가 완료 되었습니다',
								      confirmButtonText: '확인',
								      confirmButtonColor: 'midnightblue',
								    })
					 			
					 		}
					 	});
			    		// 음성 방송 삭제 기능 아작스 끝
			    		printList();
			    		
			    	}
			    	});
			
			
			
		});
		
		
		
		// 업데이트 버튼 클릭
		updateVoiceBtn.on("click", function(){
			
			
			var updateId = hiddenId.val();
			console.log(updateId);
			
			var updateContent = $("#voiceOutTextArea").val();
			
			
			var updateObj = {
					
					voiceOtptCd : updateId,
					voiceOtptCn : updateContent
					
			}
			
			// 업데이트 아작스
			$.ajax({
		 		type : "post",
				url : "/mediform/nurse/xray/voiceOutput/update",
				data : JSON.stringify(updateObj),
		 		contentType : "application/json; charset=utf-8",
		 		async: false,
		        beforeSend : function(xhr){            
		            xhr.setRequestHeader(header,token);
		        },
		 		success : function(result) {
					
		 			Swal.fire({
					      icon: 'success',
					      title:'음성 방송 수정 완료',
					      text: '음성 방송 수정이 완료 되었습니다',
					      confirmButtonText: '확인',
					      confirmButtonColor: 'midnightblue',
					    })
		 			
		 		}
		 	});
			// 업데이트 아작스 끝
			
		});
		// 업데이트 버튼 클릭 끝
		
		
		
		// 음성 insert(새로 등록) 모달
		insertVoiceBtn.on("click", function(){
			
			var voiceTitle = $("#voiceTitle").val("");
			var voiceContent = $("#voiceContent").val("");
			
			voiceoutInsertModal.modal("show");
			
			// 등록 버튼 클릭 => 방송 등록 기능
			voiceoutInsertBtn.on("click", function(){
			
				voiceTitle = $("#voiceTitle").val();
				voiceContent = $("#voiceContent").val();
				
				console.log("인서트할 음성 제목 >>> " + voiceTitle);
				console.log("인서트할 음성 내용 >>> " + voiceContent);
				
				var voiceObj = {
						
					voiceOtptNm : voiceTitle,
					voiceOtptCn : voiceContent
						
				}
				
				console.log("음성 출력 insert할 json >>> " + voiceObj);
				
				
				// 등록 기능 ajax
				$.ajax({
			 		type : "post",
					url : "/mediform/nurse/xray/voiceOutput/insert",
					data : JSON.stringify(voiceObj),
			 		contentType : "application/json; charset=utf-8",
			 		async: false,
			        beforeSend : function(xhr){            
			            xhr.setRequestHeader(header,token);
			        },
			 		success : function(result) {
			 			
			 			Swal.fire({
						      icon: 'success',
						      title:'음성 방송 등록 완료',
						      text: '음성 방송 등록이 완료 되었습니다',
						      confirmButtonText: '확인',
						      confirmButtonColor: 'midnightblue',
						    }).then(result => {
						    	voiceoutInsertModal.modal("hide");
						    	printList();
						    	});
			 			
						console.log("");
			 		}
			 	});
				// 등록 기능 ajax
				
			});
			// 등록 버튼 클릭 => 방송 등록 기능 끝
			
		});
		// 음성 insert(새로 등록) 모달 끝
		
	});
	
	
	
});	

function speak(text, opt_prop) {
    if (typeof SpeechSynthesisUtterance === "undefined" || typeof window.speechSynthesis === "undefined") {
        alert("이 브라우저는 음성 합성을 지원하지 않습니다.")
        return
    }
    
    window.speechSynthesis.cancel() // 현재 읽고있다면 초기화

    const prop = opt_prop || {}

    const speechMsg = new SpeechSynthesisUtterance()
    speechMsg.rate = prop.rate || 1 // 속도: 0.1 ~ 10      
    speechMsg.pitch = prop.pitch || 1 // 음높이: 0 ~ 2
    speechMsg.lang = prop.lang || "ko-KR"
    speechMsg.text = text
    
    // SpeechSynthesisUtterance에 저장된 내용을 바탕으로 음성합성 실행
    window.speechSynthesis.speak(speechMsg)
}


// 이벤트 영역
const selectLang = "ko-KR"
const text = document.getElementById("voiceOutTextArea")
const btnRead = document.getElementById("voiceoutBtn")

btnRead.addEventListener("click", e => {
    speak(text.value, {
        rate: 0.8, // 속도
        pitch: 0.6, // 음 높이
        lang: selectLang
    })
})




$(function(){

	// 출력할 공간
	var myCam = $('#myCam');
	var camOnBtn = $('#camOnBtn');
	var camOffBtn = $('#camOffBtn');
	var captureBtn = $('#captureBtn');
	var localStream;
	
	var getUserMedia = navigator.mediaDevices.getUserMedia || navigator.webkitGetUserMedia || 
	    navigator.mozGetUserMedia || navigator.mzGetUserMedia;
	// media 정보를 가져와서 내 화면에 띄우기
	
		camOnBtn.on('click', function () {
		    getUserMedia({ video: true, audio: false })
		        .then((stream) => {
		            localStream = stream;
		            myCam[0].srcObject = localStream; // 내 화면 출력
		        }).catch((err) => {
		        	Swal.fire({
					      icon: 'error',
					      title: '오류 발생',
					      text: '카메라 또는 마이크를 찾을 수 없습니다.',
					      confirmButtonColor: 'blue'
					    });
		        });
		    
		    camOnBtn.hide(); 
            camOffBtn.show(); 
	});
	
		camOffBtn.on('click', function () {
            // 미디어 스트림을 중지
            if (localStream) {
                localStream.getTracks().forEach(track => {
                    track.stop();
                });
            }
            myCam[0].srcObject = null; // 비디오 스트림을 중지시킴
            myCam.attr('poster', '${pageContext.request.contextPath }/resources/image/login/backgroundIMG1.jpg'); // 포스터 이미지 설정
           
            camOffBtn.hide(); // Cam Off 버튼 숨기기
            camOnBtn.show(); // Cam On 버튼 보이게 하기
        });
	
});

</script>

</body>
</html>