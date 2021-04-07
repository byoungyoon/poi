<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
	<h1>배열 테스트</h1>
	
	<div>
		<input type="text" id="title" />
		<input type="text" id="content" />
		<button type="button" onClick="handleAdd();">추가</button> 
		<button type="button" onClick="handleRemove();">삭제</button> 
		<table id="table"></table>
	</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var arrayList = [
		{
			id: 1,
			title: 'test1',
			content: 'test1'
		},
		{
			id: 2,
			title: 'test2',
			content: 'test2'
		},
		{
			id: 3,
			title: 'test3',
			content: 'test3'
		}
	];
	
	var nextId = 4;
	var checkId = [];
	
	// 추가
	handleAdd = () => {
		const addList = {
			id: nextId,
			title: $('#title').val(),
			content: $('#content').val()
		};
		nextId = nextId + 1;
		
		var arrayListAfter = [];
		arrayListAfter = arrayListAfter.concat(
			...arrayList,
			addList
		);
		
		arrayList.push(addList);
		
		$('#table tbody').empty();
		tableList(arrayListAfter);
	}
	
	// 삭제
	handleRemove = () => {
		for(var i=0; i<checkId.length; i++){
			arrayList = arrayList.filter(data =>{
				return data.id != checkId[i];
			});
		}
		
		$('#table tbody').empty();
		tableList(arrayList);
	}
	
	// 체크 박스 클릭
	handleChange = (id) => {
		if($('#check' + id)[0].checked == true){
			checkId.push(id);
		} else{
			checkId = checkId.filter(data => data != id);
		}
	}
	
	// 테이블 그리기
	tableList = (arrayList) => {
		for(var i=0; i<arrayList.length; i++){
			const tableBody = `
				<tbody>
					<tr>
						<th><input id="check\${arrayList[i].id}\" type="checkbox" onClick="handleChange(\${arrayList[i].id}\)" /></th>
						<th>\${arrayList[i].id}\</th>
						<td>\${arrayList[i].title}\</td>
						<td>\${arrayList[i].content}\</td>
					</tr>
				</tbody>
			`;
			$('#table').append(tableBody);	
		}
	};
	
	tableList(arrayList);
	
</script>
</body>
</html>