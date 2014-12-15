<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//비관리자가 로그인창을 통해 넘어오지 않은 경우 
	//admin_login으로 이동
//	if (session.getAttribute("admin_id")==null && "GET".equals(request.getMethod())) {
//		out.println("<script type='text/javascript'>");
//		out.println("window.location.href=\"admin_login.jsp\";");
//		out.println("</script>");
//	}
%>
	<header>
		<div id="top_wrap">
		<div id="top_nav">
		</div>
		<div id="top_menu">
			<div id="logo">
				<a href="admin_main.jsp"><img src="images/common/header/logo.png"/></a>
			</div>
			<div id="admin_top_text">
				<img src="images/admin/header/top_text.png"/>
			</div>
		</div>
		</div>
        <div id="admin_com_text">
                    <img src="images/admin/main/top.png"/>
                    <span id="access_time"><%=session.getAttribute("login_time")%><!-- 2014-11-05  --></span>
                </div>
	</header> 
