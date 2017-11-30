<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/included/included_head.jsp" %> 
<c:if test="${param.result eq false}">
	<script>
		alert("로그인 실패!");
	</script>
</c:if>
<style>
	html, body, .wrapper{
		height : 100%;
	}
	
	.wrap-form{
		display: flex;
		flex-flow : row wrap;
		-ms-flex-align: center;
		-webkit-align-items: center;
		-webkit-box-align: center;
		align-items: center;
		justify-content: center;
		height : 100%;
		text-align: center;
	}
	
	.tb-admin-login{
		margin : 0.2rem;
	}
	
	.tb-admin-login tr td{
		padding : 0.3rem;
	}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="wrap-form">
			<form id="form-admin-login" action="${pageContext.request.contextPath}/j_spring_security_check" method="post">
				<h1>ADMIN</h1>
				<table class="tb-admin-login">
				<tr>
				<td>USERNAME</td>
				<td><input type="text" name="username" /></td>
				</tr>
				<tr>
				<td>PASSWORD</td>
				<td><input type="password" name="password"/></td>
				</tr>
				<tr>
				<td></td>
				<td style="text-align: right;"  ><input type="submit" value="로그인"/></td>
				</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>