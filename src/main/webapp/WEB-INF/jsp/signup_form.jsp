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
<nav class="navbar navbar-marketing navbar-expand-lg bg-transparent navbar-dark fixed-top">
    <div class="container px-5">
        <a class="navbar-brand text-white" href="/">NTH</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i data-feather="menu"></i></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto me-lg-5">

                <li class="nav-item"><a class="nav-link" href="/">Home</a></li> <!--홈 -->


                <li class="nav-item"><a class="nav-link" href="/">공지사항</a></li>

                <li class="nav-item"><a class="nav-link" href="/">자유게시판</a></li>

                <li class="nav-item dropdown no-caret">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownDocs" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        전체 페이지
                        <i class="fas fa-chevron-right dropdown-arrow"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end animated--fade-in-up" aria-labelledby="navbarDropdownDocs">
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/quickstart" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="book-open"></i></div>
                            <div>
                                <div class="small text-gray-500">자유게시판</div>
                                <p>회원가입 후 누구나 자유롭게 작성 가능합니다.</p>
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/components" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="code"></i></div>
                            <div>
                                <div class="small text-gray-500">질문게시판</div>
                                <p>궁금하신 부분이 있으면 물어봐주세요</p>
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/changelog" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="file-text"></i></div>
                            <div>
                                <div class="small text-gray-500">건의사항</div>
                                <p>사이트 이용에 불편하신점이 있다면 알려주세요.</p>
                            </div>
                        </a>

                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/quickstart" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="book-open"></i></div>
                            <div>
                                <div class="small text-gray-500">트게더 css 편집기</div>
                                <p>업데이트 준비중 입니다.</p>
                            </div>
                        </a>

                    </div>
                </li>
            </ul>
            <sec:authorize access="!isAuthenticated()">
                <a class="btn fw-500 ms-lg-4 btn-teal" href="/login">
                    로그인
                </a>
                <a class="btn fw-500 ms-lg-4 btn-teal" href="/signup">
                    회원가입
                </a>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <a class="btn fw-500 ms-lg-4 btn-teal" href="/userinfo">
                    회원정보
                </a>
                <a class="btn fw-500 ms-lg-4 btn-teal" href="/logout">
                    로그아웃
                </a>
            </sec:authorize>
        </div>
    </div>
</nav>









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
</main>
</div>


<div id="layoutDefault_footer">
    <footer class="footer pt-10 pb-5 mt-auto bg-dark footer-dark">
        <div class="container px-5">
            <div class="row gx-5">
                <div class="col-lg-3">
                    <div class="footer-brand">No Tae Hyeon</div>
                    <div class="icon-list-social mb-5">
                        <a class="icon-list-social-link" href="#!"><i class="fab fa-instagram"></i></a>
                        <a class="icon-list-social-link" href="https://github.com/taehyeon1222"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="row gx-5">
                        <div class="col-lg-3 col-md-6 mb-5 mb-lg-0">
                            <div class="text-uppercase-expanded text-xs mb-4">project</div>
                            <ul class="list-unstyled mb-0">
                                <li class="mb-2"><a href="https://github.com/taehyeon1222/JPA_board">JPA project</a></li>
                                <li class="mb-2"><a href="https://github.com/taehyeon1222/JSP_BOARD">MyBatis project</a></li>
                            </ul>


                        </div>
                        <div class="col-lg-8 col-md-6 mb-5 mb-lg-0">
                            <div class="text-uppercase-expanded text-xs mb-4">사이트 안내</div>
                            <ul class="list-unstyled mb-0">
                                <li class="mb-2">해당사이트는 개인 프로젝트 사이트 입니다.<br>언제든 사이트 이용이 중지 될 수 있으며<br>
                                    모든 사이트 자료는 언제든 삭제 될 수 있습니다. <br><br>해당 사이트에서는 개인정보를 수집하고 있지 않습니다.<br>
                                    모든 비밀번호는 암호화 되어 저장됩니다.
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <hr class="my-5" />
        <div class="row gx-5 align-items-center">
            <div class="col-md-6 small">2023-07-31</div>
            <div class="col-md-6 text-md-end small">
                <p>사이트문의</p>
                <p> w.nth1222@gmail.com</p>
            </div>
        </div>


    </footer>
</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>
