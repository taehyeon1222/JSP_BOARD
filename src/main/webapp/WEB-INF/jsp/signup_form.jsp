<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<h2>
    회원가입
</h2>
<!--서비스오류메세지 -->
<c:if test="${not empty errorMessage}">
    <div class="error-message">
        <c:forEach items="${errorMessage}" var="message">
            <div>${message}</div>
        </c:forEach>
    </div>
</c:if>
<!--서비스오류메세지 -->

<form action="/signup" method="post">
    <div>
        <label for="username">아이디</label>
        <input type="text" id="username" name="username" value="${userInfoForm.username}">
        <c:if test="${not empty errorMessages['username']}">
            <div class="error-message">${errorMessages['username']}</div>
        </c:if>
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password">
        <c:if test="${not empty errorMessages['password']}">
            <div class="error-message">${errorMessages['password']}</div>
        </c:if>
    </div>


    <button type="submit">가입하기</button>
</form>

</html>
