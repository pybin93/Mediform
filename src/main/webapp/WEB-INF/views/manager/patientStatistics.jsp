<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메디폼 | 행정관리자</title>
<style type="text/css">
.subMenu:hover {
	border-color: #3f51b5;
	background-color: rgba(63, 81, 181, 0.1);
}

.subMenu {
	font-size: 16px;
	margin-left: 20px;
	margin-right: 20px;
}

.subCardHeader{
	background-color: #3737833d;
    height: 40px;
    padding-top: 10px;

}

body{
	overflow: auto !important; 
}

</style>

<!-- ECharts  -->
<!-- <script src="https://cdn.jsdelivr.net/npm/echarts@5.0.0/dist/echarts.min.js"></script> -->
<script src="${pageContext.request.contextPath }/resources/vendors/echarts/echarts.min.js"></script>


<!-- chart.js -->
<script src="${pageContext.request.contextPath }/resources/vendors/chart/chart.min.js"></script>
</head>
<body>
	<!-- 서브 메뉴 -->
	<ul class="navbar-nav d-flex flex-row"
		style="margin-bottom: 15px; border-bottom: 1px solid #ededed; border-top: 1px solid #ededed;">
		<li style="margin-left: 15px;"></li>
		<li class="subMenu nav-item"><a class="nav-link"
			href="/mediform/manager/patient/statistics/select" role="button"
			id="patientStatisticsBtn">&nbsp; 환자 &nbsp;</a></li>
		<li class="subMenu nav-item"><a class="nav-link"
			href="/mediform/manager/revenue/statistics/select" role="button"
			id="">&nbsp; 매출 &nbsp;</a></li>
		<li class="subMenu nav-item"><a class="nav-link"
			href="/mediform/manager/audit/statistics/select" role="button"
			id="">&nbsp; 감사 &nbsp;</a></li>
	</ul>
	<!-- 서브 메뉴 -->

	<!-- 부모 카드 -->
	<div class="card" style="height: 1670px;" id="pdfDiv">
		<div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
			<div class="row flex-between-end">
				<div class="col-auto align-self-center">
					<h5 class="mb-0 text-white fw-semi-bold" id="header">환자 통계</h5>
				</div>
			</div>
		</div>
		<!-- 부모 카드 body -->
		<div class="card-body ml-3 bg-body-tertiary" style="padding: initial !important; ">
			<!-- 첫번째 줄 -->
			<div class="row mt-4" style=" height: 300px; margin-left: 120px;">
				<!-- 첫째줄 첫번째 카드 -->
				<div class="subCardBody col-3" >
					<div class="card" style="height: 350px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">실시간 환자 현황</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 50px; padding-left: 37px;">
							<div style="">
								<!-- 
									추후 수정
									- setTimeout으로 함수 실행
									- 함수에 ajax로 실시간 환자 내역 조회(count)
								 -->
								 <!-- 
								 	c:choose로 
								 	오늘 - 어제 값을 구해서 해당 값이 양수인지 음수인지에 따라 다르게 구성 
								  -->
								 <div class="row g-0">
				                    <div class="col-6 col-md-4 border-200 border-bottom border-end pb-4" >
				                      <h6 class="pb-1 text-700">내원 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="todayPatientCount"></p>
				                      <div class="d-flex align-items-center">
				                        <h6 class="fs--1 text-500 mb-0" id="yesterdayPatientCount"></h6>
				                        <h6 class="fs--2 ps-3 mb-0 " id="patientCountChange">
												
										<!-- SVG -->		
												
															                        
										</h6>
				                      </div>
				                    </div>
				                    <div class="col-6 col-md-4 border-200 border-bottom border-end-md pb-4 ps-3" >
				                      <h6 class="pb-1 text-700">입원 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="todayAdmissionCount"></p>
				                      <div class="d-flex align-items-center">
				                        <h6 class="fs--1 text-500 mb-0" id="yesterdayAdmissionCount"></h6>
				                        <h6 class="fs--2 ps-3 mb-0 " id="admissionCountChange">
											
										<!-- SVG -->	
														                        
										</h6>
				                      </div>
				                    </div>
				                    <div class="col-6 col-md-4 border-200 border-bottom border-end border-end-md-0 pb-4 pt-4 pt-md-0 ps-md-3" >
				                      <h6 class="pb-1 text-700" >퇴원 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="dischargeCount"></p>
				                      <div class="d-flex align-items-center">
				                        <h6 class="fs--1 text-500 mb-0"></h6>
				                        <h6 class="fs--2 ps-3 mb-0 ">
				                        
										</h6>
				                      </div>
				                    </div>
				                    <div class="col-6 col-md-4 border-200 border-bottom border-bottom-md-0 border-end-md pt-4 pb-md-0 ps-3 ps-md-0" >
				                      <h6 class="pb-1 text-700">진료 대기 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="clinicWaitCount"></p>
				                    </div>
				                    <div class="col-6 col-md-4 border-200 border-bottom-md-0 border-end pt-4 pb-md-0 ps-md-3" >
				                      <h6 class="pb-1 text-700">진료 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="clinicCount"></p>
				                    </div>
				                    <div class="col-6 col-md-4 pb-0 pt-4 ps-3" >
				                      <h6 class="pb-1 text-700">치료 </h6>
				                      <p class="font-sans-serif lh-1 mb-1 fs-2" id="treatmentCount"></p>
				                    </div>
				                  </div>
				        	</div>
				        </div>
					</div>
			    </div>
			    
			    <!-- 첫째줄 두번째 카드 -->
				<div class="subCardBody col-3"  >
					<div class="card" style="height: 350px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">성비</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; ">
							<div style="">
								<div class="genderChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
					        	</div>
				        </div>
					</div>
			    </div>
			    
			    <!-- 첫째줄 세번째 카드 -->
				<div class="subCardBody col-5"  >
					<div class="card" style="height: 350px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center">
									<span class="mb-0 fw-semi-bold text-black" id="header">연령대</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; " >
							<div class="ageChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
			        	</div>
			        </div>
			    </div>
			</div>
			<!-- 바디 첫째줄 끝 -->
			
			<!-- 둘째줄 시작 -->
			<div class="row" style=" height: 300px; margin-left: 120px; margin-top:100px;">
				<!-- 둘째줄 첫번째 카드 -->
				<div class="subCardBody col-4" >
					<div class="card" style="height: 400px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">재원 비율</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; padding-left: 20px;">
						
							<!-- ECharts 실험 시작 -->
							<div class="revisit" style="min-height: 300px;" data-echart-responsive="true"></div>
							<!-- ECharts 실험 종료 -->
						
				        </div>
					</div>
			    </div>
			    <!-- 둘째줄 두번째 카드 -->
				<div class="subCardBody col-7"  >
					<div class="card" style="height: 400px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">의사별 진료 수</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; ">
							<div class="doctorWeek" style="min-height: 300px;" data-echart-responsive="true"></div>
				        </div>
					</div>
			    </div>
			</div>
			
			<!-- 셋째줄 시작 -->
				<div class="row" style=" height: 700px; margin-left: 120px; margin-top:150px;">
					<!-- 셋째줄 좌측 카드 -->
					<div class="subCardBody col-5" >
						<div class="card" style="height: 700px;">
							<div class="subCardHeader card-header border-bottom">
								<div class="row flex-between-end">
									<div class="col-auto align-self-center" >
										<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">상병 분석</span>
									</div>
								</div>
							</div>
							<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; padding-left: 20px;">
							    <div class="sickChartDom" style="min-height: 600px; min-width: 600px;" data-echart-responsive="true"></div>
							</div>
						</div>
				    </div>
				    
				    <!-- 우측 시작 -->
				    <div class="subCardBody col-6">
				    	
					    <!-- 셋째줄 우측 첫번째 카드 -->
<!-- 						<div class="subCardBody row"  > -->
							<div class="card" style="height: 330px;">
								<div class="subCardHeader card-header border-bottom">
									<div class="row flex-between-end">
										<div class="col-auto align-self-center" >
											<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">주소지</span>
										</div>
									</div>
								</div>
								<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; ">
									<div class="addrChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
						        </div>
							</div>
<!-- 					    </div> -->
				
			
						<!-- 넷째줄 우측 두번째 카드 -->
<!-- 					    <div class="subCardBody row" style="margin-top:40px;"  > -->
							<div class="card" style="height: 330px; margin-top:40px;">
								<div class="subCardHeader card-header border-bottom">
									<div class="row flex-between-end">
										<div class="col-auto align-self-center" >
											<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">시간대별 누적 환자수</span>
										</div>
									</div>
								</div>
								<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; padding-left: 20px;">
								
									<!-- ECharts 실험 시작 -->
									<div class="timeChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
									<!-- ECharts 실험 종료 -->
								
						        </div>
							</div>
<!-- 					    </div> -->
		   	 		</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	
	$(document).ready(function() {
		mediformAjax();
		setTimeoutFt();
    });
	
	function setTimeoutFt(){
		setTimeout(() => {
// 			  console.log("5초에 한번씩...");
			  mediformAjax();
			  setTimeoutFt();
			}, "5000");
		
	}
	
	var token = $("input[name='_csrf']").val();
    var header = $("input[name='_csrf_header']").val();
    
	function mediformAjax(){
		
		$.ajax({
		    type: "post",
		    url: "/mediform/manager/patient/statistics/select",
		    contentType: "application/json; charset=utf-8",
		    beforeSend: function (xhr) {
		        xhr.setRequestHeader(header, token);
		    },
		    success: function (rst) {
// 		        console.log("ajax 성공");
// 		        console.log(rst);

		        var patientCountChange = rst.todayPatientCount - rst.yesterdayPatientCount;
		        var admissionCountChange = rst.todayAdmissionCount - rst.yesterdayAdmissionCount;

		        // 텍스트 업데이트
		        $('#todayPatientCount').text(rst.todayPatientCount);
		        $('#yesterdayPatientCount').text(rst.yesterdayPatientCount);
		        $('#patientCountChange').text(patientCountChange);
		        $('#todayAdmissionCount').text(rst.todayAdmissionCount);
		        $('#yesterdayAdmissionCount').text(rst.yesterdayAdmissionCount);
		        $('#dischargeCount').text(rst.dischargeCount);
		        $('#clinicWaitCount').text(rst.clinicWaitCount);
		        $('#clinicCount').text(rst.clinicCount);
		        $('#treatmentCount').text(rst.treatmentCount);

		        // 입원 환자 비교 후 svg 뿌려주기
		        var admissionChangeHTML = '';
		        if (admissionCountChange > 0) {
		            // 양수인 경우
		            $('#admissionCountChange').addClass('text-danger');
		            admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16"><path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/></svg>';
			        $('#admissionCountChange').html(admissionChangeHTML + ' ' + admissionCountChange);
		        } else if (admissionCountChange < 0) {
		            // 음수인 경우
		            $('#admissionCountChange').addClass('text-primary');
		            admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>';
			        $('#admissionCountChange').html(admissionChangeHTML + ' ' + (-admissionCountChange));
		        } else {
		        	admissionChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16"><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg>'
			        $('#admissionCountChange').html(admissionChangeHTML);
		        }
		        
		        // 내원 환자 비교 후 svg 뿌려주기
		        var patientCountChangeHTML = '';
		        if (patientCountChange > 0) {
		            // 양수인 경우
		            $('#patientCountChange').addClass('text-danger');
		            patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16"><path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/></svg>';
			        $('#patientCountChange').html(patientCountChangeHTML + ' ' + patientCountChange);
		        } else if (patientCountChange < 0) {
		            // 음수인 경우
		            $('#patientCountChange').addClass('text-primary');
		            patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>';
			        $('#patientCountChange').html(patientCountChangeHTML + ' ' + (-patientCountChange));
		        } else {
		        	patientCountChangeHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16"><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg>'
			        $('#patientCountChange').html(patientCountChangeHTML);
		        }
		    }
		});


	}
	
	/* ===================================첫번째줄 첫번째 차트==================================== */
	/* 남녀 성비 */
	/* 완료 */
	var genderSumJsonList = ${genderSumJsonList};
	var genderChartDom = $('.genderChartDom')[0];
	var genderChart = echarts.init(genderChartDom);
	var genderOption;
	
	var colors = ['#00a9ff', '#ff5676'];
	
	genderOption = {
	  toolbox: {
		    feature: {
		      saveAsImage: {}
		    }
		  },
	  tooltip: {
	    trigger: 'item'
	  },
	  legend: {
	    orient: 'vertical',
	    left: 'left'
	  },
	  series: [
	    {
	      name: '성비',
	      type: 'pie',
	      radius: '50%',
	      data: genderSumJsonList
	      ,
	      label: {
              show: true,
              formatter: function(param) {
                  return param.name + ' (' + (param.percent) + '%)';
              }
          },
          itemStyle: {
              normal: {
                  // 색상을 변수에서 가져오기
                  color: function(params) {
                      return colors[params.dataIndex];
                  }
              }
          },
	      emphasis: {
	        itemStyle: {
	          shadowBlur: 10,
	          shadowOffsetX: 0,
	          shadowColor: 'rgba(0, 0, 0, 0.5)'
	        }
	      }
	    }
	  ]
	};
	
	genderOption && genderChart.setOption(genderOption);
	/* ===================================첫번째줄 첫번째 차트==================================== */
    
	/* ===================================첫번째줄 두번째 차트==================================== */
	/* 나이대별 차트 */
	/* 완료 */
	var ageSumJson = ${ageSumJson};
	
	// 데이터가 유효한 경우에만 처리
	if (Array.isArray(ageSumJson) && ageSumJson.length > 0) {
	    var ageNameArr = ageSumJson.map(function(item) {
	        return item.name;
	    });
	    
	    var ageValueArr = ageSumJson.map(function(item) {
	        return item.value;
	    });
	    
	    // value 총 합
	    var valueSum = 0; 
	    for(var i=0; i<ageValueArr.length; i++){
	    	
	    	valueSum =  valueSum + parseInt(ageValueArr[i]);
	    }
//     	console.log("valueSum : " + valueSum);
	
	    var ageChartDom = $('.ageChartDom')[0];
	    var ageChart = echarts.init(ageChartDom);
	    var ageOption;
	
	    ageOption = {
	    		toolbox: {
	    	        feature: {
	    	            saveAsImage: {}
	    	        }
	    	    },
	        xAxis: {
	            type: 'category', // 수정: 'name' 대신 'category'
	            data: ageNameArr,
	        },
	        yAxis: {
	            type: 'value',
	        },
	        series: [
	            {
	                data: ageValueArr,
	                
	                type: 'bar',
	                itemStyle: {
	                    color: function(params) {
	                        var colorList = ['#f6a9a2', '#887673', '#ffcc3b', '#888ae6', '#80a84e', '#20b8d8', '#ff7151'];
	                        return colorList[params.dataIndex];
	                    }
	                },
	                label: {
		                show: true,
		                formatter: function(param) {
		                	var percent = (param.value / valueSum * 100).toFixed(2);
		                    return param.name + ' (' + percent + '%)';
		                }
	            	}
	            }
	        ],
	        tooltip: {
	            trigger: 'axis',
	            formatter: function(params) {
	                var result = params[0].name + '<br/>'; // X 축 값을 포함한 첫 줄
	                params.forEach(function(param) {
	                    var str = param.value + "";
	                    var strArr = str.split(',');
	                    result += strArr[0] + '<br/>'; // 각 시리즈의 이름과 해당 값
	                });
	                return result;
	            },
	        },
	    };
	
	    ageOption && ageChart.setOption(ageOption);
	} else {
	    // ageSumJson이 유효한 데이터가 아닌 경우에 처리할 내용 추가
	}

	/* ===================================첫번째줄 두번째 차트==================================== */
	
	
	/* ===================================두번째줄 첫번째 echarts 차트==================================== */
	// 차트를 표시할 요소를 선택합니다.
	var revisitJson = ${revisitJson};
	var revisitNameArr = [];
	var revisitValueArr = [];
	var dataSum = 0; // 데이터 합계
	
	for (var i = 0; i < revisitJson.length; i++) {
	    revisitNameArr.push(revisitJson[i].name);
	    var value = parseInt(revisitJson[i].value); // 문자열을 정수로 변환
	    revisitValueArr.push(value);
	    dataSum += value;
	}
	
	var chartContainer = $('.revisit')[0];
	var revisitChart = echarts.init(chartContainer);
	var option;
	
	option = {
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    tooltip: {
	        trigger: 'item'
	    },
	    legend: {
	        top: '5%',
	        left: 'center',
	        selectedMode: false
	    },
	    series: [
	        {
	            name: '재원 비율',
	            type: 'pie',
	            radius: ['40%', '70%'],
	            center: ['50%', '70%'],
	            startAngle: 180,
	            label: {
	                show: true,
	                formatter: function (param) {
	                    return param.name + ' (' + ((param.value / dataSum) * 100).toFixed(2) + '%)';
	                }
	            },
	            data: revisitNameArr.map(function (name, index) {
	                return { value: revisitValueArr[index], name: name };
	            }).concat({ // 바 데이터를 추가
	                value: dataSum, // 데이터 합계
	                itemStyle: {
	                    color: 'none',
	                    decal: {
	                        symbol: 'none'
	                    }
	                },
	                label: {
	                    show: false
	                }
	            })
	        }
	    ]
	};
	
	option && revisitChart.setOption(option);

	/* ===================================두번째줄 첫번째 echarts 차트==================================== */
	
	/* ===================================두번째줄 두번째 echarts 차트==================================== */
var doctorJson = ${doctorJson};

// 데이터 변환
var data = doctorJson.map(function (item) {
    return { name: item.empNm, date: item.sevenDays, value: item.value };
});

// 의사 이름 목록을 가져옵니다.
var doctorNames = [...new Set(data.map(item => item.name))];

// sevenDays 목록을 가져옵니다.
var sevenDays = [...new Set(data.map(item => item.date))];

// 의사별 데이터를 생성
var seriesData = doctorNames.map(function (name) {
    return {
        name: name,
        type: 'line',
        data: sevenDays.map(function (day) {
            var entry = data.find(item => item.name === name && item.date === day);
            return entry ? entry.value : 0;
        }),
    };
});

// console.log(doctorJson);

var doctorWeekDom = $('.doctorWeek')[0];
var doctorWeekChart = echarts.init(doctorWeekDom);
var doctorWeekOption;

doctorWeekOption = {
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
        },
    },
    legend: {
        data: doctorNames,
    },
    grid: {
        top: 40,
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true,
    },
    toolbox: {
        feature: {
            saveAsImage: {},
        },
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: sevenDays,
    },
    yAxis: {
        type: 'value',
    },
    series: seriesData, // 사용자 데이터 추가
};

doctorWeekOption && doctorWeekChart.setOption(doctorWeekOption);
/* ===================================두번째줄 두번째 echarts 차트==================================== */

	
	/* ===================================세번째줄 우측 하단 차트==================================== */
var timeJson = ${timeJson}; // JSON 데이터를 변수에 할당

// JSON 데이터를 가공하여 차트 데이터로 변환
var timeData = timeJson.map(function (item) {
  return Number(item.value); // 문자열을 숫자로 변환
});

var total = timeData.reduce((a, b) => a + b, 0); // total 변수 정의

var timeChartDom = $('.timeChartDom')[0];
var timeChart = echarts.init(timeChartDom);
var timeOption;

timeOption = {
  toolbox: {
    feature: {
      saveAsImage: {}
    }
  },
  xAxis: {
    type: 'category',
    data: timeJson.map(function (item) {
      return item.name; // JSON 데이터의 "name" 필드를 X 축으로 사용
    })
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: timeData,
      type: 'line'
    }
  ],
  tooltip: {
    trigger: 'axis',
    formatter: function (params) {
      var result = params[0].name + '<br/>';
      params.forEach(function (param) {
        var percentage = ((param.value / total) * 100).toFixed(2) + '%';
        result += '환자수: ' + param.value + ' (' + percentage + ')<br/>';
      });
      return result;
    }
  }
};

timeOption && timeChart.setOption(timeOption);


/* ===================================세번째줄 우측 하단 차트==================================== */



	/* ===================================세번째줄 우측 상단 차트==================================== */
	/* 주소지 통계 */
	/* 완료 */
	var addrJson = ${addrJson};
	
	// 데이터 변환
	var data = addrJson.map(function(item) {
	    return { name: item.name, value: parseInt(item.value) };
	});
	
	// 데이터의 총합 계산
	var totalValue = data.reduce(function(total, item) {
	    return total + item.value;
	}, 0);
	
	// 백분율 계산 및 데이터에 추가
	data = data.map(function(item) {
	    var percentage = ((item.value / totalValue) * 100).toFixed(2) + '%';
	    return { name: item.name, value: item.value, percentage: percentage };
	});
	
	var addrChartDom = $('.addrChartDom')[0];
	var addrChart = echarts.init(addrChartDom);
	var addrOption;
	
	addrOption = {
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    dataset: {
	        source: data,
	    },
	    grid: { containLabel: true },
	    xAxis: { name: 'patient' },
	    yAxis: { type: 'category' },
	    series: [
	        {
	            type: 'bar',
	            encode: {
	                x: 'value',
	                y: 'name'
	            },
	            itemStyle: {
	                color: function(params) {
	                    // 주소에 따라 다른 색상 반환
	                    var colorList = [
	                        '#274507', '#ec6166', '#f1b87f', '#f6edaa', '#7d7574', '#f8cfed'
	                    ];
	                    return colorList[params.dataIndex];
	                },
	            },
	            emphasis: { // 마우스 호버 효과
	                itemStyle: {
	                    color: '#e5e5e5' // 마우스 호버 했을 때 색상 변경
	                }
	            },
	        }
	    ],
	    tooltip: {
	        trigger: 'axis',
	        formatter: function (params) {
	            var result = params[0].name + '<br/>';
	            params.forEach(function (param) {
	                var percentage = ((param.data.value / totalValue) * 100).toFixed(2) + '%';
	                result += '환자수: ' + param.data.value + ' (' + percentage + ')<br/>';
	            });
	            return result;
	        }
	    }

	};
	
	addrOption && addrChart.setOption(addrOption);

	


	
	/* ===================================세번째줄 우측 상단 차트==================================== */
  
 
	/* ===================================세번째줄 좌측 차트==================================== */
var sickJson = ${sickJson};
var sickChartDom = $('.sickChartDom')[0];
var sickChart = echarts.init(sickChartDom);
var sickOption;

sickOption = {
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    legend: {
        top: 'bottom'
    },
    toolbox: {
        show: true,
        feature: {
            mark: { show: true },
            saveAsImage: { show: true }
        }
    },
    grid: { // grid 설정을 이용하여 여백 조절
        top: '70%', 
        containLabel: true 
    },
    series: [
        {
            name: 'Nightingale Chart',
            type: 'pie',
            radius: [50, 250],
            center: ['50%', '50%'],
            roseType: 'area',
            itemStyle: {
                borderRadius: 8
            },
            data: sickJson,
            labelLine: { // 데이터 레이블의 선 설정
                normal: {
                    length: 1 // 데이터 레이블과 원 그래프의 거리 설정
                }
            }
        }
    ],
    tooltip: {
        trigger: 'item',
        formatter: function (params) {
            return params.data.name + '<br> ' + params.data.value + '회';
        }
    }
};

sickOption && sickChart.setOption(sickOption);


/* ===================================세번째줄 좌측 차트==================================== */



	
	
	
	
});
</script>
</body>
</html>