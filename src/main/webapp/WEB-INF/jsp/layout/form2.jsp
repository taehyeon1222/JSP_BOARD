<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="sce" uri="http://www.springframework.org/security/tags" %>
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