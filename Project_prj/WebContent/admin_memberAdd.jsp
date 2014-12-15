<!DOCTYPE html>
<%@page import="dao.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<head>
<meta  charset="utf-8" />
<title>영화보기좋은날 관리자</title>
<link rel="stylesheet" type="text/css" href="css/admin_common.css"/>
<style type="text/css">
	#photo{
	margin:0 auto; 
	width: 160px;
	padding: 10px;
	border: 1px solid #ccc;
	margin-top:40px;
	}
	#memInfo_2 {
		width: 946px;
		height: 425px;
		margin:0 auto;
		margin-top:20px;
		border:1px solid #CCCCCC;
		padding : 10px;	
	}
	#memInfo_2 ul dl{
		line-height: 30px;
	}
	#memInfo_2 ul dl dt {
		width: 150px;
		font-weight: bold;
		font-size: 15px;
		float: left;	
	}

	#memInfo_2 dl dt,dd{
		float: left;	
		width:700px;
		
	}
	.admin_value {
	color: #df345c;
	font-family: tahoma,Dotum,Ã«ÂÂÃ¬ÂÂ,Helvetica,AppleSDGothicNeo,sans-serif;
	font-size: 15px;
	font-weight: bold;
	margin:0px
	}
	
	#memInfo_2 img{
		position: relative;
		top: 7px;
	}
</style>
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<script>
	function search_post(){
		window.open("search_address.jsp", "주소 검색", "scrollbars=yes, width=510, height=300, left=500, top=200");
		return;
	}

	function popup(){
		window.open("admin_photo.jsp","pop","width=400, height=310, scrollbars=no, top=200, left=500");
	}//popup

	function view(input){
	 	var flag=false;
		var obj=document.mfrm;
		var fileName=obj.upload.value;
		 if(fileName == ""){
			alert("파일을 선택해주세요.");
			return;
		}//end if
		
		//업로드 가능 확장자 체크
		var chkExt=["png", "jpg", "gif"];
		var fileArr=fileName.split(".");
		var ext=fileArr[fileArr.length - 1];
		for(var i=0; i<ext.length; i++){
			if(chkExt[i] == ext){
				flag = true;
			}//end if
		}//for
		
		if(!flag){
			alert("업로드 허용 파일이 아닙니다.");
			return;
		}//end if
		
 		var reader = new FileReader();
		reader.onload = function(e){
			$("#photo img").attr("src", e.target.result);
		}//end function
		reader.readAsDataURL(input.files[0]); 
	}//view
	
	function idChk(id){
		alert(id.value);
		var flag = <%=md.findId(id)%>;
		if(flag){
			$("#id_result").html("");
		}
		return;
	}//idChk
</script>
</head>
<body>
<%@include file = "admin_header.jsp" %>
<div id="contentwrap"> 
<%@include file = "admin_title_member.html" %>
    <div id="title"><img src="images/admin/main/title_01.png" width="253" height="20" /> </div> 
    <div style=" width:270px; float:right; margin-right:10px;"> <a href="admin_main.jsp">메인</a> &gt; <a href="admin_memberInfo.jsp">전체회원정보 </a> &gt; 회원 추가</div>
    
    <!-- Main div -->
    <div id = "main">
    <form name="mfrm" enctype="multipart/form-data" action="test.jsp" method="post">
    	<!-- 회원 사진 -->
      <div style="width:1008px;">
        <div id="photo">
            <img src="images/member/photo/photo.jpg" width="160" height="160"> 
       </div>
      </div>
        <!-- 회원사진 end -->
        
        <!-- 사진등록 버튼 -->
        <div style="width:1008px; padding-top:10px;">
        	<div style="width:100px; margin:0 auto;">
            	<!-- <a href="javascript:popup()"> -->
   	    			<img src="images/admin/member/button_06.png" width="100" height="20" onclick="$('input[type=file]').click();" /> 
        		<!-- </a> -->
            </div>
        </div>
        <!-- 사진등록 버튼 end -->
        
		<div id="memInfo_2">
        	<ul>
            	<dl>
                	<dt> 아이디 </dt> <dd> <input class="admin_value" type="text" value="" name="id" onBlur="idChk(this)"> 
                	  <img src="images/admin/member/over.png" width="60" height="20">
                	  <span id="id_result"></span>
                	  </dd>
                    <dt> 비밀번호 </dt> <dd><input class="admin_value" type="password" value="" name="pass01">  비밀번호는 소문자와 숫자의 조합으로 작성하여주세요.</dd>
					<dt> 비밀번호 확인 </dt> <dd><input class="admin_value" type="password" value="" name="pass02"> <!-- 비밀번호가 일치하는지 일치하지않는지 text가 뜬다.--></dd>
					<dt> 닉네임 </dt> <dd><input class="admin_value" type="text" value="" name="nicname" readonly> 
                    <img src="images/admin/member/over.png" width="60" height="20"> </dd>    
                    <dt> 이름 </dt> <dd><input class="admin_value" type="text" value="" name="name" > </dd>
                    <dt> 생년월일 </dt> <dd><input class="admin_value" type="text" value="" name="joomin" > ex) 920914 </dd>
                     <dt> 주소 </dt> <dd><input class="admin_value" style="width:80px;" type="text" value="" name="add01" readonly > 
                       <a href="javascript:search_post()"><img src="images/admin/member/address.png" width="60" height="20"> <br/></a>
                       <input class="admin_value" style="width:400px;" type="text" value="" name="add02" readonly >
                       </dd>
                    <dt> 상세 주소 </dt> <dd><input class="admin_value" style="width:400px;" type="text" value="" name="add03" > </dd>
                    <dt> 핸드폰번호 </dt>
                    <dd>
                    <select name = "phoneSelect" class ="admin_value">
                    	<option value= "010"> 010 </option>
                    	<option value= "011"> 011 </option>
                    	<option value="017"> 017 </option>
                    </select> 
                    -
                    <input class="admin_value" style="width:60px;" type="text" value="" name="phone01" >
                    -
                    <input class="admin_value" style="width:60px;" type="text" value="" name="phone02" >
                    </dd>
                    <dt> email </dt> <dd> <input class="admin_value" style="width:120px;" type="text" value="" name="phone02" >
                    @
                    <select name="email" class="admin_value">
                    	<option value="naver.com"> naver.com</option>
                    	<option value="google.com"> google.com</option>
                    	<option value="daum.net"> daum.net </option>
                    	<option value="direct"> 직접입력 </option>
                    </select>
                    </dd>
                    <dt> point </dt> <dd> <input class="admin_value" type="text" value="0" name="point"  style=" width:100px; text-align: right;"> 강제 포인트 셋팅은 가급적 자제해주시길 바랍니다. </dd>
                    <dt> 비밀번호찾기 질문 </dt> 
                    <dd>
                    <!-- DB에서 질문양식을 불러온다.-->
                    <select name="hint" class="admin_value">
                    	<option> 질문을 선택해주세요. </option>
                    </select>      
                    </dd>
                    <dt> 비밀번호찾기 응답</dt> <dd><input class="admin_value" type="text" value="" name="answer" ></dd>
                </dl>
            </ul>
        </div> 
        <!-- end memInfo_2-->
        <div style="width:988px; height:100%; padding-top:30px;">
   	    	<div style="width:420px; margin:0 auto;">
   	    		<input type="submit" value="t" />
   	    		<img src="images/admin/member/button_07.png" width="200" height="40">
                <a href="admin_memberInfo.jsp"><img src="images/admin/member/button_04.png" width="200" height="40" style="float: right;"> </a></div>
   	    	</div>
   		<input type="file" name="upload" style="display:none; width: 200px; height: 18px; border: 1px solid #ccc; padding: 0; vertical-align: top;" onchange="view(this)" /> 
    </form>
  </div>
    <!-- end Main -->
</div>
</body>
</html>
