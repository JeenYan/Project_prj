<%-- <%@page import="com.sun.image.codec.jpeg.TruncatedFileException"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
      
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화보기좋은날_관리자</title>
<link rel="stylesheet" type="text/css" href="css/admin_common.css" />
<style type="text/css">

/* admin_common 중복 */
#contentwrap{
	width: 1008px;
	margin-top: 10px;
	margin:0 auto;
	position: relative;
	padding-bottom:40px;
}

#admin_com_text {
  width: 1008px;
  height: 18px;
  padding-top:10px;
  margin:0 auto;
}
/* admin_common 중복 */

#admin_contents {
   width: 100%;
   height: 667px;
   position: relative;
   margin-top: 10px;
}

#admin_contents ul {
   margin-left: -24px;
   padding: 0;
}

.main_info_list {
   float: left;
   margin: 24px 0 0 24px;
}

.main_info_listbox {
   width: 470px;
   height: 180px;
   border: 1px solid #ccc;
   padding: 10px;
   border-radius: 4px;
}

.main_listbox_img {
   float: left;
   width: 158px;
   height: 180px;
}

.listbox_content {
   float: left;
   width: 302px;
   height: 90px;
   padding: 45px 0 45px 10px;
}

.listbox_content dl dd{
	width:200px;
}

.listbox_content label {
   display: none;
   font-size: 16px;
}

.listbox_content dl {
   line-height: 18px;
   margin-top: 20px;
}

.listbox_content dt {
   float: left;
   width: 55px;
   font-weight: bold;
}

.listbox_content dt dd {
   float: left;
   width:100px;
}

.admin_value {
   color: #df345c;
   font-family: tahoma, Dotum, 돋움, Helvetica, AppleSDGothicNeo, sans-serif;
   font-size: 15px;
   font-weight: bold;
}
</style>
<script type="text/javascript">
   
</script>
</head>
<body>
   <%@include file="admin_header.jsp"%>

   <%@include file ="db_connect.jsp"%><%
try {
         DecimalFormat df = new DecimalFormat("00");
         Calendar calendar = Calendar.getInstance();
         String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
         String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
         String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
            String today = year+"-"+month+"-"+day;
         
         int today_hiredate = 0;
         int total = 0;
       

            //////////////오늘 방문자수/////////////
            String sql = "select count(*) from member"; // sql 쿼리
            PreparedStatement pstmt = con.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
            
            //바인드변수 넣기
            // pstmt.setString(1,"ghc4587");

            ResultSet rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
            if(rs.next()){
            total = rs.getInt(1);
            }//end if
            rs.close();
            pstmt.close();
            
            ////////////총 방문자수////////////////
            sql = "select memhiredate from member ";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
             
              while(rs.next()){
                 String hi = rs.getString("memhiredate");
                 String[] sphi = hi.split(" ");
                 
                 if(sphi[0].equals(today)){
                    today_hiredate ++;
                 }//end if
              }//while
            rs.close();
            pstmt.close();
            
            ///////////총 boardmovie(게시판) 수/////////////
            int total_board = 0;
            sql = "select count(*) from boardmovie ";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
             
              if(rs.next()){
              total_board = rs.getInt(1);
              }//end if
            rs.close();
            pstmt.close(); 
            
             ///////////오늘 boardmovie(게시판) 수/////////////
            int today_board = 0;
            sql = "select bdate from boardmovie ";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
                 while( rs.next() ){
                  String hi = rs.getString("bdate");
                  String[] sphi = hi.split(" ");
                  
                  if(sphi[0].equals(today)){
                 today_board ++; 
                  }//end if
            }//end while   
            rs.close();
            pstmt.close();    
            
             /////////////총 상품 수 ////////////
            int total_goods = 0;
            sql = "select count(*) from goodsinfo";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
             
              if(rs.next()){
              total_goods = rs.getInt(1);
              }//end if
            rs.close();
            pstmt.close();  
            
            //////////최신상영영화 코멘트 수 //////////
            int total_movieinfo = 0;
            sql = "select count(*) from movieinfo";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
             
              if(rs.next()){
              total_movieinfo = rs.getInt(1);
              }//end if
            rs.close();
            pstmt.close();  
            
            /////////내가본 최고 영화/////////////
            sql = "select mname,mscorenum,mscorepnum from movieinfo";

            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
              double mScoreNum = 0;
              int mScorePNum = 0;
              double tempScore = 0;
              String mName = "";
              
               while( rs.next() ){
                  mScoreNum = rs.getInt("mscorenum");                 
                  mScorePNum = rs.getInt("mscorepnum");                 
                  if( mScorePNum != 0){
                  if( mScoreNum/mScorePNum > tempScore ){
                     tempScore = mScoreNum/mScorePNum;
                        mName = rs.getString("mname");
                  }//end if
                  }//end if
            }//end while     
               
            rs.close();
            pstmt.close();  
            
            ///////////영화관 총 정보 수////////////
            int total_cinema = 0;
            sql = "select count(*) from cinemainfo";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
             
              if(rs.next()){
              total_cinema = rs.getInt(1);
              }//end if
            rs.close();
            pstmt.close(); 
            ////////////내가가본 최고 영화관 //////////////
            sql = "select ccode,cloc,cscorenum,cscorepnum from cinemainfo";

            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
              double cScoreNum = 0;
              int cScorePNum = 0;
              double ctempScore = 0;
              String cloc = "";
              String ccode = "";
              String cinemaName="";
              
               while( rs.next() ){
                  cScoreNum = rs.getInt("cscorenum");                 
                  cScorePNum = rs.getInt("cscorepnum");                 
                  if( cScorePNum != 0){
                  if( cScoreNum/cScorePNum > ctempScore ){
                     ctempScore = cScoreNum/cScorePNum;
                        cloc = rs.getString("cloc");
                        ccode = rs.getString("ccode");
                        if( ccode.substring(0,2).equals("CC") ){
                           cinemaName = "CGV";
                        }else if( ccode.substring(0,2).equals("CM") ){
                           cinemaName = "메가박스";
                        }else if( ccode.substring(0,2).equals("CR") ){
                           cinemaName = "롯데시네마";
                        }else if( ccode.substring(0,2).equals("CP") ){
                           cinemaName = "프리머스";
                        }//end if
                  }//end if
                  }//end if
            }//end while     
               
            rs.close();
            pstmt.close();  
            
            //////회원계급관리////////
            sql = "select memid,memname,mempoint from member order by mempoint desc";
            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
              String tempName = "";
              int[] maxPoint = new int[2];
              String[] maxName = new String[2];
              String[] maxId = new String[2];
              
              if( rs.next() ){
                 maxId[0] = rs.getString("memid");
                 maxPoint[0] = rs.getInt("mempoint");
                 maxName[0] = rs.getString("memname");
            }//end if    
            
              if( rs.next() ){
                 maxId[1] = rs.getString("memid");
                 maxPoint[1] = rs.getInt("mempoint");
                 maxName[1] = rs.getString("memname");
            }//end if    
               
               
            rs.close();
            pstmt.close();  
            
            ////////////BEST 상품 //////////////
            sql = "select gname,gpnum from goodsinfo";

            pstmt = con.prepareStatement(sql);
              rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
              String gName = "";
              int gPNum = 0;
              int tempPNum = 0;
//               String tempGName = "";
              
               while( rs.next() ){
                  gPNum = rs.getInt("gpnum");        
                  
                  if( gPNum != 0){
                     
                  if( gPNum > tempPNum ){
                     tempPNum = gPNum;
                        gName = rs.getString("gname");                 
//                         tempGName = gName;                 
                  }//end if
                  
                  }//end if
            }//end while     
               
            rs.close();
            pstmt.close();  
            
       %>
   <div id="contentwrap">
      <div class="contents">
         <article id="admin_contents">
            <div style="margin-top: 40px; float: right; width: 1008px;">
               <img src="images/admin/main/top_02.png" width="181" height="18">
            </div>
            <ul>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="admin_memberInfo.jsp"><img
                           src="images/admin/main/button_01.png" /></a>
                     </div>
        

                      <div class="listbox_content">
                        <label>회원의 정보를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_01.png" />
                        <dl>
                           <dt>TOTAL</dt>
                           <dd>
                              <span class="admin_value"><%= total  %></span> 명
                           </dd>
                           <dt>TODAY</dt>
                           <dd>
                              <span class="admin_value"> <%= today_hiredate %> </span> 명
                           </dd>
                        </dl>
                     </div>
                  </div>
               </li>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="#"><img src="images/admin/main/button_02.png" /></a>
                     </div>
                     <div class="listbox_content">
                        <label>회원의 계급 정보를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_02.png" />
                        <dl>
                           <dt>1위</dt>
                           <dd class="admin_value"><%= maxName[0] %>(<%= maxPoint[0] %>)P</dd>
                           <dt>2위</dt>
                           <dd class="admin_value"><%= maxName[1] %>(<%= maxPoint[1] %>)P</dd>
                        </dl>
                     </div>
                  </div>
               </li>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="#"><img src="images/admin/main/button_03.png" /></a>
                     </div>
                     <div class="listbox_content">
                        <label>최신 상영 영화를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_03.png" />
                        <dl>
                           <dt>TOTAL</dt>
                           <dd>
                              <span class="admin_value"><%= total_movieinfo %></span> 건
                           </dd>
                           <dt>BEST</dt>
                           <dd class="admin_value"><%=mName %>(<%= Math.floor(tempScore*10)/10 %>)</dd>
                        </dl>
                     </div>
                  </div>
               </li>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="#"><img src="images/admin/main/button_04.png" /></a>
                     </div>
                     <div class="listbox_content">
                        <label>영화관 정보를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_04.png" />
                        <dl>
                           <dt>TOTAL</dt>
                           <dd>
                              <span class="admin_value"> <%= total_cinema %></span> 건
                           </dd>
                           <dt>BEST</dt>
                           <dd>
                              <span class="admin_value"><%=cloc %>(<%= cinemaName %>)</span>
                           </dd>
                        </dl>
                     </div>
                  </div>
               </li>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="#"><img src="images/admin/main/button_05.png" /></a>
                     </div>
                     <div class="listbox_content">
                        <label>게시판과 코멘트를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_05.png" />
                        <dl>
                           <dt>TOTAL</dt>
                           <dd>
                              <span class="admin_value"><%=  total_board %></span>건
                           </dd>
                           <dt>TODAY</dt>
                           <dd>
                              <span class="admin_value"> <%= today_board %></span>건
                           </dd>
                        </dl>
                     </div>
                  </div>
               </li>
               <li class="main_info_list">
                  <div class="main_info_listbox">
                     <div class="main_listbox_img">
                        <a href="#"><img src="images/admin/main/button_06.png" /></a>
                     </div>
                     <div class="listbox_content">
                        <label>상품 정보를 관리할 수 있습니다.</label><img
                           src="images/admin/main/title_06.png" />
                        <dl>
                           <dt>TOTAL</dt>
                           <dd class="admin_value"> <%=  total_goods %> </dd>
                           <dt>BEST</dt>
                           <dd class="admin_value"><%= gName %>(<%= tempPNum  %>)개</dd>
                        </dl>
                     </div>
                  </div>
               </li>
            </ul>
         </article>
      </div>
   </div>
   <!-- end div contentwrap -->
   <%@include file="admin_footer.jsp"%>
<%
         con.close();         
         } catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
            e.printStackTrace();
         } finally{
            if( con != null){ con.close(); }
         }//end finally
         
%>
</body>
</html>