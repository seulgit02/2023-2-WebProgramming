<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="./Main.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script type="module">
    fetch('../json/recommend.json')
    .then(response=>response.json())
    .then(data=>console.log(data))
    .catch(console.error);
</script>
<body>

<div class="rootComponent">
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

        try {
            //db에서 랜덤으로 레시피 하나 불러오는 코드
            String query = "SELECT type, img_s FROM recipe_info ORDER BY RAND() LIMIT 1";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                //랜덤 데이터 하나 추출
                String type = rs.getString("type");
                String img_s = rs.getString("img_s");
                %>
                    <div class="main">
        
        <div class="banner">
    		<a href="Main.jsp"><img id="logo" src="image/logo.png" /></a>
        </div>
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
        

        <div class="recommend">
        <%
        //type(메뉴명) url parameter로 전달
        out.println("<a href='recipe_detail.jsp?type=" + URLEncoder.encode(type, "UTF-8") + "'>");
        out.println("<img id=recommendFood src='" + img_s + "' alt='" + type + " Image'/>");
        out.println("</a>");
		%>
            
            <div class="recommendText">
                <p id="starve">Are you Starving?</p>
                <p id="today">Today's Recommend</p>
                <p id="ment"><%= type %></p>
            </div>
            
        </div>

        <div class="search">
        <form method="post" action="./searchView.jsp">
            <select name="option">
                <option value="ingre">재료</option>
                <option value="type">메뉴</option>
            </select>
            <input id="searchInput" type="text" name="searchRecipe" />
            <input type="submit" value="search" id="searchBtn" />
       </form>
        </div>
        
        <div class="tagSearch">
            <div id="tag">#음식 종류</div>
            <div id="tagIcon">
                <button id="menuType">
                <a href="./FoodKind.jsp?type=<%= URLEncoder.encode("밥", "UTF-8") %>">
                    <img id="tagImg" src="image/rice.png" alt="#ë°¥" />
                 </a>
                    <p>#밥</p>
                </button>
                <button id="menuType">
                 <a href="./FoodKind.jsp?type=<%= URLEncoder.encode("국&찌개", "UTF-8") %>">
                    <img id="tagImg" src="image/soup.png" alt="#êµ­" />
                   </a> <p>#국&찌개</p>
                </button>
                <button id="menuType">
                 <a href="./FoodKind.jsp?type=<%= URLEncoder.encode("반찬", "UTF-8") %>">
                    <img id="tagImg" src="image/sidedish.png" alt="#ë°ì°¬" />
                 </a>
                    <p>#반찬</p>
                </button>
                <button id="menuType">
                 <a href="./FoodKind.jsp?type=<%= URLEncoder.encode("후식", "UTF-8") %>">
                    <img id="tagImg" src="image/dessert.png" alt="#íì" />
                    </a><p>#후식</p>
                </button>
            </div>
        </div>


        <div class="tagSearch">
            <div id="tag">#조리 방법</div>
            <div id="tagIcon">
                <button id="menuType">
                <a href="./MethodKind.jsp?type=<%= URLEncoder.encode("끓이기", "UTF-8") %>">
                    <img id="tagImg" src="image/boil.png" alt="#ëì´ê¸°" />
                    </a><p>#끓이기</p>
                </button>
                <button id="menuType">
                <a href="./MethodKind.jsp?type=<%= URLEncoder.encode("굽기", "UTF-8") %>">
                    <img id="tagImg" src="image/bake.png" alt="#êµ½ê¸°" />
                    </a><p>#굽기</p>
                </button>
                <button id="menuType">
                <a href="./MethodKind.jsp?type=<%= URLEncoder.encode("튀기기", "UTF-8") %>">
                    <img id="tagImg" src="image/fry.png" alt="#íê¸°ê¸°" />
                   </a><p>#튀기기</p>
                </button>
                <button id="menuType">
                <a href="./MethodKind.jsp?type=<%= URLEncoder.encode("찌기", "UTF-8") %>">
                    <img id="tagImg" src="image/etc.png" alt="#ê¸°í" />
                    </a><p>#찌기</p>
                </button>
            </div>
        </div>


    </div>
</div>
</body>
</html>
                
                <%
            }
        } catch (Exception e) {
            out.println("Error fetching random recipe: " + e.getMessage());
            e.printStackTrace();
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