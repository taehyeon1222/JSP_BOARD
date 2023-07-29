<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@ include file="../layout/header.jsp"%>


<nav class="navbar navbar-marketing navbar-expand-lg bg-transparent navbar-dark fixed-top">
    <div class="container px-5">
        <h1>
            <a class="navbar-brand text-white"  style="font-size: 40px;" href="/">NTH</a>
        </h1>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i data-feather="menu"></i></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto me-lg-5">

                <li class="nav-item"><a class="nav-link" href="/">Home</a></li> <!--홈 -->


                <li class="nav-item"><a class="nav-link" href="/post?category=공지">공지사항</a></li>

                <li class="nav-item"><a class="nav-link" href="/post?category=자유">자유게시판</a></li>

                <li class="nav-item dropdown no-caret">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownDocs" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        전체 페이지
                        <i class="fas fa-chevron-right dropdown-arrow"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end animated--fade-in-up" aria-labelledby="navbarDropdownDocs">
                        <a class="dropdown-item py-3" href="/post?category=자유" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="book-open"></i></div>
                            <div>
                                <div class="small text-gray-500">자유게시판</div>
                                <p>회원가입 후 누구나 자유롭게 작성 가능합니다.</p>
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="/post?category=질문" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="code"></i></div>
                            <div>
                                <div class="small text-gray-500">QnA</div>
                                <p>궁금하신 부분이 있으면 물어봐주세요</p>
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="/post?category=건의" target="_blank">
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
                <a class="btn fw-500 ms-lg-4 btn-danger" href="/logout">
                    로그아웃
                </a>
            </sec:authorize>
        </div>
    </div>
</nav>