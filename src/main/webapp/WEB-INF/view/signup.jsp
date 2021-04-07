<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>POI</title>
</head>
<body>
	<div class="container">
		<div class="body">
			<form action="${path}/all/signup" method="post">
				<table class="table table">
					<tr>
						<th>아이디</th>
						<td><input type="text" name="userId"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="userPw"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="userName"></td>
					</tr>
				</table>
				<div>
					<button type="submit">추가</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>