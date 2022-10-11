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
                <input type="text" name="search" placeholder="Search Fakebook" autocomplete="off">
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
    <c:if test="${sessionScope['userLogin'].id == 1}">
        <div>
            <a href="setting">
                <button>
                    <i class="bi bi-gear"></i>
                </button>
            </a>
        </div>
    </c:if>

    <div>
        <a href="logout">
            <button>
                <i class="bi bi-box-arrow-right"></i>
            </button>
        </a>
    </div>

</div>

<div id="notice-div" style="display:none;padding: 10px; z-index: 2">
    <div style="margin: 10px 0 10px 0">
        <h3>Notification</h3>
    </div>
    <c:forEach items="${requestScope['notificationList']}" var="noti">
        <div style="display: grid; grid-template-columns: 80px auto;height: 80px;padding: 10px; border-radius: 8px"
             class="noti">
            <div>
                <img src="${noti.userFrom.avatar}"
                     alt="avatar" style="height: 60px;width: 60px;border-radius: 50%">
            </div>
            <div>
                    ${noti.content}
            </div>
        </div>
    </c:forEach>
</div>

<header style="z-index: 1">
    <ul>
        <li>
            <div class="hoverable">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/img/header/home.svg" alt="home">
                </a>
            </div>
        </li>
        <li>
            <div class="hoverable">
                <a href="${pageContext.request.contextPath}/friend">
                    <img src="${pageContext.request.contextPath}/img/header/friendFill.svg" alt="friend">
                </a>
            </div>
            <div class="active"></div>
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

<div style="margin-top: 56px; position: fixed;left: 0; background:#fff; width: 300px;height: 100%; top: 0;padding: 10px">
    <h2 style="margin: 10px; font-weight: bold">Friend</h2>
    <div class="friend-request" onclick="toggle('request')" id="request-btn" style="background: #e6e6e6">
        <span style="background: #d5d5d5; border-radius: 50%; display: flex; width: 35px;height: 35px;align-items: center;justify-content: center;margin-right: 5px">
        <i class="bi bi-person-plus-fill" style="font-size: 25px;margin-left: 3px"></i>
        </span>
        Friend Request
    </div>
    <div class="friend-request" onclick="toggle('friend')" id="list-btn">
        <span style="background: #d5d5d5; border-radius: 50%; display: flex; width: 35px;height: 35px;align-items: center;justify-content: center;margin-right: 5px">
        <i class="bi bi-person-plus-fill" style="font-size: 25px;margin-left: 3px"></i>
        </span>
        Friend List
    </div>
</div>

<div class="body">

    <div id="request-div" style="display: block">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4">
                <c:forEach items="${requestScope['requestList']}" var="request">
                    <div style="padding: 15px">
                        <div class="border" style="background:#fff;border-radius: 8px; overflow: hidden">
                            <div>
                                <img src="${request.user1.avatar}"
                                     alt="avatar" class="w-100 list-request-image">
                            </div>
                            <div class="p-2" id="friend-btn">
                                <div>
                                    <h5>${request.user1.name}</h5>
                                </div>
                                <div style="padding-bottom: 10px">
                                    <a href="${pageContext.request.contextPath}/friend?action=accept&id=${request.id}">
                                        <button style="color: white;background:#0d6efd;">Confirm</button>
                                    </a>
                                </div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/friend?action=delete&id=${request.id}">
                                        <button style="background: #E4E6EB">Delete</button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>

    <div id="friend-div" style="display: none">
        <div class="container">
            <div class="row row-cols-1 row-cols-lg-2 row-cols-xxl-3 friend">

                <c:forEach items="${requestScope['friendList']}" var="friend">

                    <div style="padding: 15px">
                        <div class="border h-100 d-flex justify-content-between"
                             style="padding: 10px;border-radius: 8px;background:#fff;">
                            <div class="d-flex align-items-center">
                                <div>
                                    <img src="${friend.avatar}"
                                         alt="avatar"
                                         style="border-radius: 50%; margin: 0 15px;width: 48px;height: 48px;">
                                </div>
                                <div>
                                    <h5>${friend.name}</h5>
                                </div>
                            </div>
                            <div class="d-flex align-items-center" style="margin-right: 15px">
                                <a href="${pageContext.request.contextPath}/friend?action=delete-friend&id=${friend.id}">
                                    <button style="border: 2px solid crimson;border-radius: 50%; background:#fff;display: flex;width: 30px;height: 30px;justify-content: center;align-items: center;color: crimson">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </a>
                            </div>
                        </div>
                    </div>

                </c:forEach>

            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/friend/script.js"></script>

</body>
</html>
