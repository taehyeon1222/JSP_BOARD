<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <input type="text" name="title" placeholder="제목" required value="${postForm.title}">
    <textarea name="content" placeholder="내용" required>${postForm.content}</textarea>
    <select name="category">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <option value="공지" ${postForm.category == '공지사항' ? 'selected' : ''}>공지사항</option>
        </sec:authorize>
        <option value="자유" ${postForm.category == '자유' ? 'selected' : ''}>자유</option>
        <option value="질문" ${postForm.category == '질문게시판' ? 'selected' : ''}>질문게시판</option>
        <option value="건의" ${postForm.category == '건의사항' ? 'selected' : ''}>건의사항</option>
    </select>
    <button type="submit">게시하기</button>
</form>

</body>
</html>