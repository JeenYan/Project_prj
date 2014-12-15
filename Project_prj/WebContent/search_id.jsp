<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
  //나중에 DB 주소 변경
  		String driverName = "oracle.jdbc.OracleDriver";
  		//접속 ip 주소:포트:DB이름
  		String url = "jdbc:oracle:thin:@211.63.89.208:1522:orcl";
  		Class.forName(driverName);
  		Connection con = DriverManager.getConnection(url, "sist1", "tiger");
  		PreparedStatement pstmt=null;
  		ResultSet rs = null;
  		
  		request.setCharacterEncoding("UTF-8");
  		String nickName = "";
  		nickName = new String( request.getParameter("nick").getBytes("8859_1"),"UTF-8");
  		
  		try{
  			
  			String sql = "select memnic from member";
  			pstmt = con.prepareStatement( sql );
  			String result = nickName + " 은 사용 가능합니다.";
  			
  			rs = pstmt.executeQuery();
  			
  			while( rs.next() ){
  				
  				 if( nickName.equals(rs.getString("memnic")) ){
  					result = nickName+" 은/는 존재합니다.다른닉네임을 입력해 주세요.";
  				}
  			}//end while 
  	
    %>
<html>
<head>
<meta charset="UTF-8">
<title>영화보기좋은날</title>
<link rel="shortcut icon" type="image/x-icon" href="images/common/favicon/favicon.ico">
<style type="text/css">
	body{
		overflow: hidden;
	}
	
	#photowrap{
		width: 400px;
		height: 310px;
	}
	#photo_tap {
		width: 400px;
		height: 40px;
		background: url("images/common/search/search_id.gif") no-repeat;
	}
	#close_btn {
		float:right;
		width: 16px;
		height: 16px;
		padding: 12px 12px;
	}
	#content {
		width: 400px;
		height: 210px;
	}
</style>
<script type="text/javascript">

 function chkNick() {
	 
		 var temp_nick = document.cFrm.cNick.value;
		 location.href="search_id.jsp?nick="+temp_nick;
}// chkNick

 function pSub() {
	//현재창(자식창)의 id 값을 가져와서 부모창으로 전달한 뒤 현재창이 닫지면 된다.
	var c_id = document.cFrm.cNick.value;
	
	//부모창(opener)으로 전달한뒤
	opener.window.document.frm.nicname.value = c_id;
	
	//현재창이 닫힌다.
	self.close();
	
}// pSub
 
</script>
</head>

<body>
<div id="photowrap">
	<div id="login_logo"><img src="images/common/login/login_logo.gif" alt="ì¬ì§ìë¡ë íì´ì§"> </div>
    <div id="photo_tap">
			<div id="close_btn"><a href="javascript:self.close()" ><img src="images/common/login/close_btn.png" alt="ë«ê¸°"></a></div>
	</div>
    <div id="content">
   	  <div style="padding-top:70px; padding-left:50px; height:20px;">
       	<form name="cFrm" method="post" action="">
        	<input type="text" name="cNick" style="width:200px; height:18px; border:1px solid #ccc; padding:0; vertical-align:top;" value="<%= nickName%>">
       	  <a href="#" onclick="chkNick()"><img src="images/admin/member/over.png" width="60" height="20"></a>
        </form>
    	</div>
        <div style="padding-left:40px; padding-top:10px;">
        <font size="2">
        <a href="javascript:pSub()"><input type="text" style="width: 800px; border: 0px; cursor: pointer;" value="<%=result %>" name="subNick"></a>
        </font>
        </div>
    </div>
</div>
</body>
</html>
<%
  		}finally {
  			if (rs != null) {
  				rs.close();
  			} //end if
  			if (pstmt != null) {
  				pstmt.close();
  			} //end if
  			if (con != null) {
  				con.close();
  			} // end if
  		}//end finally
%>
