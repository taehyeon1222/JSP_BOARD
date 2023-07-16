<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/layout/header.jsp" %>

<html>
<head>
    <title>게시글작성폼</title>
</head>
<body>
<h1>게시글작성</h1>
<!-- 에러 메시지 표시 -->
<c:if test="${not empty errors}">
    <div class="error-message">
        <c:forEach items="${errors}" var="error">
            <div class="border-bottom border-dark">${error.defaultMessage}</div>
        </c:forEach>
    </div>
</c:if>

<form action="${formActionUrl}" method="post">
    <label for="title">Title:</label>
    <input type="text" id="title" name="title" value="${postForm.title}"><br><br>
    <label for="content">Content:</label><br>
    <textarea id="content" name="content" rows="4" cols="50">${postForm.content}</textarea><br><br>
    <input type="submit" value="작성하기">
</form>
</body>
</html>