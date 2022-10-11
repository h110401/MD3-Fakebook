<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hung
  Date: 9/26/2022
  Time: 6:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PostDetail</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/post/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/post/article.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/post/body.css">

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

<div style="padding-top: 56px; display: flex; justify-content: center">
    <div style="width: 500px">
        <article>
            <div class="article-user">
                <div style="display: flex; padding: 12px 16px 0; margin: 0 0 12px; justify-content: space-between">
                    <div style="display: flex">
                        <a href="user?profile=${post.user.id}">
                            <img style="border-radius: 50%"
                                 src="${post.user.avatar}"
                                 alt="avatar" width="40" height="40">
                        </a>
                        <div style="margin-left: 8px; text-align: left">
                            <a href="user?profile=${post.user.id}">
                                <h5>${post.getUser().getName()}</h5>
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

                        <a href="like?idPost=${requestScope['post'].id}&direction=post"
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
                    <div class="comment-icon-div">
                        <a href="#"
                           style="display: block;width: 100%;height: 100%;justify-content: center"><i
                                class="bi bi-chat-left" style="padding-right: 8px; font-size: 13px"></i>Comment</a>
                    </div>
                </div>
                <div style="border-top: 1px solid #CED0D4;margin: 0 16px; padding: 16px 0 0 0; display: grid; grid-template-columns: 40px auto; box-sizing: content-box"
                     class="comment-div">
                    <div style="height: 40px;display: flex;align-items: center">
                        <div>
                            <img style="border-radius: 50%; width: 32px;height: 32px;"
                                 src="${post.user.avatar}"
                                 alt="avatar" width="32" height="32">
                        </div>
                    </div>
                    <div style="height: 40px;display: flex;align-items: center">
                        <form action="${pageContext.request.contextPath}/comment?action=create" method="post"
                              style="width: 100%;height: 100%;margin: 0;">
                            <input type="hidden" value="${requestScope["post"].getId()}" name="idPost">
                            <input type="text" name="comment-content" autocomplete="off" style="width: 100%;"
                                   placeholder="Write a comment...">
                        </form>
                    </div>
                </div>
                <div style="display:flex;justify-content: flex-end; margin: 0 32px;font-size: 14px; color: #65676b; font-weight: bold; cursor: pointer"
                     onclick="showCmt()" class="showCmtChoice">
                    <c:if test="${requestScope['commentList'].size() > 3}">
                        Show all
                    </c:if>
                </div>
                <div class="cmtList" style="display: ${requestScope['commentList'].size() <= 3 ? "block" : "none"};">
                    <c:forEach items="${requestScope['commentList']}" var="comment">
                        <div style="margin: 0 16px; padding: 8px 0; display: grid;grid-template-columns: 40px auto">
                            <div>
                                <img style="border-radius: 50%; width: 32px;height: 32px;"
                                     src="${comment.user.avatar}"
                                     alt="avatar" width="40" height="40">
                            </div>
                            <div>
                                <div style="background:#e8e8e8;border-radius: 16px;display: inline-block;padding: 8px 12px;max-width: 100%; position: relative;min-width: ${sessionScope['userLogin'].id == comment.user.id ? "120px" : "80px"}">
                                    <h5>${comment.user.name}</h5>

                                    <div style="word-break: break-all;">
                                            ${comment.content}
                                    </div>
                                    <c:if test="${comment.getCountLike() > 0}">
                                        <div style="position: absolute;right: -5px;bottom: -10px; border-radius: 10px;height: 18px;line-height: 16px;display: flex;align-items: center; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);background:#fff;padding: 2px 1px 2px 2px">
                                            <img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 16 16'%3e%3cdefs%3e%3clinearGradient id='a' x1='50%25' x2='50%25' y1='0%25' y2='100%25'%3e%3cstop offset='0%25' stop-color='%2318AFFF'/%3e%3cstop offset='100%25' stop-color='%230062DF'/%3e%3c/linearGradient%3e%3cfilter id='c' width='118.8%25' height='118.8%25' x='-9.4%25' y='-9.4%25' filterUnits='objectBoundingBox'%3e%3cfeGaussianBlur in='SourceAlpha' result='shadowBlurInner1' stdDeviation='1'/%3e%3cfeOffset dy='-1' in='shadowBlurInner1' result='shadowOffsetInner1'/%3e%3cfeComposite in='shadowOffsetInner1' in2='SourceAlpha' k2='-1' k3='1' operator='arithmetic' result='shadowInnerInner1'/%3e%3cfeColorMatrix in='shadowInnerInner1' values='0 0 0 0 0 0 0 0 0 0.299356041 0 0 0 0 0.681187726 0 0 0 0.3495684 0'/%3e%3c/filter%3e%3cpath id='b' d='M8 0a8 8 0 00-8 8 8 8 0 1016 0 8 8 0 00-8-8z'/%3e%3c/defs%3e%3cg fill='none'%3e%3cuse fill='url(%23a)' xlink:href='%23b'/%3e%3cuse fill='black' filter='url(%23c)' xlink:href='%23b'/%3e%3cpath fill='white' d='M12.162 7.338c.176.123.338.245.338.674 0 .43-.229.604-.474.725a.73.73 0 01.089.546c-.077.344-.392.611-.672.69.121.194.159.385.015.62-.185.295-.346.407-1.058.407H7.5c-.988 0-1.5-.546-1.5-1V7.665c0-1.23 1.467-2.275 1.467-3.13L7.361 3.47c-.005-.065.008-.224.058-.27.08-.079.301-.2.635-.2.218 0 .363.041.534.123.581.277.732.978.732 1.542 0 .271-.414 1.083-.47 1.364 0 0 .867-.192 1.879-.199 1.061-.006 1.749.19 1.749.842 0 .261-.219.523-.316.666zM3.6 7h.8a.6.6 0 01.6.6v3.8a.6.6 0 01-.6.6h-.8a.6.6 0 01-.6-.6V7.6a.6.6 0 01.6-.6z'/%3e%3c/g%3e%3c/svg%3e"
                                                 alt="Like" width="16" height="16" style="margin-right: 2px">
                                            <c:if test="${comment.getCountLike() > 1}">
                                            <span style="margin: 0 6px 0 2px; font-size: 13px">
                                                    ${comment.getCountLike()}
                                            </span>
                                            </c:if>
                                        </div>
                                    </c:if>

                                </div>
                                <div style="display: flex">
                                    <div style="margin-right: 5px; font-size: 12px; color: #65676b">
                                            ${comment.getTimePassed()}
                                    </div>
                                    <div class="like-btn">
                                        <a href="like?idCmt=${comment.id}&idPost=${requestScope['post'].getId()}"
                                           style="color: ${comment.isLiked() ? "#2078f4" : "#65676b"}">
                                            Like
                                        </a>
                                    </div>
                                    <c:if test="${sessionScope['userLogin'].id == comment.user.id}">
                                        <div class="delete-btn">
                                            <a href="${pageContext.request.contextPath}/comment?action=delete&id=${comment.id}&idPost=${requestScope['post'].id}">
                                                Delete
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>
                <div class="cmtList3" style="display: block">
                    <c:if test="${requestScope['commentList'].size() > 3}">
                        <c:forEach begin="${requestScope['commentList'].size() - 3}"
                                   end="${requestScope['commentList'].size() - 1}" var="index">
                            <div style="margin: 0 16px; padding: 8px 0; display: grid;grid-template-columns: 40px auto">
                                <div>
                                    <img style="border-radius: 50%; width: 32px;height: 32px;"
                                         src="${requestScope['commentList'].get(index).user.avatar}"
                                         alt="avatar">
                                </div>
                                <div>
                                    <div style="background:#e8e8e8;border-radius: 16px;display: inline-block;padding: 8px 12px;max-width: 100%; position: relative;min-width: ${sessionScope['userLogin'].id == requestScope['commentList'].get(index).user.id ? "120px" : "80px"}">
                                        <h5>${requestScope['commentList'].get(index).user.name}</h5>

                                        <div style="word-break: break-all;">
                                                ${requestScope['commentList'].get(index).content}
                                        </div>
                                        <c:if test="${requestScope['commentList'].get(index).getCountLike() > 0}">
                                            <div style="position: absolute;right: -5px;bottom: -10px; border-radius: 10px;height: 18px;line-height: 16px;display: flex;align-items: center; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);background:#fff;padding: 2px 1px 2px 2px">
                                                <img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 16 16'%3e%3cdefs%3e%3clinearGradient id='a' x1='50%25' x2='50%25' y1='0%25' y2='100%25'%3e%3cstop offset='0%25' stop-color='%2318AFFF'/%3e%3cstop offset='100%25' stop-color='%230062DF'/%3e%3c/linearGradient%3e%3cfilter id='c' width='118.8%25' height='118.8%25' x='-9.4%25' y='-9.4%25' filterUnits='objectBoundingBox'%3e%3cfeGaussianBlur in='SourceAlpha' result='shadowBlurInner1' stdDeviation='1'/%3e%3cfeOffset dy='-1' in='shadowBlurInner1' result='shadowOffsetInner1'/%3e%3cfeComposite in='shadowOffsetInner1' in2='SourceAlpha' k2='-1' k3='1' operator='arithmetic' result='shadowInnerInner1'/%3e%3cfeColorMatrix in='shadowInnerInner1' values='0 0 0 0 0 0 0 0 0 0.299356041 0 0 0 0 0.681187726 0 0 0 0.3495684 0'/%3e%3c/filter%3e%3cpath id='b' d='M8 0a8 8 0 00-8 8 8 8 0 1016 0 8 8 0 00-8-8z'/%3e%3c/defs%3e%3cg fill='none'%3e%3cuse fill='url(%23a)' xlink:href='%23b'/%3e%3cuse fill='black' filter='url(%23c)' xlink:href='%23b'/%3e%3cpath fill='white' d='M12.162 7.338c.176.123.338.245.338.674 0 .43-.229.604-.474.725a.73.73 0 01.089.546c-.077.344-.392.611-.672.69.121.194.159.385.015.62-.185.295-.346.407-1.058.407H7.5c-.988 0-1.5-.546-1.5-1V7.665c0-1.23 1.467-2.275 1.467-3.13L7.361 3.47c-.005-.065.008-.224.058-.27.08-.079.301-.2.635-.2.218 0 .363.041.534.123.581.277.732.978.732 1.542 0 .271-.414 1.083-.47 1.364 0 0 .867-.192 1.879-.199 1.061-.006 1.749.19 1.749.842 0 .261-.219.523-.316.666zM3.6 7h.8a.6.6 0 01.6.6v3.8a.6.6 0 01-.6.6h-.8a.6.6 0 01-.6-.6V7.6a.6.6 0 01.6-.6z'/%3e%3c/g%3e%3c/svg%3e"
                                                     alt="Like" width="16" height="16" style="margin-right: 2px">
                                                <c:if test="${requestScope['commentList'].get(index).getCountLike() > 1}">
                                            <span style="margin: 0 6px 0 2px">
                                                    ${requestScope['commentList'].get(index).getCountLike()}
                                            </span>
                                                </c:if>
                                            </div>
                                        </c:if>

                                    </div>
                                    <div style="display: flex">
                                        <div style="margin-right: 5px; font-size: 12px; color: #65676b">
                                                ${requestScope['commentList'].get(index).getTimePassed()}
                                        </div>
                                        <div class="like-btn">
                                            <a href="like?idCmt=${requestScope['commentList'].get(index).id}&idPost=${requestScope['post'].getId()}"
                                               style="color: ${requestScope['commentList'].get(index).isLiked() ? "#2078f4" : "#65676b"}">
                                                Like
                                            </a>
                                        </div>
                                        <c:if test="${sessionScope['userLogin'].id == requestScope['commentList'].get(index).user.id}">
                                            <div class="delete-btn">
                                                <a href="${pageContext.request.contextPath}/comment?action=delete&id=${requestScope['commentList'].get(index).id}&idPost=${requestScope['post'].id}">
                                                    Delete
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                            </div>
                        </c:forEach>
                    </c:if>

                </div>
            </div>
        </article>
    </div>
</div>

${requestScope['commentList'].size()}
<%--<div style="padding-top: 56px">--%>
<%--    ${requestScope["post"]}--%>
<%--    <br>--%>
<%--    <c:forEach items="${requestScope['commentList']}" var="comment">--%>
<%--        <a href="like?idCmt=${comment.getId()}&idPost=${requestScope['post'].getId()}">--%>
<%--            <button>--%>
<%--                    ${comment.isLiked() ? "Da like" : "Chua like"} ${comment.getCountLike()}--%>
<%--            </button>--%>
<%--        </a>--%>
<%--        <p>${comment.getContent()}</p>--%>
<%--    </c:forEach>--%>
<%--    <form action="${pageContext.request.contextPath}/comment" method="post">--%>
<%--        <input type="hidden" value="${requestScope["post"].getId()}" name="idPost">--%>
<%--        <input type="text" name="comment-content" autocomplete="off">--%>
<%--        <button>Comment</button>--%>
<%--    </form>--%>

<%--    <div>--%>
<%--        <img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 16 16'%3e%3cdefs%3e%3clinearGradient id='a' x1='50%25' x2='50%25' y1='0%25' y2='100%25'%3e%3cstop offset='0%25' stop-color='%2318AFFF'/%3e%3cstop offset='100%25' stop-color='%230062DF'/%3e%3c/linearGradient%3e%3cfilter id='c' width='118.8%25' height='118.8%25' x='-9.4%25' y='-9.4%25' filterUnits='objectBoundingBox'%3e%3cfeGaussianBlur in='SourceAlpha' result='shadowBlurInner1' stdDeviation='1'/%3e%3cfeOffset dy='-1' in='shadowBlurInner1' result='shadowOffsetInner1'/%3e%3cfeComposite in='shadowOffsetInner1' in2='SourceAlpha' k2='-1' k3='1' operator='arithmetic' result='shadowInnerInner1'/%3e%3cfeColorMatrix in='shadowInnerInner1' values='0 0 0 0 0 0 0 0 0 0.299356041 0 0 0 0 0.681187726 0 0 0 0.3495684 0'/%3e%3c/filter%3e%3cpath id='b' d='M8 0a8 8 0 00-8 8 8 8 0 1016 0 8 8 0 00-8-8z'/%3e%3c/defs%3e%3cg fill='none'%3e%3cuse fill='url(%23a)' xlink:href='%23b'/%3e%3cuse fill='black' filter='url(%23c)' xlink:href='%23b'/%3e%3cpath fill='white' d='M12.162 7.338c.176.123.338.245.338.674 0 .43-.229.604-.474.725a.73.73 0 01.089.546c-.077.344-.392.611-.672.69.121.194.159.385.015.62-.185.295-.346.407-1.058.407H7.5c-.988 0-1.5-.546-1.5-1V7.665c0-1.23 1.467-2.275 1.467-3.13L7.361 3.47c-.005-.065.008-.224.058-.27.08-.079.301-.2.635-.2.218 0 .363.041.534.123.581.277.732.978.732 1.542 0 .271-.414 1.083-.47 1.364 0 0 .867-.192 1.879-.199 1.061-.006 1.749.19 1.749.842 0 .261-.219.523-.316.666zM3.6 7h.8a.6.6 0 01.6.6v3.8a.6.6 0 01-.6.6h-.8a.6.6 0 01-.6-.6V7.6a.6.6 0 01.6-.6z'/%3e%3c/g%3e%3c/svg%3e"--%>
<%--             alt="Like" width="18" height="18" style="margin-right: 8px">--%>
<%--        ${requestScope['post'].getCountLike()}--%>
<%--    </div>--%>

<%--    <div>--%>
<%--        <a href="like?idPost=${requestScope['post'].getId()}&direction=post"--%>
<%--           style="color: ${requestScope['post'].isLiked() ? "#2078f4" : "black"}">--%>
<%--            <c:if test="${requestScope['post'].isLiked()}">--%>
<%--                <i class="bi bi-hand-thumbs-up-fill" style="padding-right: 8px"></i>--%>
<%--            </c:if>--%>
<%--            <c:if test="${!requestScope['post'].isLiked()}">--%>
<%--                <i class="bi bi-hand-thumbs-up" style="padding-right: 8px"></i>--%>
<%--            </c:if>--%>
<%--            Like--%>
<%--        </a>--%>
<%--    </div>--%>
<%--</div>--%>

<script>
    let showCmt = () => {
        let showCmtChoice = document.querySelector(".showCmtChoice");
        let cmtList = document.querySelector(".cmtList");
        let cmtList3 = document.querySelector(".cmtList3");

        let check = cmtList.style.display === "none";
        if (check) {
            showCmtChoice.innerHTML = "Show less";
            cmtList.style.display = "block";
            cmtList3.style.display = "none";
        } else {
            showCmtChoice.innerHTML = "Show all";
            cmtList3.style.display = "block";
            cmtList.style.display = "none";
        }
    }
</script>

</body>
</html>
