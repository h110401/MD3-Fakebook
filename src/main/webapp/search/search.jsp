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
</head>
<body>
<a href="home">home</a>
<br>
${requestScope['search']}


<c:forEach items="${requestScope['userList']}" var="user">
    <form action="friend" method="post" style="display: none" id="user${user.getId()}">
        <input type="hidden" name="search" value="${requestScope['search']}">
        <input type="hidden" name="status" value="${requestScope['relativeMap'].get(user.getId())}">
        <input type="hidden" name="iduser" value="${user.getId()}">
    </form>

    <div>
        <span>${user.getName()}</span>
        <c:choose>
            <c:when test="${requestScope['relativeMap'].get(user.getId()).toString() == 'FRIEND'}">
                <button>FRIEND</button>
            </c:when>
            <c:otherwise>
                <button onclick="submit('user${user.getId()}')">${requestScope['relativeMap'].get(user.getId())}</button>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>

<script>
    let submit = (id) => {
        document.getElementById(id).submit();
    }
</script>

</body>

</html>
