<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 검색-영화 보기 좋은날</title>
<link rel="shortcut icon" type="image/x-icon" href="images/common/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<style type="text/css">
body {
	overflow-x: hidden;
	overflow-y: auto;
}

#logwrap {
	width: 520px;
	height: 300px;
	margin: auto;
}

#login_tap {
	width: 500px;
	height: 40px;
	background: url("images/admin/member/search_add.gif") no-repeat;
}

#close_btn {
	float: right;
	width: 16px;
	height: 16px;
	padding: 12px 12px;
}

#content {
	width: 500px;
	height: 190px;
}

#form_area {
	width: 400px;
	height: 74px;
	margin: 0 auto;
	position: relative;
	text-align: center;
	top: 70px;
}

#login_form {
	width: 280px;
	height: 74px;
}

#input_id_pwd {
	float: left;
	width: 190px;
	height: 74px;
}

#pwd_area {
	margin-top: 10px;
}

#login_btn {
	float: left;
	width: 64px;
	height: 74px;
	margin-left: 26px;
}

.btn {
	width: 64px;
	height: 74px;
	background: url("images/common/login/login_btn.png") no-repeat;
	border: 0;
	text-indent: -999em;
	cursor: pointer;
}

#find_info {
	text-align: center;
	margin-top: 40px;
}

#find_info a {
	text-decoration: none;
}

#logwrap div:first-child {
	text-align: center;
}

form:first-child {
	margin-bottom: 5px;
}

form input[type="text"] {
	height: 15px;
	border: 1px solid #ccc;
}

form:first-child input[type="text"] {
	width: 100px;
	background-color: #ccc;
}

form:first-child input[type="button"] {
	border: 0px;
	background: url('./images/admin/member/address.png') no-repeat;
	width: 60px;
	height: 20px;
}

form:nth-child(2) input[type="text"] {
	margin-bottom: 5px;
}

form:nth-child(2) input[type="reset"], form:nth-child(2) input[type="submit"]
	{
	
}

table {
	width: 500px;
	margin: 30px auto;
}

table th {
	text-align: center;
}

table tr:first-child {
	font-weight: bold;
	text-align: center;
}

table td, th {
	height: 25px;
	text-align: center;
}

table th {
	background-color: #df345c;
	color: #fff;
}

table tr:hover td {
	background: #ffdbe3;
}

table th:first-child {
	width: 80px;
}

table th:nth-chiild(2) {
	width: 40px;
}

table th:nth-chiild(3) {
	width: 120px;
}

table th:nth-chiild(4) {
	width: 180px;
}

table th:last-chiild {
	width: 80px;
	text-align: center;
}
	#login_logo{
		width:400px;
		margin:0 auto;
	}
</style>
<script type="text/javascript">
	function joinPage() {
		opener.location.href = 'join.html';
		self.close();
	}

	function search() {
		var obj = document.sfrm;
		if (obj.dong.value == '' || obj.dong.value == null) {
			alert("동을 입력해주세요");
			obj.dong.focus();
			return;
		}
		obj.include_post.value = "search_post.jsp";
		obj.submit();
	}
	function chk(zip, val) {
		var obj = opener.window.document.mfrm;
		obj.add01.value = zip;
		obj.add02.value = val;
		window.close();
		return;
	}
</script>
</head>
<body>
	<div id="logwrap">
		<div id="login_logo"><img src="images/common/login/login_logo.gif" alt="로그인페이지"></div>
		<div id="login_tap">
			<div id="close_btn"><a href="javascript:self.close()" ><img src="images/common/login/close_btn.png" alt="닫기"></a></div>
		</div>
		<div id="content">
			<div id="form_area">
				<form action="search_address.jsp" method="post" name="sfrm">
					<input type="hidden" name="include_post" />
					<input type="text" name="dong" onKeyDown="if(event.keyCode == '13'){search();}" tabindex="1" style="width:300px;" autofocus  />
					<input type="button" onClick="search()" tabindex="2" />
				</form>
			</div>
		</div>
	</div>
				<div id="address_table">
				<c:if test="${param.include_post ne null and param.include_post ne ''}">
					<form action="search_address.jsp" name="ifrm" method="post">
						<table width="480">
							<tr>
								<th width="100">우편번호</th>
								<th>시</th>
								<th>군</th>
								<th>동</th>
								<th>번지</th>
							</tr>
							<c:import url="${param.include_post}" />
						</table>
					</form>
				</c:if>
				</div>
</body>
</html>