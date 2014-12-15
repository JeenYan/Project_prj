<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화보기좋은날</title>
</head>
<body>
				<!-- 1. DB 접속 -->
				<%
					try {
				%>
				<%@include file ="Process/db_con.jsp"%>
				<%

						String IdnPass = "select manId, manPass, mannic from manager";
						PreparedStatement pstmt = con.prepareStatement(IdnPass);
						ResultSet rs = pstmt.executeQuery();
						
						//admin_login에서 넘어온 id와pass를 변수에 저장
						String param_id = request.getParameter("id");
						String param_pass = request.getParameter("pass");

						while (rs.next()) {//멤버 목록이 끝날 때까지 포인트 이동, 루프
						// 2. ID 및 PASSWORD 검사 
							if (param_id.equals(rs.getString("manId"))) {// ID 존재한다면 if 아래로
								if (!param_pass.equals(rs.getString("manPass"))) {//PASSWORD가 불일치하면 if 아래로
									out.println("<script type='text/javascript'>");
									out.println("alert('비밀번호가 일치하지 않습니다.');");	//경고창
									out.println("history.go(-1);");	//이전 페이지로 이동
									out.println("</script>");
								}//end if --pass 검사

								//3. 세션 생성

								// 생존시간 설정
								session.setMaxInactiveInterval(600); 
								// 세션에 속성값 설정
								session.setAttribute("admin_id", param_id);	//id
								session.setAttribute("admin_nic", rs.getString("MANNIC"));	//nick
								session.setAttribute("admin_ip", request.getRemoteAddr());	//ip
								session.setAttribute("login_time",	new SimpleDateFormat("yyyy-MM-dd").format(new Date())); //로그인 시간

								//4. admin_main으로 페이지 이동
								out.println("<script type='text/javascript'>");
								out.println("window.location.href=\"admin_main.jsp\";");
								out.println("</script>");
							}//end if --ID 검사
						}//end while
						
						//멤버목록 루프가 끝나도록 검색해도 ID가 없음
						//이전 페이지로 이동
						out.println("<script type='text/javascript'>");
						out.println("alert('ID가 존재하지 않습니다.');");
						out.println("history.go(-1);");
						out.println("</script>");
					} catch (Exception e) {
						e.printStackTrace();
					}
				%>
</body>
</html>