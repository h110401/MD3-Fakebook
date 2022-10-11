<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/21/2022
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/body.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <style>
        .no-deco, .no-deco:hover, .no-deco:active {
            text-decoration: none;
            color: black;
        }
    </style>

</head>
<body>

<div class="f-logo" style="z-index: 2">
    <div style="display: flex">
        <a href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/img/f-logo.png" alt="f-logo" id="f-logo">
        </a>
        <form action="search" method="get">
            <label style="display: flex; justify-content: flex-end">
            <span>
                <i class="bi bi-search"></i>
            </span>
                <input type="text" name="search" placeholder="Search Fakebook" autocomplete="off"
                       value="${requestScope['search']}">
            </label>
        </form>
    </div>
</div>

<div style="position: fixed; z-index: 2; right: 0;top: 0; display: flex;align-items: center;height: 56px;"
     class="top-right-div">
    <div>
        <button onclick="displayNotification()">
            <i class="bi bi-bell-fill"></i>
        </button>
    </div>
    <div>
        <a href="messenger">
            <button>
                <i class="bi bi-chat-dots-fill"></i>
            </button>
        </a>
    </div>

    <c:if test="${sessionScope['userLogin'].getRoleName() == 'ADMIN'}">
        <div>
            <a href="setting">
                <button>
                    <i class="bi bi-gear"></i>
                </button>
            </a>
        </div>
    </c:if>
</div>

<header style="z-index: 1">
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/img/header/homeFill.svg" alt="home">
            </a>
            <div class="active"></div>
        </li>
        <li>
            <div class="hoverable">
                <a href="${pageContext.request.contextPath}/friend">
                    <img src="${pageContext.request.contextPath}/img/header/friend.svg" alt="friend">
                </a>
            </div>
        </li>
        <li>
            <div class="hoverable">
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/header/watch.svg" alt="watch">
                </a>
            </div>
        </li>
        <li>
            <div class="hoverable">
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/header/market.svg" alt="market">
                </a>
            </div>
        </li>
        <li>
            <div class="hoverable">
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/header/game.svg" alt="game">
                </a>
            </div>
        </li>
    </ul>
</header>

<div class="container" style="margin-top: 56px; padding:20px">
    <div class="row row-cols-1 row-cols-lg-3">
        <c:forEach items="${requestScope['userList']}" var="user">
            <div class="p-4">
                <form action="friend" method="post" style="display: none" id="user${user.getId()}">
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="search" value="${requestScope['search']}">
                    <input type="hidden" name="status" value="${requestScope['relativeMap'].get(user.getId())}">
                    <input type="hidden" name="iduser" value="${user.getId()}">
                </form>
                <form action="user" method="get" id="profile${user.getId()}">
                    <input type="hidden" name="profile" value="${user.id}">
                </form>
                <div onclick="wall('profile${user.getId()}')"
                     class="border d-flex align-items-center justify-content-between px-3 bg-light rounded"
                     style="height: 60px; box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2), 0 1px 2px 0 rgba(0, 0, 0, 0.1);cursor:pointer;">
                    <div>
                    <span>
                        <img src="${user.avatar}" alt="avatar" width="40" height="40" class="rounded-circle">
                    </span>
                        <span>${user.getName()}</span>
                    </div>

                    <c:choose>
                        <c:when test="${requestScope['relativeMap'].get(user.getId()).toString() == 'FRIEND'}">
                            <button class="btn btn-primary" style="width: 120px;">FRIEND</button>
                        </c:when>
                        <c:otherwise>
                            <button style="width: 120px;" onclick="submit('user${user.getId()}')"
                                    class="btn ${requestScope['relativeMap'].get(user.getId()) == 'SENT' ? "btn-danger": requestScope['relativeMap'].get(user.getId()) == 'NOT_FRIEND' ? "btn-secondary" : "btn-success"}">${requestScope['relativeMap'].get(user.getId())}</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<script>
    let submit = (id) => {
        document.getElementById(id).submit();
    }
    let wall = (id) => {
        if (event.target.tagName === 'DIV') {
            submit(id);
        }
    }
</script>

</body>

</html>
