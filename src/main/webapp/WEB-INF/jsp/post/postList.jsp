<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/css/styles.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
<script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
<html>
<head>
  <title>게시판</title>
</head>
<body>

<%@ include file="../layout/nav.jsp" %>


<header class="page-header-ui page-header-ui-dark bg-gradient-primary-to-secondary">
  <div class="page-header-ui-content pt-10">

    <div class="container px-5 ">
      <h1 class="page-header-ui-title">${category}게시판</h1>
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


          <div>

          <form action="/post" method="GET">
            <input type="hidden" name="category" value="${category}">

            <div class="d-flex justify-content-start">

            <div class="col-2">
            <select class="form-select" name="searchType">
              <option value="title">제목+내용</option>
              <option value="userId">사용자 ID</option>
            </select>
            </div>


            <div class="col-8">
            <input class="form-control"
                    type="text" name="keyword" placeholder="검색어를 입력해주세요" value="${keyword}">
            </div>

              <div class="col-2">
                <button class="btn btn-green" type="submit">검색</button>
              </div>

            </div>
          </form>

          </div>





        </div>

      </div>
    </div>
    <div class="svg-border-rounded text-light">
      <!-- Rounded SVG Border-->
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
  </div>

</header>



<!----------------------------------------
<c:if test="${not empty errorMessage}">
  <div class="error-message">${errorMessage}</div>
</c:if>
------------에러메세지출력----------------->


<section class="bg-white py-10">
  <div class="container">

    <table class="table table-hover">
      <tr>
        <th>순번</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
        <th>추천수</th>

      </tr>
      <c:forEach var="post" items="${postList}" varStatus="status">
        <tr>
          <td>${(status.index + 1) + (pagination.page - 1) * pagination.listSize}</td>
          <td><a href="/post/${post.id}">${post.title}</a></td>
          <th>${post.userInfo.username}</th>
          <td><fmt:formatDate value="${post.createdDate}" pattern="yyyy-MM-dd" /></td>
          <td>${post.views}</td>
          <td>${post.likeCount}</td>
        </tr>
      </c:forEach>
    </table>

    <!--검색결과 null 체크-->
    <c:choose>
      <c:when test="${empty postList}">
        <p>검색 결과가 없습니다.</p>
      </c:when>
    </c:choose>
    <!--검색결과 null 체크-->

    <!-- 하단페이징 처리-->
    <div class="d-flex justify-content-center align-items-center">
      <!-- 이전 -->
      <ul class="pagination">
        <li>
          <c:if test="${pagination.page > 1}">
            <a class="page-link" href="?category=${category}&searchType=${searchType}&keyword=${keyword}&page=${pagination.page-1}">
              <font style="vertical-align: inherit;"><font style="vertical-align: inherit;">&laquo;</font></font></a>
          </c:if>
        </li>
        <!-- 이전 -->




      <c:set var="startPage" value="${pagination.page - 2 <= 0 ? 1 : pagination.page - 2}" />

      <c:set var="endPage" value="${startPage + 4 >= pagination.pageCnt ? pagination.pageCnt : startPage + 4}" />


      <c:forEach var="i" begin="${startPage}" end="${endPage}">

<li class="page-item active">
        <c:choose>
          <c:when test="${i == pagination.page}"> <!--현재페이지-->
            <a class="page-link" href="?category=${category}&searchType=${searchType}&keyword=${keyword}&page=${i}">${i}<font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font></a>
          </c:when>
          <c:otherwise>
</li>

        <li class="page-item"> <!--페이지 번호-->
            <a class="page-link" href="?category=${category}&searchType=${searchType}&keyword=${keyword}&page=${i}">${i}<font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font></a>
          </c:otherwise>
        </c:choose>

      </c:forEach>
</li>


        <!-- 다음-->
        <li>
          <c:if test="${pagination.page < pagination.pageCnt}">
            <a class="page-link" href="?category=${category}&searchType=${searchType}&keyword=${keyword}&page=${pagination.page+1}"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">&raquo;</font></font></a>
          </c:if>
        </li>
        <!-- 다음-->


      </ul>
    </div>







  </ul>


  </div>
  <div class="svg-border-rounded text-dark">
    <!-- Rounded SVG Border-->
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
  </div>
</section>






</body>
<%@ include file="../layout/footer.jsp" %>

</html>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>

