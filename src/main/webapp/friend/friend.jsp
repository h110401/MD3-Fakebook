<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/19/2022
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Friend Request</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/friend/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/friend/body.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">


</head>
<body>

<div class="f-logo">
    <a href="home">
        <img src="${pageContext.request.contextPath}/img/f-logo.png" alt="f-logo" id="f-logo">
    </a>
    <form>
        <label style="display: flex; justify-content: flex-end">
            <span>
                <i class="bi bi-search"></i>
            </span>
            <input type="text" name="search" placeholder="Tim kiem tren fakebook">
        </label>
    </form>
</div>
<header>
    <ul>
        <li>
            <div class="hoverable">
                <a href="home">
                    <img src="${pageContext.request.contextPath}/img/header/home.svg" alt="home">
                </a>
            </div>
        </li>
        <li>
            <img src="${pageContext.request.contextPath}/img/header/friendFill.svg" alt="friend">
            <div class="active"></div>
        </li>
        <li>
            <div class="hoverable">
                <img src="${pageContext.request.contextPath}/img/header/watch.svg" alt="watch">
            </div>
        </li>
        <li>
            <div class="hoverable">
                <img src="${pageContext.request.contextPath}/img/header/market.svg" alt="market">
            </div>
        </li>
        <li>
            <div class="hoverable">
                <img src="${pageContext.request.contextPath}/img/header/game.svg" alt="game">
            </div>
        </li>
    </ul>
</header>

<div class="body">
    <c:forEach items="${requestScope['friendList']}" var="friend">
        <p>${friend.getName()}</p>
    </c:forEach>
</div>

</body>
</html>
