<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인-영화 보기 좋은날</title>
<link rel="shortcut icon" type="image/x-icon"
	href="images/common/favicon/favicon.ico">
<style type="text/css">
body {
	overflow: hidden;
}

#photowrap {
	width: 400px;
	height: 310px;
}

#photo_tap {
	width: 400px;
	height: 40px;
	background: url("images/admin/member/upload_title.gif") no-repeat;
}

#close_btn {
	float: right;
	width: 16px;
	height: 16px;
	padding: 12px 12px;
}

#content {
	width: 400px;
	height: 210px;
}
</style>
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	function view(input){
		var flag=false;
		var obj=document.loadImg;
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
			$(opener.document).find("#photo img").attr("src", e.target.result);
			$(opener.document).find("#photo user_photo").attr("value", e.target.result);
		}//end function
		reader.readAsDataURL(input.files[0]);
		//input text에 파일명만 선택해 출력
		$("input[type='text']").attr("value", fileName.split("\\")[fileName.split("\\").length-1]);
		
		//단독서버 실행 후에는 setTimeout을 삭제
		setTimeout('window.close()', 1000);
		
		//부모창 처리하는 사람은 부모창에 파일경로 전달은 여기코드를 따로 처리해줄 것
	}//chkNull
</script>
</head>

<body>
	<div id="photowrap">
		<div id="login_logo">
			<img src="images/common/login/login_logo.gif" alt="사진업로드 페이지">
		</div>
		<div id="photo_tap">
			<div id="close_btn">
				<a href="javascript:self.close()"><img
					src="images/common/login/close_btn.png" alt="닫기"></a>
			</div>
		</div>
		<div id="content">
			<div style="padding-top: 70px; padding-left: 50px; height: 20px;">
				<form name="loadImg" enctype="multipart/form-data" method="post" action="admin_photo.jsp">
					<input type="text" readonly="readonly" value="" style="width:200px; height:18px; border:1px solid #ccc; padding:0; vertical-align:top;" />
					<input type="file" name="upload" style="display:none; width: 200px; height: 18px; border: 1px solid #ccc; padding: 0; vertical-align: top;" onchange="view(this)" /> 
					<img src="images/admin/member/upload.png" width="80" height="20"  onclick="$('input[type=file]').click();" />
				</form>
			</div>
			<div style="padding-left: 40px; padding-top: 10px;">
				<font size="2"> 이미지 크기는 160*160이 적합합니다. <br /> 업로드 이미지는 .jpg,
					.png, .gif 만 사용 가능합니다.
				</font>
			</div>
		</div>
	</div>
</body>
</html>