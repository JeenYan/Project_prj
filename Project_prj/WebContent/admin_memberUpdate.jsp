<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	
<%
	request.setCharacterEncoding("UTF-8");

		/////////////memberRe 페이지에서 값 받아오기/////////////
			String user_id = request.getParameter("user_id");
			String pass = request.getParameter("pass02");
			String nickName = request.getParameter("nicname");
			String name = request.getParameter("name");
			String ssd = request.getParameter("joomin");
			String email = request.getParameter("email1");
			String add1 = request.getParameter("add1");
			String add2 = request.getParameter("add2");
			String add3 = request.getParameter("add3");
			String add4 = request.getParameter("add4");
 			String add = add1+"-"+add2+"--"+add3+"--"+add4;
			String question = request.getParameter("question");
			String answer = request.getParameter("answer");

	/////////////디비연동후 업데이트////////////////
			//나중에 DB 주소 변경
			String driverName = "oracle.jdbc.OracleDriver";
			//접속 ip 주소:포트:DB이름
			String url = "jdbc:oracle:thin:@211.63.89.208:1522:orcl";
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(url, "sist1", "tiger"); 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {

				//4. 쿼리문 생성객체 얻기
				StringBuilder updateDiary = new StringBuilder();
				updateDiary.append("  update member      ")
						.append("  set mempass = ? , memnic = ? , memname = ? ,   ")
						.append("  memjoomin = ? , mememail= ? , ")
						.append(" memaddress = ? , memask = ? , memans = ? ")
						.append(" where memid = ?  ");
				
				
				pstmt = con.prepareStatement(updateDiary.toString());
				
				//바인드변수 값넣기
				pstmt.setString(1, pass );
				pstmt.setString(2, nickName  );
				pstmt.setString(3, name  );
				pstmt.setString(4, ssd  );
				pstmt.setString(5, email  );
				pstmt.setString(6,  add );
				pstmt.setString(7, question.substring(0, 1)  );
				pstmt.setString(8, answer  );
				pstmt.setString(9,  user_id  );

				//5. 쿼리수행후 결과 얻기
				if (pstmt.executeUpdate() == 1) {
					%>
					alert("변경성공");	
					location.href = "admin_memberRe.jsp?update_userId="+'<%= user_id %>';
					<%
				}//end if
			}catch(SQLException se){
				se.printStackTrace();
				%>
				alert("서버에 문제가 있습니다.");
				<%
			} finally {
				//6. 연결 끊기
				if (pstmt != null) {
					pstmt.close();
				} //end if
				if (con != null) {
					con.close();
				} // end if
			}//end finally
%>  
</script>

