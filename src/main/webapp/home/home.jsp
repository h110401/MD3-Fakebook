<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/body.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/nav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/section.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/article.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">


</head>
<body>

<div style="display: none" id="userID">${sessionScope['userLogin'].getId()}</div>

<div class="f-logo">
    <div style="display: flex">
        <a href="home">
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

<div style="position: absolute; z-index: 1; right: 0;top: 0;">
    <div>
        <a href="messenger">
            <button>messenger</button>
        </a>
    </div>
</div>

<header>
    <ul>
        <li>
            <a href="#">
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

<div class="body">

    <div>
        <nav>
            <div style="margin-top: 16px">
                <a href="#">
                    <div class="label user">
                        <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.30497-1/143086968_2856368904622192_1959732218791162458_n.png?stp=cp0_dst-png_p40x40&_nc_cat=1&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=KGMN7pZGaI8AX-HifdX&_nc_ht=scontent.fhan3-1.fna&oh=00_AT-KSHFMj11ROQeuuj6O5hXp_bRhBtS-yxBFhr3-MdkMCA&oe=634CFC78"
                             alt="avatar">
                        <div>${sessionScope['userLogin'].getName()} </div>
                    </div>
                </a>
                <a href="friend">
                    <div class="label">
                        <img src="https://static.xx.fbcdn.net/rsrc.php/v3/y8/r/S0U5ECzYUSu.png" alt="Friend">
                        <h5>Friend</h5>
                    </div>
                </a>
                <a href="#">
                    <div class="label">
                        <img src="https://static.xx.fbcdn.net/rsrc.php/v3/y5/r/PrjLkDYpYbH.png" alt="group">
                        <h5>Group</h5>
                    </div>
                </a>
                <div style="margin: 8px 16px 0; border-bottom: 1px solid #ced0d4"></div>
            </div>
        </nav>
    </div>

    <div class="section-container">
        <section>
            <div class="create-post">
                <div class="create-div" data-bs-toggle="modal" data-bs-target="#create-post-modal">
                    <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.30497-1/143086968_2856368904622192_1959732218791162458_n.png?stp=cp0_dst-png_p40x40&_nc_cat=1&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=KGMN7pZGaI8AX-HifdX&_nc_ht=scontent.fhan3-1.fna&oh=00_AT-KSHFMj11ROQeuuj6O5hXp_bRhBtS-yxBFhr3-MdkMCA&oe=634CFC78"
                         alt="avatar">
                    <div>
                        <div class="create-content">
                            What's on your mind, ${sessionScope['userLogin'].getName()} ?
                        </div>
                    </div>
                </div>
                <div style="margin: 8px 0 0; border-bottom: 1px solid #ced0d4"></div>
                <div class="addition">
                    <div class="click-able" data-bs-toggle="modal" data-bs-target="#create-post-modal"
                         onclick="displayPhotoAdd()">
                        <img src="${pageContext.request.contextPath}/img/create-post/photo.svg" alt="photo">
                        <div>Photo/video</div>
                    </div>
                    <div class="click-able">
                        <img src="${pageContext.request.contextPath}/img/create-post/photo.svg" alt="photo">
                        <div>Photo/video</div>
                    </div>
                    <div class="hide-icon click-able">
                        <img src="${pageContext.request.contextPath}/img/create-post/photo.svg" alt="photo">
                        <div>Photo/video</div>
                    </div>
                </div>

                <form action="post" method="post" id="form-post">

                    <div class="modal" id="create-post-modal" tabindex="-1" aria-labelledby="create-post-label"
                         aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="create-post-label">Create Post</h5>
                                    <div class="close-btn">
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close" onclick="hidePhotoAdd()"></button>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div style="margin: 0 16px; padding: 16px 0">
                                        <div class="user" style="display: flex">
                                            <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.30497-1/143086968_2856368904622192_1959732218791162458_n.png?stp=cp0_dst-png_p40x40&_nc_cat=1&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=KGMN7pZGaI8AX-HifdX&_nc_ht=scontent.fhan3-1.fna&oh=00_AT-KSHFMj11ROQeuuj6O5hXp_bRhBtS-yxBFhr3-MdkMCA&oe=634CFC78"
                                                 alt="avatar">
                                            <div style="display: flex; align-items: center">
                                                <h5>${sessionScope['userLogin'].getName()}</h5></div>
                                        </div>
                                    </div>
                                    <div class="modal-body-content">
                                        <div style="padding: 0 16px 40px" class="create-content-body">
                                            <textarea name="content" style="width: 100%;height: 36px;" rows="2"
                                                      id="content-box"
                                                      oninput="disablePostButton()"
                                                      placeholder="What's on your mind, ${sessionScope['userLogin'].getName()} ?"></textarea>
                                        </div>
                                        <div style="padding: 16px; display: none" id="add-photo-div">
                                            <label for="fileButton" id="fileButtonLabel">
                                                <progress value="0" max="100" id="uploader">0%
                                                </progress>
                                                <div class="fileButtonBg">
                                                    <span>Add photos</span>
                                                    <div id="imgDiv" style="width: 100%; display: none"></div>
                                                </div>
                                                <input type="file" value="upload" accept=".jpg, .png" id="fileButton"
                                                       style="display: none" hidden>
                                                <input type="hidden" id="imgSrc" name="imgSrc">
                                                <input type="hidden" id="date-created" name="date-created">
                                            </label>
                                        </div>
                                    </div>
                                    <div class="add-content">
                                        <div style="padding-left: 8px">
                                            <h5>Add to your post</h5>
                                        </div>
                                        <div style="padding: 8px;" class="bg-hover">
                                            <img src="${pageContext.request.contextPath}/img/create-post/photo.svg"
                                                 alt="photo" class="click-able"
                                                 onclick="displayPhotoAdd()">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="create-post-button" disabled id="post-button"><h5>
                                        Post</h5></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="action" value="create">
                </form>

            </div>

            <c:forEach items="#{requestScope['postList']}" var="post">
                <article>
                    <div class="article-user">
                        <div style="display: flex; padding: 12px 16px 0; margin: 0 0 12px; justify-content: space-between">
                            <div style="display: flex">
                                <img style="border-radius: 50%"
                                     src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.30497-1/143086968_2856368904622192_1959732218791162458_n.png?stp=cp0_dst-png_p40x40&_nc_cat=1&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=KGMN7pZGaI8AX-HifdX&_nc_ht=scontent.fhan3-1.fna&oh=00_AT-KSHFMj11ROQeuuj6O5hXp_bRhBtS-yxBFhr3-MdkMCA&oe=634CFC78"
                                     alt="avatar">
                                <div style="margin-left: 8px; text-align: left">
                                    <h5>${post.getUser().getName()}</h5>
                                    <span style="font-size: 13px; color: #969696">${post.getTimePassed()}</span>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/post" method="post" style="display:none;"
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
                        <div class="emotion-bar">
                            Like
                        </div>
                        <div class="interact-bar">
                            <div class="comment-div" onclick="displayCommentArea(${post.getId()})">
                                <a href="${pageContext.request.contextPath}/post?action=detail&id=${post.getId()}"
                                   style="display: block;width: 100%;height: 100%;justify-content: center">Comment</a>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>


        </section>
    </div>

    <div>
        <aside>
            <div style="margin-top: 28px">
                <div style="height: 30px;">Nguoi lien he</div>

                <c:forEach items="${requestScope['friendList']}" var="friend">
                    <a href="#">
                        <div class="label user">
                            <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.30497-1/143086968_2856368904622192_1959732218791162458_n.png?stp=cp0_dst-png_p40x40&_nc_cat=1&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=KGMN7pZGaI8AX-HifdX&_nc_ht=scontent.fhan3-1.fna&oh=00_AT-KSHFMj11ROQeuuj6O5hXp_bRhBtS-yxBFhr3-MdkMCA&oe=634CFC78"
                                 alt="avatar">
                            <h5>${friend.getName()}</h5>
                        </div>
                    </a>
                </c:forEach>

            </div>
        </aside>
    </div>
</div>


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

    let deleteImg = (imgName) => {

        let listRef = firebase.storage().ref(fbBucketName);
        listRef.listAll()
            .then((res) => {
                res.prefixes.forEach((folderRef) => {
                    // All the prefixes under listRef.
                    // You may call listAll() recursively on them.
                });
                res.items.forEach((itemRef) => {
                    console.log(1)
                });
            }).catch((error) => {
            // Uh-oh, an error occurred!
        });
    }

    fileButton.addEventListener('change', function (e) {

        fileList = e.target.files;
        file = fileList[0];


        let divLocation = document.getElementById("imgDiv");
        divLocation.style.display = "block";
        document.querySelector(".fileButtonBg > span").style.display = "none";

        let output = document.createElement("img");

        output.src = URL.createObjectURL(file);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }

        output.style.width = "100%";
        output.style.borderRadius = '8px';
        document.getElementById("fileButtonLabel").style.width = "100%";
        document.getElementById("fileButtonLabel").style.height = "100%";
        document.getElementById("fileButtonLabel").style.paddingBottom = "8px";
        document.getElementById("fileButton").disabled = true;

        divLocation.append(output);
        let button = document.querySelector(".modal-footer > button");
        button.disabled = false;
    })

    var postButton = document.getElementById('post-button');

    // listen for file selection
    postButton.addEventListener('click', function (e) {

        // what happened
        console.log('file upload event', e);
        document.querySelector("progress").style.display = "block";
        // get file

        var today = new Date();
        var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
        var time = today.getHours() + ':' + today.getMinutes() + ':' + today.getSeconds();
        var datetime = date + ' ' + time
        document.getElementById("date-created").value = datetime;

        var userId = document.getElementById("userID").innerText;

        if (file === null) {
            document.getElementById("form-post").submit();
        }

        // create a storage ref
        var storageRef = firebase.storage().ref(fbBucketName + '/' + "userId=" + userId + '-post-' + "'" + datetime + "'");
        // upload file
        var uploadTask = storageRef.put(file);

        document.querySelector(".fileButtonBg > span").style.display = "none";
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
                    document.getElementById("form-post").submit();
                }
            }
        );

    });

</script>
<script src="${pageContext.request.contextPath}/home/script.js"></script>

</body>
</html>
