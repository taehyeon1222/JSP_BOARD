<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<h2>
    회원가입
</h2>

<form action="/signup" method="post">
    <input type="text" name="username" value="${userInfoForm.username}"><br>
    <input type="text" name="password" value="${userInfoForm.password}">
    <button type="submit">가입하기</button>
</form>

</html>
