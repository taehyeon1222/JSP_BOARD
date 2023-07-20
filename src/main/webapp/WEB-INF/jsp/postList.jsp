<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Post</title>
</head>
<body>
<h1>Post</h1>

<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<c:if test="${not empty errorMessage}">
  <div class="error-message">${errorMessage}</div>
</c:if>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->

<form action="/post" method="GET">
  <select name="searchType">
    <option value="title">제목+내용</option>
    <option value="userId">사용자 ID</option>
  </select>
  <input type="text" name="keyword" placeholder="검색어를입력해주세요" value="${keyword}">
  <input type="submit" value="검색">
</form>



<table>
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
      <td>${post.createdDate}</td>
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
<div>
  <c:if test="${pagination.page > 1}">
    <a href="?searchType=${searchType}&keyword=${keyword}&page=${pagination.page-1}">이전</a>
  </c:if>

  <c:set var="startPage" value="${pagination.page - 2 <= 0 ? 1 : pagination.page - 2}" />

  <c:set var="endPage" value="${startPage + 4 >= pagination.pageCnt ? pagination.pageCnt : startPage + 4}" />

  <c:forEach var="i" begin="${startPage}" end="${endPage}">
    <c:choose>
      <c:when test="${i == pagination.page}">
        <a href="?searchType=${searchType}&keyword=${keyword}&page=${i}">${i}</a>
      </c:when>
      <c:otherwise>
        <a href="?searchType=${searchType}&keyword=${keyword}&page=${i}">${i}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${pagination.page < pagination.pageCnt}">
    <a href="?searchType=${searchType}&keyword=${keyword}&page=${pagination.page+1}">다음</a>
  </c:if>
</div>





</body>
</html>

