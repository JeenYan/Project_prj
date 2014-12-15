<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>영화보기좋은날 관리자</title>
<link rel="stylesheet" type="text/css" href="css/admin_common.css"/>
<style type="text/css">
	#admin_contents {
		width: 1008px;
		margin-top: 10px;
		margin:0 auto;
	}

	#title {
		width: 988px;
		height: 20px;
		float:left; /*ì ë ¬*/
		margin-top: 20px;
		padding-left:20px;
	}
	#memInfo {
		width: 286px;
		height: 100px;
		float:left; /*ì ë ¬*/
		margin-top:30px;
		margin-bottom:30px;
		margin-left:10px;
	}

	.info_list{
		float: left;
		display: block;
		width: 458px;
		height: 162px;
		margin-left:20px;
		margin-top:20px;
	}
	.info_listbox {
		width: 456px;
		height: 160px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	.listbox_img {
		float: left;
		width: 160px;
		height: 160px;
	}
	#memInfo dl dt {
		width: 62px;
		font-weight: bold;

	}
	#memInfo dl dt,dd{
		float: left;	
		height: 25px;
	}
	 .admin_value {
	color: #df345c;
	font-family: tahoma,Dotum,ëì,Helvetica,AppleSDGothicNeo,sans-serif;
	font-size: 12px;
	font-weight: bold;
	}
	
	#search{
	width:353px; 
	float:right; 
	height:20px;
	padding-top: 10px;
	}
	
	#search img {
		margin:0px;	
	}

	#create {
		margin-left: 10px;
	}
</style>
<script>

window.onload=function(){
//검색한 값과 검색할 분류(Id, NicName)를 그대로 검색 후 페이지로 넘기는 코드
//1. JSP 처리 > 2. SCRIPT 처리 > 3. HTML 처리 순서기 때문에 <BODY></BODY> 안 JSP에서 처리하지 X
var ob = document.surch;
//값이 없을 때 null의 값 출력 방지
ob.surch.value=<%=(request.getParameter("surch") == null) ? "" : "'"+request.getParameter("surch")+"'" %>;
<%if("NicName".equals(request.getParameter("surch_con"))){%> 
ob.surch_con[1].selected=true;
<%}%>
}
</script>
</head>

<body>

<%@include file = "admin_header.jsp" %>
<div id="contentwrap">
<section class="contents"> 
	<!--top 타이틀-->
<%@include file = "admin_title_member.html" %>
<%
	int i=0; //	
	int maxView=10; //화면에 보여질 멤버의 수
	int pageNum=1; //현재 화면의 페이지 번호
	int pageCount = 0; //DB에 저장된 모든 멤버의 수
	int minNum=0, maxNum=0; //페이지마다 출력될 멤버들을 한정짓는 함수
	String grade_src = "./images/member/level/";
	String surch="";
	
	PreparedStatement sub_pstmt = null;
	PreparedStatement pstmt = null;
	ResultSet sub_rs = null;
	ResultSet rs = null;
	try{%>
		<%@include file ="db_connect.jsp"%>
		<%@include file = "grade_number.jsp" %>
		<%
			String surch_con = request.getParameter("surch_con");	
			surch = request.getParameter("surch");	
			String mem_all = request.getParameter("member_all");
			
			String sub_sql = null;
			String sql = null;

			Map<String, String> user_info = new HashMap<String, String>();	//사용자의 정보 저장
			
			
			if(surch_con != null){
			///////// 검색을 한 경우 /////////
			surch = (surch!=null ? surch : ""); //검색값 설정
			surch_con = (surch_con.equals("Id") ? "memid" : "memnic"); //검색할 항목 선택(ID 또는 NICNAME)
			sql = "select to_char(memhiredate, 'YYYY-MM-DD') memhiredate, memid, memnic, mempoint from member where "+surch_con+" like '%' || ? || '%'";
			System.out.println(surch);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, surch); //검색할 값 입력
		}else{
			///////// 기본 메인 페이지 /////////
			sql ="select count(memid) from member";
			pstmt = con.prepareStatement(sql);
		 	rs = pstmt.executeQuery();
		 	while(rs.next()){
		 		pageCount = Integer.parseInt(rs.getString("count(memid)"));
		 	}//end while
	 		
		 	sql = "select to_char(memhiredate, 'YYYY-MM-DD') memhiredate, memid, memnic, mempoint from (select rownum r, memhiredate, memid, memnic, mempoint from member) where ?<r and r<?";
			pstmt = con.prepareStatement(sql);
			
			//첫페이지가 아닐 때 페이지 번호 저장
			if(request.getParameter("page")!=null){
				pageNum = Integer.parseInt(request.getParameter("page"));
			}
			minNum = maxView*(pageNum-1);//화면에 보여질 첫 멤버의 순서-1
			maxNum = maxView*pageNum+1;//화면에 보여질 마지막 멤버의 순서+1
			pstmt.setInt(1, minNum);
			pstmt.setInt(2, maxNum);
		}
	 	rs = pstmt.executeQuery();
	 	
 %>
 
    <!-- top 타이틀-->
    <div id="title">
    	<img src="images/admin/main/title_01.png" width="253" height="20" /> 
    </div> 
    
    <!-- top 네비게이션-->
    <div style="width:1008px; margin: 0 auto; float: right;" >
	    <div style=" width:120px; float:right; margin-right:10px;"> 
	    	<a href="admin_main.jsp">메인</a> &gt; 전체회원정보
	    </div>
    </div>
    
    <!-- search  -->
    <!-- search버튼을 누르면 div main 에 원하는 인물의 회원DB가 나타난다. -->
    <div id="search"> 
    	   	<form name="surch" action="admin_memberInfo.jsp" method="post">
    	<select name="surch_con" style="margin:0; height:20px;">
    		<option value="Id">ID</option>
    		<option value="NicName">NicName</option>
    	</select>
    	<input type="text"  name="surch"  style="margin:0; "/>
   		<div style="width:140px; height: 20px; float: right;">
   			<a href="#" onclick="surch.submit()"><img src="images/admin/member/such.png"/></a>
   			<a href="admin_memberInfo.jsp"><img src="images/admin/member/all.png"/></a>
    	</div>
    	</form>
    </div>
    
    <!--  회원 추가 버튼  -->
    <div id="create">
    	<a href="admin_memberAdd.jsp"><img src="images/admin/member/button_05.png"/></a>
    </div>
    
    <!-- 콘텐츠 내용 -->
    <div id = "main">
    	<ul>
 <%
 		String user_id = "";
    	String photo="photo.jpg";
    	
    	while(rs.next()){ 
    		user_id = rs.getString("memid");
 %>
            <li class="info_list">
            	<div class="info_listbox">
                <!-- 회원 정보 -->
                	<div class="listbox_img">
               	    <a href="admin_memberDetail.jsp?user_id=<%=rs.getString("memid") %>"><img src="images/admin/member/<%=photo%>" width="160" height="160" /></a> </div> <!-- 회원 사진-->
                	<div id = "memInfo">
                    <dl>
                    	<dt> Hiredate</dt> <dd style="width:224px;"> <span class="admin_value"><%=rs.getString("memhiredate")%></span></dd>
                        <dt> ID </dt> <dd style="width:81px;">  <span class="admin_value"><%=user_id %> </span></dd> <dt> Nicname </dt> <dd>  <span class="admin_value"><%=rs.getString("memnic") %>  </span></dd>
                        <dt> Level </dt> <dd style="width:224px;">  <span class="admin_value"><img src="<%=rs.getInt("mempoint") > -1 ? grade_src+getGrade(rs.getInt("mempoint"))+".gif" : " " %>" />  (<%=rs.getInt("mempoint") %>) </span></dd> 
                        <%
            			//코멘트의 총 수 ~ Select Table(boardcomment, cinemacomment, moviecomment) 
            			sub_sql = "select count(bcdate) from((select memid, bcdate from cinemacomment union select memid, bcdate from boardcomment) union select memid, bcdate from moviecomment) where memid=?";	
            			sub_pstmt = con.prepareStatement(sub_sql);
            			sub_pstmt.setString(1, user_id);
            			sub_rs = sub_pstmt.executeQuery();
            			while(sub_rs.next()){
            				user_info.put("comment_count", sub_rs.getString("count(bcdate)"));	//코멘트 총 수
            			}
        				//게시글 총 수 ~ Select Table(boardMovie)
        				sub_pstmt.clearParameters();
        				sub_sql = "select count(bdate) from boardmovie where memid=?";
        				sub_pstmt = con.prepareStatement(sub_sql);
        				sub_pstmt.setString(1, user_id);
        				sub_rs = sub_pstmt.executeQuery();
        				while(sub_rs.next()){
        					user_info.put("boardmovie_count", sub_rs.getString("count(bdate)"));	//게시글 총 수
        				}
                        %>
                      	<dt> Board </dt> <dd style="width:81px;">  <span class="admin_value"><%=user_info.get("boardmovie_count") %> </span></dd>  <dt> Comment </dt> <dd style="width:81px;">  <span class="admin_value"><%=user_info.get("comment_count") %></span> </dd>
                    </dl>
                    </div>
                </div>
            </li>	
		<%}//end while
		con.close();	//con이 try문 안에 있기 때문에 finally에 적용되지 않음 > 여기서 끊음
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		//연결된 경우 끊음
		if(rs != null){rs.close();}	
		if(pstmt != null){pstmt.close();}
		if(sub_rs != null){sub_rs.close();}	
		if(sub_pstmt != null){sub_pstmt.close();}
	}
	%>
    	</ul>
    </div>
    <!-- end Main -->
    <div style="float:left; width:100%; height:20px; margin:0 auto; font-size:14px; margin-bottom:40px;">
    <center>
    	<%
    	if(pageCount > maxView){%>
    	<a href="?page=1">◀</a>&nbsp;
    	<%
    	for(int j=1; j<=Math.ceil((double)pageCount/maxView); j++){
    	%>
    	<%
    		//주소연결 페이지 네비
    	%>
    	<a href="?page=<%=j %>"><%=j %></a>&nbsp;
    	<%
    	}//end for
    	%>
       	<a href="?page=<%=Math.ceil((double)pageCount/maxView)%>">▶</a>
		<% 	
    }//end if
    	%>
    </center>
    </div>
</section>
</div>
<%@include file = "admin_footer.jsp" %>
</body>
</html>
