<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("delete_userId") != null){
		PreparedStatement pstmt=null;
		try{%>
		<%@include file ="db_connect.jsp"%>
		<%
			String user_id = request.getParameter("delete_userId");
			String sql = "delete from member where memid=?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			int rs = pstmt.executeUpdate();
			if(rs != 1){
			out.println("<script>alert('ID ["+user_id+"]의 정보가 삭제되지 않았습니다.');</script>");
			}else{
			out.println("<script>alert('"+rs+"건, ID ["+user_id+"]의 정보가 삭제되었습니다.');</script>");
			}
			//con(DB연결)이 try문 안에 있기 때문에 finally가 아닌 여기서 close
			if(con != null){con.close();}
		}catch(SQLException se){
			out.println("<script>alert('SQL 에러가 발생했습니다.');</script>");
			se.printStackTrace();
		}finally{
			if(pstmt != null){pstmt.close();}
			//response.sendRedirect("admin_memberInfo.jsp");
			out.println("<script>location.href='admin_memberInfo.jsp';</script>");
		}
	}else{
		out.println("<script>alert('ID가 존재하지 않습니다.'); location.href='admin_memberInfo.jsp';</script>");
	}

%>