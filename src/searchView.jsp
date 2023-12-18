<%@page contentType="text/html; charset=UTF-8" %><!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	String option=request.getParameter("option");
	String searchWord=request.getParameter("searchRecipe");
	String query="";
	%>
<html lang="en">
<head>
	
	 <link rel="stylesheet" href="./recipeCategory.css">
    <link rel="stylesheet" href="./searchView.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div class="main">
        <div class="banner">
    		<a href="Main.jsp"><img id="logo" src="image/logo.png" /></a>
        </div>
        <div class="loginUser">
           <%
	String id = (String)session.getAttribute("userid");
	if (id == null) // 로그인 확인
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
            검색 결과  
        </div>
        <div class="username" style={{margin:1vw}}>검색 결과 조회 페이지입니다.</div>
        <div class="recipeBox">
<%
	
	String typeParam=request.getParameter(option);//URLencode로 가져옴.
	String url = "jdbc:mysql://webprecipes.mysql.database.azure.com:3306/webp_db?useSSL=true";
    String user = "We_bp1234";
    String password = "Webp1234";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        if("ingre".equals(option)) {
            query = "SELECT type, img_s FROM recipe_info WHERE ingre LIKE ?";
        } else if("type".equals(option)) {
            query = "SELECT type, img_s FROM recipe_info WHERE type LIKE ?";
        }

        pstmt = con.prepareStatement(query);
        pstmt.setString(1, "%" + searchWord + "%");
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
        out.println("Database connection failed");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</div>

       
        </div>


      
    </div>
    
</body>
</html>