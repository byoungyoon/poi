<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>poi</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://unpkg.com/tabulator-tables@4.9.3/dist/css/tabulator.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleForm.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
	<div>
		<div id="leftData" class="float-left pad-10" style="width:400px;">
			<div class="float-left">
				<h1>POI</h1>
			</div>
			<div class="text-right pad-10">
				<c:if test="${userId == 'admin'}">
					<span style="border-right: 1px solid #bcbcbc; padding:7px">
						<a href="${pageContext.request.contextPath}/admin/adminPage" class="btn btn-outline-primary btn-sm">Admin Page</a>
					</span>					
				</c:if>
				<button type="button" class="btn btn-secondary btn-sm" style="margin-left:9px;" disabled>INDEX</button>
				<a href="${pageContext.request.contextPath}/all/direction" class="btn btn-secondary btn-sm">DIRECTION</a>
			</div>
			<div id="poiList">
				<input id="searchData" type="text" class="form-control" onChange="onChangeBySearch();" placeholder="검색하실 내용을 입력해 주세요.">
			</div>
			<div id="searchList" class="auto" style="margin-top:12px;height:426px;margin-bottom:12px;">
				<span id="dataTableTitle" class="font-weight-bolder"></span>
				<table id="dataTable"></table>
			</div>
			<div id="categoryList" class="pad-10" style="border-bottom: 2px solid #bcbcbc; border-top: 2px solid #bcbcbc;">
				<span class="font-weight-bold">카테고리 모아보기</span>
				<div class="row text-center pd-12" style="margin-top:10px">
					<div class="col-sm-3 col-md-3 categoryStyle" id="Environment" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('공공/환경');">
							<img src="https://i.imgur.com/YZxcVxV.png#.YFp_LE7WPt8.link" width="50" />
							<br><span>관광</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="education" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('교육/보건');">
							<img src="https://i.imgur.com/BDIDMbr.png#.YFp_LJs4e0E.link" width="50" />
							<br><span>교육</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="industry" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('산업');">
							<img src="https://i.imgur.com/ydVBIfC.png#.YFp_LPUNfco.link" width="50" />
							<br><span>산업</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="terrainy" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('선형지형지물');">
							<img src="https://i.imgur.com/Q0Kgm8m.png#.YFp_LLSZSP8.link" width="50" />
							<br><span>선형지형</span>
						</a>
					</div>
				</div>
				<div class="row text-center">
					<div class="col-sm-3 col-md-3 categoryStyle" id="lodgment" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('숙박/음식');">
							<img src="https://i.imgur.com/nUgfV1e.png#.YFp_LEBOvmU.link" width="50" />
							<br><span>숙박</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="facility" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('시설물');">
							<img src="https://i.imgur.com/nU5P0kP.png#.YFp_LAmxfGU.link" width="50" />
							<br><span>시설물</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="events" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('이벤트');">
							<img src="https://i.imgur.com/NckOIqB.png#.YFp_LICwcps.link" width="50" />
							<br><span>이벤트</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="dwelling" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('주거');">
							<img src="https://i.imgur.com/QIzHXHR.png#.YFp_LBWn03U.link" width="50" />
							<br><span>주거</span>
						</a>
					</div>
				</div>
				<div class="row text-center">
					<div class="col-sm-3 col-md-3 categoryStyle" id="administration" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('행정');">
							<img src="https://i.imgur.com/ulDNkcU.png#.YFp_LFGhwQs.link" width="50" />
							<br><span>행정</span>
						</a>
					</div>
					<div class="col-sm-3 col-md-3 categoryStyle" id="tourism" style="margin-top:5px;">
						<a href="javascript:void(0);" onclick="poiCategoryClick('레저/관광/예술');">
							<img src="https://i.imgur.com/JsSKxb9.png#.YFp_LAANH2w.link" width="50" />
							<br><span>환경</span>
						</a>
					</div>
				</div>
			</div>
			<div id="btnList">
				<div class="float-left pad-12">
					<c:if test="${userId == null}">
						<a href="${pageContext.request.contextPath}/all/login" class="btn btn-info">로그인</a>					
					</c:if>
					<c:if test="${userId != null}">
						<a href="${pageContext.request.contextPath}/logout" class="btn btn-info">로그아웃</a>					
					</c:if>
				</div>
				<div class="text-right pad-12">
					<c:if test="${userId == 'admin'}">
						<button type="button" onclick="addPoi();" class="btn btn-outline-primary">추가</button>
					</c:if>
				</div>
			</div>
		</div>
		<div id="rightData">
			<div id="mapData" class="map_wrap" style="width:100%;border-left: 2px solid #bcbcbc;">
				<div id="map" style="height:970px;position:relative;z-index:1;"></div>
				<div id="poiOneData" style="position:absolute;bottom:0px;right:5px;z-index:2;width:70%;"></div>
				<div id="categoryListForm" class="auto pad-12">
					<span id="categoryListTitle" class="font-weight-bold text-info"></span>
					<div id="categoryListTable" style="margin-top:10px"></div>
					<div id="pagingTable" class="text-center"><button type="button" class="btn btn-block" onClick="addPaging()"><i class='fas fa-angle-down' style='font-size:36px'></i></button></div>
				</div>
				<div id="roadviewForm" style="position:absolute;bottom:0px;right:0px;z-index:3;width:100%;">
					<div id="roadview" style="height:970px;"></div>
					<div style="position:absolute;top:0px;right:0px;z-index:4">
						<button type="button" class="btn btn-secondary btn-sm" onclick="gotoOneData();">돌아가기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ee89d92102b5b72b2c9f6fa2ea091a7&libraries=services"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.9.3/dist/js/tabulator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index/roadview.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index/searchForm.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

	<script>
	// 현재 경로
	function getContextPath() {
	    return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	}
	var contextPath = getContextPath();
	
	onDefaultTable();
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.48327, 127.04445), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		var positions = [];
		var overlay = {};
		
		var imageSize = new kakao.maps.Size(24, 35); 
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png'; 
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		
		// 교육
		var categoryMarkerSize = new kakao.maps.Size(42, 47); 
		var educationSrc = 'https://i.imgur.com/BDIDMbr.png#.YFp_LH0K4P4.link'; 
		var educationImage = new kakao.maps.MarkerImage(educationSrc, categoryMarkerSize); 
		// 관광
		var tourismSrc = 'https://i.imgur.com/JsSKxb9.png#.YFp_LFySr2s.link'; 
		var tourismImage = new kakao.maps.MarkerImage(tourismSrc, categoryMarkerSize); 
		// 시설물
		var facilitySrc = 'https://i.imgur.com/nU5P0kP.png#.YFp_LA3rPdE.link'; 
		var facilityImage = new kakao.maps.MarkerImage(facilitySrc, categoryMarkerSize); 
		// 산업
		var industrySrc = 'https://i.imgur.com/ydVBIfC.png#.YFp_LBaFLHU.link'; 
		var industryImage = new kakao.maps.MarkerImage(industrySrc, categoryMarkerSize); 
		// 선형지형지물
		var terrainySrc = 'https://i.imgur.com/Q0Kgm8m.png#.YFp_LCoRaHA.link'; 
		var terrainImage = new kakao.maps.MarkerImage(terrainySrc, categoryMarkerSize); 
		// 숙박/음식
		var lodgmentSrc = 'https://i.imgur.com/nUgfV1e.png#.YFp_LExQUBw.link'; 
		var lodgmentImage = new kakao.maps.MarkerImage(lodgmentSrc, categoryMarkerSize); 
		// 공공/환경
		var EnvironmentSrc = 'https://i.imgur.com/YZxcVxV.png#.YFp_LBdFVss.link'; 
		var EnvironmentImage = new kakao.maps.MarkerImage(EnvironmentSrc, categoryMarkerSize); 
		// 이벤트
		var eventSrc = 'https://i.imgur.com/NckOIqB.png#.YFp_LDtQ-6k.link'; 
		var eventImage = new kakao.maps.MarkerImage(eventSrc, categoryMarkerSize); 
		// 행정
		var administrationSrc = 'https://i.imgur.com/ulDNkcU.png#.YFp_LJxa2TU.link'; 
		var administrationImage = new kakao.maps.MarkerImage(administrationSrc, categoryMarkerSize); 
		// 주거
		var dwellingSrc = 'https://i.imgur.com/QIzHXHR.png#.YFp_LNLEUGg.link'; 
		var dwellingImage = new kakao.maps.MarkerImage(dwellingSrc, categoryMarkerSize); 
		
		var addMarker = new kakao.maps.Marker({
			position: map.getCenter() 
		});
		
		var oneClickCk = 0;
		
		// poi infowindow의 a태그를 클릭
		function poiOneClick(poiNo){
			oneClickCk = 1;
			$('#poiOneData').empty();
			$('#poiOneData').show();	
			$.ajax({
				url:'${pageContext.request.contextPath}/all/poiOneData',
				type: 'GET',
				dataType: 'JSON',
				data: {poiNo : poiNo},
				success: function(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/all/reviewList',
						type:'GET',
						data: {poiNo : poiNo},
						success: function(secondData){
							//console.log(secondData);
							var userId = '${userId}';
							var oneDataReview = '';
							if(secondData.length == 0){
								oneDataReview = '<tr><td colspan="2">해당하는 리뷰가 없습니다.</td></tr>'
							}
							for(var i=0; i<secondData.length; i++){
								var reviewNo = secondData[i].reviewNo;
								oneDataReview += `
									<tr>
										<td><img width="55px" src="${pageContext.request.contextPath}/images/\${secondData[i].reviewFileName}\"></td>
										<td style="width:80%;">\${secondData[i].reviewContent}\</td>
								`;
								if(secondData[i].userId == userId){
									oneDataReview += `<td><a href="javascript:void(0);" onclick="deleteReview('\${reviewNo}\', '\${poiNo}\');" style="color:#FF0000;">X</a></td></tr>`;
								} else{
									oneDataReview += '<td></td></tr>';
								}
							}
							
							var image = '';
							var content = '';
							if(data.poiOneData.poiSubdata == null){
								image = 'default.jpg';	
								content = '해당 추가정보 없음';
							} else{
								if(data.poiOneData.poiSubdata.poiContent == ''){
									content = '해당 추가정보 없음';
								} else{
									content = data.poiOneData.poiSubdata.poiContent;								
								}
								image = data.poiOneData.poiSubdata.poiImg;
							}
							
							var inputTelNo = '';
							if(data.poiOneData.telNo == ''){
								inputTelNo = '해당 번호 없음';
							} else{
								inputTelNo = data.poiOneData.telNo;
							}
							
							var oneDataDiv = `
								<div class="row">
									<div class="col-sm-3">
										<img src="${pageContext.request.contextPath}/images/\${image}\" id="previewByModify" style="width:100%; height:310px; padding:5px">
										<div class="modifyForm" style="margin-top:3px">
											<input type="file" id="imgSelectorByModify" onchange="imgSelectorByModify()">
										</div>
									</div>
									<div class="col-sm-9">
										<div class="row" style="padding-top:25px; padding-bottom:15px;">
											<div class="col-sm-4 col-md-4" style="border-right: 2px solid #bcbcbc;">
												<table class="table table">
													<tr>
														<th>Name</th>
														<td>
															<input 
																type="text" 
																id="modifyName" 
																class="form-control" 
																value="\${data.poiOneData.name}\" 
																readonly 
															/>
														</td>
													</tr>
													<tr>
														<th>Tel</th>
														<td>
															<input 
																type="text" 
																id="modifyTelNo" 
																class="form-control" 
																value="\${inputTelNo}\" 
																readonly 
															/>
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<textarea 
																rows="2" 
																id="modifyContent" 
																class="form-control" 
																readonly>\${content}\</textarea>
														</td>
													</tr>
												</table>
												<div id="defaultForm" class="text-right">
													<div style="float:left">
														<button type="button" class="btn btn-secondary" onclick="roadViewClick(\${poiNo}\);">로드뷰</button>
													</div>
													<div class="text-right">
														<c:if test="${userId == 'admin'}">
															<button type="button" class="btn btn-outline-primary" onclick="modifyClick(\${poiNo}\);">수정</button>
															<button type="button" class="btn btn-outline-primary" onclick="deleteClick(\${poiNo}\);">삭제</button>		
														</c:if>												
													</div>
												</div>					
												<div class="text-right modifyForm">
													<div style="float:left">
														<button type="button" class="btn btn-info" onclick="backOneData(\${poiNo}\)">돌아가기</button>
													</div>
													<div class="text-right">
														<button type="button" class="btn btn-secondary" onclick="modifyAction(\${poiNo}\);">수정</button>
													</div>
												</div>					
											</div>
											<div class="col-sm-4 col-md-4" style="border-right: 2px solid #bcbcbc; overflow:auto; height:270px;">
												<span class="font-weight-bold" style="padding:3px;">리뷰</span>
												<table id="reviewTable" class="table table">
													\${oneDataReview}\
												</table>
											</div>
											<div class="col-sm-4 col-md-4" style="padding-right: 20px">
												<span class="font-weight-bold" style="padding:3px;">리뷰 쓰기</span>
												<div style="margin-top:9px">
													<textarea rows="4" id="reviewContent" class="form-control" placeholder="리뷰를 작성해주세요."></textarea>
												</div>
												<div style="margin-top:8px;">
													<input type="file" id="reviewFile" onChange="imgSelectorOnly();" />
												</div>
												<div class="text-right">
													<button type="button" class="btn btn-secondary btn-sm" onClick="addReviewClick(\${poiNo}\)">리뷰 작성</button>
												</div>
											</div>
										</div>
									</div>
								</div>		
							`;
							
							$('#poiOneData').append(oneDataDiv);
							$('.modifyForm').hide();
						}
					});
				
				}
			});
		}
		
		// 리뷰 삭제
		function deleteReview(reviewNo, poiNo){
			if(confirm('정말 삭제하시겠습니까')){
				$.ajax({
					url: '${pageContext.request.contextPath}/user/deleteReview',
					type: 'GET',
					data: {reviewNo: reviewNo},
					success: function(data){
						poiOneClick(poiNo);
					}
				});
			}
		}
		
		// poi 데이터 수정버튼 클릭
		function modifyClick(poiNo){
			//console.log('${userId}');
			if('${userId}' == ''){
				alert('로그인이 필요합니다.');
				location.href='${pageContext.request.contextPath}/login';
			} else if('${userId}' != 'admin'){
				alert('접근 권한이 없습니다.');
			} else{
				$('#modifyName').attr('readonly', false);
				$('#modifyTelNo').attr('readonly', false);
				$('#modifyContent').attr('readonly', false);
				$('.modifyForm').show();
				$('#defaultForm').hide();
			}
		}
		
		// poi 데이터 수정 액션
		function modifyAction(poiNo){
			if(confirm('입력하신 내용으로 수정하겠습니까')){
			const modifyForm = new FormData();
			modifyForm.append('name', $('#modifyName').val());
			modifyForm.append('poiNo', poiNo);
			modifyForm.append('telNo', $('#modifyTelNo').val());
			modifyForm.append('poiContent', $('#modifyContent').val());
			if($('#imgSelectorByModify').val() != ''){
				modifyForm.append('poiImg', $('#imgSelectorByModify')[0].files[0]);			
			}
			
			fetch('${pageContext.request.contextPath}/admin/updatePoiDataAll', {
				method: 'POST', 
				body: modifyForm, 
			}).then((res) => {
				if (res.status === 200 || res.status === 201) {
					//console.log('success');
					poiOneClick(poiNo);
					poiMarkerCreate($lat, $lon, $name, poiNo);
					
					res.json().then(json => console.log(json));
				}
			}).catch(err => console.error(err));
			}
		}
		
		// poi 데이터 삭제버튼 클릭
		function deleteClick(poiNo){
			if('${userId}' == ''){
				alert('로그인이 필요합니다.');
				location.href='${pageContext.request.contextPath}/login';
			} else if('${userId}' != 'admin'){
				alert('접근 권한이 없습니다.');
			} else{
				if(confirm('데이터 삭제 시 관련된 리뷰나 정보등이 삭제됩니다. \n 정말 삭제하시겠습니까')){
					$.ajax({
						url: '${pageContext.request.contextPath}/admin/deletePoiDataAll',
						type: 'GET',
						data: {poiNo: poiNo},
						success: function(data){
							location.href='${pageContext.request.contextPath}/all/index';
						},
						error: function(error){
							if(error.status == 403){
								alert('접근 권한이 없습니다.');
							}
						}
					});	
				}
			}
		}
		
		function loginCk(){
			if('${userId}' == ''){
				alert('로그인이 필요한 서비스입니다.');
				location.href='${pageContext.request.contextPath}/login';
			}
		}
		
		// 리뷰 추가 버튼을 클릭
		function addReviewClick(poiNo){
			if('${userId}' == ''){
				alert('로그인이 필요한 서비스입니다.');
				location.href='${pageContext.request.contextPath}/login';
			} else if($('#reviewContent').val().length < 1){ 
				alert('작성하신 리뷰가 없습니다.');
			} else{
				if(confirm('작성하신 내용을 입력합니다.')){
					const review = new FormData();
					var userId = '${userId}';
					review.append('userId', userId);
					review.append('poiNo', poiNo);
					review.append('reviewContent', $('#reviewContent').val());
					if(reviewImgJudgment == true){
						review.append('reviewImg', $('#reviewFile')[0].files[0]);
					}
					
					fetch('${pageContext.request.contextPath}/user/addReview' , {
						method: 'POST',
						body: review,
					}).then((res) =>{
						if(res.status === 200 || res.status === 201){
							alert('입력하신 리뷰가 추가되었습니다.');
							poiOneClick(poiNo);
						}
					}).catch(err => console.error(err));	
				}
			}
		}
		
		
		// 맵에서 poi 클릭시 나오는 infowindow
		function makeClickListener(map, marker, infowindow){
			return function(){
				infowindow.open(map, marker);
			};
		}
		
		// 검색 대상 클릭
		searchDataClick = (poiNo, title, lat, lon) => {	
			panTo(lat, lon);
			poiMarkerCreate(lat, lon, title, poiNo);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/all/modifyPoiSubdata',
				type: 'GET',
				data: {poiNo: poiNo},
				success: function(data){
					//console.log(data);
				}
			});
		}
		
		// 해당하는 좌표로 이동
		function panTo(lat, lon){
			map.setLevel(3);
			var moveLatLon = new kakao.maps.LatLng(lat, lon);
			map.panTo(moveLatLon);
		}
		
		// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
		var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
		    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		    markers = [], // 마커를 담을 배열입니다
		    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

		    
		var categoryMarkers = [];
		var $lclasdc = '';
		var $poiNo = 0;
		
		addPaging = () => {
			$.ajax({
				url: '${pageContext.request.contextPath}/all/categoryData',
				type: 'GET',
				data: {lclasdc: $lclasdc, poiNo: $poiNo},
				success: function(data){
					for(var i=0; i<data.length; i++){
						var lat = data[i].lat;
						var lon = data[i].lon;
						var name = data[i].name;
						var poiNo = data[i].poiNo;
						var telNo = data[i].telNo;
						$poiNo = poiNo;
								
						poiCategoryAction(lat, lon, name, poiNo, $lclasdc);
						poiCategoryList(name, telNo, $lclasdc, lat, lon, poiNo);
					}
				}
			});
		}
		
		// 카테고리 버튼 클릭
		function poiCategoryClick(lclasdc){		
			for(var i=0; i<categoryMarkers.length; i++){
				categoryMarkers[i].setMap(null);
			}
			categoryMarkers = [];
			$('#categoryListForm').hide();
			
			for(var i=0; i<$('.categoryStyle').length; i++){
				$('.categoryStyle')[i].style.backgroundColor = '#D5D5D5';
			}
			
			if($lclasdc != lclasdc){
				$('#categoryListForm').show();
				$('#categoryListTable').empty();
				$.ajax({
					url: '${pageContext.request.contextPath}/all/categoryData',
					type: 'GET',
					data: {lclasdc: lclasdc, poiNo: 1},
					success: function(data){
						$lclasdc = lclasdc;
						for(var i=0; i<data.length; i++){
							var lat = data[i].lat;
							var lon = data[i].lon;
							var name = data[i].name;
							var poiNo = data[i].poiNo;
							var telNo = data[i].telNo;
							$poiNo = poiNo;
								
							poiCategoryAction(lat, lon, name, poiNo, lclasdc);
							poiCategoryList(name, telNo, lclasdc, lat, lon, poiNo);
						}
					}
				});
			} else{
				$lclasdc = '';
			}
		}
		
		$('#categoryListForm').hide();
		
		poiCategoryList = (name, telNo, lclasdc, lat, lon, poiNo) => {
			if(name.length > 10 ){
				name = name.substr(0,10) + '...';
			}
			if(telNo == ''){
				telNo = '해당 번호 없음';
			}
			categoryListTableTbody = `
				<div style="border: 1px solid #000000; height: 60px; border-radius: 7px; background-color: rgba(255,255,255,0.8)">
					<div>
					<a href="javascript:void(0);" onClick="categoryListClick('\${lat}\', '\${lon}\', '\${poiNo}\');" style="color: #000000;">
						\${name}\
					</a>
					</div>
					<div style="color: #A6A6A6">
						\${telNo}\
					</div>
				</div>
			`;
			$('#categoryListTable').append(categoryListTableTbody);
			
			$('#categoryListTitle').text(lclasdc + ' 의 검색결과');
		}
		
		categoryListClick = (lat, lon, poiNo) => {
			panTo(lat, lon);
			poiOneClick(poiNo)
		}
		
		var overlay = {};
		poiCategoryAction = (lat, lon, name, poiNo, lclasdc) => {
			var latLng = new kakao.maps.LatLng(lat, lon);
			var marker = {};
			
			if(lclasdc == '교육/보건'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: educationImage,
					map: map
			    });
			   $('#education')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '레저/관광/예술'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: tourismImage,
					map: map
			    });
			    $('#tourism')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '시설물'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: facilityImage,
					map: map
			    });
			    $('#facility')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '산업'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: industryImage,
					map: map
			    });
			    $('#industry')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '선형지형지물'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: terrainImage,
					map: map
			    });
			    $('#terrainy')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '숙박/음식'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: lodgmentImage,
					map: map
			    });
			    $('#lodgment')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '공공/환경'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: EnvironmentImage,
					map: map
			    });
			    $('#Environment')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '이벤트'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: eventImage,
					map: map
			    });
			    $('#events')[0].style.backgroundColor = '#A6A6A6';
			} else if(lclasdc == '행정'){
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: administrationImage,
					map: map
			    });
			    $('#administration')[0].style.backgroundColor = '#A6A6A6';
			} else{
			    marker = new kakao.maps.Marker({
			        position: latLng,
					image: dwellingImage,
					map: map
			    });
			    $('#dwelling')[0].style.backgroundColor = '#A6A6A6';
			}
			
			categoryMarkers.push(marker);
			
			var iwContent = `<div style="padding: 5px;"><a href="javascript:void(0)" onclick="poiOneClick(\${poiNo}\);">\${name}\</a></div>`,
			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
					
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});
					
			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
		}
		
		var markers = [];
		var $lat = '';
		var $lon = '';
		var $name = '';
		
		// 마커 생성
		function poiMarkerCreate(lat, lon, name, poiNo){
			$lat = lat;
			$lon = lon;
			$name = name;
			closeOverlay();
			setMarkers(null);
		
			var lating = new kakao.maps.LatLng(lat, lon);
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        position: lating, // 마커를 표시할 위치
		        image : markerImage // 마커 이미지 
		    });
		    
		    marker.setMap(map);
		    markers.push(marker);
		    
		    
		    $.ajax({
		    	url: '${pageContext.request.contextPath}/all/getPoiSubDataOneByImg',
		    	type: 'GET',
		    	data: {poiNo: poiNo},
		    	dataType: 'JSON',
		    	success: function(data){
				    var poiImg = 'default.jpg';
				    var poiContent = '설명 없음';
		    		if(data.poiSubData != null){
			    		poiImg = data.poiSubData.poiImg;
			    		poiContent = data.poiSubData.poiContent;		    		
						var iwContent = `
							<div class="wrap">
								<div class="info">
									<div class="title">
										<a href="javascript:void(0);" onClick="poiOneClick(\${poiNo}\)" style="text-decoration:none">\${name}\</a>					
										<div class="close" onclick="closeOverlay()" title="닫기"></div>
									</div>
									<div class="body">
										<div class="img">
											<img src="${pageContext.request.contextPath}/images/\${poiImg}\" width="73" height="70">
										</div>
										<div class="desc">
											<div class="ellipsis jibun" style="width:150px;">
												\${poiContent}\
											</div>
										</div>
									</div>
								</div>
							</div>
						`,
			
						iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
						    
						// 인포윈도우를 생성합니다
						overlay = new kakao.maps.CustomOverlay({
						    content : iwContent,
						    position: marker.getPosition()
						});
						
						overlay.setMap(map);
								
						// 마커에 클릭이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'click', function(){
							overlay.setMap(map);
						});
		    		}
		    	}
		    });
		    
		}

		closeOverlay = () => {
			if(overlay.Pc != null){
				overlay.setMap(null);
			}
		}
		
		function setMarkers(map) {
		    for (var i = 0; i < markers.length; i++) {
		        markers[i].setMap(map);
		    }            
		}
		
		var $addStart = 0;
		
		locationMarker = () => {
			$addStart = 1;
		}
		
		// 추가버튼 클릭
		function addPoi(){
			if('${userId}' != 'admin'){
				alert('접근 권한이 없습니다');
			} else{
				$('#poiList').hide();
				$('#searchList').hide();
				$('#categoryList').hide();
				$('#btnList').hide();
				
				var lclasdcList = '';
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/addLclasdc',
					type: 'GET',
					success: function(data){
						for(var i=0; i<data.length; i++){
							lclasdcList += `<option value="\${data[i].lclasdc}\">\${data[i].lclasdc}\</option>`;
	
						}
						var addForm = `
							<div>
								<div style="overflow-x:hidden; overflow-y:auto; height:800px; margin-bottom:12px; clear:left;">
									<span class="small text-danger" style="margin-bottom:5px;">선택항목을 제외하고 필수 입력 항목입니다.</span>
									<table id="addForm" class="table">
										<tbody style="paddding:10px">
											<tr>
												<th>Name</th>
												<td><input type="text" name="name" id="name" class="form-control" placeholder="명(이름)을 입력해주세요." onchange="addNameCk();" style="width:80%"></td>
											</tr>
										</tbody>
										<tbody>
											<tr>
												<th rowspan="4">Category</th>
												<td>
													<select id="lclasdc" name="lclasdc" class="form-control" style="width:80%" onchange="changeLclasdc()">
														<option value="">항목을 선택해주세요.</option>
														\${lclasdcList}\						
													</select>
												</td>
											</tr>
											<tr>
												<td>
													<select id="mlsfcdc" name="mlsfcdc" class="form-control" onchange="changeMlsfcdc()" style="width:80%" disabled>
														<option value=""></option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													<select id="sclasdc" name="sclasdc" class="form-control" onchange="changeSclasdc()" style="width:80%" disabled>
														<option value=""></option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													<select id="dclasdc" class="form-control" name="dclasdc" onchange="changeDclasdc()" style="width:80%" disabled>
														<option value=""></option>
													</select>
												</td>
											</tr>
										</tbody>
										<tbody>
											<tr>
												<th rowspan="2">
													<div style="margin-bottom:25px">location</div>
													<button type="button" class="btn btn-outline-secondary btn-sm" onClick="locationMarker();">선택</button>
												</th>
												<td><input id="addLat" class="form-control" name="lat" style="width:80%;" type="text" readonly></td>
											</tr>
											<tr>
												<td><input id="addLng" class="form-control" name="lon" style="width:80%;" type="text" readonly></td>
											</tr>
										</tbody>
										<tbody>
											<tr>
												<th>Phone<br><span class="small text-secondary">(선택항목)</span></th>
												<td><input type="text" class="form-control form-control" name="telNo" id="telNo" placeholder="연락처를 입력해주세요." style="width:80%" onchange="addTelNoCk();"></td>
											</tr>
											<tr>
												<th>Content<br><span class="small text-secondary">(선택항목)</span></th>
												<td><textarea name="poiContent" class="form-control form-control" id="poiContent" placeholder="더 추가 할 내용을 입력해주세요." style="width:80%"></textarea></td>
											</tr>
											<tr>
												<th>Image<br><span class="small text-secondary">(선택항목)</span></th>
												<td>
													<img src="${pageContext.request.contextPath}/images/default.jpg" id="preview" style="width:170px; height:200px;"/>
													<input type="file" id="imgSelector" onchange="imgSelector()" style="margin-top: 5px;"/>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div style="float:left;">
									<a href="${pageContext.request.contextPath}/all/index" class="btn btn-secondary">돌아가기</a>
								</div>
								<div class="text-right">
									<button type="button" class="btn btn-secondary" onclick="addPoiForm();">추가</button>
								</div>
							</div>
						`;
						$('#leftData').append(addForm);
					}
				});
			}
		}
		
		var nameJudgment = false;
		var categoryJudgment = false;
		var locationJudgment = false;
		var phoneJudgment = true;
		
		function addNameCk(){
			if($('#name').val().length > 0){
				$('#name')[0].style.border="3px solid #B2CCFF";
				nameJudgment = true;
			} else{				
				$('#name')[0].style.border="3px solid #F15F5F";
				nameJudgment = false;
			}
		}
		
		
		function addPoiForm(){
			if(nameJudgment == true && categoryJudgment == true && locationJudgment == true && phoneJudgment == true){
				if(confirm('입력하신 내용을 추가하시겠습니까')){
					const poiForm = new FormData();
					poiForm.append('name', $('#name').val());
					poiForm.append('lclas', $('#lclasdc').val());
					poiForm.append('mlsfc', $('#mlsfcdc').val());
					poiForm.append('sclas', $('#sclasdc').val());
					poiForm.append('dclas', $('#dclasdc').val());
					poiForm.append('lat', $('#addLat').val());
					poiForm.append('lon', $('#addLng').val());
					poiForm.append('telNo', $('#telNo').val());
					poiForm.append('poiContent', $('#poiContent').val());
					if(poiImgJudgment == true){
						poiForm.append('poiImg', $('#imgSelector')[0].files[0]);				
					}
					
					fetch('${pageContext.request.contextPath}/admin/addPoi', {
						method: 'POST', 
						body: poiForm, 
					}).then((res) => {
						if (res.status === 200 || res.status === 201) {
							//console.log('success');
							alert('입력하신 데이터가 추가되었습니다');
							location.href='${pageContext.request.contextPath}/all/index';
						}
					}).catch(err => console.error(err));
				}
			} else{
				alert('폼 입력란을 다시 한번 확인 해주세요.');
			}
			
		}
		
		function changeLclasdc(){
			$('#mlsfcdc').empty();
			$('#mlsfcdc')[0].style.border = '';
			$('#sclasdc').empty();
			$('#sclasdc').attr('disabled', true);
			$('#dclasdc').empty();
			$('#dclasdc')[0].style.border = '';
			var defaultMlsfcdc = '<option value="">항목을 선택해주세요.</option>';
			$('#mlsfcdc').attr('disabled', false);
			$('#mlsfcdc').append(defaultMlsfcdc);
			var lclasdc = $('#lclasdc').val();
			
			if(lclasdc != ''){
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/addMlsfcdc',
					type: 'GET',
					data: {lclasdc: lclasdc},
					success: function(data){
						for(var i=0; i<data.length; i++){
							var mlsfcdcList = `
								<option value="\${data[i].mlsfcdc}\">\${data[i].mlsfcdc}\</option>
							`;					
							
							$('#mlsfcdc').append(mlsfcdcList);
						}
						$('#lclasdc')[0].style.border = '3px solid #B2CCFF';
					}
				});
			} else{
				$('#lclasdc')[0].style.border = '3px solid #F15F5F';
				categoryJudgment = false;
				$('#mlsfcdc').empty();
				$('#sclasdc').empty();
				$('#dclasdc').empty();
				$('#mlsfcdc').attr('disabled', true);
				$('#sclasdc').attr('disabled', true);
				$('#dclasdc').attr('disabled', true);
			}
		}
		
		function changeMlsfcdc(){
			$('#sclasdc').empty();
			$('#sclasdc')[0].style.border = '';
			$('#dclasdc').empty();
			$('#dclasdc')[0].style.border = '';
			var defaultSclasdc = '<option value="">항목을 선택해주세요.</option>';
			$('#sclasdc').attr('disabled', false);
			$('#sclasdc').append(defaultSclasdc);
			var mlsfcdc = $('#mlsfcdc').val();
			
			if(mlsfcdc != ''){
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/addSclasdc',
					type: 'GET',
					data: {mlsfcdc: mlsfcdc},
					success: function(data){
						for(var i=0; i<data.length; i++){
							var sclasdcList = `
								<option value="\${data[i].sclasdc}\">\${data[i].sclasdc}\</option>
							`;
							
							$('#sclasdc').append(sclasdcList);
						}
						$('#mlsfcdc')[0].style.border = '3px solid #B2CCFF';
					}
				});
			} else{
				$('#mlsfcdc')[0].style.border = '3px solid #F15F5F';
				categoryJudgment = false;
				$('#sclasdc').empty();
				$('#dclasdc').empty();
				$('#sclasdc').attr('disabled', true);
				$('#dclasdc').attr('disabled', true);
			}
		}

		function changeSclasdc(){
			$('#dclasdc').empty();
			$('#dclasdc')[0].style.border = '';
			var defaultDclasdc = '<option value="">항목을 선택해주세요.</option>';
			$('#dclasdc').attr('disabled', false);
			$('#dclasdc').append(defaultDclasdc);
			var sclasdc = $('#sclasdc').val();
			
			if(sclasdc != ''){
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/addDclasdc',
					type: 'GET',
					data: {sclasdc: sclasdc},
					success: function(data){
						//console.log(data);
						if(data[0].dclasdc != ''){
							for(var i=0; i<data.length; i++){
								var dclasdcList = `
									<option value="\${data[i].dclasdc}\-\${data[i].bclasdc}\">\${data[i].dclasdc}\-\${data[i].bclasdc}\</option>
								`;
								
								$('#dclasdc').append(dclasdcList);				
							}
						} else{
							$('#dclasdc').empty();
							$('#dclasdc').attr('disabled', true);
							var nullDclasdc = '<option value=""></option>'
							$('#dclasdc').append(nullDclasdc);
							categoryJudgment = true;
						}
						$('#sclasdc')[0].style.border = '3px solid #B2CCFF';
					}
				});
			} else{
				$('#sclasdc')[0].style.border = '3px solid #F15F5F'
				categoryJudgment = false;
				$('#dclasdc').empty();
				$('#dclasdc').attr('disabled', true);
			}
		}
		
		function changeDclasdc(){
			var dclasdc = $('#dclasdc').val();
			if(dclasdc != ''){
				$('#dclasdc')[0].style.border = '3px solid #B2CCFF';
				categoryJudgment = true;
			} else{
				$('#dclasdc')[0].style.border = '3px solid #F15F5F';
				categoryJudgment = false;
			}
		}
		
		function addTelNoCk(){
			//console.log('check');
			var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
			
			if(regExp.test($('#telNo').val())){
				phoneJudgment = true;
				$('#telNo')[0].style.border="3px solid #B2CCFF";
			} else if($('#telNo').val().length < 1){
				phoneJudgment = true;
				$('#telNo')[0].style.border="";
			}
			
			else {
				phoneJudgment = false;
				$('#telNo')[0].style.border="3px solid #F15F5F";
			} 
		}
		
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			if($addStart == 1){
				var latlng = mouseEvent.latLng; 
				    
				// 마커 위치를 클릭한 위치로 옮깁니다
				addMarker.setPosition(latlng);
				
				var getLat = Math.round(latlng.getLat() * 1000000) / 1000000;
				var getLng = Math.round(latlng.getLng() * 1000000) / 1000000;
				    
				$('#addLat').val(getLat);
				$('#addLng').val(getLng);       
				addMarker.setMap(map);
				
				$('#addLat')[0].style.border = '3px solid #B2CCFF';
				$('#addLng')[0].style.border = '3px solid #B2CCFF';
				locationJudgment = true;
			} else if(oneClickCk == 1){
				$('#poiOneData').hide();
				oneClickCk = 0;
			} else{
				locationJudgment = false;
			}
		});
		
		// 이미지에 대한 제약조건 명시 (수정)
		function imgSelectorByModify(){
            ext = $('#imgSelectorByModify').val().split('.').pop().toLowerCase(); //확장자
            //배열에 추출한 확장자가 존재하는지 체크
            if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'jfif']) == -1) {
               alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg, jfif 만 업로드 가능)');
               $('#imgSelectorByModify').val('');
            } else {
            	setImageFromFile($('#imgSelectorByModify')[0], '#previewByModify');
            }
		}		
		
		var reviewImgJudgment = false;
		
		// 이미지에 대한 제약조건 명시 (리뷰)
		function imgSelectorOnly(){
            ext = $('#reviewFile').val().split('.').pop().toLowerCase(); //확장자
            //배열에 추출한 확장자가 존재하는지 체크
            if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'jfif']) == -1) {
               alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg, jfif 만 업로드 가능)');
               $('#reviewFile').val('');
               reviewImgJudgment = false;
            } else{
            	reviewImgJudgment = true;
            }
		}		
		var poiImgJudgment = false;
		
		// 이미지에 대한 제약조건 명시 (추가)
		function imgSelector(){
            ext = $('#imgSelector').val().split('.').pop().toLowerCase(); //확장자
            //배열에 추출한 확장자가 존재하는지 체크
            if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'jfif']) == -1) {
               alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg, jfif 만 업로드 가능)');
               $('#imgSelector').val('');
            } else {
            	setImageFromFile($('#imgSelector')[0], '#preview');
            	poiImgJudgment = true;
            }
		}		
		
		// 이미지 미리보기에 대한 함수 정의
		function setImageFromFile(input, expression) {
			
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $(expression).attr('src', e.target.result);
		        }
		        reader.readAsDataURL(input.files[0]);
		    }
		}
		
		function backOneData(poiNo){
			poiOneClick(poiNo);
		}
	</script>
</body>

</html>