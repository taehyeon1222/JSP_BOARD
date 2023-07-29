<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<form action="/userinfo/modify" method="post">
    <p>기존 비밀번호</p>
    <input type="password" name="password"><br>
    <p>변경할 비밀번호</p>
    <input type="password" name="newPassword">
    <button type="submit">비밀번호 변경</button>
</form>
