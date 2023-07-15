<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Post</title>
</head>
<body>
<h1>Post</h1>
<table>
  <tr>
    <th>ID</th>
    <th>Title</th>
    <th>Content</th>
  </tr>
  <c:forEach var="post" items="${postList}">
    <tr>
      <td>${post.id}</td>
      <td>${post.title}</td>
      <td>${post.content}</td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
