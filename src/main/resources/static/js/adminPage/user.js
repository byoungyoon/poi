// 유저 탈퇴 액션
removeUser = (userId) => {
	if (confirm('해당 유저를 탈퇴 시키겠습니까')) {
		$.ajax({
			url: contextPath + '/admin/removeUser',
			type: 'GET',
			data: { userId: userId },
			success: function(data) {
				alert('해당 유저가 탈퇴되었습니다.');
				createUserList();
			}
		});
	}
}

createUserList = () => {
	$('#userTable').empty();
	$.ajax({
		url: contextPath + '/admin/getUserByAdmin',
		type: 'GET',
		success: function(data) {
			//console.log(data);
			var userTableTbody = '<tbody>';
			for (var i = 0; i < data.length; i++) {
				userTableTbody += `
						<tr>
							<td>${data[i].userId}</td>
							<td>${data[i].userName}</td>
							<td>${data[i].createDate}</td>
							<td><button type="button" class="btn btn-outline-danger" onClick="removeUser('${data[i].userId}');">탈퇴</button></td>
						</tr>
					`;
			}
			userTableTbody += '</tbody>';

			userTableDiv = `
					<table class="table table">
						<thead>
							<tr>
								<th>Id</th>
								<th>이름</th>
								<th>만든 날짜</th>
								<th></th>
							<tr>
							${userTableTbody}
						</thead>
					</table>
				`;

			$('#userTable').append(userTableDiv);
		}
	});
}