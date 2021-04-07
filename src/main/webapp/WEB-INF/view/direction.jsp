<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>poi</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://unpkg.com/tabulator-tables@4.9.3/dist/css/tabulator.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleForm.css">
<style>
	#leftData{
		float: left; 
		height: 970px; 
		width: 400px; 
		padding:10px; 
		background-color: #D5D5D5;
		border: 2px solid #bcbcbc;
		border-radius: 15px;
	}
	
	#directionTable th{
		width: 40%;
		vertical-align: middle;
	}
	
	#routeSubdataTable th{
		width: 40%;
	}
	#routeSubdataTable td{
		vertical-align: middle;
	}
	#dataTable{
		width: 100%;
		table-layout: fixed;
	}
	
	#dataTable tbody{
		border-top: 1px solid #bcbcbc;
		border-bottom: 1px solid #bcbcbc;
	}	
	#dataTable th{
		width: 55%;
		vertical-align: middle;
	}	
	#dataTable td{
		width: 45%;
		text-align: center;
		height: 40px;
	}	
</style>
</head>
<body>
	<div>
		<div id="leftData">
			<div>
				<div style="float: left">
					<h1>POI</h1>
				</div>
				<div class="text-right pad-10">
					<a href="${pageContext.request.contextPath}/all/index"
						class="btn btn-secondary btn-sm">INDEX</a>
					<button type="button" class="btn btn-secondary btn-sm" disabled>DIRECTION</button>
				</div>
				<div id="searchForm">
					<div class="clear">
						<input type="text" id="inputSearch1"
							class="form-control form-control" placeholder="출발지를 입력해주세요"
							onChange="btnSearch1();")>
					</div>
					<div id="addWayPoint"></div>
					<div style="margin-top: 8px">
						<input type="text" id="inputSearch2"
							class="form-control form-control" placeholder="도착지를 입력해주세요"
							onChange="btnSearch2();">
					</div>
					<div style="margin-top: 8px; border-bottom: 1px solid #bcbcbc;">
						<button type="button" id="btnDirection"
							class="btn btn-secondary btn-block" style="width: 80%; float: left">검색</button>
						<a href="javascript:void(0);" onclick="addWayPointForm();"
							style="color: #4C4C4C"><i class='fas fa-plus'
							style='font-size: 36px; margin-bottom: 12px; margin-left: 25px'></i></a>
					</div>
				</div>
			</div>
			<c:if test="${routeList != null}">
				<div id="oneRouteForm" style="margin-bottom: 12px">
					<div class="font-weight-bold">저장한 경로</div>
					<div id="defaultDataForm" style="overflow: auto; height: 640px">
						<table id="routeSubdataTable" class="table table">
							<c:forEach var="r" items="${routeList}">
								<tbody>
									<tr>
										<th rowspan="2"><a href="javascript:void(0)"
											onclick="oneRouteClick('${r.routeNo}');"><img
												src="${r.routeImg}" width="170" height="170"></a></th>
										<td colspan="2">${r.routeTitle}</td>
									</tr>
									<tr>
										<td>${r.routeLength}Km</td>
										<td>${r.routeTime}분<br> 미만</td>
									</tr>
								</tbody>
							</c:forEach>
						</table>
					</div>
				</div>
			</c:if>
			<div id="dataTableForm">
				<div id="dataTableDiv" style="overflow:auto; height:550px">
					<span class="font-weight-bold" id="dataTableTitle"></span>
					<table id="dataTable" class="table" style="margin-top: 12px"></table>
				</div>
				<div id="directionList"
					style="margin-top: 12px; width: 100%; height: 600px; overflow: auto;">
					<table id="directionTable" class="table table"></table>
				</div>
				<div id="directionSynthesis" style="margin-bottom: 20px;"></div>
				<div id="oneRouteList" style="overflow: auto; height: 700px"></div>
			</div>
			<div id="addDirectionForm"></div>
			<div id="btnOption" class="text-right"
				style="padding: 12px; border-top: 1px solid #bcbcbc;">
				<div style="float: left; clear:left">
					<a href="${pageContext.request.contextPath}/all/direction"
						class="btn btn-info">처음으로</a>
				</div>
				<c:if test="${userId == null}">
					<a href="${pageContext.request.contextPath}/all/login"
						class="btn btn-info">로그인</a>
				</c:if>
				<c:if test="${userId != null}">
					<a href="${pageContext.request.contextPath}/logout"
						class="btn btn-info">로그아웃</a>
				</c:if>
			</div>
		</div>
		<div>
			<div id="mapData"
				style="border-left: 2px solid #bcbcbc;">
				<div id="map" style="height: 970px;"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ee89d92102b5b72b2c9f6fa2ea091a7"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript"
		src="https://unpkg.com/tabulator-tables@4.9.3/dist/js/tabulator.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js'
		crossorigin='anonymous'></script>
	<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.48327, 127.04445), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
			
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
		
		var positions = [];
		
		var imageSize = new kakao.maps.Size(12, 17); 
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png'; 
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		
		var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png'; // 출발 마커이미지의 주소입니다    
		var startSize = new kakao.maps.Size(50, 45); // 출발 마커이미지의 크기입니다 
		var startImage = new kakao.maps.MarkerImage(startSrc, startSize);
		
		var arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png'; // 도착 마커이미지 주소입니다    
		var arriveSize = new kakao.maps.Size(50, 45); // 도착 마커이미지의 크기입니다 
		var arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize);
		
		var wayPoint1Src = 'https://i.imgur.com/mwEffij.png'; // 도착 마커이미지 주소입니다    
		var wayPoint1Size = new kakao.maps.Size(50, 45); // 도착 마커이미지의 크기입니다 
		var wayPoint1Image = new kakao.maps.MarkerImage(wayPoint1Src, wayPoint1Size);
		
		var wayPoint2Src = 'https://i.imgur.com/NGGt41R.png'; // 도착 마커이미지 주소입니다    
		var wayPoint2Size = new kakao.maps.Size(50, 45); // 도착 마커이미지의 크기입니다 
		var wayPoint2Image = new kakao.maps.MarkerImage(wayPoint2Src, wayPoint2Size);
		
		var wayPoint3Src = 'https://i.imgur.com/hSZvhCB.png'; // 도착 마커이미지 주소입니다    
		var wayPoint3Size = new kakao.maps.Size(50, 45); // 도착 마커이미지의 크기입니다 
		var wayPoint3Image = new kakao.maps.MarkerImage(wayPoint3Src, wayPoint3Size);
		
		var linePath = [];
		
		// 지도에 표시할 선을 생성합니다
		var polyline = {};
		var markers = [];
		var overlays = [];
		
		var bounds = new kakao.maps.LatLngBounds();    
		var points = [];
		var staticPoints = [];
		
		$('#addDirectionForm').hide();
		$('#dataTableDiv').hide();
		
		// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'zoom_changed', function() {        
		    // 지도의 현재 레벨을 얻어옵니다
		    var level = map.getLevel();
		    
		    if(level > 8){
		    	for(var i=0; i<markers.length; i++){
		    		markers[i].setMap(null);
		    		overlays[i].setMap(null);
		    	}
		   	} else if(level <= 8){
				for(var i=0; i<markers.length; i++){
		    		markers[i].setMap(map);
		    		overlays[i].setMap(map);
		    	}
		   	}
		});
		
		var $imgSrc = '';
		
		var directionCk = false;
		var $distanceSynthesis = '';
		var $durationSynthesis = '';
		var $level = '';
		var $startName = '';
		var $goalName = '';
		var $wayPointName1 = '';
		var $wayPointName2 = '';
		var $wayPointName3 = '';
		var $startPoiNo = '';
		var $goalPoiNo = '';
		var $wayPoint1PoiNo = 0;
		var $wayPoint2PoiNo = 0;
		var $wayPoint3PoiNo = 0;
		
		$('#directionList').hide();
		$('#oneRouteList').hide();
		
		$('#btnDirection').click(function(){
			$('#directionList').show();
			if($start == ''){
				alert('출발지를 검색해주세요.');
			} else if($goal == ''){
				alert('도착지를 검색해주세요.');
			} else{
				$.ajax({
					url: '${pageContext.request.contextPath}/all/test',
					type: 'GET',
					data: {start: $start, goal: $goal, wayPoint1: $wayPoint1, wayPoint2: $wayPoint2, wayPoint3: $wayPoint3},
					dataType: 'JSON',
					success: function(data){
						$('#directionTable').empty();
						$('#directionSynthesis').empty();
						//console.log(data);
						directionCk = true;
						
						if(markers.length != 0){
							for(var i=0; i<markers.length; i++){
								markers[i].setMap(null);
								overlays[i].setMap(null);
							}
							markers = [];
							overlays= [];
						}
						
						for(var i=0; i<data.route.traoptimal[0].guide.length; i++){
							var pathLat = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i].pointIndex][1];
							var pathLon = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i].pointIndex][0];
							if(i != data.route.traoptimal[0].guide.length - 1){
							
								var lating = new kakao.maps.LatLng(pathLat, pathLon);
							    // 마커를 생성합니다
							    var marker = new kakao.maps.Marker({
							        position: lating, // 마커를 표시할 위치
							        image: markerImage
							    });
							    
							    marker.setMap(map);
							    markers.push(marker);
							    
								// 마커에 표시할 인포윈도우를 생성합니다
								var overlay = new kakao.maps.CustomOverlay({
							        content: `<div style="margin-bottom: 50px; font-weight: bolder;">
							        		  	\${i+1}\
							        		  </div>`, 
							        position: marker.getPosition()
							    });
							    
							    // 마커 위의 글씨 표시
								overlay.setMap(map);
								overlays.push(overlay);
							}
							staticPoints.push(pathLat + ',' + pathLon);
							
							// 경로의 걸리는 시간과 거리를 정리 (distance (m -> km), duration (millis -> min))
							var distance = data.route.traoptimal[0].guide[i].distance / 1000;
							var duration = (data.route.traoptimal[0].guide[i].duration + 60000) / 1000 / 60;
							duration = Math.floor(duration);
							
							// detail path 설정
							var detailPathLat = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i].pointIndex][0];
							var detailPathLon = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i].pointIndex][1];
							
							var lastDetailPathLat = '';
							var lastDetailPathLon = '';
							var addCssForm = '';
							var addCssForm = '';
							
							if(i == 0){
								lastDetailPathLat = data.route.traoptimal[0].summary.start.location[0];
								lastDetailPathLon = data.route.traoptimal[0].summary.start.location[1];
								addCssForm = '출발 -> ' + (i+1);
							} else if(i == data.route.traoptimal[0].guide.length - 1){
								lastDetailPathLat = data.route.traoptimal[0].summary.goal.location[0];
								lastDetailPathLon = data.route.traoptimal[0].summary.goal.location[1];
								addCssForm = i + ' -> 도착';
							} else{
								lastDetailPathLat = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i-1].pointIndex][0];
								lastDetailPathLon = data.route.traoptimal[0].path[data.route.traoptimal[0].guide[i-1].pointIndex][1];
								addCssForm = i + ' -> ' + (i+1);
							}
							
							// 경로에 대한 길이나 시간을 append
							var directionTable = '';
							if(data.route.traoptimal[0].guide[i].instructions == '경유지'){
								directionTable = `
									<tbody>
										<tr>
											<th rowspan="2"><a class="btn btn-success btn-block" style="padding:20px;" href="javascript:void(0);" onclick="detailDirection(\${detailPathLat}\, \${detailPathLon}\, \${lastDetailPathLat}\, \${lastDetailPathLon}\);">\${addCssForm}\</a></th>
											<td>\${distance}\Km</td>
											<td>\${duration}\분 미만</td>
										</tr>
										<tr>
											<td colspan="2">\${data.route.traoptimal[0].guide[i].instructions}\</td>
										</tr>
									</body>
								`;
							} else{
								directionTable = `
									<tbody>
										<tr>
											<th rowspan="2"><a class="btn btn-light btn-block" style="padding:20px;" href="javascript:void(0);" onclick="detailDirection(\${detailPathLat}\, \${detailPathLon}\, \${lastDetailPathLat}\, \${lastDetailPathLon}\);">\${addCssForm}\</a></th>
											<td>\${distance}\Km</td>
											<td>\${duration}\분 미만</td>
										</tr>
										<tr>
											<td colspan="2">\${data.route.traoptimal[0].guide[i].instructions}\</td>
										</tr>
									</body>
								`;
							}
							
							$('#directionTable').append(directionTable);
						}
						
						if(linePath.length != 0){
							linePath = [];
							polyline.setMap(null);
						}
						
						// 경로에 따른 좌표를 linePath에 push
						for(var i=0; i<data.route.traoptimal[0].path.length; i++){
							var pathLat = data.route.traoptimal[0].path[i][1];
							var pathLon = data.route.traoptimal[0].path[i][0];
							
						    var lonLat = new kakao.maps.LatLng(pathLat, pathLon);
						    linePath.push(lonLat);
						}						
						
						// 선에 대한 옵션
						polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 7, // 선의 두께 입니다
						    strokeColor: '#db4040', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});
						
						// 경로 선 그리기
						polyline.setMap(map); 
						
						var distanceSynthesis = data.route.traoptimal[0].summary.distance / 1000;
						$distanceSynthesis = distanceSynthesis;
						var durationSynthesis = (data.route.traoptimal[0].summary.duration + 60000) / 1000 / 60;
						durationSynthesis = Math.floor(durationSynthesis);
						$durationSynthesis = durationSynthesis;
						
						var directionSynthesis = `
							<div style="float:left; margin-top: 5px;">
								<div>
									전체 경로 길이 : \${distanceSynthesis}\Km
								</div>
								<div>
									전체 시간 : \${durationSynthesis}\분 미만
								</div>
							</div>
							<div class="text-right" style="margin-top: 5px;">
								<button type="button" class="btn btn-secondary" onclick="addDircetion();">저장</button>
							</div>
						`;
						
						$('#directionSynthesis').append(directionSynthesis);
						
						var startPosition = new kakao.maps.LatLng(data.route.traoptimal[0].summary.start.location[1], data.route.traoptimal[0].summary.start.location[0]);
						// 출발 마커를 생성합니다
						var startMarker = new kakao.maps.Marker({
						    map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
						    position: startPosition,
						    image: startImage // 출발 마커이미지를 설정합니다
						});
						
						var arrivePosition = new kakao.maps.LatLng(data.route.traoptimal[0].summary.goal.location[1], data.route.traoptimal[0].summary.goal.location[0]);    
						// 도착 마커를 생성합니다 
						var arriveMarker = new kakao.maps.Marker({  
						    map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
						    position: arrivePosition,
						    image: arriveImage // 도착 마커이미지를 설정합니다
						});
						
						points.push(startPosition);
						points.push(arrivePosition);
						
						if($wayPoint1 != ''){
							var wayPointPosition = new kakao.maps.LatLng(data.route.traoptimal[0].summary.waypoints[0].location[1], data.route.traoptimal[0].summary.waypoints[0].location[0]);    
							// 경유지1 마커를 생성합니다 
							var wayPointMarker = new kakao.maps.Marker({  
							    map: map, // 경유지1 마커가 지도 위에 표시되도록 설정합니다
							    position: wayPointPosition,
							    image: wayPoint1Image // 경유지1 마커이미지를 설정합니다
							});
							points.push(wayPointPosition);
						}
						
						if($wayPoint2 != ''){
							var wayPointPosition = new kakao.maps.LatLng(data.route.traoptimal[0].summary.waypoints[1].location[1], data.route.traoptimal[0].summary.waypoints[1].location[0]);    
							// 경유지2 마커를 생성합니다 
							var wayPointMarker = new kakao.maps.Marker({  
							    map: map, // 경유지2 마커가 지도 위에 표시되도록 설정합니다
							    position: wayPointPosition,
							    image: wayPoint2Image // 경유지2 마커이미지를 설정합니다
							});
							points.push(wayPointPosition);
						}
						
						if($wayPoint3 != ''){
							var wayPointPosition = new kakao.maps.LatLng(data.route.traoptimal[0].summary.waypoints[2].location[1], data.route.traoptimal[0].summary.waypoints[2].location[0]);    
							// 경유지3 마커를 생성합니다 
							var wayPointMarker = new kakao.maps.Marker({  
							    map: map, // 경유지3 마커가 지도 위에 표시되도록 설정합니다
							    position: wayPointPosition,
							    image: wayPoint3Image // 경유지3 마커이미지를 설정합니다
							});
							points.push(wayPointPosition);
						}
						
						for (var i = 0; i < points.length; i++) {
						    bounds.extend(points[i]);
						}
						setBounds();
						
						$level = map.getLevel();
					}
				});
			}
		
		});
		
		// 해당하는 좌표로 이동
		function panTo(lat, lon){
			var moveLatLon = new kakao.maps.LatLng(lat, lon);
			map.panTo(moveLatLon);
		}
		
		// points에 담긴 좌표로 point 시점 변경
		function setBounds() {
		    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
		    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
		    map.setBounds(bounds);
		}
				
		var $start = '';
		var $goal = '';	
		var $wayPoint1 = '';
		var $wayPoint2 = '';
		var $wayPoint3 = '';
		
		// 기본적인 dataTable 폼
		onDataTableForm = (data, type) => {
			$('#dataTable').empty();
			$('#btnOption').show();
			$('#dataTableDiv').show();
			$('#oneRouteForm').hide();
			$('#dataTableForm #oneRouteList').hide();
			var dataTableTbody = '';
			if(data.length == 0){
				dataTableTbody = `
					<tbody>
						<tr>
							<td>해당 검색어 없음</td>
						</tr>
					</tbody>
				`;
			}
			for(var i=0; i<data.length; i++){
				var dclas = '';
				if(data[i].dclas == ''){
					dclas = '<td style="color: #BDBDBD;">분류 없음</td>';
				} else{
					dclas = `<td>\${data[i].dclas}\</td>`;
				}
						
				var telNo = '';
				if(data[i].telNo == ''){
					telNo = '<td style="color: #BDBDBD;">번호 없음</td>';
				} else{
					telNo = `<td>\${data[i].telNo}\</td>`;
				}
						
				var lat = data[i].lat;
				var lon = data[i].lon;
						
 				var title = data[i].name;
			    var poiNo = data[i].poiNo;
						
				dataTableTbody += `
					<tbody>
						<tr>
							<th rowspan="2">
								<button type="button" class="btn btn-outline-dark btn-block" onClick="searchDataClick('\${poiNo}\', '\${title}\', '\${lat}\', '\${lon}\', '\${type}\');" style="padding:12px">
									\${data[i].name}\
								</button>
							</th>
							\${dclas}\
						</tr>
						<tr>
							\${telNo}\
						</tr>
					</tbody>
				`;					
			}
			$('#dataTable').append(dataTableTbody);
		}
		
		searchDataClick = (poiNo, title, lat, lon, type) => {
			if(type == 'start'){
				$start = lon + ',' + lat;
				$startName = title;
				$startPoiNo = poiNo;
				$('#inputSearch1').val($startName);
			} else if(type == 'goal'){
				$goal = lon + ',' + lat;
				$goalName = title;
				$goalPoiNo = poiNo;
				$('#inputSearch2').val($goalName);
			} else if(type == 'wayPoint1'){
				$wayPoint1 = lon + ',' + lat;
				$wayPoint1Name = title;
				$wayPoint1PoiNo = poiNo;
				$('#inputSearchByWayPoint1').val($wayPoint1Name);
			} else if(type == 'wayPoint2'){
				$wayPoint2 = lon + ',' + lat;
				$wayPoint2Name = title;
				$wayPoint2PoiNo = poiNo;
				$('#inputSearchByWayPoint2').val($wayPoint2Name);
			} else if(type == 'wayPoint3'){
				$wayPoint3 = lon + ',' + lat;
				$wayPoint3Name = title;
				$wayPoint3PoiNo = poiNo;
				$('#inputSearchByWayPoint3').val($wayPoint3Name);
			}
		
			$('#dataTableDiv').hide();
		}
		
		// 출발지 찾기 클릭
		btnSearch1 = () =>{
			var type = 'start';
			var searchData = $('#inputSearch1').val();
			$.ajax({
				url: '${pageContext.request.contextPath}/all/searchData',
				type: 'GET',
				data: {searchData: searchData},
				success: function(data){
					onDataTableForm(data, type);
				}
			});
			
			$('#dataTableTitle').text(`출발지 검색 결과 (검색 : \${searchData}\)`);
		}
		
		// 도착지 찾기 클릭
		btnSearch2 = () => {
			var type = 'goal';
			var searchData = $('#inputSearch2').val();
			$.ajax({
				url: '${pageContext.request.contextPath}/all/searchData',
				type: 'GET',
				data: {searchData: searchData},
				success: function(data){
					onDataTableForm(data, type);
				}
			});
			
			$('#dataTableTitle').text(`도착지 검색 결과 (검색 : \${searchData}\)`);
		}
		
		// 경로지 장소 찾기 버튼 클릭
		function wayPointClick(count){
			var type = 'wayPoint' + count;
			//console.log(type);
			var searchData = $('#inputSearchByWayPoint' + count).val();
			$.ajax({
				url: '${pageContext.request.contextPath}/all/searchData',
				type: 'GET',
				data: {searchData: searchData},
				success: function(data){
					onDataTableForm(data, type);
				}
			});
			
			$('#dataTableTitle').text(`경유지 검색 결과 (검색 : \${searchData}\)`);
		}
		
		var wayPointCount = 0;
		
		// 경로지 추가 액션 (최대 3개)
		function addWayPointForm(){
			if(wayPointCount < 3){
				wayPointCount += 1;
				var addWayPointDiv = `
					<div style="margin-top:8px">
						<input 
							type="text" 
							id="inputSearchByWayPoint\${wayPointCount}\" 
							class="form-control form-control" 
							placeholder="경유지를 입력해주세요" 
							onChange="wayPointClick(\${wayPointCount}\)"
						/>
					</div>
				`;
				
				var tableHeight = 640 + (-wayPointCount)*46;
				var tableHeightByOne = 700 + (-wayPointCount)*46;
				var directionListHeight = 600 + (-wayPointCount)*46;

				//console.log(tableHeight);
				
				$('#addWayPoint').append(addWayPointDiv);
				$('#defaultDataForm').css('height', tableHeight + 'px');
				$('#oneRouteList').css('height', tableHeightByOne + 'px');
				$('#directionList').css('height', directionListHeight + 'px');
			} else{
				alert('경유지는 최대 3개까지 가능합니다.');
			}
		}
		
		// 경로 저장 폼
		function addDircetion(){
			if('${userId}' == ''){
				alert('로그인이 필요합니다.');
				location.href='${pageContext.request.contextPath}/all/login';
			} else{
				$('#btnOption').hide();
				$('#searchForm').hide();
				$('#dataTableForm').hide();
				$('#addDirectionForm').show();
				$('#addDirectionForm').empty();
				
				var addDirectionDefaultDiv = `
					<table class="table table" style="vertical-align: middle">
						<tbody>
							<tr>
								<th rowspan="2">start</th>
								<td>name</td>
								<td>\${$startName}\</td>
							</tr>
							<tr>
								<td>location</td>
								<td>\${$start}\</td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th rowspan="2">goal</th>
								<td>name</td>
								<td>\${$goalName}\</td>
							</tr>
							<tr>
								<td>location</td>
								<td>\${$goal}\</td>
							</tr>
						</tbody>
					</table>
				`;
				$('#addDirectionForm').append(addDirectionDefaultDiv);
				
				if($wayPoint1 != ''){
					var addWayPoint1Div = `
						<table class="table table" style="vertical-align: middle">
							<tbody>
								<tr>
									<th rowspan="2">wayPoint1</th>
									<td>name</td>
									<td>\${$wayPoint1Name}\</td>
								</tr>
								<tr>
									<td>location</td>
									<td>\${$wayPoint1}\</td>
								</tr>
							</tbody>
						</table>
					`;
					$('#addDirectionForm').append(addWayPoint1Div);
				}
				if($wayPoint2 != ''){
					var addWayPoint2Div = `
						<table class="table table" style="vertical-align: middle">
							<tbody>
								<tr>
									<th rowspan="2">wayPoint2</th>
									<td>name</td>
									<td>\${$wayPoint2Name}\</td>
								</tr>
								<tr>
									<td>location</td>
									<td>\${$wayPoint2}\</td>
								</tr>
							</tbody>
						</table>
					`;
					$('#addDirectionForm').append(addWayPoint2Div);
				}
				if($wayPoint3 != ''){
					var addWayPoint3Div = `
						<table class="table table" style="vertical-align: middle">
							<tbody>
								<tr>
									<th rowspan="2">wayPoint3</th>
									<td>name</td>
									<td>\${$wayPoint3Name}\</td>
								</tr>
								<tr>
									<td>location</td>
									<td>\${$wayPoint3}\</td>
								</tr>
							</tbody>
						</table>
					`;
					$('#addDirectionForm').append(addWayPoint3Div);
				}
				
				var addDirectionDataDiv = `
					<table class="table table">
						<tbody>
							<tr>
								<th>전체 거리</th>
								<td colspan="2">\${$distanceSynthesis}\Km</td>
							</tr>
							<tr>								
								<th>걸린 시간</th>
								<td colspan="2">\${$durationSynthesis}\분 미만</td>
							</tr>
						</tbody>	
					</table>
				`;

				$('#addDirectionForm').append(addDirectionDataDiv);
				
				var addDirectionFormDiv = `
					<table class="table table">
						<tr>
							<th>제목</th>
							<td><input type="text" id="routeTitle" class="form-control" placehorder="제목을 입력하세요."></td>
						</tr>
						<tr>
							<th>추가정보</th>
							<td><textarea id="routeContent" class="form-control" placehorder="추가하시고 싶은 내용을 입력하세요."></textarea>
						</tr>
					</table>
					<div style="margin-top:5px;">
						<div style="float:left;">
							<button type="button" class="btn btn-info" onclick="backTheDirection();">돌아가기</button>
						</div>
						<div class="text-right">
							<button type="button" class="btn btn-secondary" onclick="addDriectionSubData()">저장</button>
						</div>
					</div>
				`;
				$('#addDirectionForm').append(addDirectionFormDiv);
				
				const staticForm = new FormData();
				staticForm.append('level', $level);
				staticForm.append('start', $start);
				staticForm.append('goal', $goal);
				staticForm.append('wayPoint1', $wayPoint1);
				staticForm.append('wayPoint2', $wayPoint2);
				staticForm.append('wayPoint3', $wayPoint3);
				for(var i=0; i<staticPoints.length; i++){
					staticForm.append('staticPoints', staticPoints[i]);	
				}
						
				fetch('${pageContext.request.contextPath}/user/getDirectionImage', {
					method: 'POST', 
					body: staticForm, 
					type: 'JSON',
				}).then(res=>res.json())
	    		  .then((data)=>{
	    		  		$imgSrc=data.imgSrc
	    		  	});
	    	}
		}
		
		// 경로에서 해당하는 좌표로 이동
		function detailDirection(detailPathLat, detailPathLon, lastDetailPathLat, lastDetailPathLon){
			points = new Array();
			bounds = new kakao.maps.LatLngBounds();   
			
			var lating = new kakao.maps.LatLng(detailPathLon, detailPathLat);
			var lastLating = new kakao.maps.LatLng(lastDetailPathLon, lastDetailPathLat);
			
			
			points.push(lating);
			points.push(lastLating);

			//console.log(points);
			
			for (var i = 0; i < points.length; i++) {
			   bounds.extend(points[i]);
			}
			//console.log(bounds);
			
			setBounds();
		}
		
		// 경로 저장 폼에서 돌아가기
		function backTheDirection(){
			$('#btnOption').show();
			$('#searchForm').show();
			$('#dataTableForm').show();
			$('#addDirectionForm').hide();
		}
		
		// 이미지에 대해서 dataURL로 바꿔주는 함수
		function toDataURL(url, callback) {
		  var xhr = new XMLHttpRequest();
		  xhr.onload = function() {
		    var reader = new FileReader();
		    reader.onloadend = function() {
		      callback(reader.result);
		    }
		    reader.readAsDataURL(xhr.response);
		  };
		  xhr.open('GET', url);
		  xhr.responseType = 'blob';
		  xhr.send();
		}
		
		// 경로 저장 버튼
		function addDriectionSubData(){
			if($('#routeTitle').val().length < 1){
				alert('해당하는 경로를 저장할 제목을 입력해주세요.');
			} else{
				const route = new FormData();
				toDataURL($imgSrc, function(dataURL){
					route.append('routeImg', dataURL);
					route.append('routeTitle', $('#routeTitle').val());
					route.append('routeContent', $('#routeContent').val());
					route.append('routeLength', $distanceSynthesis);
					route.append('routeTime', $durationSynthesis);
					route.append('userId', '${userId}');
					route.append('poiStartNo', $startPoiNo);
					route.append('poiGoalNo', $goalPoiNo);
					route.append('poiWayPoint1No', $wayPoint1PoiNo);
					route.append('poiWayPoint2No', $wayPoint2PoiNo);
					route.append('poiWayPoint3No', $wayPoint3PoiNo);
					
					//console.log(route);
					
					fetch('${pageContext.request.contextPath}/user/addDirectionByRoute', {
						method: 'POST', 
						body: route, 
					}).then((res) => {
						if (res.status === 200 || res.status === 201) {
							alert('해당 경로를 저장하였습니다');
							$('#searchForm').show();
							$('#dataTableForm').show();
							$('#addDirectionForm').hide();
							$('#btnOption').show();
						}
					}).catch(err => console.error(err));
				});
			}
		}
		
		// 경로 자세히보기
		function oneRouteClick(routeNo){
			$('#oneRouteList').empty();
			$('#btnOption').hide();
			$('#oneRouteForm').hide();
			$('#directionList').hide();
			$('#oneRouteList').show();
			$.ajax({
				url: '${pageContext.request.contextPath}/user/getRouteOne',
				type: 'GET',
				data: {routeNo: routeNo},
				success: function(data){
					var routeNameDiv = data.poiStartName;
					if(data.poiWayPoint1Name != null){
						routeNameDiv += ' => ' + data.poiWayPoint1Name;
					}
					if(data.poiWayPoint2Name != null){
						routeNameDiv += ' => ' + data.poiWayPoint2Name;
					}
					if(data.poiWayPoint3Name != null){
						routeNameDiv += ' => ' + data.poiWayPoint3Name;
					}
					routeNameDiv += ' => ' + data.poiGoalName;
					
					var RouteOneForm = `
						<div class="font-weight-bold" style="font-size:25px">
							<input type="text" id="routeTitle" class="form-control" value="\${data.routeTitle}\" readonly>
						</div>
						<div class="font-weight-bold" style="font-size:15px">
							\${routeNameDiv}\
						</div>
						<div style="margin-top:10px">
							<img src="\${data.routeImg}\" height="400" style="max-width:100%;" />
						</div>
						<div>
							<table class="table table text-center">
								<tr>
									<td>총 거리 : \${data.routeLength}\Km</td>
									<td>총 시간 : \${data.routeTime}\분 미만</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea class="form-control" id="routeContent" rows="3" readonly>\${data.routeContent}\</textarea>
									</td>
								</tr>
							</table>
						</div>
						<div id="oneRouteFormByBtn" style="margin-top:5px;">
							<div id="oneRouteFormBydefaultBtn">
								<div style="float:left">
									<button type="button" class="btn btn-info" onclick="backTheDirectionByOneRoute();">돌아가기</button>
								</div>
								<div class="text-right">
									<button type="button" class="btn btn-secondary" onclick="modifyOneRouteForm(\${routeNo}\)">수정</button>
									<button type="button" class="btn btn-secondary" onclick="deleteOneRoute(\${routeNo}\)">삭제</button>
								</div>
							</div>
							<div id="oneRouteFormByModifyBtn">
								<div style="float:left">
									<button type="button" class="btn btn-info" onclick="oneRouteClick(\${routeNo}\)">돌아가기</button>
								</div>
								<div class="text-right">
									<button type="button" class="btn btn-secondary" onclick="modifyOneRoute(\${routeNo}\)">수정</button>
								</div>
							</div>
						</div>
					`;
					
					$('#oneRouteList').append(RouteOneForm);
					$('#oneRouteFormByModifyBtn').hide();
				}
			});
		}
		
		// 경로 자세히 보기에서 돌아가기
		function backTheDirectionByOneRoute(){
			location.href="${pageContext.request.contextPath}/all/direction";
		}
		
		// 경로 자세히 보기 페이지에서 삭제
		function deleteOneRoute(routeNo){
			if(confirm('현재 저장된 경로를 삭제하시겠습니까')){
				$.ajax({
					url: '${pageContext.request.contextPath}/user/deleteRoute',
					type: 'GEt',
					data: {routeNo: routeNo},
					success: function(data){
						alert('삭제되었습니다.');
						location.href='${pageContext.request.contextPath}/all/direction';
					}
				});
			}
		}
		
		// 경로 자세히 보기에서 수정
		function modifyOneRouteForm(routeNo){
			$('#oneRouteFormBydefaultBtn').hide();
			$('#oneRouteFormByModifyBtn').show();
			$('#routeTitle').attr('readonly', false);
			$('#routeContent').attr('readonly', false);
		}
		
		function modifyOneRoute(routeNo){
			if($('#routeTitle').val().length < 1){
				alert('제목을 공백으로 할 수 없습니다.');
			} else{
				if(confirm('작성하신 내용으로 수정하시겠습니까')){
					const route = new FormData();
					route.append('routeNo', routeNo);
					route.append('routeTitle', $('#routeTitle').val());
					route.append('routeContent', $('#routeContent').val());
					
					fetch('${pageContext.request.contextPath}/user/modifyRouteSubData', {
						method: 'POST', 
						body: route, 
					}).then((res) => {
						if (res.status === 200 || res.status === 201) {
							alert('수정되었습니다.');
							oneRouteClick(routeNo);
						}
					}).catch(err => console.error(err));
				}
			}
		}

	</script>
</body>
</html>
