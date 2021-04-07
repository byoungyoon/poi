var table = {};

dataTableDefault = () => {
	table = new Tabulator("#dataTable", {
		height: "550px",
		layout: "fitColumns",
		ajaxURL: contextPath + "/admin/getPoi",
		pagination: 'local',
		paginationSize: 20,
		selectable: true,
		selectableRangeMode: "click",
		placeholder: "No Data Set",
		rowClick: function(e, row) {
			var poiNo = row.getData().poiNo;

			$.ajax({
				url: contextPath + '/admin/getPoiDataByAdmin',
				type: 'GET',
				data: { poiNo: poiNo },
				success: function(data) {
					//console.log(data);

					var poiPhone = '';
					if (data[0].telNo == '') {
						poiPhone = '분류 없음';
					} else {
						poiPhone = data[0].telNo;
					}

					var location = `
								<table class="table">
									<tr>
										<th>name</th>
										<td>${data[0].name}</td>
									</tr>
									<tr>
										<th>phone</th>
										<td>${poiPhone}</td>
									</tr>
									<tr>
										<th>lon</th>
										<td>${data[0].lon}</td>
									</tr>
									<tr>
										<th>lat</th>
										<td>${data[0].lat}</td>
									</tr>
								</table>
							`;

					$('#location').empty();
					$('#location').append(location);

					var categoryDclas = '';
					console.log(data[0].dclas);
					console.log(data[0]);
					if (data[0].dclas == '') {
						categoryDclas = '분류 없음';
					} else {
						categoryDclas = data[0].dclas;
					}


					var poiCategory = `
								<table class="table">
									<tr>
										<th>lcals</th>
										<td>${data[0].lclas}</td>
									</tr>
									<tr>
										<th>mlsfc</th>
										<td>${data[0].mlsfc}</td>
									</tr>
									<tr>
										<th>sclas</th>
										<td>${data[0].sclas}</td>
									</tr>
									<tr>
										<th>dclas</th>
										<td>${categoryDclas}</td>
									</tr>
								</table>
							`;

					$('#poiCategory').empty();
					$('#poiCategory').append(poiCategory);

					var poiImg = '';
					var poiContent = '';
					if (data[0].poiContent != '') {
						poiContent = data[0].poiContent;
					} else {
						poiContent = '내용 없음';
					}
					if (data[0].poiSubdata != null) {
						poiImg = data[0].poiSubdata.poiImg;
					} else {
						poiImg = 'default.jpg';
						poiContent = '내용 없음';
					}


					var subdata = `
								<table class="table text-center">
									<tr>
										<th>사진</th>
										<td><img src="${contextPath}/images/${poiImg}" width="100" /></tD>
									</tr>
									<tr>
										<th>추가 설명</th>
										<td>${poiContent}</tD>
									</tr>
								</table>
							`;

					$('#subdata').empty();
					$('#subdata').append(subdata);
				}
			});
		},
		columns: [
			{ title: "name", field: "name" },
			{ title: "poi_category_code", field: "poiCategoryCode" },
			{ title: "lclas", field: "lclas" },
			{ title: "mlsfc", field: "mlsfc" },
			{ title: "lat", field: "lat" },
			{ title: "lon", field: "lon" },
			{ title: "poiNo", field: "poiNo", visible: false }
		]
	});
}

// 테이블 검색
nameChange = () => {
	//console.log('check');
	table.setFilter('name', 'like', $('#name').val());
}