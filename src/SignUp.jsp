<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="./SignUp.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 페이지</title>
</head>
<body>
    <div class="banner">
    <a href="Main.jsp"><img id="logo" src="image/logo.png" /></a>
    </div>
    <div class="SignUpPage">
        <div class="shef">
            <img id="shefImg" src="image/shef.png" alt="shef">
        </div>
        <div class="signupBox">
            <div id="createaccount">Create Account</div>
            <form action="./signup_db.jsp" method="POST">
                <input id ="signupInput" type="text" name="userid" placeholder="set your ID"/><br>
                <input id ="signupInput" type="password" name="passw" placeholder="set your PW"/><br>
                <input id ="signupInput" type="password" name="pwagain" placeholder="enter your PW again"/><br>
                 <input id ="signupInput" type="email" name="email"placeholder="enter your email address"/><br>
               
                <button id="signupBtn">SIGN UP</button>
            </form>
        </div>

    </div>
    
</body>
</html>