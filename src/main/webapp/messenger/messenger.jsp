<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<html>
<head>
    <title>Messenger</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/body.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/messenger/style.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">


</head>
<body>

<div style="display: none" id="userId">${sessionScope['userLogin'].getId()}</div>

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

<div style="margin-top: 56px">

    <div style="display: grid; grid-template-columns: 300px auto" class="main-container">

        <div class="bg-light position-fixed p-3 border" id="chatbox-container"
             style="width: 300px;height: 100%;overflow: scroll">
            <div class="d-flex align-items-center justify-content-between mb-2 pe-2">
                <h2>Chats</h2>
                <span style="cursor: pointer; position:relative;" onclick="toggle()">
                            <i class="bi bi-plus-circle-fill animation"></i>
                        </span>
                <div class="border rounded" id="addChatBox"
                     style="position:absolute;background:#ffffff;right: 20px;top: 60px;display: none">
                    <c:forEach items="${requestScope['friendList']}" var="friend">
                        <a href="messenger?action=create&idUser=${friend.id}">
                            <div class="p-2 m-2 hover rounded">
                                <img src="${friend.avatar}" alt="avatar" width="32" height="32"
                                     class="rounded-circle">
                                    ${friend.name}
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="w-100 border-top mb-2"></div>
            <c:forEach items="${requestScope['chatBoxList']}" var="cb">
                <a href="messenger?id=${cb.id}">
                    <div class="d-flex p-2 rounded"
                         style="background: ${cb.id == requestScope['selectedChatBox'].id ? "rgba(45, 136, 255, 0.1)" : "none"}">
                        <img src="${cb.userChatWith.avatar}" alt="avatar" width="56" height="56"
                             class="rounded-circle border me-2">
                        <div>
                            <div style="font-size: 15px">
                                    ${cb.userChatWith.name}
                            </div>
                            <div style="color: #65676B">
                                <c:if test="${cb.lastMessage != null}">
                                            <span style="font-size: 13px; color: #65676B">

                                                    <c:if test="${cb.lastMessage.idUser == sessionScope['userLogin'].id}">
                                                        You:
                                                    </c:if>
                                                    ${cb.lastMessage.content}
                                            </span>.
                                    <span style="font-size: 12px; color: #65676B">
                                            ${cb.lastMessage.getTimePassed()}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        <br>
                    </div>
                </a>
            </c:forEach>
        </div>

        <div></div>
        <c:if test="${requestScope['chatBoxList'] != null}">
            <div style="position: relative">
                <div class="border-bottom"
                     style="position: fixed;display: flex; height: 76px; width: 100%;background:#fff;align-items: center; padding: 0 12px">

                    <img src="${requestScope['selectedChatBox'].userChatWith.avatar}" alt="avatar" width="40"
                         height="40" class="rounded-circle">

                    <div style="margin-left: 10px"><h5>${requestScope['selectedChatBox'].userChatWith.name}</h5>
                    </div>

                </div>
                <div style="padding: 76px 30px 70px; height: 100%; display: flex;flex-direction: column; justify-content: flex-end">
                    <c:if test="${requestScope['messageList'] != null}">
                        <c:forEach items="${requestScope['messageList']}" var="mes">
                            <div style="
                                    max-width: 60%;
                                    height: 45px;
                                ${mes.idUser == sessionScope['userLogin'].id ? "align-self: flex-end" : ""};
                                    cursor: pointer
                                    ">
                                <div style="display:flex; align-items: center">
                                    <c:if test="${mes.idUser != sessionScope['userLogin'].id}">
                                        <img src="${requestScope['selectedChatBox'].userChatWith.avatar}"
                                             alt="avatar" width="40" height="40" class="rounded-circle me-2">
                                    </c:if>
                                    <div style="padding: 8px 12px; border-radius: 32px; background: ${mes.idUser == sessionScope['userLogin'].id ? "rgb(0, 132, 255); color: white" : "#E4E6EB"}; display: inline-block">
                                            ${mes.content}
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </c:if>
                    <c:if test="${requestScope['messageList'] == null}">
                        <div style="align-self: center;height: 100%;display: flex;align-items: center;">
                            No message found
                        </div>
                    </c:if>
                </div>
                <div style="position:absolute;bottom: 0; background:#fff;height: 60px;width: 100%;"
                     class="border-top d-flex align-items-center">
                    <form action="" class="m-0 w-100 ps-3" id="message-form" method="post">
                        <input type="hidden" name="id" value="${requestScope['selectedChatBox'].id}">
                        <input type="text" name="chat" placeholder="Aa" autocomplete="off">
                        <button>Send</button>
                    </form>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope['chatBoxList'] == null}">
            <div style="display: flex;justify-content: center; align-items: center">
                <h3>
                    You have no chat box! Choose a friend to start chatting now!
                </h3>
            </div>
        </c:if>
    </div>
</div>

<script src="${pageContext.request.contextPath}/messenger/script.js"></script>
</body>
</html>
