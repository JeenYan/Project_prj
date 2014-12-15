<%@page import="dao.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = "";
	memberDAO md = memberDAO.getInstance();
	if(md.findId(request.getParameter(request.getParameter("id")))){
		msg = "사용 가능한 ID입니다.";
	}else{
		msg = "이미 사용중인 ID입니다.";
	}
%>
{"result":"<%=msg %>"}