<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//나중에 DB 주소 변경
	String driverName = "oracle.jdbc.OracleDriver";
	//접속 ip 주소:포트:DB이름
	//String url = "jdbc:oracle:thin:@211.63.89.208:1522:orcl";
	String url = "jdbc:oracle:thin:@211.63.89.205:1521:orcl";
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, "scott", "tiger");
	out.println("오라클 DB 연동 성공!");
%>