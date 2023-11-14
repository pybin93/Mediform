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
			id="revenueStatisticsBtn">&nbsp; 매출 &nbsp;</a></li>
		<li class="subMenu nav-item"><a class="nav-link"
			href="/mediform/manager/audit/statistics/select" role="button"
			id="auditStatisticsBtn">&nbsp; 감사 &nbsp;</a></li>
	</ul>
	<!-- 서브 메뉴 -->

	<!-- 부모 카드 -->
	<div class="card" style="height: 680px;" id="pdfDiv">
		<div class="card-header d-flex flex-between-center py-2 border-bottom" style="background-color: midnightblue">
			<div class="row flex-between-end">
				<div class="col-auto align-self-center">
					<h5 class="mb-0 text-white fw-semi-bold" id="header">매출 통계</h5>
				</div>
			</div>
		</div>
		<!-- 부모 카드 body -->
		<div class="card-body ml-3 bg-body-tertiary" style="padding: initial !important;">
			<!-- 첫번째 줄 -->
			<div class="row mt-4" style=" margin-left: 120px;">
				<!-- 첫째줄 첫번째 카드 -->
				<div class="subCardBody col-6" >
					<div class="card" style="height: 550px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">매출 비교</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 50px; padding-left: 37px;">
						    <div>
						        <ul class="nav nav-tabs" id="myTab" role="tablist">
						            <li class="nav-item text-center col-3" role="presentation">
						                <a class="nav-link fw-semi-bold active" id="dayTab" data-bs-toggle="tab" href="#day" role="tab" aria-controls="day" aria-selected="true">DAY</a>
						            </li>
						            <li class="nav-item text-center col-3" role="presentation">
						                <a class="nav-link fw-semi-bold" id="weekTab" data-bs-toggle="tab" href="#week" role="tab" aria-controls="week" aria-selected="false" tabindex="-1">WEEK</a>
						            </li>
						            <li class="nav-item text-center col-3" role="presentation">
						                <a class="nav-link fw-semi-bold" id="monthTab" data-bs-toggle="tab" href="#month" role="tab" aria-controls="month" aria-selected="false" tabindex="-1">MONTH</a>
						            </li>
						            <li class="nav-item text-center col-3" role="presentation">
						                <a class="nav-link fw-semi-bold" id="yearTab" data-bs-toggle="tab" href="#year" role="tab" aria-controls="year" aria-selected="false" tabindex="-1">YEAR</a>
						            </li>
						        </ul>
						    </div>
						    <div class="tab-content border border-top-0 p-3">
						        <div class="tab-pane fade active show" id="day" role="tabpanel" aria-labelledby="day-tab">
						            <div class="dayChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
						        </div>
						        <div class="tab-pane fade" id="week" role="tabpanel" aria-labelledby="week-tab">
						            <div class="weekChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
						        </div>
						        <div class="tab-pane fade" id="month" role="tabpanel" aria-labelledby="month-tab">
						            <div class="monthChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
						        </div>
						        <div class="tab-pane fade" id="year" role="tabpanel" aria-labelledby="year-tab">
						            <div class="yearChartDom" style="min-height: 300px;" data-echart-responsive="true"></div>
						        </div>
						    </div>
						</div>

					</div>
			    </div>
			    
			    <!-- 첫째줄 두번째 카드 -->
				<div class="subCardBody col-5" >
					<div class="card" style="height: 550px;">
						<div class="subCardHeader card-header border-bottom">
							<div class="row flex-between-end">
								<div class="col-auto align-self-center" >
									<span class="mb-0 fw-semi-bold text-black" style="height: 15px;" id="header">주간 평균 매출 요일</span>
								</div>
							</div>
						</div>
						<div class="card-body" style="padding-bottom: 20px; padding-top: 20px; padding-left: 0px;">
							<div class="daySumChartDom" style="min-height: 300px; margin-top: 50px;" data-echart-responsive="true"></div>
				        </div>
					</div>
			    </div>
			</div>
			<!-- 바디 첫째줄 끝 -->
			
			
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	/* ==============================일별 비교============================== */
	var dayJsonList = ${dayJsonList};
	
	$("#dayTab").on("click",function(){
		var salesData = dayJsonList;
	
	
		var dayChartDom = $('.dayChartDom')[0];
		var dayChart = echarts.init(dayChartDom);
		var dayOption;
	
		dayOption = {
				toolbox: {
				    feature: {
				      saveAsImage: {}
				    }
				  },
		    xAxis: {
		        type: 'category',
		        data: salesData.map(function(item) {
		            return item.name;
		        })
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [
		        {
		            data: salesData.map(function(item) {
		                return item.value;
		            }),
		            type: 'bar',
		            itemStyle: {
		                color: function(params) {
		                    if (params.dataIndex === 0) {
		                        return '#a90000';
		                    } else {
		                        return '#5f95ff'; // 다른 막대의 색상
		                    }
		                }
		            }
		        }
		    ],
		    tooltip: {
	            trigger: 'axis',
	            formatter: function (params) {
	                var result = params[0].name + '<br/>';
	                params.forEach(function (param) {
	                    // 숫자를 특정 형식으로 포맷
	                    var formattedValue = Number(param.value).toLocaleString('ko-KR');
	                    result += formattedValue + '원 <br>';
	                });
	                return result;
	            }
	        }
	    };
	
		dayOption && dayChart.setOption(dayOption);
	});
	/* ==============================일별 비교============================== */
	
	/* ==============================주별 비교============================== */
	var weekJsonList = ${weekJsonList};
	$("#weekTab").on("click",function(){
		var salesData = weekJsonList;
		var weekChartDom = $('.weekChartDom')[0];
		var weekChart = echarts.init(weekChartDom);
		var weekOption;

		weekOption = {
				toolbox: {
				    feature: {
				      saveAsImage: {}
				    }
				  },
		  xAxis: {
		    type: 'category',
		    data: salesData.map(function(item) {
	            return item.name;
	        })
		  },
		  yAxis: {
		    type: 'value'
		  },
		  series: [
		    {
		    	data: salesData.map(function(item) {
	                return item.value;
	            }),
	            type: 'bar',
	            itemStyle: {
	                color: function(params) {
	                    if (params.dataIndex === 0) {
	                        return '#a90000';
	                    } else {
	                        return '#5f95ff'; // 다른 막대의 색상
	                    }
	                }
	            }
	        }
	    ],
		  tooltip: {
	            trigger: 'axis',
	            formatter: function (params) {
	                var result = params[0].name + '<br/>';
	                params.forEach(function (param) {
	                    // 숫자를 특정 형식으로 포맷
	                    var formattedValue = Number(param.value).toLocaleString('ko-KR');
	                    result += formattedValue + '원 <br>';
	                });
	                return result;
	            }
	        }
	    };

		weekOption && weekChart.setOption(weekOption);
		
	});
	/* ==============================주별 비교============================== */
	
	/* ==============================월별 비교============================== */
    var monthJsonList = ${monthJsonList};
	$("#monthTab").on("click", function () {
    var monthChartDom = $('.monthChartDom')[0];
    var monthChart = echarts.init(monthChartDom);
    var monthOption;
    var salesData = monthJsonList;

    monthOption = {
    		toolbox: {
			    feature: {
			      saveAsImage: {}
			    }
			  },
        xAxis: {
            type: 'category',
            data: salesData.map(function(item) {
	            return item.name;
	        })
		  },
        yAxis: {
            type: 'value'
        },
        series: [
		    {
		    	data: salesData.map(function(item) {
	                return item.value;
	            }),
	            type: 'bar'
	        }
	    ],
        tooltip: {
            trigger: 'axis',
            formatter: function (params) {
                var result = params[0].name + '<br/>';
                params.forEach(function (param) {
                    // 숫자를 특정 형식으로 포맷
                    var formattedValue = Number(param.value).toLocaleString('ko-KR');
                    result += formattedValue + '원 <br>';
                });
                return result;
            }
        }
    };

    monthOption && monthChart.setOption(monthOption);
});
	/* ==============================월별 비교============================== */
	
	/* ==============================연별 비교============================== */
    var yearJsonList = ${yearJsonList};
	$("#yearTab").on("click", function () {
    var yearChartDom = $('.yearChartDom')[0];
    var yearChart = echarts.init(yearChartDom);
    var yearOption;
    var salesData = yearJsonList;

    yearOption = {
    		toolbox: {
			    feature: {
			      saveAsImage: {}
			    }
			  },
        xAxis: {
            type: 'category',
            data: salesData.map(function(item) {
	            return item.name;
	        })
		  },
        yAxis: {
            type: 'value'
        },
        series: [
		    {
		    	data: salesData.map(function(item) {
	                return item.value;
	            }),
	            type: 'bar',
	            itemStyle: {
	                color: function(params) {
	                    if (params.dataIndex === 0) {
	                        return '#a90000';
	                    } else {
	                        return '#5f95ff'; // 다른 막대의 색상
	                    }
	                }
	            }
	        }
	    ],
        tooltip: {
            trigger: 'axis',
            formatter: function (params) {
                var result = params[0].name + '<br/>';
                params.forEach(function (param) {
                    // 숫자를 특정 형식으로 포맷
                    var formattedValue = Number(param.value).toLocaleString('ko-KR');
                    result += formattedValue + '원 <br>';
                });
                return result;
            }
        }
    };

    yearOption && yearChart.setOption(yearOption);
	});
	/* ==============================연별 비교============================== */
	
	/* ==============================일별 평균 매출액=============================== */
	var avgJsonList = ${avgJsonList};
var daySumChartDom = $('.daySumChartDom')[0];
var daySumChart = echarts.init(daySumChartDom);
var daySumOption;

// 데이터 포맷 변경
var datasetData = avgJsonList.map(function(item) {
    return [item.value, item.name];
});

daySumOption = {
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    dataset: {
        source: datasetData
    },
    grid: { containLabel: true },
    xAxis: { name: '매출 (원)' },
    yAxis: { type: 'category' },
    series: [
        {
            type: 'bar',
            encode: {
                x: 0,
                y: 1
            },
            itemStyle: {
                color: function (params) {
                    // 주소에 따라 다른 색상 반환
                    if (params.dataIndex === 0) {
                        return '#274507';
                    } else if (params.dataIndex === 1) {
                        return '#ec6166';
                    } else if (params.dataIndex === 2) {
                        return '#f1b87f';
                    } else if (params.dataIndex === 3) {
                        return '#f6edaa';
                    } else if (params.dataIndex === 4) {
                        return '#ce4848';
                    } else if(params.dataIndex === 5){
                        return '#7d7574';
                    } else {
                    	return '#9d6058';
                    }
                }
            }
        }
    ],
    tooltip: {
        trigger: 'axis',
        formatter: function (params) {
            var result = params[0].name + '<br/>';
            params.forEach(function (param) {
                var formattedValue = Number(param.value[0]).toLocaleString('ko-KR') + '원';
                result += formattedValue + ' <br>';
            });
            return result;
        }
    }
};

daySumOption && daySumChart.setOption(daySumOption);

/* ==============================일별 평균 매출액=============================== */

	// 페이지 로드시 가장 먼저 실행 될 놈
	$("#dayTab").click();
});
</script>
</body>
</html>