<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%@ include file="../layout/nav.jsp" %>

<header class="page-header-ui page-header-ui-dark bg-gradient-primary-to-secondary">
    <div class="page-header-ui-content pt-10">
        <div class="container px-5 ">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6" data-aos="fade-up">
                    <!--비 인증 사용자 화면-->
                    <sec:authorize access="!isAuthenticated()">
                    <h1 class="page-header-ui-title">반갑습니다.</h1>
                    <p class="page-header-ui-text mb-5">해당 사이트는 로그인 후 이용 가능합니다.</p>
                    <div class="d-flex flex-column flex-sm-row">
                        </sec:authorize>

                        <sec:authorize access="!isAuthenticated()">
                            <a class="btn btn-lg btn-primary fw-500 me-sm-3 mb-3 mb-sm-0" href="#explore">
                                로그인
                                <i class="ms-2" data-feather="arrow-right"></i>
                            </a>
                            <a class="btn btn-lg btn-primary-soft text-primary fw-500" href="https://docs.startbootstrap.com/sb-ui-kit-pro/quickstart" target="_blank">회원가입</a>
                        </sec:authorize>
                        <!--비 인증 사용자 화면-->

                        <!-- 인증 사용자 화면-->
                        <sec:authorize access="isAuthenticated()">
                        <h1 class="page-header-ui-title">${username}님 반갑습니다.</h1>
                        <div class="d-flex flex-column flex-sm-row ">
                            </sec:authorize>

                            <sec:authorize access="isAuthenticated()">
                                <a class="btn btn-lg btn-primary fw-500 me-sm-3 mb-3 mb-sm-0" href="/create">
                                    게시글작성
                                </a>
                                <a class="btn btn-lg btn-primary-soft text-primary fw-500" href="/" target="_blank">
                                    업데이트 준비중 </a>
                            </sec:authorize>
                            <!-- 인증 사용자 화면-->
                        </div>


                    </div>
                    <div class="col-lg-6 d-none d-lg-block" data-aos="fade-up" data-aos-delay="100"><img class="img-fluid" src="/assets/img/illustrations/programming.svg" alt="..." /></div>
                </div>


            </div>
        </div>
        <div class="svg-border-rounded text-light">
            <!-- Rounded SVG Border-->
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
        </div>
    </div>

</header>


<h2>Post Detail</h2>
<p>${post.category}입니다.</p>
<p>Post ID: ${post.id}</p>
<p>Title: ${post.title}</p>
<p>작성자: ${post.userInfo.username}</p>
<p>Content: ${post.content}</p>
<p>조회수 : ${post.views}</p>
<p>추천수: ${like}</p>
<!-- 추천의 시작-->

<a href="/post/${post.id}/like">추천</a>



<!-------------------------------------------에러메세지출력의시작---------------------------------------->
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<!-------------------------------------------에러메세지출력 끝----------------------------------------------------------->
<!--게시글 수정 및 삭제 버튼-->
<c:if test="${canEdit}">
    <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or hasRole('ROLE_USER'))">
        <a href="/post/delete/${post.id}">게시글 삭제</a>
        <a href="/post/modify/${post.id}">게시글 수정</a>
    </sec:authorize>
</c:if>
<!--게시글 수정 및 삭제 버튼-->

<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<c:if test="${not empty errors}">
    <div class="error-message">
        <c:forEach items="${errors}" var="error">
            <div class="border-bottom border-dark">${error.defaultMessage}</div>
        </c:forEach>
    </div>
</c:if>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->



<!-------------------------------------------댓글출력의 시작----------------------------------------------------------->
<div class="border-dark border-bottom">
    <h2>댓글작성</h2>
    <c:forEach items="${comments}" var="comment">
        <p>댓글id : ${comment.id}</p>
        <p>댓글작성자: ${comment.userInfo.username}</p>
        <p>${comment.content}</p>
        <p>작성시간: ${comment.createdDate}</p>
        <p>게시글 id : ${comment.postId}</p>
        <p>Likes: ${commentLikeCount[comment.id]}</p>
        <a href="/post/${comment.postId}/comment/${comment.id}/like">추천</a>

        <c:if test="${commentEditPermissions[comment.id]}"><!--작성자와같은지체크-->
            <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or hasRole('ROLE_USER'))">
                <a href="/post/${post.id}/delete/${comment.id}">댓글 삭제</a>
                <a href="/post/${post.id}/c/modify/${comment.id}#commentForm">댓글 수정</a>
            </sec:authorize>
        </c:if>

    </c:forEach>
</div>






<!-------------------------------------------댓글작성 폼----------------------------------------------------------->
댓글생성
<div id="commentForm">
<form class="id" action="${formActionUrl}" method="post">
    <label for="content">댓글:</label>
    <input type="text" id="content" name="content" value="${updateComment.content}"><br><br>
    <input type="hidden" name="postId" value="${post.id}">
    <input type="submit" value="작성하기">
</form>
</div>
<!-------------------------------------------댓글폼----------------------------------------------------------->

