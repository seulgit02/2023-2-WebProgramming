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
                    <img id="heart" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAflBMVEX////hS1rgRlb99PXfOkzhSVjfN0rgPk/gRFTiT17iU2HgQlLgP1D64uTfNUjiUWD87u/309bjXWr++vv429376er1zM/lZnLzv8P1ys743N7neYPupavmb3rxtrvsl57qjZXtoKbpgovjWmfpgYrrk5rneILwrrPtnaTzwcWwhgD0AAAFDklEQVR4nO2daVviPBSG6XKaYqFAWZQBcZRRnP//B19S8QVmWLqck552nvuD38yV2ydLkya11wMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADoKsFwtnx6WsyG46ZrcpFpMJ8tfi8nP8bTCr8dLF6f4zQMjRmYMIyi7a/PpSLP6eL1LSNj67f/Ecaj1XpRpnrD9daYxCfvCMWJMdnrUKzOJRjunkOTxHSsH5GfmDRbF6tesH6IklO5E81kX0rDSQabLEz8K9ULs83dBjv8GV7RO5QyCN/mLkwuE7yEg5vVM8n7zQjGb2l8q4CcOPrVUI7j92ut6zTI6D24VsD0M43v6R0cdy7FvtmZpFD1ksGV6s28QaECLGb7w63dvv9szd3mdYBMdmnMeUmLFpAXkjqOcReVqZ4frv8sIMiKB/hF+FFlnq3IdBWWrd7qvIS5V6wHnpJ4zgac8ahYDzyr3sPpgDMp3MRP8X1HDwDD+PIEeJv48djIJqXa+BEyMxeCk7Ba9eLs/xJKjTHnig5SHFYUtCnW+xPlir54X5zfneSvk+SK1RO0+H3hEXXar9IHTxXrJJiXsbpfyzp8lB/kzxWrDjJHQtGpf1d2HvwT39QsYE8qONoMo/r1q4+f3a9pVbI6nZCPcCMluKnbRpkgc3VBVo+gxkTBS/IuY/hS/mlUCKEQAyVt1JJ8Shh+qonQ7k8JPNlMKy14pDBP/IZPDHM1H/4zv+Gjjrnwm5R9jTFXNM5YBuyz/q7sxpEwPvsS40NXI90vhZkFp8oa6f7hlHnLZqLOkLsjauuGnhczP5v+rLe2F4B7Rsw0PdDkcA81pM7QS1kF9SwNj0SsK6ixuqF0P12wvvweajRkfWeqbzr8JwxZt01nCg2jzvfDiHWFOFex2X1O5+dDemA17PXVGXIvgfU9l3Lve+tbW5jfvIYbdetD3oc2hdMF9XkFe72ab9/Zid+4DVfK9trMkttQ16a+R4b91Yymd2ueRCPt9Z5VNdNwwW+41BQibfkFdT24GZHTGGs9kz77S4svpjcvHjhFJkJFIXIvnI5o2RaOJlKGSs5ExYLnL581rKEoETxDO9Zw4iQSmOyPbJrfkTIvkoL7tX7T46n0Iehe77HZrhgLnp49EIyafAL3R0InS88Ua53WrynYdyDYZIqOBJtL0fccCTaVorMEc8UGUvTd3T7MFZ2n6Pcd3+d2naLjBHNFpyk2ILhXfHCn2Iigy4bqy1+rvKLoKMWGEswVnaTYWIK5ooMUiRr9fIt8ihQ3/X0a4RTJb/DjNAdF0XlRgaCsIsUKBCUbqooELVLDDSVKBKVSVJOgRaIvKkrQwp+ikkHmCHdfJKNMkDtFSlR8TvAcTkUaKBTkVFQqyKeoVpBruCHeawa8cKSoOEFL/RRVJ2ipm6LyBC31UlSfoKVOimScf8OzCtUVifc6mhxVFYn7ir0c1RRbJFhtuKGoRYJVUmxVgpayKbYsQUu5FFuXoKVMipS2ULBMihSKHYmVpegOHMmd+ZWmmGKLBYs11NY20S/uDzeUtlrwfootT9ByO8XWJ2i5lSJJXEFzz/UUKe2E4PUUSfZegUsuz4udSdBySZFS9rvKTfJ3Q6WoU4J/DzcdS9BynmLnErScptjBBC3HFCli/i6JFr5TpLSjgt8pdjZBSz4vdjdBSzCKuy24VySBj6nrwuH/TgMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIB7/gNo8lb2OAw7bQAAAABJRU5ErkJggg==">
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

