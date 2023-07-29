<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="sce" uri="http://www.springframework.org/security/tags" %>
<html>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>nth</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
</head>

<%@ include file="../layout/nav.jsp"%>

<%@ include file="../layout/form2.jsp" %>

<section class="bg-white py-10">
    <div class="container px-5">
        <div>
        <h1 style="font-size: 5rem;">${user.username}님
        <br>
        반갑습니다.
        </h1>
        </div>

        <div>
        <p>사이트 가입일:${user.createdDate} </p>
    </div>

        <div class="d-flex">
    <div class="p-2">
        <a class="btn-primary btn" href="userinfo/modify">비밀번호변경</a>
    </div>

            <div class="p-2">
        <a class="btn-danger btn" href="/userinfo/deleteCheck">회원탈퇴</a>
    </div>
        </div>

     <a class="btn-primary btn"href="/userinfo/post">내가쓴 글</a>
    <a class="btn-primary btn" href="/userinfo/comment">내가쓴 댓글</a>

    </div>
    </div>
    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
</section>




<div>
<%@ include file="../layout/footer.jsp" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>
