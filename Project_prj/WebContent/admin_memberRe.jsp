<!DOCTYPE html>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@page import="com.sun.xml.internal.ws.api.pipe.NextAction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<head>
<meta  charset="utf-8" />
<title>영화보기좋은날 관리자</title>
<link rel="stylesheet" type="text/css" href="css/admin_common.css"/>
<style type="text/css">

	#button a {
		display: block;
	}

	#memInfo_2 {
		width: 946px;
		height: 100%;
		float:left; 
		margin-top:50px;
		border:1px solid #CCCCCC;
		padding : 10px;	
	}
	
	#memInfo_2 img{
		position: relative;
		top: 5px;
	}
	
	#main ul {
		margin: 0px;
		padding: 0px;	
	}
	.info_list_2{
		float: left;
		display: block;
		width: 100%;
		height: 162px;
	}
	#memInfo_2 dl{
		line-height: 30px;
	}
	#memInfo_2 dl dt {
		width: 150px;
		font-weight: bold;
		font-size: 15px;
	}

	#memInfo_2 dl dt,dd{
		float: left;	
	}
	
	 .admin_value {
	color: #df345c;
	font-family: tahoma,Dotum,Ã«ÂÂÃ¬ÂÂ,Helvetica,AppleSDGothicNeo,sans-serif;
	font-size: 15px;
	font-weight: bold;
	}
	
	#bottom_button{
	width:968px;
	height:40px;
	margin-top:20px;
	float:left;
	}
	#bottom_button div{
	width:440px;
	height:40px;
	margin: 0 auto;
	}
	#bottom_button img {
	display:block;
	float: left;
	}
</style>
<script type="text/javascript">
	function update_submit() {
		
		var obj = document.frm;
		
		//비밀번호  일치 체크
		if( obj.pass01.value != obj.pass02.value ){
			alert("비밀번호가 일치하지 않습니다.");
			obj.pass01.focus();
			return;
		}//end if
		
		if( obj.pass01.value.length < 5 || obj.pass01.value.length > 12 ){
			alert("비밀번호는 5~12자리를 입력해 주세요.");
			obj.pass01.focus();
		}//end if
		
		//닉네임 null 체크
		var nickName = obj.nicname.value;
		
		if( nickName == "" ){
			alert("닉네임을 입력해 주세요.");
			obj.nicname.focus();
			return;
		}//end if
		
		//name null 체크
		var name = obj.name.value;
		if( name == "" ){
			alert("이름을 입력해 주세요.");
			obj.name.focus();
			return;
		}//end if
		
		if( name.replace(/[가-힣]/g,"") != "" ){
			alert("이름은 한글만 가능합니다.");
			obj.name.focus();
			return;
		}//end if
		
		//주민번호 null & 6자리 체크
		if( obj.joomin.value == "" ){
			alert("주민번호를 입력해 주세요.");
			obj.joomin.focus();
			return;
		}//end if
		
		if( obj.joomin.value.replace(/[0-9]/g,"") != "" ){
			alert("주민번호는 숫자만 가능합니다.");
			obj.joomin.focus();
			return;
		}//end if
		
		//email 체크
		var email = obj.email1.value;
		if( email == "" ){
			alert("이메일을 입력해 주세요.");
			obj.email1.focus();
			return;
		}//end if
		
		if( email.replace(/[a-z0-9@.]/g,"") != "" ){
			alert("이메일을 정확히 입력해 주세요.");
			obj.email1.focus();
			return;
		}//end if
		
		//우편번호,주소,상세주소 null 체크
		if( obj.add1.value == "" || obj.add2.value == "" || obj.add3.value == "" || obj.add4.value == ""){
			alert("주소 또는 상세주소를 입력해 주세요.");
			obj.add3.focus();
			return;
		}//end if
		
		//비밀번호 답 null 체크
		if( obj.answer.value == "" ){
			alert("비밀번호 질문에 답을 넣어주세요.");
			obj.answer.focus();
			return;
		}//end if
		
		frm.submit();
		
	}// update_submit
	
	//////////////////중복확인//////////////////////////
	function chkNick(){
		
		var obj = document.frm;
		if( obj.nicname.value == "" ){
			alert("닉네임을 입력해 주세요");
			obj.nicname.focus();
			return;
		}//end if
		
		//현재창(부모창) 의 아이디를 받아와서 
		var nick = obj.nicname.value;		
		
		//자식창을 띄운후에 
		var subWin = window.open("search_id.jsp?nick="+nick, "중복체크","width=400,height=300,top=300,left=600");
 		
	}// chkNick
	
	
	///////비밀번호 체크 문구//////////
	function chkPass(){
		var obj = document.frm;
		
		var pass1 = obj.pass01.value;
		var pass2 = obj.pass02.value;
 		var result = "비밀번호가 일치하지 않습니다.";
		
		if(pass1 == pass2 ){
			result = "비밀번호가 일치합니다.";
		}//end if
		
		var formNode = document.getElementById("pass");
		formNode.value=result;
		
	}//end chkPass
</script>
</head>

<body>
<%@include file = "admin_header.jsp" %>
<div id="contentwrap"> 
<%@include file = "admin_title_member.html" %>
<%
	if(request.getParameter("update_userId") != null){%>
		<%@include file ="db_connect.jsp"%>
		<%
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		try{
			StringBuilder sb = new StringBuilder();
			String user_id = request.getParameter("update_userId");
			
			int seq = 0 ;
			String memid = "";
			String memhiredate = "";
			String mempass = "";
			String memname = "";
			String memnic = "";
			String memjoomin = "";
			String memaddress = "";
			String memphone = "";
			String mememail = "";
			String mempoint = "";
			String memask = "";
			String memans = "";
			String photo = "";
			
			sb.
			append("  select seq,	memid,	memhiredate,	mempass,	memname,	memnic,  ").
			append("  memjoomin,	memaddress,	memphone,	mememail	,mempoint,	memask   ").
			append("  ,memans,	photo	from member  where memid =? ");
			
			pstmt = con.prepareStatement(sb.toString());
			
			//바인드변수에 값넣기
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if( rs.next() ){
				seq = rs.getInt("seq");
				memid = rs.getString("memid");
				memhiredate = rs.getString("memhiredate");
				mempass = rs.getString("mempass");
				memname = rs.getString("memname");
				memnic =rs.getString("memnic");
				memjoomin = rs.getString("memjoomin");
				memaddress = rs.getString("memaddress");
				memphone = rs.getString("memphone");
				mememail = rs.getString("mememail");
			    mempoint = rs.getString("mempoint");
				memask =rs.getString("memask");
		        memans = rs.getString("memans");
				photo = rs.getString("photo");
			}//end if
			
			rs.close();
			pstmt.close();
			
  			///////////////게시글수/////////////
			int boardNum = 0;
			
  			String sql = " select count(*) from boardmovie where memid = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			//바인드변수에 값넣기
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if( rs.next() ){
				boardNum = rs.getInt(1);
			}//end if  
			
			rs.close();
			pstmt.close();
			
			////////////영화댓글수////////////////
			int commentMNum = 0;
			
  			sql = " select count(*) from boardcomment where memid = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			//바인드변수에 값넣기
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if( rs.next() ){
				commentMNum = rs.getInt(1);
			}//end if  
			
			rs.close();
			pstmt.close();
			
			
			/////////////게시판댓글수///////////////
			int commentBNum = 0;
			
  			sql = " select count(*) from moviecomment where memid = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			//바인드변수에 값넣기
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if( rs.next() ){
				commentBNum = rs.getInt(1);
			}//end if  
			
			rs.close();
			pstmt.close();
			
			///////질문가지고 오기///////
			
			String[] askString = new String[10];
			String[] ask = new String[10];
			sql = " select memask,askstring from joinask ";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			int i = 0;
			while( rs.next() ){
				ask[i] = rs.getString("memask");
				askString[i] = rs.getString("askstring");
				i++;
			}//end while  
			
			rs.close();
			pstmt.close();
			
		
%>
    <div id="title"><img src="images/admin/main/title_01.png" width="253" height="20" /> </div> 
    <div style=" width:300px; float:right; margin-right:10px;"> <a href="admin_main.jsp">메인</a> &gt; <a href="admin_memberInfo.jsp">전체회원정보 </a>&gt;<a href="#"> 개인회원정보</a> &gt; 회원정보 수정</div>
    
    <!-- Main div -->
    <div id = "main">
    <form name ="frm" method="post" action="admin_memberUpdate.jsp?user_id=<%= user_id %>">
    	<ul>
            <li class="info_list">
            
            	<!--  간략한 회원정보에 대한 박스 -->
            	<div class="info_listbox">
                
                	<div class="listbox_img">
               	    	<a href="#"><img src="images/admin/member/photo.jpg" width="160" height="160" /></a> 
               	    </div> 
               	    <!--  end listbox_img --> 
               	    
               	    <!--  회원의 간략한 정보 -->
                	<div id = "memInfo">
	                    <dl>
	                    	<dt> Hiredate</dt> <dd style="width:224px;"> <span class="admin_value"><%= memhiredate %> </span></dd>
	                        <dt> ID </dt> <dd style="width:81px;">  <span class="admin_value"><%= memid %> </span></dd> <dt> Nicname </dt> <dd>  <span class="admin_value"><%= memnic %></span></dd>
	                        <dt> Level </dt> <dd style="width:224px;">  <span class="admin_value"><img src=""><%= mempoint %> </span></dd> 
	                        <dt> 게시글수 </dt> <dd style="width:81px;">  <span class="admin_value"><%= boardNum %></span></dd>  <dt> 영화댓글수 </dt> <dd style="width:81px;">  <span class="admin_value"><%= commentMNum %></span> </dd>
	                        <dt style="width: 80px;"> 게시판댓글수 </dt> <dd style="width:81px;">  <span class="admin_value"><%= commentBNum %></span> </dd>
	                    </dl>
                    </div>
                    <!--  end memInfo -->
                </div>
                <!--  end info_listbox -->
                
                <!--  아래화살표 -->
                <div style="margin-top:10px; margin-bottom:10px;">
                 	<img src="images/admin/member/img01.png"/> 
              </div>
                 <!--  end 아래화살표 -->
            </li> 
    	</ul>
    	
    	
        <div  style="width:968px; margin-left:20px; float:left;" >
        	<ul>
            	<li style="width:968px;">
                	<div id = "memInfo_2" >
                    <dl>
					<dt> Hiredate</dt> <dd style="width:700px;"> <span class="admin_value"><%= memhiredate %> </span> 가입날짜는 변경하실 수 없습니다.</dd>
                    <dt> ID </dt> <dd style="width:700px;"><span class="admin_value"><%= memid %> </span> 아이디는 변경하실 수 없습니다.</dd>
                    <dt> Pass </dt> <dd style="width:700px;"><input class="admin_value" type="password" value="<%= mempass %>" name="pass01"></dd>
                    <dt> PassCheck </dt> <dd style="width:700px;"><input class="admin_value" type="password" value="<%= mempass %>" name="pass02" onkeyup="chkPass();">  <input type="text" id="pass" style="width: 200px; border: 0px; "></dd>
                    <dt> Nickname </dt> <dd style="width:700px;"><input class="admin_value" type="text" placeholder="<%= memnic %>"  size="15" height="20px" name="nicname" >
                      <a href="#"><img src="images/admin/member/over.png" width="60" height="20" onclick="chkNick();"></a></dd>
                    <dt>Name</dt> <dd style="width:700px;"><input class="admin_value" type="text" placeholder="<%=memname %>" size="15" name="name"></dd>
                    <dt> 주민등록번호</dt> <dd style="width:700px;"><span class="admin_value"><input class="admin_value" type="text" placeholder="<%= memjoomin %>" size="15" name="joomin" maxlength="6"> - ******* </span></dd>
                    <dt> E-Mail </dt> <dd style="width:700px;"><span class="admin_value"> <input class="admin_value" type="text" placeholder="<%=mememail %>" name="email1">
                    
                   </span></dd>
                    <dt> 우편번호 </dt> <dd style="width:700px;"><span class="admin_value"> <input type="text" value="<%= memaddress.split("--")[0].substring(0,3) %>" size="10" name="add1"> - <input type="text" value="<%= memaddress.split("--")[0].substring(4)  %>" size="10" name="add2">
                    </span> <img src="images/admin/member/address.png" width="60" height="20"></dd>
                    <dt> 주 소 </dt> <dd style="width:700px;"><input type="text" value="<%=memaddress.split("--")[1] %>" size="80" name="add3"></dd>
                     <dt> 상세주소 </dt> <dd style="width:700px;"><input type="text" value="<%=memaddress.split("--")[2] %>" size="80" name="add4"></dd>
                   <dt> 비밀번호찾기 질문</dt> <dd style="width:700px;"> 
                    <!-- DB에서 질문을 불러온다. -->
                    <select name="question">
                    <%
                    	for(int k = 0; k < ask.length; k ++ ){
                    %>
                       <option ><%= ask[k]  %>.<%= askString[k]  %></option>
                     <%
                    	}//end for
                     %>  
                    </select>
                    </dd>
                    <dt> 답 </dt> <dd style="width:750px;"><input type="text" value="<%= memans %>" size="80" name="answer">
                      단답형으로 간결하게 작성하여 주세요. </dd>
                    
                    </dl>
                    </div>
                    <!-- end 회원정보 수정 박스 id=memInfo_2-->
                </li>
           </ul>      
      </div>
     <div id="bottom_button"> 
        <div>
        	<!-- <input type="image" src="images/admin/member/button_03.png" onclick="submit();"> -->
            <a href="javascript: update_submit()"><img src="images/admin/member/button_03.png" width="200" height="40"></a>  
            <a href="javascript:history.back()" ><img src="images/admin/member/button_04.png" width="200" height="40" style="margin-left:40px;"></a> 
        </div>
      </div>
        </form>
            <!-- end 외부 테두리 -->       
         
    </div>
    <!-- end Main -->
</div>
<%@include file = "admin_footer.jsp" %>
</body>
</html>
<%
	//con(DB연결)이 try문 안에 있기 때문에 finally가 아닌 여기서 close
			if(con != null){con.close();}
		}catch(SQLException se){
			out.println("<script>alert('SQL 에러가 발생했습니다.');</script>");
			se.printStackTrace();
		}finally{
			if(pstmt != null){pstmt.close();}
		}//end finally
	}//end if

%>