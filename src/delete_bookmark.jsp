<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.lang.String.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>delete bookmark</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String bookmark_num = request.getParameter("bookmark_num");
	String query="";
	String id = (String)session.getAttribute("userid");
	
	String url = "jdbc:mysql://webprecipes.mysql.database.azure.com:3306/webp_db?useSSL=true";
    String user = "We_bp1234";
    String password = "Webp1234";
	
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	
    int user_num = 0;
    String bookmark_list = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
 
        query = "SELECT user_num FROM user_info WHERE userid = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        while (rs.next()) {
        	user_num = rs.getInt("user_num");
        }
        pstmt.close();
        rs.close();
        String temp = Integer.toString(user_num);
        
        query = "SELECT mark_str FROM bookmark WHERE user_num = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, temp);
        rs = pstmt.executeQuery();
        while (rs.next()) {
        	bookmark_list = rs.getString("mark_str");
        }
        pstmt.close();
        rs.close();
        bookmark_list = bookmark_list.replace(bookmark_num + "," , "");
        query = "UPDATE bookmark SET mark_str = " 
        +  "'" + bookmark_list + "'"
        + " WHERE user_num = " + temp;
        pstmt = con.prepareStatement(query);
        pstmt.executeUpdate();

    } catch (Exception e) {
        out.println("Database connection failed");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
	String typeParam=request.getParameter("type");//URLencode로 가져옴.
%>
    <script type="text/javascript">
	alert("즐겨찾기 삭제를 성공하였습니다.");
	window.location = "./Main.jsp";
	</script>
</body>
</html>