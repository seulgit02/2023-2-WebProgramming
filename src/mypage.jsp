<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.lang.String.*" %>
<html lang="en">
<head>
    <link rel="stylesheet" href="./mypage.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>mypage</title>
</head>
<script type="module">
    fetch('../json/recommend.json')
    .then(response=>response.json())
    .then(data=>console.log(data))
    .catch(console.error);
</script>
<body>
    <div class="main">
        <div class="banner">
                <a href="Main.jsp"><img id="logo" src="image/logo.png" /></a>
        </div>
        <div class="loginUser">
 <%
	String usid = (String)session.getAttribute("userid");
	if (usid == null) // 로그인 확인
	{
		%>
		<div class="loginUser">
            <button id="login"><a href="Login.jsp">login</button><t></t>
        </div>
		<%
	}
	else
	{
		%>
		<div class="loginUser">
            <button id="logout"><a href="Logout.jsp">log out</button><t></t>
            <button id="keep"><a href="mypage.jsp">MyPage</a></button>
        </div>
		<%
	}
%>
        </div>
       
        <div class="title">
            <img id="basket" src="image/basket.png" alt="basket" />
            <span><b>레시피</b> 찜 목록 리스트</span>
            <img id="basket" src="image/basket.png" alt="basket" />
        </div>
        
        
        <div class="keeplist">
<%
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
    	String[] numArray = bookmark_list.split(",");
    	query = "SELECT type, img_s FROM recipe_info WHERE recipeid = ";
    	for(int i = 0; i< numArray.length - 1; i++)
    	{
    		query += numArray[i] + " OR ";
    	}
    	query += numArray[numArray.length-1];
        pstmt = con.prepareStatement(query);
        rs = pstmt.executeQuery();
		
        while (rs.next()) {
            String type = rs.getString("type");
            String img_s = rs.getString("img_s");

            out.println("<a href='recipe_detail.jsp?type=" + URLEncoder.encode(type, "UTF-8") + "'>");
        	%><div class="shell"><%
        	
            out.println("<img src='" + img_s + "' alt='" + type + " Image'/>");
        	out.println("</a>");
        	out.println("<div><b>"+type+"</b></div>");
            %></div><%
            /*
            out.println("<p>" + type + "</p>");
            out.println("<img src='" + img_s + "' alt='Recipe Image'/>");
        	*/
        }
    } catch (Exception e) {
        out.println("즐겨찾기한 메뉴가 없습니다.");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

        </div>


      
    </div>
    
</body>
</html>