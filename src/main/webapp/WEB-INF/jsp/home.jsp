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
<sec:authorize access="isAuthenticated()">
    <a class="boxed-btn3" href="/userinfo">회원정보</a>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <a class="boxed-btn3" href="/signup">회원가입</a>
</sec:authorize>
<a class="boxed-btn3" href="/post">글목록</a>
<a class="boxed-btn3" href="/post?category=자유">자유게시판</a>
<a class="boxed-btn3" href="/post?category=공지">공지사항</a>
<a class="boxed-btn3" href="/post?category=질문">질문</a>
<a class="boxed-btn3" href="/post?category=건의">건의사항</a>
<a class="boxed-btn3" href="/create">글작성</a>
<sec:authorize access="isAuthenticated()">
    <c:out value="${pageContext.request.userPrincipal.name}님, 반갑습니다."/>
</sec:authorize>




</body>