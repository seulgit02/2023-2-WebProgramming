<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./mypage.css">
    <link rel="stylesheet" href="./recipe_detail.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레시피 디테일 페이지</title>
</head>
<body>
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
            <button id="login"><a href="Login.jsp">login</a></button><t></t>
        </div>
		<%
	}
	else
	{
		%>
		<div class="loginUser">
            <button id="logout"><a href="Logout.jsp">log out</a></button><t></t>
            <button id="keep"><a href="mypage.jsp">MyPage</a></button>
        </div>
		<%
	}
%>
        </div>

<%
    String url = "jdbc:mysql://webprecipes.mysql.database.azure.com:3306/webp_db?useSSL=true";
    String user = "We_bp1234";
    String password = "Webp1234";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        
            String typeParam = request.getParameter("type"); // URL에서 type 파라미터 값을 가져옴
            if (typeParam != null && !typeParam.isEmpty()) {
                String detailQuery = "SELECT recipeid, type, img_s, ingre, rec_1, rec_img_1, rec_2, rec_img_2, rec_3, rec_img_3, rec_4, rec_img_4, rec_5, rec_img_5, rec_6, rec_img_6 FROM recipe_info WHERE type = ?";
                pstmt = con.prepareStatement(detailQuery);
                pstmt.setString(1, typeParam);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    //레시피 정보 출력
                    String recipeid = rs.getString("recipeid");
                   	String type=rs.getString("type");
                    String img_s=rs.getString("img_s");
                    String ingre = rs.getString("ingre");
                    String rec_1 = rs.getString("rec_1");
                    String rec_img_1 = rs.getString("rec_img_1");
                    String rec_2 = rs.getString("rec_2");
                    String rec_img_2 = rs.getString("rec_img_2");
                    String rec_3 = rs.getString("rec_3");
                    String rec_img_3 = rs.getString("rec_img_3");
                    String rec_4 = rs.getString("rec_4");
                    String rec_img_4 = rs.getString("rec_img_4");
                    String rec_5 = rs.getString("rec_5");
                    String rec_img_5 = rs.getString("rec_img_5");
                    String rec_6 = rs.getString("rec_6");
                    String rec_img_6 = rs.getString("rec_img_6");
                    %>
                    <div id="name">
                    <div id="new">
                    <%=typeParam %>
                    </div>
                    
<%
	if (id != null) // 로그인 확인
	{
		%>
		            <div>

                    <form class="Bookmarkform" action="./insert_bookmark.jsp" method="POST">
                    <input type="hidden" name="bookmark_num" value = <%= recipeid%>>
                    <button id="bookmark">즐겨찾기 등록</button>
                    </form>
                    <form class="Bookmarkdelform" action="./delete_bookmark.jsp" method="POST">
                    <input type="hidden" name="bookmark_num" value = <%= recipeid%>>
                    <button id="bookmark">즐겨찾기 삭제</button>
                    </form>
                    </div>
		<%
	}
%>
                    </div>
                    <%
                    
                    out.println("<div class=ingre>[재료]</div>");
                    out.println("<p>" + ingre + "</p>");
                    
                    out.println("<div class=ingre>[조리 방법]</div>");
                    %>
                    <div class="manualBox">
                    <%
                    if (rec_img_1 != null && !rec_img_1.isEmpty()) {
                        out.println("<img src='" + rec_img_1 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_1 + "</p>");
                    
                    if (rec_img_2 != null && !rec_img_2.isEmpty()) {
                        out.println("<img src='" + rec_img_2 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_2 + "</p>");
                    
                    if (rec_img_3 != null && !rec_img_3.isEmpty()) {
                        out.println("<img src='" + rec_img_3 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_3 + "</p>");
                    
                    if (rec_img_4 != null && !rec_img_4.isEmpty()) {
                        out.println("<img src='" + rec_img_4 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_4 + "</p>");
                    
                    if (rec_img_5 != null && !rec_img_5.isEmpty()) {
                        out.println("<img src='" + rec_img_5 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_5 + "</p>");
                    
                    if (rec_img_6 != null && !rec_img_6.isEmpty()) {
                        out.println("<img src='" + rec_img_6 + "' alt='Recipe Image'/>");
                    }
                    out.println("<p>" + rec_6 + "</p>");
     				%></div><%
                    
                } else {
                    out.println("<p>Recipe not found.</p>");
                }
            } else {
                out.println("<p>No recipe selected.</p>");
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

</body>
</html>

