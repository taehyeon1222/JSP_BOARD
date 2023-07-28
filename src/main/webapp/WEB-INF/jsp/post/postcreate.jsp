<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/jsp/layout/header.jsp" %>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>게시글작성</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
</head>

<!-- Navbar-->
<%@ include file="../layout/nav.jsp" %>


<section class="d-flex justify-content-center align-items-center page-header-ui page-header-ui-dark bg-gradient-nth-to-secondary">

    <div class="bg-white w-50 rounded" style="lex-direction: column;">
        <div class="d-flex-column justify-content-center con_box brd">



            <div class="">
                <div style="background:#21283208">
                    <h1 class="border-bottom p-5 ">게시글 작성 서비스</h1>
                    <!-- 에러 메시지 표시 -->




                    <c:if test="${not empty errors}">
                        <div class="alert alert-dismissible alert-danger">
                            <c:forEach items="${errors}" var="error">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <strong>
                                <p class="text-dark"> ${error.defaultMessage}</p>
                            </strong>
                            </c:forEach>
                        </div>
                    </c:if>

                    <!-- 에러 메시지 표시 -->
                </div>
              <form action="${formActionUrl}" method="post">
                    <div class="form-group m-2 p-2 ">
                        <!--제목 입력창-->
                        <div class="form-group d-flex justify-content-start">
                        <select class="me-4 w-25 form-select" name="category">

                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <option value="공지" ${postForm.category == '공지사항' ? 'selected' : ''}>공지사항</option>
                            </sec:authorize>
                            <option value="자유" ${postForm.category == '자유' ? 'selected' : ''}>자유</option>
                            <option value="질문" ${postForm.category == '질문게시판' ? 'selected' : ''}>질문게시판</option>
                            <option value="건의" ${postForm.category == '건의사항' ? 'selected' : ''}>건의사항</option>
                        </select>

                        <!--카테고리 선택의 끝-->

                            <div class="me-1 w-100">
                        <input  class=" form-control"
                                type="text" name="title"
                                placeholder="제목"
                                value="${postForm.title}">
                            </div>
                        </div>
                        </div>
                    <!--제목 입력창-->

                    <!--내용 입력창-->
                    <div class="form-group m-2 p-2">
                        <textarea style="resize: none;"
                                  rows="40"
                                  class="form-control"
                                  name="content"
                                  placeholder="내용을 작성해주세요">${postForm.content}</textarea>
                    </div>
                    <!--내용 입력창-->


            <!-- 로그인 에러 전달 스프링시큐리티에서 전달함-->

            <div class="form-group m-2 p-2 d-flex justify-content-between">
                <div>
                    <button class="btn btn-primary m-2" type="submit">게시글 작성</button>
                </div>
            </div>
            </form>
        </div>
        <!--유입력 폼 의 끝-->

    </div>
    </div>

    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
</section>

<%@ include file="../layout/footer.jsp" %>

</html>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>