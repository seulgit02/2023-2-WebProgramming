<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>db_connect_test</title>
</head>
<body>

<%
	String url = "jdbc:mysql://webprecipes.mysql.database.azure.com:3306/webp_db?useSSL=true";
	String user = "We_bp1234";
	String password = "Webp1234";

    Connection con = null;
    Statement stmt = null;
    /*
    try {
        Class.forName("com.mysql.jdbc.Driver");
        out.println("드라이버 로드 성공");
    } catch (ClassNotFoundException e) {
    	out.println(e);
        out.println("드라이버 로드 실패");
        e.printStackTrace();
    }
    */

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
		out.print("연결 성공\n");
    } catch (Exception e) {
    	out.print("연결 실패");
    	e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }

%>

</body>
</html>