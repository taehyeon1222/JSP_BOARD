<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/layout/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<body>

<sec:authorize access="!isAuthenticated()">
    <a class="boxed-btn3" href="/login">로그인</a>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <a class="boxed-btn3" href="/logout">로그아웃</a>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <a class="boxed-btn3" href="/signup">회원가입</a>
</sec:authorize>
<a class="boxed-btn3" href="/post">글목록</a>
<a class="boxed-btn3" href="/create">글작성</a>

<sec:authorize access="hasRole('ROLE_USER')">
    유저권한임
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <c:out value="${pageContext.request.userPrincipal.name}님, 반갑습니다."/>
</sec:authorize>




</body>