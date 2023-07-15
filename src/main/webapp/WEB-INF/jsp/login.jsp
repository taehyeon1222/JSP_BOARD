<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<h2>
    로그인
</h2>

<form action="/login" method="post">
    <input type="text" name="username"><br>
    <input type="text" name="password">
    <button type="submit">가입하기</button>
</form>

</html>
