// 기본적인 dataTable 폼
onDataTableForm = (data) => {
	$('#dataTable').empty();
	var dataTableTbody = '';
	for (var i = 0; i < data.length; i++) {
		var dclas = '';
		if (data[i].dclas == '') {
			dclas = '<td style="color: #BDBDBD;">분류 없음</td>';
		} else {
			dclas = `<td>${data[i].dclas}</td>`;
		}

		var telNo = '';
		if (data[i].telNo == '') {
			telNo = '<td style="color: #BDBDBD;">번호 없음</td>';
		} else {
			telNo = `<td>${data[i].telNo}</td>`;
		}

		var lat = data[i].lat;
		var lon = data[i].lon;

		var title = data[i].name;
		var poiNo = data[i].poiNo;

		dataTableTbody += `
					<tbody>
						<tr>
							<th rowspan="2">
								<button type="button" class="btn btn-outline-dark btn-block pad-12" onClick="searchDataClick('${poiNo}', '${title}', '${lat}', '${lon}');">
									${data[i].name}
								</button>
							</th>
							${dclas}
						</tr>
						<tr>
							${telNo}
						</tr>
					</tbody>
				`;
	}
	$('#dataTable').append(dataTableTbody);
}

// 검색 순위 top 5
onDefaultTable = () => {
	$.ajax({
		url: contextPath + '/all/getPoiSubDataByCount',
		type: 'GET',
		success: function(data) {
			$('#dataTableTitle').text('검색 순위');
			onDataTableForm(data);
		}
	});
}

// 검색
onChangeBySearch = () => {
	if ($('#searchData').val() == '') {
		onDefaultTable();
	} else {
		$.ajax({
			url: contextPath + '/all/searchData',
			type: 'GET',
			data: { searchData: $('#searchData').val() },
			success: function(data) {
				$('#dataTableTitle').text($('#searchData').val() + ' 의 검색결과 (총 ' + data.length + ' 개)');
				onDataTableForm(data);
			}
		});
	}
}