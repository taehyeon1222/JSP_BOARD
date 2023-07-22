<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<a href="/userinfo/post">내가쓴 글</a>
<a href="/userinfo/comment">내가쓴 댓글</a>
<table>
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
            <td>${comment.createdDate}</td>
            <td>${comment.likeCount}</td>
            <!-- You need to have these values in your comment object -->
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
<div>
    <c:if test="${pagination.page > 1}">
        <a href="?page=${pagination.page-1}">이전</a>
    </c:if>

    <c:set var="startPage" value="${pagination.page - 2 <= 0 ? 1 : pagination.page - 2}" />

    <c:set var="endPage" value="${startPage + 4 >= pagination.pageCnt ? pagination.pageCnt : startPage + 4}" />

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${i == pagination.page}">
                <a href="?page=${i}">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${pagination.page < pagination.pageCnt}">
        <a href="?page=${pagination.page+1}">다음</a>
    </c:if>
</div>
