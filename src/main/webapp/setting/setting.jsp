<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Setting</title>
</head>
<body>
<h1>User manager</h1>
<div>
    <a href="${pageContext.request.contextPath}/">Home</a>
</div>

<table border="1" width="100%">
    <tr>
        <th>AVATAR</th>
        <th>ID</th>
        <th>NAME</th>
        <th>EMAIL</th>
        <th>PASSWORD</th>
        <th>STATUS</th>
        <th>EDIT</th>
        <th>DELETE</th>
    </tr>
    <c:forEach items="${requestScope['userList']}" var="user">
        <tr align="center">
            <td style="width: 60px"><img src="${user.avatar}" alt="avatar" width="60" height="60"></td>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.password}</td>
            <td>${user.status}</td>
            <td style="width: 100px;"><a href="#"><button>Edit</button></a></td>
            <td style="width: 100px;"><a href="#"><button>Delete</button></a></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
