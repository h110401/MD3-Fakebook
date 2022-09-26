<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/16/2022
  Time: 1:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>

        body {
            font-family: SFProDisplay-Regular, Helvetica, Arial, sans-serif;
            margin: 0;
        }

        .global-container {
            height: 940px;
        }

        .top-container {
            width: 100%;
            height: 515px;
            background: #f0f2f5;
            text-align: center;
        }

        #logo {
            width: 284px;
            height: 100px;
        }

        .logo-div {
            width: 100%;
            height: 104px;
            padding-top: 5px;
        }

        .form-div {
            margin: 5px auto 0;
            width: 396px;
            text-align: center;
            box-shadow: 0 2px 4px rgb(0 0 0 / 10%), 0 8px 16px rgb(0 0 0 / 10%);
            border-radius: 8px;
        }

        .form-header, .form-body {
            width: 100%;
            background: #fff;
            box-sizing: border-box;
        }


        .form-header {
            padding: 24px 0 0 0;
            border-radius: 8px 8px 0 0;
            height: 46px;
            font-size: 18px;
        }

        .form-body {
            border-radius: 0 0 8px 8px;
            padding: 16px;
            text-align: left;
        }

        .form-body input, .form-body input:focus, .form-body input:active, select, label {
            border-radius: 5px;
            border: 1px solid #ccd0d5;
            outline: none;
            width: 100%;
            height: 40px;
            box-sizing: border-box;
            margin: 6px 0;
            padding: 14px 16px;
        }

        .log-in {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
        }

        button[type="submit"] {
            width: 100%;
            height: 48px;
            background-color: #1877f2;
            color: white;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            box-sizing: border-box;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #1c64cb
        }

        .log-in + div {
            font-size: 14px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
            padding: 12px 0 18px;
            height: 49px;
        }

        .log-in + div > a {
            text-decoration: none;
            color: #1877f2;
        }

        li, span {
            display: inline;
            padding-left: 10px;
            font-size: 14px;
            color: #737373;
        }

        #footer li {
            padding-left: 20px;
        }

        span {
            display: inline-block;
            font-size: 11px;
            margin: 30px 0 20px -10px;
        }

    </style>
</head>
<body>

<div class="global-container">
    <div style="height: 640px;">
        <div class="top-container">
            <div class="logo-div">
                <img src="${pageContext.request.contextPath}/img/logo.svg" alt="logo" id="logo">
            </div>
            <div class="form-div">
                <div class="form-header">
                    Log in to Fakebook
                </div>
                <div class="form-body">
                    <form action="#" method="post">

                        <input type="text" placeholder="Email address or phone number" name="email">

                        <input type="password" placeholder="Password" name="password">


                        <div class="log-in">
                            <button type="submit">Log In</button>
                        </div>

                        <div>
                            <a href="#">Forgotten account?</a>
                            <span style="width: 14px"></span>
                            <a href="register">Sign up for Fakebook</a>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>

    <div class="bottom-container">
        <div style="width: 980px; margin: 0 auto">
            <ul style="display: flex; padding: 8px 0 0; margin: 0 0 8px -10px; flex-wrap: wrap">
                <li> English (UK)</li>
                <li> Tiếng Việt</li>
                <li> 中文(台灣)</li>
                <li> 한국어</li>
                <li> 日本語</li>
                <li> Français (France)</li>
                <li> ภาษาไทย</li>
                <li> Español</li>
                <li> Português (Brasil)</li>
                <li> Deutsch</li>
                <li> Italiano</li>
                <li>
                    <button style="border: 1px solid #a9a9a9; border-radius: 3px">
                        <span style="padding: 0 5px; margin: 0; color: #444444; font-weight: bold; font-size: 15px; line-height: 17px">
                            +</span>
                    </button>
                </li>
            </ul>

            <div style="border-bottom: 1px solid #dddfe2;font-size: 1px;height: 8px;margin-bottom: 8px;"></div>

            <ul style="display: flex; flex-wrap: wrap; padding: 8px 0 0; margin: 0 0 8px -20px" id="footer">
                <li>Sign up</li>
                <li>Log in</li>
                <li>Messenger</li>
                <li>Facebook Lite</li>
                <li>Watch</li>
                <li>Places</li>
                <li>Games</li>
                <li>Marketplace</li>
                <li>Facebook Pay</li>
                <li>Oculus</li>
                <li>Instagram</li>
                <li>Bulletin</li>
                <li>Local</li>
                <li>Fundraisers</li>
                <li>Services</li>
                <li>Voting Information Centre</li>
                <li>Groups</li>
                <li>About</li>
                <li>Create ad</li>
                <li>Create Page</li>
                <li>Developers</li>
                <li>Carreers</li>
                <li>Privacy</li>
                <li>Cookies</li>
                <li>AdChoices</li>
                <li>Terms</li>
                <li>Help</li>
                <li>Contact uploading and non-users</li>
            </ul>

            <span>Meta © 2022</span>


        </div>

    </div>
</div>

</body>
</html>
