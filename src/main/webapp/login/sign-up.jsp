<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/login/sign-up-style.css">


</head>
<body>


<div class="global-container">
    <div class="top-container">
        <div class="logo-div">
            <img src="${pageContext.request.contextPath}/img/logo.svg" alt="logo" id="logo">
        </div>
        <div class="form-div">
            <div class="form-header">
                <div>
                    Create a new account
                </div>
                <div>
                    It's quick and easy
                </div>
            </div>
            <div class="form-body">
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div>
                        <input type="text" placeholder="First name" name="first-name">
                        <input type="text" placeholder="Surname" name="surname">
                    </div>

                    <input type="text" placeholder="Mobile number or email address" name="email">

                    <input type="password" placeholder="New password" name="password">

<%--                    <div class="date-note">--%>
<%--                        Date of birth--%>
<%--                    </div>--%>

<%--                    <div class="select-birth">--%>
<%--                        <select name="day" id="day">--%>
<%--                            <c:forEach begin="1" end="31" var="i">--%>
<%--                                <option>${i}</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                        <select name="month" id="month">--%>
<%--                            <option>Jan</option>--%>
<%--                            <option>Feb</option>--%>
<%--                            <option>Mar</option>--%>
<%--                            <option>Apr</option>--%>
<%--                            <option>May</option>--%>
<%--                            <option>Jun</option>--%>
<%--                            <option>Jul</option>--%>
<%--                            <option>Aug</option>--%>
<%--                            <option>Sep</option>--%>
<%--                            <option>Oct</option>--%>
<%--                            <option>Nov</option>--%>
<%--                            <option>Dec</option>--%>
<%--                        </select>--%>
<%--                        <select name="year" id="year">--%>
<%--                            <% for (int i = 2022; i >= 1905; i -= 1) { %>--%>
<%--                            <option><%=i%></option>--%>
<%--                            <% } %>--%>
<%--                        </select>--%>
<%--                    </div>--%>

<%--                    <div class="gender-note">--%>
<%--                        Gender--%>
<%--                    </div>--%>

<%--                    <div class="select-gender">--%>
<%--                        <label>--%>
<%--                            Female--%>
<%--                            <input type="radio" value="female" name="gender">--%>
<%--                        </label>--%>
<%--                        <label>--%>
<%--                            Male--%>
<%--                            <input type="radio" name="gender" value="male">--%>
<%--                        </label>--%>
<%--                        <label>--%>
<%--                            Custom--%>
<%--                            <input type="radio" name="gender" value="custom">--%>
<%--                        </label>--%>
<%--                    </div>--%>

                    <p>
                        People who use our service may have uploaded your contact information to Facebook.
                    </p>
                    <p>
                        By clicking Sign Up, you agree to our Terms, Privacy Policy and Cookies Policy. You may receive
                        SMS
                        notifications from us and can opt out at any time.
                    </p>
                    <div class="sign-up">
                        <button type="submit">Sign Up</button>
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/login">Already have an account?</a>
                    </div>

                </form>

            </div>
        </div>
    </div>
    <div style="height: 30px;"></div>
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
                        <p style="padding: 0 5px; margin: 0; color: #444444; font-weight: bold; font-size: 15px; line-height: 17px">
                            +</p>
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
