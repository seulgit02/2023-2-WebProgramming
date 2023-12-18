<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>idpw_ins</title>
</head>
<body>
<%
	String url = "jdbc:mysql://webprecipes.mysql.database.azure.com:3306/webp_db?useSSL=true";
	String user = "We_bp1234";
	String password = "Webp1234";
	
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
    	
    	request.setCharacterEncoding("UTF-8");
        String userid = request.getParameter("userid");
        String passw = request.getParameter("passw");

        out.println("UserID: " + userid + " | Password: " + passw);

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
        
     	String sql = "SELECT * FROM user_info WHERE userid=? AND passw=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, passw);

        rs = pstmt.executeQuery();
        if(rs.next()){
        	%>
        	<script type="text/javascript">
           alert("로그인에 성공하였습니다.");
       <%
        session.setAttribute("userid", userid);
		session.setAttribute("password", passw);
       %>
           window.location = "./Main.jsp";
       </script>
        	<%
           
        } else {
        	%>
        	<script type="text/javascript">
            alert("회원정보가 존재하지 않습니다.");
            //window.location = "./Login.jsp";
        </script>
         	<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
%>
</body>
</html>