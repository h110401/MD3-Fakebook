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
</head>
<body>

${requestScope["post"]}
<br>
<c:forEach items="${requestScope['commentList']}" var="comment">
    <p>${comment.getContent()}</p>
</c:forEach>
<form action="${pageContext.request.contextPath}/comment" method="post">
    <input type="hidden" value="${requestScope["post"].getId()}" name="idPost">
    <input type="text" name="comment-content" autocomplete="off">
    <button>Comment</button>
</form>

</body>
</html>
