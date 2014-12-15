<%@page import="java.io.UnsupportedEncodingException"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최신 영화 정보</title>
<link rel="shortcut icon" type="image/x-icon" href="images/common/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<style type="text/css">

#contents {
	background-color: #f3f3f3;
}
#content_area {
	position:relative;
	width: 1008px;
	margin: 0 auto;
	padding-top: 60px;
}

.location {
	position: absolute;
	top: 30px;
	right: 0;
	font-size:  15px;
}
.location_home {
	background: url("images/common/contents/location_bg01.png") no-repeat 0 3px !important;
}
.location dd {
	float: left;
	padding-left: 16px;
	background: url("images/common/contents/location_bg02.png") no-repeat 7px center;
}
.skip {
	position: absolute;
	top: -5000px;
	text-indent: -5000px;
	font-size: 0;
	line-height: 0;
	width: 0;
	height: 0;
}
.con_wrap {
	width: 1008px;
}
.search_wrap {
	width: 1008px;
	height: 30px;
}
.search {
	width: 185px;
	height: 30px;
	float: right;
}
.new_movie_search {
	width: 138px;
	height: 28px;
	border: 1px solid #ccc;
	padding: 0 5px;
}
.search_btn {
	background: url("images/common/search_btn.png") no-repeat;
	width:30px;
	height: 30px;
	border: 0;
	font-family: FontAwesome;
	cursor: pointer;
}
.new_movieWrap {
	width: 1008px;
}
.new_movieWrap ul {
	margin-top: -10px;
}
.new_movieWrap li {
	margin-top: 20px;
}
.new_movieBox {
	background-color: #fff;
	width: 100%;
	height: 337px;
	border-top: 3px solid #f72d5d;
	box-shadow: 1px 1px 3px #ddd;
}
.new_movieBox:hover .con_top {
	padding-bottom: 19px;
	border-bottom: 5px solid #f72d5d;
}
.new_movie_img {
	float: left;
	width: 236px;
	height: 337px;
}
.new_movie_img img {
	width: inherit;
	max-width: 100%;
	height: auto;
}
.con_box {
	float: right;
	width: 772px;
	height: 337px;
	font-family: 'Nanum Gothic';
}
.con_top {
	width: 712px;
	height: 68px;
	padding: 22px 0;
	border-bottom: 2px solid #eee;
	margin: 0 auto;
		transition: all 0.3s ease;
}

.con_top a {
	text-decoration: none;
}
.con_top a:hover {
	color: #f72d5d;
}
.con_top dl {
	float: left;
	position: relative;
	width: 470px;
	height: 50px;
	padding-top: 20px;
}
.con_top dt {
	float: left;
	font-size: 30px;
	font-weight: bold;
}
.con_top dd {
	float: left;
	font-size: 15px;
	font-weight: bold;
	padding-left: 5px;
	position: relative;
	top: 16px;
}
.gread_box {
	float: left;
	width: 242px;
	height: 70px;
}
.gread_star {
	float: left;
	width: 172px;
	height: 70px;
}
.star_off {
	display: block;
	width: 142px;
	height: 24px;
	background: url("images/common/contents/star_off.png") no-repeat 0 20px; 
	padding-top:20px;
}
.star_on {
	display: block;
	height: 24px;
	background: url("images/common/contents/star_on.png") no-repeat;
}
.gread_score {
	float: right;
	width: 70px;
	height: 70px;
	background: url("images/common/contents/gread_score_bg.png");
}
.gread_score strong {
	display: block;
	color: white;
	font-size: 30px;
	text-align: center;
	position: relative;
	top: 15px;
}
.con_bottom {
	width: 712px;
	height: 173px;
	padding-top: 20px;
	margin: 0 auto;
	font-size: 13px;
}
.con_bottom dl {
	line-height: 20px;
}
.con_bottom dt {
	float: left;
	width: 40px;
	color: #666;
	font-weight: bold;
}
.con_bottom dd {
}
.story {
	float:none !important;
}
.story_text {
	text-indent: 5px;
}
.paging {
	position: relative;
	padding: 25px;
	width: 470;
	height: 24px;
	text-align: center;
}
.paging div {
	display: inline-block;
	margin: 0 auto;
	text-align: center;
	float: none;
}
.paging a {
	display: block;
	float: left;
	position: relative;
	width: 24px;
	height: 24px;
	line-height: 24px;
	font-size: 14px;
	text-decoration: none;
}
.paging a:hover {
	font-size: 18px;
	font-weight: bold;
}
.paging a em {
	display: block;
	text-indent: -9999em;
}
.pg_prev {
	background: url("images/common/pg_btn.png") no-repeat;
}
.pg_next {
	background: url("images/common/pg_btn.png") no-repeat -48px 0;
}
</style>
<script type="text/javascript">
function popup(){
	window.open("login.html","pop","width=400, height=310, scrollbars=no, top=200, left=500");
}//popup
function search_btn(){
	var obj = document.searchFrm;
	//빈칸 검사
	var search = obj.inputSearch.value.replace(/(^\s*)|(\s*$)/g, "");
	if(search == ""){
		alert("영화제목을 입력하세요.");
		//빈칸의 경우 잘못된 값으로 검색-> null 대입
		obj.inputSearch.value=null;
		return;
	}//end if
	obj.submit;
}
</script>
</head>
<body>
	<header>
		<div id="top_wrap">
		<div id="top_nav">
			<nav>
				<ul id="nav_list">
					<li><a href="javascript:popup()">로그인</a></li>
					<li><a href="join.html">회원가입</a></li>
					<li><a href="">Mypage</a></li>
				</ul>
			</nav>
		</div>
		<div id="top_menu">
			<div id="logo">
				<a href="index.html"><img src="images/common/header/logo.png"/></a>
			</div>
			<div id="gnv">
				<ul>
					<li id="gnv_newmovie"><a href="sub_movieinfo.html" title="최신 영화 정보">최신 영화 정보</a></li>
					<li id="gnv_movieinfo"><a href="#" title="영화관 정보">영화관 정보</a></li>
					<li id="gnv_community"><a href="#" title="영화 커뮤니티">영화 커뮤니티</a></li>
					<li id="gnv_shop"><a href="#" title="SHOP">SHOP</a></li>
				</ul>
			</div>
		</div>
		</div>
	</header>
	<!-- contents -->
	<section id="contents">
		<div id="content_area">
			<dl class="location">
				<dt class="skip">현재위치</dt>
				<dd class="location_home"><a href="index.html">HOME</a></dd>
				<dd><strong>최신 영화 정보</strong></dd>
			</dl>
			<div class="con_wrap">
				<div class="search_wrap">
					<form name="searchFrm" action="sub_movieInfo.jsp" method="get">
						<div class="search">
							<input type="text" name="inputSearch" maxlength="20" placeholder="검색" autofocus="autofocus" class="new_movie_search">
							<input type="submit" onclick="search_btn()" value="" class="search_btn" alt="검색" title="검색"/>
						</div>
					</form>
				</div>
				<div class="new_movieWrap">
					<ul>
					<%
						PreparedStatement	pstmt = null;
						ResultSet rs = null;
						PreparedStatement sub_pstmt = null;
						ResultSet sub_rs = null;
						
						try{
					%>
					<%@include file ="db_connect.jsp"%>
					<%
						int allItem = 0;	//모든 영화의 수(초기값 0)
						int viewItem = 5; //한 페이지에 보여줄 영화의 수
						int CmaxLength = 200;	//내용 최대 글자수
						int startNum = 1, endNum = viewItem;	//처음과 마지막에 보여질 영화의 번호(mopen일 정렬, rownum 순서)
						
						//처음과 마지막에 보여질 번호값 설정(파라메터 page 값을 받아 결정)
						if(request.getParameter("page")!=null){
							int pageNum = Integer.parseInt(request.getParameter("page"));
							startNum = viewItem*(pageNum-1)+1;
							endNum = viewItem*pageNum;
						}//end if

						String people=""; //출연진
						String[] pcode=null; //감독, 출연진 코드값
						String inputSearch = null;	//검색값
						StringBuilder sub_sql = null; 
						StringBuilder sql= new StringBuilder();
						
						//검색값이 있을 때
						if(request.getParameter("inputSearch") != null){
							inputSearch = request.getParameter("inputSearch");
							//검색값의 인코딩을 UTF-8로 변경(GET으로 전달)
							inputSearch = new String(inputSearch.getBytes("8859_1"), "UTF-8");

							//검색의 결과 출력될 영화의 수 저장
							sql.append("select count(mname) from movieinfo where mname like '%' || ? || '%'");
							pstmt = con.prepareStatement(sql.toString());
							pstmt.setString(1, inputSearch); //검색할 값 입력
							rs = pstmt.executeQuery();
							if(rs.next()){ allItem = rs.getInt("count(mname)");}//end if
							
							sql.setLength(0); //StringBuild 값 초기화
							//페이지 별로 보여질 검색된 영화의 정보 출력
							sql.append("select mdate, mcode, mname, pcode, mscorenum, mscorepnum, mruntime, mopen, mexplain from(select rownum r, mdate, mcode, ")
							.append("mname, pcode, mscorenum, mscorepnum, mruntime, mopen, mexplain from(")
									.append("select mdate, mcode, mname, pcode, mscorenum, mscorepnum, mruntime, mopen, mexplain from movieinfo where mname like '%' || ? || '%' order by mopen desc")
									.append(")) where r between ? and ?");
							pstmt = con.prepareStatement(sql.toString());
							pstmt.setString(1, inputSearch); //검색할 값 입력
							pstmt.setInt(2, startNum);
							pstmt.setInt(3, endNum);
						}else{
							//최신영화의 수 저장
							sql.append("select count(mname) from movieinfo");
							pstmt = con.prepareStatement(sql.toString());
							rs = pstmt.executeQuery();
							if(rs.next()){ allItem = rs.getInt("count(mname)");}//end if
							
							sql.setLength(0);//StringBuild 값 초기화
							//페이지 별로 보여질 최신 영화의 정보 출력
							sql.append("select mcode, mname, pcode, mscorenum, mscorepnum, ")
							.append("mruntime, mopen, mexplain from(select rownum r, mcode, mname, pcode, ")
							.append("mscorenum, mscorepnum, mruntime, mopen, mexplain from(select mcode, mname, ")
							.append("pcode, mscorenum, mscorepnum, mruntime, mopen, mexplain from movieinfo ")
							.append("order by mopen desc)) where r between ? and ?");
							
							pstmt = con.prepareStatement(sql.toString());
							pstmt.setInt(1, startNum);
							pstmt.setInt(2, endNum);
						}
						rs = pstmt.executeQuery();
						
						//정보 출력
						while(rs.next()){ %>
						<li>
						<div class="new_movieBox" id="box_001">
							<div class="new_movie_img">
								<a href="#"><img src="./images/movie/<%=rs.getString("mcode")%>.jpg" /></a>
							</div>
							<div class="con_box">
								<div class="con_top">
									<dl>
										<dt><a href="#"><%=rs.getString("mname") %></a></dt>
										<!--<dd>Interstellar</dd>-->
										<dd><%=rs.getString("mopen").substring(0, 4) %></dd>
									</dl>
									<div class="gread_box">
										<div class="gread_star">
											<span class="star_off"><!-- 소수점 제거-->
												<span class="star_on" style="width: <%=String.format("%.0f", rs.getDouble("mscorenum")/rs.getDouble("mscorepnum")*20) %>%"></span>
											</span>
										</div>
										<div class="gread_score"><!-- 소수점 한자리까지 출력-->
											<strong><%=String.format("%.1f", rs.getDouble("mscorenum")/rs.getDouble("mscorepnum")) %></strong>
										</div>
									</div>
								</div>
								<div class="con_bottom">
									<dl>
										<dt>장르</dt>
										<dd>
										<%
										//장르 출력 ~ select table(movieinfo, moviecategory)
										sub_sql = new StringBuilder();
										sub_sql.append("select mcategory from movieinfo i, moviecategory m ")
										.append("where m.mcode=i.mcode and m.mcode=?");
										sub_pstmt = con.prepareStatement(sub_sql.toString());
										sub_pstmt.setString(1, rs.getString("mcode"));
										sub_rs = sub_pstmt.executeQuery();
										if(sub_rs.next()){
											out.println(sub_rs.getString("mcategory"));
										}//end if
										%>
										</dd>
									</dl>
									<dl>
										<dt>감독</dt>
										<dd>
										<%
										//감독 및 출연진 코드값(pcode)을 , 로 구분해 배열에 저장
										pcode = rs.getString("pcode").split(",");
										sub_sql.setLength(0);//초기화
										//pcode > CHAR(14), pcode에 붙은 공백값으로 인해 %를 붙임
										sub_sql.append("select pname from peopleinfo where pcode like ? || '%'");
										sub_pstmt = con.prepareStatement(sub_sql.toString());
										//trim : 본타:땅콩왕국의 전설-출연진을 입력하지 않아 감독에 공백이 생김 > 출연진 추가 입력 시 삭제 가능
										sub_pstmt.setString(1, pcode[0].trim());
										sub_rs = sub_pstmt.executeQuery();
										if(sub_rs.next()){
											out.println(sub_rs.getString("pname"));
										}//end if
										%>
										</dd>
									</dl>
									<dl>
										<dt>출연</dt>
										<dd>
										<% 
										//출연진 출력
										people="";//이전값 초기화
										for(int i=1; i < pcode.length; i++){
											sub_pstmt.clearParameters(); //파라메터 제거
											sub_pstmt.setString(1, pcode[i].trim());
											sub_rs = sub_pstmt.executeQuery();
											if(sub_rs.next()){
												//출연진 목록 덧붙여 저장
												people += sub_rs.getString("pname");
												if(i!=pcode.length-1){//마지막의 경우 , 제외
													people += ", ";
												}//end if
											}//end if
										}//end for
										
										out.println(people);
										%>
										</dd>
									</dl>
									<dl>	<!-- 날짜의 -를 .으로 표기 -->
										<dt>개봉</dt><dd><%=rs.getString("mopen").substring(0, 10).replace("-", ".") %></dd>
									</dl>
									<dl>
										<dt class="story">줄거리</dt>
										<dd>
										<!-- 글자수 200자 제한 -->
										<%=rs.getString("mexplain").length()>CmaxLength ? rs.getString("mexplain").substring(0, CmaxLength)+"..." : rs.getString("mexplain") %>
										</dd>
									</dl>
								</div>
							</div>
						</div>
						</li>
						<%}//end while %>
					</ul>
				</div>
				<div class="paging">
					<!-- 페이지 표시 -->
					<%if(allItem > viewItem){%>
					<div>
					<a href="?page=1<%=(inputSearch != null || "".equals(inputSearch) ) ? "&inputSearch="+inputSearch : ""%>" class="pg_prev"><em>이전</em></a>
			    	<%for(int j=1; j<=(int)Math.ceil((double)allItem/viewItem); j++){%>
    				<a href="?page=<%=j %><%=(inputSearch != null || "".equals(inputSearch) ) ? "&inputSearch="+inputSearch : ""%>"><span><%=j %></span></a>
			    	<%}//end for	%>
					<a href="?page=<%=(int)Math.ceil((double)allItem/viewItem)%><%=(inputSearch != null && "".equals(inputSearch) ) ? "&inputSearch="+inputSearch : ""%>" class="pg_next"><em>다음</em></a>
					</div>
					<%}//end if
					
						con.close();
					}catch(SQLException se){
						se.printStackTrace();
					}catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}finally{
						//연결 끊기
						if(sub_pstmt != null){ pstmt.close();}
						if(sub_rs != null){ rs.close();}
						if(pstmt != null){ pstmt.close();}
						if(rs != null){ rs.close();}
					}
					%>
				</div>
			</div>
		</div>
	</section>
	<div id="footerwrap">
		<footer>
			<div id="footer_con">
				<div id="footer_logo">
					<img src="images/common/footer/footer_logo.png"/>
				</div>
				<div id="footer_info">
					<div id="footer_menu">
						<a href="#">회사소개</a><span class="footer_line">|</span>
						<a href="#">제휴문의</a><span class="footer_line">|</span>
						<a href="#">이용약관</a><span class="footer_line">|</span>
						<a href="#">개인정보 취급방침</a><span class="footer_line">|</span>
						<a href="#">고객센터</a>
					</div>
					<div id="footer_copy">
						경기도 성남시 분당구 탄천로 215 탄천종합운동장 (야탑동 486 탄천종합운동장 주경기장 내)<br/>
						대표자명 오화연 | 개인정보관리책임자 제휴&솔루션 본부장 이용훈 | 사업자등록번호 123-45-67890 | 통신판매업신고번호 제 123호<br/>
						Copyright 2014 by MOVIE DAY. All rights reserved
					</div>
				</div>
			</div>
		</footer>
	</div>
</body>
</html>