<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="sce" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<%@ include file="../layout/nav.jsp"%>

<%@ include file="../layout/form2.jsp" %>

<ul class="pagination">
    <li class="d-flex">
        <a class="page-link" href="/userinfo/post">내가쓴 글</a>
        <a class="page-link page-item active" href="/userinfo/comment">내가쓴 댓글</a>
    </li>
</ul>


<table class="table table-hover">
    <tr>
        <th>순번</th>
        <th>게시판 제목</th>
        <th>댓글 내용</th>
        <th>작성일</th>
        <th>추천수</th>

    </tr>
    <c:forEach var="comment" items="${commentsList}" varStatus="status">
        <tr>
            <td>${(status.index + 1) + (pagination.page - 1) * pagination.listSize}</td>
            <td><a href="/post/${comment.postId}">${comment.title}</a></td>
            <td>${comment.content}</td>
            <td><fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd" /></td>
            <td>${comment.likeCount}</td>
        </tr>
    </c:forEach>
</table>



<!--검색결과 null 체크-->
<c:choose>
    <c:when test="${empty commentsList}">
        <p>작성된 댓글이 없습니다..</p>
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

        <li><!-- 다음-->
            <c:if test="${pagination.page < pagination.pageCnt}">
                <a class="page-link" href="?category=${category}&searchType=${searchType}&keyword=${keyword}&page=${pagination.page+1}"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">&raquo;</font></font></a>
            </c:if>
        </li> <!-- 다음-->

    </ul>
</div>



</ul>
</div>
<div>
    <%@ include file="../layout/footer.jsp" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>