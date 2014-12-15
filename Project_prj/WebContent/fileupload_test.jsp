<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function view(){
	alert("a");
}//view
</script>
</head>
<body>
	<img src="" style="width:200px; height:auto;" />
	<form action="upload_process.jsp" method="post" enctype="multipart/form-data" name="upload">
	<input type="file" name="image"  onchange="view()" /><br />
	<input type="button" style="border:1px solid #ccc; background:#ccc; color:#fff;" />
	</form>
</body>
</html>