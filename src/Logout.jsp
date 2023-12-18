<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<%
	session.removeAttribute("userid");
	session.removeAttribute("password");
%>
	<script type="text/javascript">
	alert("로그아웃에 성공하였습니다.");
	window.location = "./Main.jsp";
	</script>
</body>
</html>