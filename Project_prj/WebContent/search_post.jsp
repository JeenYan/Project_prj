<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String dong = request.getParameter("dong");
PreparedStatement pstmt = null;
ResultSet rs = null;
try{%>
<%@include file ="db_connect.jsp"%>
 <%
	String[] address = new String[2];
	//String sql = "select zipcode, sido, gugun, dong, bunji from zipcode where dong like '완월동'";
	String sql = "select zipcode, sido, gugun, dong, bunji from zipcode where dong like '%' || ? || '%'";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, dong);
	rs = pstmt.executeQuery();
	while(rs.next()){%>
	<%
		address[0] = rs.getString("zipcode");
		address[1] = rs.getString("sido") + " " + rs.getString("gugun") + rs.getString("dong");
	%> 
	<tr>
 	<td><a href="javascript:chk('<%=address[0] %>', '<%=address[1]%>');"><%=address[0] %></a></td>
	<td><a href="javascript:chk('<%=address[0] %>', '<%=address[1]%>');"><%=rs.getString("sido")%></a></td> 
	<td><a href="javascript:chk('<%=address[0] %>', '<%=address[1]%>');"><%=rs.getString("gugun")%></a></td> 
	<td><a href="javascript:chk('<%=address[0] %>', '<%=address[1]%>');"><%=rs.getString("dong")%></a></td> 
	<td><a href="javascript:chk('<%=address[0] %>', '<%=address[1]%>');"><%=rs.getString("bunji")==null ? "" : rs.getString("bunji")%></a></td> 
	</tr>
<%}//end while
    }catch(SQLException se){
	se.printStackTrace();
}//end catch
%>