<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="./Login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login </title>  
</head>
<body>
    <div class="loginComponent">
    <div class="banner">
    		<a href="Main.jsp"><img id="logo" src="image/logo.png" /></a>
    </div>
    <div class="loginPage">
        <div class="innerBox">
            <img id ="shef" src="image/shef.png" alt="shef"/>
            <div class="loginBox">
                <div id="welcome">Welcome!</div>
                
                <form class="loginForm" action="./Id_pasw_insert.jsp" method="POST">
                  
                    <input id="loginInput" type="text" name="userid" placeholder="Enter your ID"/><br>
                    
                    <input id="loginInput" type="password" name="passw" placeholder="Enter your PW"/><br>
                    <button id="loginBtn">LOG IN</button>
                </form>
                <div class="footer">
                    <a href="SignUp.jsp" class="button"><b>회원가입</b></a>
                </div>
            </div>
        </div>

    </div>
    </div>
    
</body>
</html>