<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

오류페이지 입니다
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
