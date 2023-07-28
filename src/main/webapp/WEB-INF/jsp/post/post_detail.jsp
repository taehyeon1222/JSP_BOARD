<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>

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

<section class="bg-white py-10">
    <div class="container">
        <p>Post ID:${post.id}</p>

        <!-- 제목 -->
        <div class="d-flex justify-content-between align-items-center table-active border-bottom border-dark text-center">

            <div class="m-2 d-flex">
                <p class="text-center p-2 border-left-right">${post.category}</p>
                <h1 class="text-center p-2">${post.title}</h1>
            </div>

            <div>
                <p class="p-2"> <fmt:formatDate value="${post.createdDate}" pattern="yy.MM.dd [ H:MM ]" /></p>
            </div>

        </div><!--제목레이아웃끝-->

        <!--작성자 -->
        <div class="d-flex justify-content-between align-items-center border-top border-bottom border-dark p-2">
            <div class="d-flex">
                <p>작성자: ${post.userInfo.username}</p>
            </div>
            <div class="d-flex">
                <p>조회수 : ${post.views}</p>
                <p>추천수: ${like}</p>
            </div>
        </div><!--작성자 레이아웃끝-->

        <!-- 내용 -->
        <div class="p-5">

        <p style="height: 200px">${post.content}</p>

        </div>
        <!-- 내용의 끝 -->

        <div class="d-flex justify-content-center align-items-center">

        <a class="btn btn-primary btn-rounded-50 " href="/post/${post.id}/like">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-hand-thumbs-up mt-1 mr-1 mb-1 ml-1 " viewBox="0 0 16 16">
                <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
            </svg>
            <span>추천</span>
        </a>
        </div>

        <div class="d-flex justify-content-between align-items-center table-active text-center">
            <!--목록 버튼-->
            <div class="d-flex">
       <a  class="btn btn-green btn-rounded-50 " href="/post">
           <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
               <path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
               <path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
           </svg>
       </a>
            </div>
            <!--목록 버튼-->


            <!--게시글 수정 및 삭제 버튼-->
            <div class="d-flex">
        <c:if test="${canEdit}">
            <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or hasRole('ROLE_USER'))">
                <a  class="btn btn-danger btn-rounded-50 " href="/post/delete/${post.id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
                        <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
                    </svg>
                    삭제</a>
                <a  class="btn btn-green btn-rounded-50 " href="/post/modify/${post.id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                    </svg>
                    수정</a>
            </sec:authorize>
        </c:if>
        <!--게시글 수정 및 삭제 버튼-->
            </div>

        </div>



        <!-------------------------------------------댓글출력의 시작----------------------------------------------------------->

            <h2>댓글▼</h2>


        <div class="mt-5"> <!--댓글보기 전체-->
            <c:forEach items="${comments}" var="comment">


                <div class="table-active d-flex justify-content-between p-2"> <!--댓글 상단-->
                    <div class="d-flex"> <!--댓글 상단 왼쪽-->
                <p class="p-1">${comment.userInfo.username}</p>
                    </div><!--댓글 상단 왼쪽-->

                    <div class="d-flex"><!--댓글 상단 오른쪽-->
                <p class="p-1"> <fmt:formatDate value="${comment.createdDate}" pattern="yy.MM.dd [ H:MM ]" /></p>
                        <a class="p-1" href="/post/${comment.postId}/comment/${comment.id}/like">
                            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-hand-thumbs-up mt-1 mr-1 mb-1 ml-1 " viewBox="0 0 16 16">
                                <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
                            </svg>
                            <span class="p-0">${commentLikeCount[comment.id]}</span>
                        </a>


                <c:if test="${commentEditPermissions[comment.id]}"><!--작성자와같은지체크-->
                    <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or hasRole('ROLE_USER'))">
                        <a class="p-1" href="/post/${post.id}/delete/${comment.id}">삭제</a>
                        <a class="p-1" href="/post/${post.id}/c/modify/${comment.id}#commentForm">수정</a>
                    </sec:authorize>
                </c:if>
                    </div><!--댓글 상단 오른쪽-->
                </div><!--댓글 상단-->

                <div> <!--댓글하단-->

                    <p>${comment.content}</p>

                </div><!--댓글하단-->

            </c:forEach>
        </div><!--댓글보기 전체-->

        <div>


            <!-------------------------------------------에러메세지출력의시작---------------------------------------->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            <!-------------------------------------------에러메세지출력 끝----------------------------------------------------------->
        <!-------------------------------------------에러메세지출력----------------------------------------------------------->
        <c:if test="${not empty errors}">
            <div class="alert alert-dismissible alert-danger">
                <c:forEach items="${errors}" var="error">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong>
                    ${error.defaultMessage}
                    </strong>
                </c:forEach>
            </div>
        </c:if>
        <!-------------------------------------------에러메세지출력----------------------------------------------------------->
        </div>


        <!-------------------------------------------댓글작성 폼----------------------------------------------------------->

        <div class="justify-content-center align-items-center mt-5">

        <div id="commentForm">
            <form class="id" action="${formActionUrl}" method="post">

                <textarea class="form-control form-group" rows="10" style="resize: none; width: 100%;" type="text"; id="content" name="content"
                          placeholder="내용을 작성해주세요" >${updateComment.content}</textarea>
                <input type="hidden" name="postId" value="${post.id}">
                <button class="btn btn-primary m-2" type="submit">댓글 작성</button>

            </form>
        </div>

        </div>

        <!-------------------------------------------댓글폼----------------------------------------------------------->

    </div>
    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
    </div>
</section>



<%@ include file="../layout/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>