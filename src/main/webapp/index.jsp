<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/16/2022
  Time: 8:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>

    <title>Fakebook</title>
    <style>
        body {
            font-family: SFProDisplay-Regular, Helvetica, Arial, sans-serif;
        }

        input, input[type="button"] {
            margin: 6px 0;
            padding: 14px 16px;
            border-radius: 9px;
            border: gray 1px solid;
        }

        input:active, input:focus {
            outline: none;
            border-color: #1b74e4;
            box-shadow: 0 0 0 2px #e7f3ff;
            caret-color: #1b74e4;
        }

        @media only screen and (max-width: 992px) {
            .w-fix {
                width: 400px;
            }
        }

        a {
            font-size: 14px;
            text-decoration: none;
        }

        a:link {
            color: #0d6efd;
        }

        a:hover {
            text-decoration: underline;
        }

        li {
            display: inline;
            padding-left: 10px;
            font-size: 12px;
            color: #737373;
        }

        #footer li {
            padding-left: 20px;
        }

    </style>
</head>
<body>

<%
    Cookie cookie = null;
    Cookie[] cookies;

    cookies = request.getCookies();

    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("id")) {
                cookie = c;
                break;
            }
        }
    }

    if (cookie != null) {
        request.setAttribute("id", cookie.getValue());
        request.getRequestDispatcher("/login").forward(request, response);
    }
%>

<div class="container-fluid justify-content-center" style="background: #f0f2f5">
    <div class="row justify-content-center" style="height: 740px;padding: 70px 0 112px">
        <div class="col-7 col-lg-4 pt-lg-5">
            <div class="d-flex flex-column d-lg-block align-items-center pt-lg-5 pe-lg-5 pb-lg-1 p-0">
                <img src="${pageContext.request.contextPath}/img/logo.svg" alt="icon"
                     style="width: 300px;height: 106px;">
                <p style="font-size: 28px;margin-top: -10px;line-height: 32px"
                   class="text-center text-lg-start w-lg-100 w-fix ps-lg-4">
                    Facebook helps you connect and share with the people in your life.</p>
            </div>

        </div>

        <div class="col-7 col-lg-auto p-0 pe-lg-3 d-flex flex-column d-lg-block align-items-center pt-lg-1">

            <div style="
                background-color: #fff;
                border-radius: 10px;
                width: 396px;
                margin-top: 40px;
                padding: 10px 18px 24px;
                box-shadow: 0 2px 4px rgb(0 0 0 / 10%), 0 8px 16px rgb(0 0 0 / 10%);
            ">
                <form action="login" method="post">

                    <div style="display: flex; flex-direction: column">
                        <input type="text" name="email" placeholder="Email address or phone number">
                        <input type="password" name="password" placeholder="Password">
                    </div>

                    <input type="submit" class="btn btn-primary w-100 fw-bold"
                           style="margin: 10px 0 20px; font-size: 20px"
                           value="Login">

                    <div class="w-100 text-center d-inline-block">
                        <a href="#">Forgotten password?</a>
                    </div>

                    <div style="width: 360px; height: 1px; border-bottom: 1px solid #dadde1; margin: 20px 0"></div>

                    <div class="d-flex justify-content-center">
                        <a href="register">
                            <input type="button"
                                   style="background:#42b72a; color: white; font-size: 17px; font-weight: bold; padding: 0 16px;margin: 0;height: 48px; border: none"
                                   value="Create new account">
                        </a>
                    </div>
                </form>
            </div>

            <div style="width: 396px; text-align: center; margin-top:28px">
                <a href="#" style="color: black; font-weight: bold">Create a page</a> for a celebrity, brand or
                business.
            </div>

        </div>
    </div>

    <div class="row justify-content-center"
         style="height: 157px; background:#ffffff;padding-top: 20px; position: relative">
        <div class="col-7 d-flex flex-column">
            <ul style="display: flex; padding: 8px 0 0; margin: 0 0 8px -10px">
                <li> English (UK)</li>
                <li> Ti???ng Vi???t</li>
                <li> ??????(??????)</li>
                <li> ?????????</li>
                <li> ?????????</li>
                <li> Fran??ais (France)</li>
                <li> ?????????????????????</li>
                <li> Espa??ol</li>
                <li> Portugu??s (Brasil)</li>
                <li> Deutsch</li>
                <li> Italiano</li>
                <li>
                    <button style="border: 1px solid #a9a9a9; border-radius: 3px">
                        <p style="padding: 0 5px; margin: 0; color: #444444; font-weight: bold; font-size: 15px; line-height: 17px">
                            +</p>
                    </button>
                </li>
            </ul>

            <div style="width: 100%; height: 1px; border-bottom: 1px solid #dadde1; margin: 0"></div>

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
            <li style="margin: 10px -10px">Meta ?? 2022</li>
        </div>

    </div>
</div>

</body>
</html>
