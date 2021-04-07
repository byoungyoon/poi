
// 달력의 하나의 날짜를 클릭
btnDay = (day) => {
	$('#memoOneTable tbody').empty();
	$('#btnForm').empty();
	$('#defaultForm').hide();
	$('#oneClickForm').show();

	$.ajax({
		url: contextPath + '/admin/getMemoOneByDay',
		type: 'GET',
		data: { year: currentYear, month: currentMonth, day: day },
		success: function(data) {
			//console.log(data);
			var memoOneTableTbody = '';
			var btnForm = '';

			if (data.memo == null) {
				var memoOneTableTbody = `
						<tbody>
							<tr>
								<td colspan="2">${currentYear}-${currentMonth}-${day}에 작성한 메모가 없습니다.</td>
							</tr>
						</tbody>
					`;

				var btnForm = `
						<div class="float-left">
							<button type="button" class="btn btn-info" onClick="memoTableDefault();">돌아가기</button>					
						</div>
						<div class="text-right">
							<button type="button" class="btn btn-secondary" onClick="addMemoForm(${day})">작성</button>						
						</div>
					`;
			} else {
				var memoOneTableTbody = `
						<tbody>
							<tr>
								<td>${data.memo.memoDate}</td>
								<td>
									<textarea rows="4" id="memoContent" class="form-control" readonly>${data.memo.memoContent}</textarea>
								</td>
							</tr>
						</tbody>
					`;

				var btnForm = `
						<div class="float-left">
							<button type="button" class="btn btn-info" onClick="memoTableDefault();">돌아가기</button>					
						</div>
						<div class="text-right">
							<button type="button" class="btn btn-secondary" onClick="removeMemo(${data.memo.memoNo}, ${day});">삭제</button>					
						</div>
					`;
			}

			$('#memoOneTable').append(memoOneTableTbody);
			$('#btnForm').append(btnForm);
		}
	});
}

// 메모 작성
addMemo = (day) => {
	if (confirm('작성하신 메모를 입력하시겠습니까')) {
		if (Number(currentMonth) < 10) {
			currentMonth = '0' + currentMonth;
		}
		if (Number(day) < 10) {
			day = '0' + day;
		}

		var memoDate = currentYear + '-' + currentMonth + '-' + day;
		//console.log(memoDate);
		const memoForm = new FormData();
		memoForm.append('memoDate', memoDate);
		memoForm.append('memoContent', $('#memoContent').val());

		fetch(contextPath + '/admin/addMemo', {
			method: 'POST',
			body: memoForm,
			type: 'JSON',
		}).then((res) => {
			btnDay(day);
			CalendarDefault();
		});
	}
}

// 메모 작성 폼
addMemoForm = (day) => {
	$('#memoOneTable').empty();
	$('#btnForm').empty();

	var memoOneTableTbody = `
			<table class="table table">
				<tr>
					<th>날짜</th>
					<td>${currentYear}-${currentMonth}-${day}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="memoContent" rows="4" class="form-control"></textarea>
					</td>
				</tr>
			</table>
		`;

	var btnForm = `
			<div style="float:left;">
				<button type="button" class="btn btn-info" onClick="btnDay(${day});">돌아가기</button>					
			</div>
			<div class="text-right">
				<button type="button" class="btn btn-secondary" onClick="addMemo(${day})">작성</button>					
			</div>
		`;

	$('#memoOneTable').append(memoOneTableTbody);
	$('#btnForm').append(btnForm);
}

// 메모 삭제
removeMemo = (memoNo, day) => {
	if (confirm('정말 해당 메모를 삭제하시겠습니까')) {
		$.ajax({
			url: contextPath + '/admin/romoveMemo',
			type: 'GET',
			data: { memoNo: memoNo },
			success: function(data) {
				btnDay(day);
				CalendarDefault();
			}
		});
	}
}

// 메모가 적힌 날짜를 저장하는 리스트
var dayList = new Array;

// 현재 날짜 기준의 달력 출력
CalendarDefault = () => {
	const calendarForm = new FormData();
	calendarForm.append('currentYear', currentYear);
	calendarForm.append('currentMonth', currentMonth);
	calendarForm.append('judgment', '');

	console.log(contextPath);

	fetch(contextPath + '/admin/modifyMonth', {
		method: 'POST',
		body: calendarForm,
		type: 'JSON',
	}).then(res => res.json())
		.then((data) => {
			//console.log(data);
			currentYear = data.currentYear;
			currentMonth = data.currentMonth;

			for (var i = 0; i < data.dayList.length; i++) {
				dayList.push(data.dayList[i]);
			}

			createCalendar(data.dayOfTheWeek, data.lastDay);
		});
}

// 다음 달의 달력 출력
btnCalendarNext = () => {
	const calendarForm = new FormData();
	calendarForm.append('currentYear', currentYear);
	calendarForm.append('currentMonth', currentMonth);
	calendarForm.append('judgment', 'next');

	fetch(contextPath + '/admin/modifyMonth', {
		method: 'POST',
		body: calendarForm,
		type: 'JSON',
	}).then(res => res.json())
		.then((data) => {
			//console.log(data);
			currentYear = data.currentYear;
			currentMonth = data.currentMonth;

			for (var i = 0; i < data.dayList.length; i++) {
				dayList.push(data.dayList[i]);
			}

			createCalendar(data.dayOfTheWeek, data.lastDay);
		});
}

// 이전 달의 달력 출력
btnCalendarPre = () => {
	const calendarForm = new FormData();
	calendarForm.append('currentYear', currentYear);
	calendarForm.append('currentMonth', currentMonth);
	calendarForm.append('judgment', 'pre');

	fetch(contextPath + '/admin/modifyMonth', {
		method: 'POST',
		body: calendarForm,
		type: 'JSON',
	}).then(res => res.json())
		.then((data) => {
			//console.log(data);
			currentYear = data.currentYear;
			currentMonth = data.currentMonth;

			for (var i = 0; i < data.dayList.length; i++) {
				dayList.push(data.dayList[i]);
			}

			createCalendar(data.dayOfTheWeek, data.lastDay);
		});
}

// 달력 그리는 액션
createCalendar = (dayOfTheWeek, lastDay) => {
	$('#calendarTable tbody').empty();
	var dayCount = Number(dayOfTheWeek) - 1;
	var calendar = '<tbody><tr>';
	for (var i = 0; i < dayCount; i++) {
		calendar += '<td></td>';
	}
	for (var i = 1; i <= lastDay; i++) {
		var star = '';
		for (var j = 0; j < dayList.length; j++) {
			if (i == dayList[j]) {
				star = '★';
			}
		}
		if (dayCount % 7 == 0) {
			calendar += `
					<td>
						<button type="button" class="btn btn-light btn-block btn-sm test-danger" onClick="btnDay(${i});">
							${i}
						</button>
						<span style="font-size:20px">
							${star}
						</span>
					</td>
				`;
		} else if (dayCount % 7 == 6) {
			calendar += `
					<td>
						<button type="button" class="btn btn-light btn-block btn-sm text-primary" onClick="btnDay(${i});">
							${i}
						</button>
						<span style="font-size:20px">
							${star}
						</span>
					</td>
				`;
		} else {
			calendar += `
					<td>
						<button type="button" class="btn btn-light btn-block btn-sm" onClick="btnDay(${i});">
							${i}
						</button>
						<span style="font-size:20px">
							${star}
						</span>
					</td>
				`;
		}
		dayCount += 1;
		if (dayCount % 7 == 0) {
			calendar += '</tr><tr>';
		}
	}
	calendar += '</tbody>';
	$('#calendarTable').append(calendar);

	dayList = new Array;

	$('#current span').text(currentYear + '-' + currentMonth);
}

// 최근 작성한 메모장
memoTableDefault = () => {
	$('#defaultForm').show();
	$('#oneClickForm').hide();

	$.ajax({
		url: contextPath + '/admin/getMemoByLastUpdate',
		type: 'GET',
		success: function(data) {
			//console.log(data);
			$('#memoTable tbody').empty();
			var memoTableTbody = '<tbody>'
			for (var i = 0; i < data.length; i++) {
				memoTableTbody += `
						<tr>
							<td>${data[i].memoDate}</td>
							<td>${data[i].memoContent}</td>
							<td>${data[i].lastUpdate}</td>
						</tr>
					`;
			}

			$('#memoTable').append(memoTableTbody);
		}
	});
}