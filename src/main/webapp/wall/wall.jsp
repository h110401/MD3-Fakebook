<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/28/2022
  Time: 7:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wall</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/wall/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/wall/body.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/wall/article.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/wall/section.css">

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


<div class="container" style="margin-top: 100px; position: relative">
    <div style="display: flex">
        <div>
            <img id="avatar" src="${requestScope['user'].avatar}"
                 alt="avatar" width="180" height="180" style="border-radius: 50%; border: 5px solid white">
        </div>
        <div>
            <h5 style="font-size: 32px; margin: 50px 0 0 20px">
                ${requestScope['user'].name}
            </h5>
        </div>
    </div>

    <div style="position: absolute; left: 0; top: 200px" class="d-none d-lg-block">
        <c:if test="${requestScope['user'].id == sessionScope['userLogin'].id}">
            <div style="margin-top: 20px" class="setting">

                <div onclick="displayAvatarInput()">Change avatar</div>

                <form id="change-avatar" method="post" style="display: none;margin-left: 10px">
                    <input type="hidden" name="action" value="change-avatar">
                    <input type="file" id="fileButton" accept=".png, .jpg" style="margin: 10px 0"><br>
                    <progress value="0" max="100" id="uploader">0%</progress>
                    <input type="hidden" name="imgSrc" id="imgSrc">
                    <div class="avatar-btn">
                        <button type="button" class="btn btn-success" id="post-button">Submit</button>
                        <button type="button" class="btn btn-danger" onclick="hideAvatarInput()">Cancel</button>
                    </div>
                </form>


                <div onclick="displayNameInput()">Change name</div>

                <form style="display: none;margin-left: 10px" id="change-name" method="post">
                    <input type="hidden" name="id" value="${requestScope['user'].id}">
                    <input type="hidden" name="action" value="change-name">
                    <input type="text" name="name" autocomplete="off" value="${sessionScope['userLogin'].name}"
                           style="width: 200px">
                    <div class="d-block d-xl-inline-block mt-2 mt-xl-0">
                        <div style="display: flex;flex-direction: column" class="name-btn">
                            <button class="btn btn-success">
                                Submit
                            </button>
                            <button type="reset" onclick="hideNameInput()"
                                    class="btn btn-danger">
                                Cancel
                            </button>
                        </div>
                    </div>
                </form>

                <div onclick="displayPassInput()">Change pass</div>

                <form style="display: none;margin-left: 10px" id="change-pass" method="post">
                    <input type="hidden" name="id" value="${requestScope['user'].id}">
                    <input type="hidden" name="action" value="change-pass">
                    <input type="password" name="pass" id="pass" autocomplete="off"
                           style="width: 200px; margin-bottom: 15px" placeholder="Password"><br>
                    <input type="password" name="repeat" id="repeat" autocomplete="off"
                           style="width: 200px; margin-bottom: 10px" placeholder="Repeat"><br>
                    <div>
                        <div style="display: flex;flex-direction: column" class="name-btn">
                            <button type="button" class="btn btn-success" onclick="checkRepeatPass()">
                                Submit
                            </button>
                            <button type="reset" onclick="hidePassInput()"
                                    class="btn btn-danger">
                                Cancel
                            </button>
                        </div>
                    </div>
                </form>

            </div>
        </c:if>
        <c:if test="${requestScope['user'].id != sessionScope['userLogin'].id}">
            <form action="friend" method="post">
                <input type="hidden" name="action" value="wall">
                <input type="hidden" name="iduser" value="${requestScope['user'].id}">
                <input type="hidden" name="status" value="${requestScope['relative']}">
                <c:choose>
                    <c:when test="${requestScope['relative'] == 'FRIEND'}">
                        <button type="button" class="btn btn-primary" style="width: 120px;">FRIEND</button>
                    </c:when>
                    <c:otherwise>
                        <button style="width: 120px;"
                                class="btn ${requestScope['relative'] == 'SENT' ? "btn-danger": requestScope['relative'] == 'NOT_FRIEND' ? "btn-secondary" : "btn-success"}">${requestScope['relative']}</button>
                    </c:otherwise>
                </c:choose>
            </form>
        </c:if>
    </div>

    <div class="section-container">
        <section>
            <c:forEach items="#{requestScope['postList']}" var="post">
                <article>
                    <div class="article-user">
                        <div style="display: flex; padding: 12px 16px 0; margin: 0 0 12px; justify-content: space-between">
                            <div style="display: flex">
                                <a href="user?profile=${post.user.id}">
                                    <img style="border-radius: 50%"
                                         src="${requestScope['user'].avatar}"
                                         alt="avatar" width="40" height="40">
                                </a>
                                <div style="margin-left: 8px; text-align: left">
                                    <a href="user?profile=${post.user.id}">
                                        <h5 style="margin: 0;">${post.getUser().getName()}</h5>
                                    </a>
                                    <span style="font-size: 13px; color: #969696">${post.getTimePassed()}</span>
                                </div>
                            </div>
                            <form action="post" method="post" style="display:none;"
                                  id="delete-${post.getId()}">
                                <input type="hidden" name="idPost" value="${post.getId()}">
                                <input type="hidden" name="action" value="delete">
                            </form>
                            <button class="btn-close" onclick="deletePost('delete-${post.getId()}')"
                                    style="display: ${post.getUser().getId() == sessionScope['userLogin'].getId() ? "block" : "none"}; width: 15px;height: 15px;box-sizing: border-box"></button>
                        </div>
                    </div>

                    <div class="article-content">
                        <div>
                                ${post.getContent()}
                        </div>
                    </div>

                    <div class="article-img" style="display: ${post.getImgUrl() == "" ? "none" : "block"}">
                        <img src="${post.getImgUrl()}" alt="img">
                    </div>

                    <div class="article-interact">
                        <div class="emotion-bar" style="display: ${post.getCountLike() == 0 ? "none" : "flex"}">
                            <img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 16 16'%3e%3cdefs%3e%3clinearGradient id='a' x1='50%25' x2='50%25' y1='0%25' y2='100%25'%3e%3cstop offset='0%25' stop-color='%2318AFFF'/%3e%3cstop offset='100%25' stop-color='%230062DF'/%3e%3c/linearGradient%3e%3cfilter id='c' width='118.8%25' height='118.8%25' x='-9.4%25' y='-9.4%25' filterUnits='objectBoundingBox'%3e%3cfeGaussianBlur in='SourceAlpha' result='shadowBlurInner1' stdDeviation='1'/%3e%3cfeOffset dy='-1' in='shadowBlurInner1' result='shadowOffsetInner1'/%3e%3cfeComposite in='shadowOffsetInner1' in2='SourceAlpha' k2='-1' k3='1' operator='arithmetic' result='shadowInnerInner1'/%3e%3cfeColorMatrix in='shadowInnerInner1' values='0 0 0 0 0 0 0 0 0 0.299356041 0 0 0 0 0.681187726 0 0 0 0.3495684 0'/%3e%3c/filter%3e%3cpath id='b' d='M8 0a8 8 0 00-8 8 8 8 0 1016 0 8 8 0 00-8-8z'/%3e%3c/defs%3e%3cg fill='none'%3e%3cuse fill='url(%23a)' xlink:href='%23b'/%3e%3cuse fill='black' filter='url(%23c)' xlink:href='%23b'/%3e%3cpath fill='white' d='M12.162 7.338c.176.123.338.245.338.674 0 .43-.229.604-.474.725a.73.73 0 01.089.546c-.077.344-.392.611-.672.69.121.194.159.385.015.62-.185.295-.346.407-1.058.407H7.5c-.988 0-1.5-.546-1.5-1V7.665c0-1.23 1.467-2.275 1.467-3.13L7.361 3.47c-.005-.065.008-.224.058-.27.08-.079.301-.2.635-.2.218 0 .363.041.534.123.581.277.732.978.732 1.542 0 .271-.414 1.083-.47 1.364 0 0 .867-.192 1.879-.199 1.061-.006 1.749.19 1.749.842 0 .261-.219.523-.316.666zM3.6 7h.8a.6.6 0 01.6.6v3.8a.6.6 0 01-.6.6h-.8a.6.6 0 01-.6-.6V7.6a.6.6 0 01.6-.6z'/%3e%3c/g%3e%3c/svg%3e"
                                 alt="Like" width="18" height="18" style="margin-right: 8px">
                                ${post.getCountLike()}
                        </div>
                        <div class="interact-bar">
                            <div>

                                <a href="like?idPost=${post.id}&direction=wall&id=${requestScope['user'].id}"
                                   style="color: ${post.isLiked() ? "#2078f4" : "black"}">
                                    <c:if test="${post.isLiked()}">
                                        <i class="bi bi-hand-thumbs-up-fill" style="padding-right: 8px"></i>
                                    </c:if>
                                    <c:if test="${!post.isLiked()}">
                                        <i class="bi bi-hand-thumbs-up" style="padding-right: 8px"></i>
                                    </c:if>
                                    Like
                                </a>
                            </div>
                            <div class="comment-div">
                                <a href="${pageContext.request.contextPath}/post?action=detail&id=${post.getId()}"
                                   style="display: block;width: 100%;height: 100%;justify-content: center"><i
                                        class="bi bi-chat-left" style="padding-right: 8px; font-size: 13px"></i>Comment</a>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>
        </section>
    </div>
</div>

<div style="display: none" id="userId">${sessionScope['userLogin'].getId()}</div>

<script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>

<script>

    const firebaseConfig = {
        apiKey: "AIzaSyCDEoecxRvKI8S8D4PaUYOqrQvSbuZJnm4",
        authDomain: "fakebook-bdd35.firebaseapp.com",
        projectId: "fakebook-bdd35",
        storageBucket: "fakebook-bdd35.appspot.com",
        messagingSenderId: "458972229199",
        appId: "1:458972229199:web:70fe05a0a996c34128843a",
        measurementId: "G-9VEGVRXL22"
    };
    firebase.initializeApp(firebaseConfig);
</script>

<script type="text/javascript">
    let image = '';
    // firebase bucket name
    // REPLACE WITH THE ONE YOU CREATE
    // ALSO CHECK STORAGE RULES IN FIREBASE CONSOLE
    let fbBucketName = 'images';

    // get elements
    let uploader = document.getElementById('uploader');

    let fileButton = document.getElementById('fileButton');

    let file = null;
    let fileList = null;

    let temp = null;

    fileButton.addEventListener('change', function (e) {

        fileList = e.target.files;
        file = fileList[0];


        let output = document.createElement("img");

        output.src = URL.createObjectURL(file);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }

        let avatar = document.getElementById("avatar");
        temp = avatar.src;
        avatar.src = output.src;

    })

    let postButton = document.getElementById('post-button');

    // listen for file selection
    postButton.addEventListener('click', function (e) {

        // what happened
        console.log('file upload event', e);
        document.querySelector("progress").style.display = "block";
        // get file

        let today = new Date();
        let date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
        let time = today.getHours() + ':' + today.getMinutes() + ':' + today.getSeconds();
        let datetime = date + ' ' + time

        let userId = document.getElementById("userId").innerText;

        // create a storage ref
        let storageRef = firebase.storage().ref(fbBucketName + '/' + "userId=" + userId + '&avatar-created=' + datetime);
        // upload file
        let uploadTask = storageRef.put(file);

        // update progress bar
        uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // or 'state_changed'
            function (snapshot) {
                // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
                var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                uploader.value = progress;
                console.log('Upload is ' + progress + '% done');

                switch (snapshot.state) {
                    case firebase.storage.TaskState.PAUSED: // or 'paused'
                        console.log('Upload is paused');
                        break;
                    case firebase.storage.TaskState.RUNNING: // or 'running'
                        console.log('Upload is running');
                        break;
                }
            }, function (error) {

                // A full list of error codes is available at
                // https://firebase.google.com/docs/storage/web/handle-errors
                switch (error.code) {
                    case 'storage/unauthorized':
                        // User doesn't have permission to access the object
                        break;

                    case 'storage/canceled':
                        // User canceled the upload
                        break;

                    case 'storage/unknown':
                        // Unknown error occurred, inspect error.serverResponse
                        break;
                }
            }, function () {
                // Upload completed successfully, now we can get the download URL
                // save this link somewhere, e.g. put it in an input field
                var downloadURL = uploadTask.snapshot.downloadURL;

                document.getElementById("imgSrc").value = downloadURL;

                if (downloadURL != null) {
                    document.getElementById("change-avatar").submit();
                }
            }
        );

    });

</script>

<script src="${pageContext.request.contextPath}/wall/script.js"></script>

</body>
</html>
