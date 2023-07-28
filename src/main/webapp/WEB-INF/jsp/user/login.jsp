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
<!-- Navbar-->


<section class="d-flex justify-content-center align-items-center page-header-ui page-header-ui-dark bg-gradient-primary-to-secondary">

    <div class="bg-white w-50 rounded" style="lex-direction: column;">
        <div class="d-flex-column justify-content-center con_box brd">


            <div class="">
                <div style="background:#21283208">
                <h1 class="border-bottom p-5 ">로그인</h1>
                    <c:if test="${not empty successMessage}">

                    <div class="alert alert-dismissible alert-success">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                                ${successMessage}
                        </font></font></strong></font></a><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                    </font></font></div>
                    <c:remove var="error" scope="session"/>
                </div>
                </c:if>

                </div>
                <form action="/login" method="post">
                    <div class="form-group m-2 p-2">
                        <p class="text-dark">아이디</p>
                        <input  class="form-control w-100" name="username"  type="text"  placeholder="아이디 입력">
                    </div>
                    <div class="form-group m-2 p-2">
                        <p class="text-dark">비밀번호</p>
                        <input class="form-control"  name="password" type="password"   placeholder="비밀번호">
                    </div>

                    <c:if test="${not empty sessionScope.error}">

                        <div class="alert alert-dismissible alert-danger">
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                                    ${sessionScope.error}
                            </font></font></strong></font></a><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                        </font></font></div>
                            <c:remove var="error" scope="session"/>
                        </div>
                    </c:if>

        <div class="form-group m-2 p-2 d-flex justify-content-between">
            <div>
                <a href="/signup">계정이 없을 경우 여기를 눌러 가입 신청을 해주세요.</a>
            </div>
            <div>
                <button class="btn btn-primary m-2" type="submit">로그인</button>
            </div>
        </div>


        <div class="p-3 border-top" style="background:#21283208">
                        <p class=" text-dark ">공용테스트 계정<br>아이디:user<br>비밀번호:1234</p>
                        <p class="text-muted">테스트 계정은 누구나 이용가능합니다.</p>
                    </div>
                </form>
            </div>

        </div>

    </div>

    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
</section>
</main>
</div>


<%@ include file="../layout/footer.jsp" %>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>
