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
    <title>로그인</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
</head>



<!-- Navbar-->
<%@ include file="../layout/nav.jsp" %>


<!--회원가입 틀 -->
<section class="d-flex justify-content-center align-items-center page-header-ui page-header-ui-dark bg-gradient-nth-to-secondary">

    <div class="bg-white w-50 rounded" style="lex-direction: column;">
        <div class="d-flex-column justify-content-center con_box brd">


            <!--서비스오류메세지 -->
            <div class="">
                <div style="background:#21283208">
                    <h1 class="border-bottom p-5 ">회원가입</h1>
                </div>
                <form action="/signup" method="post">
                    <div class="form-group m-2 p-2">
                        <!--아이디 입력창-->
                        <p class="text-dark">아이디</p>
                        <input  class="form-control w-100" name="username"  type="text"  placeholder="아이디 입력">

                        <!-- 아이디 검증에러 메세지 -->
                        <c:if test="${not empty errorMessages['username']}">
                            <div class="alert alert-dismissible alert-danger">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                <strong>
                                    <span style="vertical-align: inherit;">${errorMessages['username']}</span>
                                </strong>
                            </div>
                        </c:if>
                        <!--아이디 검증에러 메세지의 끝-->

                        <!--아이디 중복 오류 Exception 오류내역 출력-->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-dismissible alert-danger">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                <strong>
                                    <span style="vertical-align: inherit;">${errorMessage}</span>
                                </strong>
                            </div>
                        </c:if>
                        <!--아이디 중복 오류 Exception 오류내역 출력-->
                    </div>
                    <!--아이디 입력창-->

                    <!--비밀번호 입력창-->
                    <div class="form-group m-2 p-2">
                        <p class="text-dark">비밀번호</p>
                        <input class="form-control"  name="password" type="password"   placeholder="비밀번호">

                        <!-- 비밀번호 검증에러메세지 -->
                        <c:if test="${not empty errorMessages['password']}">
                            <div class="alert alert-dismissible alert-danger">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                <strong>
                                    <span style="vertical-align: inherit;">${errorMessages['password']}</span>
                                </strong>
                            </div>
                        </c:if>
                        <!-- 비밀번호 검증 에러메세지의 끝-->

                    </div>
                    <!--비밀번호 입력창-->


                    <!-- 로그인 에러 전달 스프링시큐리티에서 전달함-->
                    <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                                ${sessionScope.error}
                        </font></font></strong></font></a><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                    </font></font></div>
                        <c:remove var="error" scope="session"/> <!--세션 삭제-->
            </div>
            </c:if>
            <!-- 로그인 에러 전달 스프링시큐리티에서 전달함-->

            <div class="form-group m-2 p-2 d-flex justify-content-between">
                <div>
                    <p class="text-dark">계정을 분실할 경우 찾을 방법이 없습니다.</p>
                </div>
                <div>
                    <button class="btn btn-primary m-2" type="submit">가입하기</button>
                </div>
            </div>

            <div class="p-3  border-top" style="background:#21283208">
                <p class=" text-dark">공용테스트 계정<br>아이디:user<br>비밀번호:1234</p>
                <p class="text-muted">테스트 계정은 누구나 이용가능합니다.</p>
            </div>
            </form>
        </div>
        <!--유저입력 폼 의 끝-->

    </div>

    </div>

    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>

</section>
<!--회원가입 틀 -->
<%@ include file="../layout/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>
