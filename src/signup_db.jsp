<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    try {
        String userid = request.getParameter("userid");
        String passw = request.getParameter("passw");
        String pwagain = request.getParameter("pwagain");
        String email = request.getParameter("email");
   		String exist_user = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
        ResultSet rs = null;
        
        String Query = "SELECT userid FROM user_info";
        pstmt = con.prepareStatement(Query);
        rs = pstmt.executeQuery();
        
        while(rs.next())
        {
            exist_user = rs.getString(1);
        	if (exist_user.equals(userid))
        		break;
        }
			

        rs.close();
		pstmt.close();
		
       if(!passw.equals(pwagain)){
    	   %>
    	  <script type="text/javascript">
           alert("패스워드가 일치하지 않습니다.");
           window.location = "./SignUp.jsp";
       </script>
      <%
    } else if (userid == null || passw == null || pwagain == null || email == null || userid.isEmpty() || passw.isEmpty() || pwagain.isEmpty() || email.isEmpty() ) {
	%>
        <script type="text/javascript">
            alert("폼을 모두 작성해주세요.");
            window.location = "./SignUp.jsp";
        </script>
	<%
	    } else if (exist_user.equals(userid))
	    {
	    	%>
	        <script type="text/javascript">
	            alert("이미 존재하는 아이디입니다.");
	            window.location = "./SignUp.jsp";
	        </script>
		<%
	    }
    	else
    	{
	    	String sql = "INSERT INTO user_info (userid, passw, email) VALUES (?, ?, ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, userid);
	        pstmt.setString(2, passw);
	        pstmt.setString(3, email);

	        int result = pstmt.executeUpdate();
	        if(result > 0){
	            out.println("Data saved successfully!");
	        } else {
	            out.println("Error saving data.");
	        }
	    }
     	
       String sql = "INSERT INTO bookmark (mark_str) VALUES ('')";
       pstmt.close();
       pstmt = con.prepareStatement(sql);
       int result = pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
%>
<script type="text/javascript">
           alert("회원가입이 완료되었습니다.");
           ///window.location = "./Login.jsp";
       </script>
</body>
</html>