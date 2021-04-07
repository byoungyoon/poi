<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>poi</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://unpkg.com/tabulator-tables@4.9.3/dist/css/tabulator.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleForm.css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div id="leftData" class="col-sm-3 col-md-3 pad-10">
				<div class="float-left">
					<h1>POI(ADMIN)</h1>
				</div>
				<div class="text-right">
					<a href="${pageContext.request.contextPath}/all/index" class="btn btn-secondary" style="margin-left:9px;">INDEX</a>
				</div>
				
				<div class="clear">
					<div id="current" class="text-center">
						<a href="javascript:void(0);" onClick="btnCalendarPre()"><i class='fas fa-arrow-left' style='font-size:27px; color: gray;'></i></a>
						<span style="font-size: 29px; margin-left:40px; margin-right:40px"></span>
						<a href="javascript:void(0);" onClick="btnCalendarNext()"><i class='fas fa-arrow-right' style='font-size:27px; color: gray;'></i></a>
					</div>
					<table id="calendarTable" style="margin-bottom:12px">
						<thead>
							<tr>
								<th class="text-danger">일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th class="text-primary">토</th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="pad-10" style="border-top: 1px solid #bcbcbc;">
					<div id="defaultForm">
						<div style="margin-bottom:12px">
							<span class="font-weight-bold">최근 작성한 메모장</span>
						</div>
						<div style="overflow:auto; height: 300px;">
							<table id="memoTable" class="table table">
								<thead>
									<tr>
										<th style="width:20%">날짜</th>
										<th style="width:50%">내용</th>
										<th style="width:30%">업데이트</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div id="oneClickForm">
						<table id="memoOneTable" class="table table">
							<thead>
								<tr>
									<th style="width:30%">날짜</th>
									<th style="width:70%">내용</th>
								</tr>
							</thead>
						</table>
						<div id="btnForm"></div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 col-md-9" style="border-left: 2px solid #bcbcbc;">
				<div class="row">
					<div class="col-sm-7 col-md-7 pad-10" style="min-height:600px">
						<span class="font-weight-bold">poi 데이터 리스트</span>
						<input type="text" id="name" onChange="nameChange()" />
						<table id="dataTable"></table>
					</div>
					<div class="col-sm-5 col-md-5 pad-10" style="margin-top: 33px">
						<canvas class="pad-10" id="myChart" width="500" height="500"></canvas>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-7 col-md-7 pad-10">
						<div class="row">
							<div class="col-sm-4 col-md-4">						
								<div id="location"></div>
							</div>
							<div class="col-sm-4 col-md-4">
								<div id="poiCategory"></div>
							</div>
							<div class="col-sm-4 col-md-4">
								<div id="subdata"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-5 col-md-5 pad-10">
						<span class="font-weight-bold">가입한 유저 관리</span>
						<div id="userTable" style="overflow:auto; height:250px;margin-top:10px"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ee89d92102b5b72b2c9f6fa2ea091a7"></script>
<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.9.3/dist/js/tabulator.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminPage/calendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminPage/user.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminPage/dataTable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminPage/chart.js"></script>
<script>
	// 현재 경로
	function getContextPath() {
	    return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	}
	var contextPath = getContextPath();

	// 달력의 현재 년, 월
	var currentYear = '${currentYear}';
	var currentMonth = '${currentMonth}';
	
	$('#oneClickForm').hide();
	
	// 달력
	CalendarDefault();
	// 메모
	memoTableDefault();
	// 테이블
	dataTableDefault();
	// 차트
	chartDefault();
	// 유저 리스트
	createUserList();
	
</script>
</body>
</html>