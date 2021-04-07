<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>poi</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	body {
		background: #eee !important;
	}
	
	.wrapper {
		margin-top: 80px;
		margin-bottom: 80px;
	}
	
	.form-signin {
		max-width: 380px;
		padding: 15px 35px 45px;
		margin: 0 auto;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, 0.1);
		.
		form-signin-heading
		,
		.checkbox
		{
		margin-bottom
		:
		30px;
	}
	
	.checkbox {
		font-weight: normal;
	}
	
	.form-control {
		position: relative;
		font-size: 16px;
		height: auto;
		padding: 10px;
		@
		include
		box-sizing(border-box);
		&:
		focus
		{
		z-index
		:
		2;
	}
	
	}
	input[type="text"] {
		margin-bottom: -1px;
		border-bottom-left-radius: 0;
		border-bottom-right-radius: 0;
	}
	
	input[type="password"] {
		margin-bottom: 20px;
		border-top-left-radius: 0;
		border-top-right-radius: 0;
	}
	}
</style>
</head>
<body>
	<div class="wrapper">
		<form id="loginForm" class="form-signin" method="post" action="${pageContext.request.contextPath}/loginAction">
			<h2 class="form-signin-heading">Please login</h2>
			<input 
				type="text" 
				class="form-control" 
				name="userId" 
				placeholder="Id" 
				required="" 
				autofocus="" 
				style="margin-top:7px"
			/> 
			<input
				type="password" 
				class="form-control" 
				name="userPw"
				placeholder="Password" 
				required="" 
				style="margin-top:7px"
			/> 
			<button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top:7px">Login</button>
			<div style="margin-top:7px; float:left">
				<a href="${pageContext.request.contextPath}/all/index">돌아가기</a>
			</div>
			<div class="text-right" style="margin-top:7px">
				<a href="javascript:void(0);" onClick="showSignupForm();">회원가입</a>
			</div>
		</form>
		<form id="signupForm" class="form-signin" action="${path}/all/signup" method="post">
			<h2 class="form-signin-heading">Sign Up</h2>
			<table class="table table">
				<tr>
					<th>Id</th>
					<td>
						<input 
							class="form-control" 
							type="text"
							id="userId" 
							name="userId"
							onChange="onChangeById();"
						/>
					</td>
				</tr>
				<tr>
					<th>Password</th>
					<td>
						<input 
							class="form-control" 
							type="password" 
							id="userPw"
							name="userPw"
							onChange="onChangeByPw();"
						/>
					</td>
				</tr>
				<tr>
					<th>Name</th>
					<td>
						<input 
							class="form-control" 
							type="text" 
							id="userName"
							name="userName"
							onChange="onChangeByName();"
						/>
					</td>
				</tr>
			</table>
			<div>
				<button class="btn btn-lg btn-primary btn-block" type="button" onClick="btnSignup()">추가</button>
			</div>
			<div style="margin-top:7px;">
				<a href="javascript:void(0);" onclick="showLoginForm();">돌아가기</a>
			</div>
		</form>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$('#signupForm').hide();
		
		var idCk = false;
		var pwCk = false;
		var nameCk = false;
		
		btnSignup = () => {
			if(idCk == false){
				$('#userId')[0].style.border="3px solid #F15F5F";
				$('#userId').focus();
			} else if(pwCk == false){
				$('#userPw')[0].style.border="3px solid #F15F5F";	
				$('#userPw').focus();
			} else if(nameCk == false){
				$('#userName')[0].style.border="3px solid #F15F5F";	
				$('#userName').focus();
			} else{
				$.ajax({
					url: '${pageContext.request.contextPath}/all/loginCk',
					type: 'GET',
					data: {userId: $('#userId').val()},
					success: function(data){
						if(data == '1'){
							$('#userId')[0].style.border="3px solid #F15F5F";
							var idCk = false;
							alert('중복된 아이디입니다.');
						} else{
							if(confirm('입력하신 값으로 회원가입 하시겠습니까')){
								$('#signupForm').submit();
							}
						}
					}
				});
			}	
		}
		
		onChangeByName = () => {
			if($('#userName').val().length > 1){
				$('#userName')[0].style.border="3px solid #B2CCFF";
				nameCk = true;
			} else{
				$('#userName')[0].style.border="3px solid #F15F5F";
				nameCk = false;
			}	
		}
		
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/g;
		onChangeByPw = () => {
			if(pwReg.test($('#userPw').val())){
				$('#userPw')[0].style.border="3px solid #B2CCFF";
				pwCk = true;
			} else{
				$('#userPw')[0].style.border="3px solid #F15F5F";				
				pwCk = false;
			}
		}
		
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		onChangeById = () => {
			if(idReg.test($('#userId').val())){
				$('#userId')[0].style.border="3px solid #B2CCFF";
				idCk = true;
			} else{
				$('#userId')[0].style.border="3px solid #F15F5F";				
				idCk = false;
			}
		}
		
		showLoginForm = () => {
			$('#signupForm').hide();
			$('#loginForm').show();
		}
		
		showSignupForm = () => {
			$('#signupForm').show();
			$('#loginForm').hide();
		}
		
	</script>
</body>
</html>