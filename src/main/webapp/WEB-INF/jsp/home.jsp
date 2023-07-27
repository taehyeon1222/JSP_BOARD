<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="sce" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>nth_home</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
</head>
<body>
<div id="layoutDefault">
    <div id="layoutDefault_content">
        <main>
            <!-- Navbar-->
            <nav class="navbar navbar-marketing navbar-expand-lg bg-transparent navbar-dark fixed-top">
                <div class="container px-5">
                    <h1>
                    <a class="navbar-brand text-white"  style="font-size: 40px;" href="/">NTH</a>
                    </h1>
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



            <header class="page-header-ui page-header-ui-dark bg-gradient-primary-to-secondary">
                <div class="page-header-ui-content pt-10">
                    <div class="container px-5 text-center">
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
                                    <h1 class="page-header-ui-title">님 반갑습니다.</h1>
                                    <div class="d-flex flex-column flex-sm-row">
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
            </header>






            <section class="bg-white py-10">
                <div class="container px-5">
                    <h1>This is a basic content page.</h1>
                    <p class="lead">You can use this page as a starting point to create your own custom pages, or choose an already built example page to start development!</p>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Qui quisquam animi temporibus ipsum iusto necessitatibus laudantium beatae. Eligendi dolorum laudantium numquam? Officiis nemo error animi aliquam dolor consequatur ducimus unde.</p>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Qui repellat magni eaque beatae explicabo fugit placeat earum, dolores quaerat aperiam vero adipisci quidem minus officiis blanditiis unde? Incidunt, ea ad.</p>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Perspiciatis sed illum soluta, quaerat et deleniti magnam laudantium, non omnis numquam quos placeat. Porro autem consectetur dolor minima voluptatum modi maiores.</p>
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
            </div>
        </footer>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
