<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	
	#memInfo_3 {
		width: 748px;
		height: 140px;
		float:left; 
		margin-top: 10px;
		padding : 10px;	
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

	#memInfo_2 dl dt {
		width: 150px;
		font-weight: bold;
		font-size: 15px;
	}
	#memInfo_3 dl dt {
		width: 100px;
		font-weight: bold;
	}

	#memInfo_2 dl dt,dd{
		float: left;	
		height: 25px;
	}
	
	#memInfo_3 dl dt,dd{
		float: left;	
		height: 25px;
	}
	
	 .admin_value {
	color: #df345c;
	font-family: tahoma,Dotum,Ã«ÂÂÃ¬ÂÂ,Helvetica,AppleSDGothicNeo,sans-serif;
	font-size: 15px;
	font-weight: bold;
	}
	
	#etcInfo{
		width:928px;
		padding-top:10px;
		float:left;
		padding-left:10px;
		
	}
	#etcInfo dl dt {
		width: 100px;
		font-weight: bold;
	}

	#etcInfo dl dt,dd{
		float: left;	
		height: 25px;
	}
	#etcInfo dl dd{
		width:180px;
	}
	
	#pointInfo{
		width:928px;
		padding-top:10px;
		float:left;
		padding-left:10px;
		
	}
	#pointInfo dl dt {
		width: 200px;
		font-weight: bold;
	}

	#pointInfo dl dt,dd{
		float: left;	
		height: 25px;
	}
	#pointInfo dl dd{
		width:700px;
	}
</style>
<script type="text/javascript">
function userDelete(){
	if(confirm("사용자 정보가 삭제됩니다.\n 정말로 삭제하시겠습니까?") == true){
		var url = "admin_memberDelete.jsp?delete_userId="+'<%=request.getParameter("user_id")%>';
		location.href=url;	
	}
}

function userUpdate(){
	if(confirm("정보 바꾸게?") == true){
		var url = "admin_memberRe.jsp?update_userId="+'<%=request.getParameter("user_id")%>';
		location.href=url;	
	} //end if
}// userUpdate
</script>
</head>
<body>
<%@include file = "admin_header.jsp" %>
<div id="contentwrap"> 
<%@include file = "admin_title_member.html" %>
    <div id="title"><img src="images/admin/main/title_01.png" width="253" height="20" /> </div> 
    <div style=" width:220px; float:right; margin-right:10px;"> <a href="admin_main.jsp">메인</a> &gt; <a href="admin_memberInfo.jsp">전체회원정보 </a>&gt; 개인회원정보</div>
    
    <!-- Main div -->
    <div id = "main">
    	<ul>
            <li class="info_list">
		    <%
		     String grade_src="./images/member/level/";
		     String user_id=request.getParameter("user_id")!=null ? request.getParameter("user_id") : "";
		     PreparedStatement pstmt = null;
		     ResultSet rs = null;
		
		     try{%>
		     <%@include file ="db_connect.jsp"%>
			 <%@include file = "grade_number.jsp" %>
            	<!--  간략한 회원정보에 대한 박스 -->
            	<div class="info_listbox">
                
		     <%
				//두 div에서 값 사용. 중간에 ul, li이 있어 데이터 값이 null일 경우 디자인이 무너짐
				//파라메터 값 없이 admin_memberDetail에 접속(null)해도 디자인이 무너지지 않도록 값을 상단에 코딩, map에 저장
		     	String sql = "select to_char(m.memhiredate, 'YYYY-MM-DD') memhiredate, m.memid, m.memnic, m.mempoint, m.memname, m.mememail, m.memaddress, m.memjoomin, m.memans, j.askstring from member m, joinask j where m.memask = j.memask and memid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user_id);
				rs = pstmt.executeQuery();
		     	Map<String, String> user_info = new HashMap<String, String>();	//사용자의 정보 저장
				
				if(rs.next()){ 
					user_info.put("memname", rs.getString("memname"));			//이름
					user_info.put("mememail", rs.getString("mememail"));			//메일
					user_info.put("memaddress", rs.getString("memaddress"));	//주소
					user_info.put("askstring", rs.getString("askstring"));			//질문
					user_info.put("memhiredate", rs.getString("memhiredate"));	//등록일
					user_info.put("memnic", rs.getString("memnic"));				//닉네임
					user_info.put("mempoint", rs.getString("mempoint"));			//포인트
					user_info.put("memans", rs.getString("memans"));				//질문의 답
					user_info.put("memjoomin", rs.getString("memjoomin"));		//주민번호 앞자리
				}//end if
				
				//코멘트의 총 수 ~ Select Table(boardcomment, cinemacomment, moviecomment) 
				pstmt.clearParameters();
				sql = "select count(bcdate) from((select memid, bcdate from cinemacomment union select memid, bcdate from boardcomment) union select memid, bcdate from moviecomment) where memid=?";	
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user_id);
				rs = pstmt.executeQuery();
				if(rs.next()){
					user_info.put("comment_count", rs.getString("count(bcdate)"));	//코멘트 총 수
				}
				
				//게시글 총 수 ~ Select Table(boardMovie)
				pstmt.clearParameters();
				sql = "select count(bdate) from boardmovie where memid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user_id);
				rs = pstmt.executeQuery();
				if(rs.next()){
					user_info.put("boardmovie_count", rs.getString("count(bdate)"));	//게시글 총 수
				}
				%>
                	<div class="listbox_img">
               	    	<a href="#"><img src="images/admin/member/photo.jpg" width="160" height="160" /></a> 
               	    </div> 
               	    <!--  end listbox_img --> 
               	    <!--  회원의 간략한 정보 -->
                	<div id = "memInfo">
	                    <dl>
	                    	<dt> Hiredate</dt> <dd style="width:224px;"> <span class="admin_value"> <%=user_info.get("memhiredate") %></span></dd>
	                        <dt> ID </dt> <dd style="width:81px;">  <span class="admin_value"> <%=user_id %></span></dd> <dt> Nicname </dt> <dd>  <span class="admin_value"> <%=user_info.get("memname") %></span></dd>
	                        <dt> Level </dt> <dd style="width:224px;">  <span class="admin_value"> <img src="<%=user_info.get("mempoint") != null ? grade_src+getGrade(Integer.parseInt(user_info.get("mempoint")))+".gif" : " " %>" /> (<%=user_info.get("mempoint") %>) </span></dd> 
	                        <dt> Board </dt> <dd style="width:81px;">  <span class="admin_value"> <%=user_info.get("boardmovie_count") %> </span></dd>  <dt> Comment </dt> <dd style="width:81px;">  <span class="admin_value"> <%=user_info.get("comment_count") %></span> </dd>
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
            
            <!--  수정하기, 삭제하기 버튼 -->
            <li> 
	             <div style="margin-top:50px; margin-left:100px; width:200px; height:100px; float: left; "> 
	              <a href="#" onclick="userUpdate()"><img src="images/admin/member/button_01.png" width="200" height="40" /> </a> 
	              <div style="height:20px;"></div>
	              <a href="#" onclick="userDelete()"><img src="images/admin/member/button_02.png" width="200" height="40" /></a> </div>  
          	</li>
          	<!--  end 수정하기, 삭제하기 버튼 -->
    	</ul>
    	
    	
        <div  style="width:968px; margin-left:20px; float:left;" >
        	<ul>
            	<li style="width:968px;">
                	<div id = "memInfo_2" >
                    <dl>
                	<dt> Hiredate</dt> <dd style="width:700px;"> <span class="admin_value"> <%=user_info.get("memhiredate") %></span></dd>
                    <dt> ID </dt> <dd style="width:160px;"><span class="admin_value"> <%=user_id %></span></dd>
                    <dt> Nicname </dt> <dd style="width:160px;"><span class="admin_value"> <%=user_info.get("memnic") %></span></dd>
                    <dt>Name</dt> <dd style="width:160px;"><span class="admin_value"> <%=user_info.get("memname") %></span></dd>
                    <dt> 주민등록번호</dt> <dd style="width:160px;"><span class="admin_value"> <%=user_info.get("memjoomin") %> - ******* </span></dd>
                    <dt> E-Mail </dt> <dd style="width:400px;"><span class="admin_value"> <%=user_info.get("mememail") %></span></dd>
                    <dt> Addredd </dt> <dd style="width:700px;"><span class="admin_value"> <%=user_info.get("memaddress") %></span></dd>
                	<dt> 비밀번호찾기 질문</dt> <dd style="width:480px;"><span class="admin_value"> <%=user_info.get("askstring") %></span></dd>
                    <dt> 답 </dt> <dd style="width:160px;"><span class="admin_value">  <%=user_info.get("memans") %></span></dd> 
                    </dl>
                    </div>
                    <!-- end 회원 디테일 정보 박스-->
                    
                    <!-- 기타 활동 정보 -->
                    <div style="width:946px; float:left; margin-top:20px; border:1px solid #CCCCCC; padding:10px;" >
                    	<div style="float:left; font-size:15px; width:930px;"> 
                		<span class="admin_value"> ▶ </span> <strong>활동 정보</strong>
               			</div>
               			<%
                			String[] sqls = {
               					"select count(ltime) from login where memid=?", 
               					"select to_char(ltime, 'yyyy-mm-dd') ltime from(select rownum r, ltime from(select ltime from login where memid=? order by ltime)) where rownum=1",
               					"select count(ltime) from login where memid=? and to_char(ltime, 'mm')=to_char(sysdate, 'mm')",
               					//"select count(bcdate) from((select memid, bcdate from cinemacomment union select memid, bcdate from boardcomment) union select memid, bcdate from moviecomment) where memid=?",			
               					//"select count(bdate) from boardmovie where memid=?",
               					"select count(bdate) from boardmovie where memid=? and to_char(bdate, 'mm')=to_char(sysdate, 'mm')",
               					"select count(orddate) from orderhistory where memid=?",
               					"select gname from (select rownum r, gname from (select gname from orderhistory g, goodsinfo i where g.gcode = i.gcode and memid=? order by orddate desc)) where r=1"         							
               					};
               			//1.방문횟수     2.최근 방문 날짜     3.이달 방문 횟수     
               			/*4.작성 코멘트 수		5.작성 게시물 수  >>	중복사용으로 상단에 코딩	*/     
               			//6.이달 작성글 수     7.구매 상품 수     8.최근 구매 상품
               			String[] etcInfo;
               			etcInfo = new String[]{"0", "-", "0", "0", "0", "-"};
               			String[] etcInfo_title = {"count(ltime)", "ltime", "count(ltime)", "count(bdate)", "count(orddate)", "gname"};
               			for(int i=0; i<sqls.length; i++){
               				pstmt.clearParameters();
               				pstmt = con.prepareStatement(sqls[i]);
               				pstmt.setString(1, user_id);
               				rs = pstmt.executeQuery();
               				if(rs.next()){
               					etcInfo[i] = rs.getString(etcInfo_title[i]);
               				}//end if
               			}//end for 
               			%>
                         <div id="etcInfo">
							<dl>
                            	<dt> 방문 횟수 : </dt> <dd ><span class="admin_value"><%=etcInfo[0] %></span><a href="#"> &lt;more&gt; </a></dd>
                                <dt> 최근 방문 날짜 : </dt> <dd><span class="admin_value"><%=etcInfo[1] %></span></dd>
                                <dt> 이달 방문 횟수 : </dt> <dd><span class="admin_value"><%=etcInfo[2] %></span></dd>
                             	<dt> 작성 게시물 수 : </dt> <dd><span class="admin_value"><%=user_info.get("boardmovie_count") %></span></dd>
                                <dt> 작성 코멘트 수 : </dt> <dd><span class="admin_value"><%=user_info.get("comment_count") %></span></dd>
                                <dt> 이달 작성글 수 : </dt> <dd><span class="admin_value"><%=etcInfo[3] %></span></dd>
                                <dt> 구매 상품 수 : </dt> <dd><span class="admin_value"><%=etcInfo[4] %></span></dd>
                                <dt> 최근 구매 상품 : </dt> <dd><span class="admin_value"><%=etcInfo[5] %></span></dd>
                            </dl>
                        </div>
                    </div> 
                    <!-- end 활동 정보 -->
                    
                    <!-- 포인트 정보: 최신 날짜순으로 10개까지만 select -->
                    <div  style="width:946px; float:left; margin-top:20px; border:1px solid #CCCCCC; padding:10px;" >
                    	<div style="float:left; font-size:15px; width:880px;"> 
                			<span class="admin_value"> ▶ </span> <strong> Point(Level) </strong>
                		</div>
                         <div style="float:right; width:40px;"><a href="#"> more </a></div>
                          <div id="pointInfo">
                          	<dl>
		                    <%
		                    //포인트 출력 ~ Select Table(Point)
		                    sql = "select to_char(ptime, 'YYYY-MM-DD HH24:MI') ptime, ptxt, ppoint from(select rownum r, ptime, ptxt, ppoint from(select ptime, ptxt, ppoint from point where memid=? order by ptime desc)) where r < ?";
		                    pstmt = con.prepareStatement(sql);
		                    pstmt.setString(1, user_id);
		                    pstmt.setInt(2, 11);	//보여줄 개수 + 1
		                    rs = pstmt.executeQuery();
		                    
		                    if(rs.next()){
		                    %>
                            	<dt> <%=rs.getString("ptime") %> </dt> <dd> <span class="admin_value"><%=rs.getString("ptxt") %></span> (으)로 <span class="admin_value"><%=rs.getInt("ppoint") %></span> 점을 얻으셨습니다. </dd>
                           <%}//end if %>
                            </dl>
                          </div>
                    </div>
                    <!-- end 포인트 정보 -->
                </li>
        	</ul>
            <!-- 게시글 조회 ( 한 페이지에 보여지는 게시글 수 : 5 ) -->
            <div  style="width:946px; float:left; margin-top:20px; border:1px solid #CCCCCC; padding:10px;" >
            	<div style="float:left; font-size:15px; width:880px;"> 
                	<span class="admin_value"> ▶ </span>  <strong>작성 게시물 </strong>
                </div>
                <div style="float:right; width:40px;"><a href="#"> more </a></div>
                	<!-- 게시글이미지 -->
	            <%
	            	//게시글 출력 ~ Select Table(boardmovie)
	            	sql = "select to_char(bdate, 'yyyy-mm-dd') bdate, bcategory, bcount, btitle, bcontent from(select rownum r , bdate, bcategory, bcount, btitle, bcontent from (select bdate, bcategory, bcount, btitle, bcontent from boardmovie  where memid=? order by bnumber desc)) where r < ?";
	            	pstmt = con.prepareStatement(sql);
	            	pstmt.setString(1, user_id);
	            	pstmt.setInt(2, 6); //보여줄 개수 + 1
	            	rs = pstmt.executeQuery();
	            	String content="";
	            	if(rs.next()){
	            %>
                    <div class="listbox_img" style="float:left; margin-top:10px;">
                            <a href="#"><img src="images/admin/member/photo.jpg" width="160" height="160" /></a> 
                        </div>
                        <div id = "memInfo_3" >
                            <ul>
                                <dl>
                                <%content = rs.getString("bcontent").replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""); %>
                                    <dt>작성일</dt> <dd style="width:140px;"> <span class="admin_value"><%=rs.getString("bdate") %></span></dd>
                                    <dt>장르</dt> <dd style="width:140px;"> <span class="admin_value"><%=rs.getString("bcategory") %></span></dd>
                                    <dt>조회수/추천수</dt> <dd style="width:140px;"> <span class="admin_value"><%=rs.getString("bcount") %>/567</span></dd>
                                    <dt>제 목</dt> <dd style="width:600px;"> <span class="admin_value"> <%=rs.getString("btitle") %> [코멘트 수]</span></dd>
                                    <dt>내 용</dt> <dd style="width:600px; height:80px;"> <span class="admin_value"> <%=content.length()>200 ? new StringBuffer().append(content.substring(0, 201)).append("...").toString() : content %><%=content.length()>50 ? content.substring(0, 200) + "..." : content %></span></dd>
                                    <!-- 200자 이상 넘어갈 경우 ... 으로 표시 -->
                                </dl>
                            </ul>
                        </div>
                        <!-- end memIfno_3-->
                    <%}//end if %>
            </div>
            <!-- end 작성 게시글 조회 -->
            
            <!-- 내가 쓴 코멘트 종류별 조회. 종류별로 3개씩 조회.-->
            <div  style="width:946px; float:left; margin-top:20px; border:1px solid #CCCCCC; padding:10px;" >
            	<div style="float:left; font-size:15px; width:880px;"> 
                	<span class="admin_value"> ▶ </span> <strong>코멘트 - 최신상영영화</strong></div>
                <div style="float:right; width:40px;"> <a href="#">more</a></div>
                <%
                	//최신상영영화 코멘트 ~ Select Table(moviecomment)
                	sql = "select mcode, to_char(bcdate, 'YYYY-MM-DD HH24:MI') bcdate, bccomment from(select rownum r, mcode, bcdate, bccomment from (select mcode, bcdate, bccomment from moviecomment where memid=? order by bcdate desc)) where r<?";
                	pstmt = con.prepareStatement(sql);
                	pstmt.setString(1, user_id);
                	pstmt.setInt(2, 3); //보여줄 개수 + 1
                	rs = pstmt.executeQuery();
                	if(rs.next()){
                %>
                <div style="width:924px; float:left; margin-left:10px; margin-bottom:10px;">
            	<%=rs.getString("mcode") %>/<%=rs.getString("bcdate") %>
               	 <div style="border:1px dashed;">
                	<span class="admin_value"> 
                    <%=rs.getString("bccomment").length()>50 ? rs.getString("bccomment").substring(0, 51)+"..." : rs.getString("bccomment") %></span>
                 </div>
            </div>
            <%} %>
            
            <div style="float:left; font-size:15px; width:880px;"> 
                	<span class="admin_value"> ▶ </span> <strong>코멘트 - 영화관</strong></div>
                <div style="float:right; width:40px;"> <a href="#">more</a></div>
                <%
             	    //영화관 코멘트 ~ Select Table(cienmacomment)
                	sql = "select ccode, to_char(bcdate, 'YYYY-MM-DD HH24:MI') bcdate, bccomment from(select rownum r, ccode, bcdate, bccomment from (select ccode, bcdate, bccomment from cinemacomment where memid=? order by bcdate desc)) where r<?";
                	pstmt = con.prepareStatement(sql);
                	pstmt.setString(1, user_id);
                	pstmt.setInt(2, 3); //보여줄 개수 + 1
                	rs = pstmt.executeQuery();
                	if(rs.next()){
                %>
                <div style="width:924px; float:left; margin-left:10px; margin-bottom:10px;">
            	<%=rs.getString("ccode") %>/<%=rs.getString("bcdate") %>
               	 <div style="border:1px dashed;">
                	<span class="admin_value"> 
                    <%=rs.getString("bccomment").length()>50 ? rs.getString("bccomment").substring(0, 51)+"..." : rs.getString("bccomment") %></span>
                 </div>
            </div>
            <%} %>
            
                  <div style="float:left; font-size:15px; width:880px;"> 
                	<span class="admin_value"> ▶ </span> <strong>코멘트 - 게시판</strong></div>
                <div style="float:right; width:40px;"> <a href="#">more</a></div>
                <%
                	//게시판 코멘트~Select Table(boardcomment)
                	sql = "select bnumber, to_char(bcdate, 'YYYY-MM-DD HH24:MI') bcdate, bccomment from(select rownum r, bnumber, bcdate, bccomment from (select bnumber, bcdate, bccomment from boardcomment where memid=? order by bcdate desc)) where r<?";
                	pstmt = con.prepareStatement(sql);
                	pstmt.setString(1, user_id);
                	pstmt.setInt(2, 3); //보여줄 개수 + 1
                	rs = pstmt.executeQuery();
                	if(rs.next()){
                %>
                <div style="width:924px; float:left; margin-left:10px; margin-bottom:10px;">
            	<%=rs.getString("bnumber") %>/<%=rs.getString("bcdate") %>
               	 <div style="border:1px dashed;">
                	<span class="admin_value"> 
                    <%=rs.getString("bccomment").length()>50 ? rs.getString("bccomment").substring(0, 51)+"..." : rs.getString("bccomment") %></span>
                 </div>
            </div>
            <%} %>
	      </div>    
        </div> 
      <!-- 코멘트--> 
    </div>
<%
	con.close();
	}catch(Exception e){
		e.printStackTrace();            	    	
	}finally{
        if(pstmt != null){pstmt.close();}
        if(rs != null){rs.close();}
	}
%>
    <!-- end Main -->
</div>
<%@include file = "admin_footer.jsp" %>
</body>
</html>
