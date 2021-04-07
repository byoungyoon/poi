// 로드뷰 옵션
var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
var roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
$('#roadviewForm').hide();

// 로드뷰 버튼 클릭
function roadViewClick(poiNo) {
	console.log(poiNo);
	$('#poiOneData').hide();
	$('#roadviewForm').show();
	$.ajax({
		url: contextPath + '/all/getRoadView',
		type: 'GET',
		data: { poiNo: poiNo },

		success: function(data) {
			var position = new kakao.maps.LatLng(data.lonAndLat.lat, data.lonAndLat.lon);
			roadviewClient.getNearestPanoId(position, 50, function(panoId) {
				roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
			});
		}
	});
}

// 로드뷰 메뉴에서 돌아기기 클릭
function gotoOneData() {
	$('#poiOneData').show();
	$('#roadviewForm').hide();
}
