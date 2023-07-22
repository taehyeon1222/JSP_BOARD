<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<h2>
    로그인
</h2>
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>


<form action="/login" method="post">
    <p>아이디</p>
    <input type="text" name="username"><br>
    <p>비밀번호</p>
    <input type="text" name="password">
    <button type="submit">로그인</button>
</form>

</html>
