<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language ="java" import="java.sql.*,java.sql.DriverManager.*" %>
<%
 Class.forName("oracle.jdbc.driver.OracleDriver");
 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@211.63.89.208:1522:orcl","sist1","tiger");
 //out.println("오라클 DB 연동 성공!");
%>
<%-- <%=con%> --%>