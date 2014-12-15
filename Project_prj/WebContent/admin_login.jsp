<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화보기좋은날</title>
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<style type="text/css">
	#admin_top_text {
		float: right;
		position: relative;
		top:35px;
	}
	#content{ width: 1008px; height: 100%; margin:0 auto; background:#FFF }
	.login { border:0px; border-bottom: 1px solid black; padding: 5px 10px; }
</style>

<script type="text/javascript"> 
 function keydown(){
		if(event.keyCode == 13){//엔터키를 누를 때
			check();//유효성 검사
		}//end if
 }//keydown
 
function check(){
	var id = document.admin_login.id;//id
	var pass = document.admin_login.pass;//pass
	
	//아이디 여백, 빈칸유무
	if(id.value.replace(/(^\s*)|(\s*$)/g, "").length == 0){
		alert("아이디를 입력하세요.");
		id.focus();
		return;
	}//end if
	
	//아이디 유효성 검사
	if(!(id.value.replace(/[a-z 0-9]/g, "") == "" && id.value.search(/\s/g) == -1)){//화이트스페이스제외포함
		alert("아이디는 영문 소문자와 숫자만 사용 가능합니다.");
		id.value = "";	//초기화
		id.focus();
		return;
	}//end if
	
	//비밀번호 빈칸유무
	if(pass.value.replace(/(^\s*)|(\s*$)/g, "").length ==0 || pass.value.search(/\s/g) != -1){//화이트스페이스제외포함
		alert("영문소문자, 대문자, 숫자로 이루어진 비밀번호를 입력해주세요.");
		pass.value = "";	//초기화
		pass.focus();
		return;
	}//end if
	
	admin_login.submit();//전송
}//check
</script>
</head>
<body>
<%
	//관리자 아이디로 로그인이 되어있는 경우
	if(session.getAttribute("admin_id")!=null){
		//관리자 페이지로 이동
		//이동할 페이지 설정
		response.sendRedirect("admin_main.jsp");
/* 		out.println("<script type='text/javascript'>");
		out.println("window.location.href=\"admin_main.jsp\";");
		out.println("</script>"); */
	}
%>

	<header>
		<div id="top_wrap">
		<div id="top_nav">
		</div>
		<div id="top_menu">
			<div id="logo">
				<a href="#"><img src="images/common/header/logo.png"/></a>
			</div>
			<div id="admin_top_text">
				<img src="images/admin/header/top_text.png"/>
			</div>
		</div>
		</div>
	</header> 
    <div id="content">
    	<img src="images/admin/login/notic.png" width="1008" height="343">
    	<form name="admin_login" method="post"  action="admin_loginOK.jsp"">
      <table width="383" height="51" align="center" >
          <tr height="22">
            <td width="74"><img src="images/admin/login/id.png" width="74" height="22"></td>
            <td width="182" ><input type="text" name="id" width="182" height="22" class="login" autofocus tabindex="1" onkeypress="keydown();"></td>
            <td rowspan="2" width="26"></td>
            <td rowspan="2" width="101"><a href="javascript:check();"  tabindex="3"><img src="images/admin/login/login.png" width="101" height="51"></a></td>
          </tr>
          <tr height="29" >
            <td><img src="images/admin/login/pass.png" width="74" height="29"></td>
            <td><input type="password" name="pass" width="182" height="29" class="login" tabindex="2"onkeypress="keydown();"></td>
          </tr>
        </table>
        </form>
      <div style="height:175px;"></div>
    </div>
    	<div id="footerwrap">
		<footer>
			<div id="footer_con">
				<div id="footer_logo">
					<img src="images/common/footer/footer_logo.png"/>
				</div>
				<div id="footer_info">
					<div id="footer_menu">
						<a href="#">회사소개</a><span class="footer_line">|</span>
						<a href="#">제휴문의</a><span class="footer_line">|</span>
						<a href="#">이용약관</a><span class="footer_line">|</span>
						<a href="#">개인정보 취급방침</a><span class="footer_line">|</span>
						<a href="#">고객센터</a>
					</div>
					<div id="footer_copy">
						경기도 성남시 분당구 탄천로 215 탄천종합운동장 (야탑동 486 탄천종합운동장 주경기장 내)<br/>
						대표자명 오화연 | 개인정보관리책임자 제휴&솔루션 본부장 이용훈 | 사업자등록번호 123-45-67890 | 통신판매업신고번호 제 123호<br/>
						Copyright 2014 by MOVIE DAY. All rights reserved
					</div>
				</div>
			</div>
		</footer>
	</div>
</body>
</html>