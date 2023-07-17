<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2>Post Detail</h2>
<p>Post ID: ${post.id}</p>
<p>Title: ${post.title}</p>
<p>작성자: ${post.userInfo.username}</p>
<p>Content: ${post.content}</p>
<p>추천수: ${like}</p>
<!-- 추천의 시작-->

<a href="/post/${post.id}/like">추천</a>
<!---------------------------------------게시글 삭제 수정버튼의 시작---------------------------------->
<sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or (hasRole('ROLE_USER')
and post.author != null and principal.username == post.author.username))">
    <a href="/post/delete/${post.id}">게시글 삭제</a>
</sec:authorize>
<sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or (hasRole('ROLE_USER')
and post.author != null and principal.username == post.author.username))">
    <a href="/post/modify/${post.id}">게시글 수정</a>
</sec:authorize>
<!---------------------------------------게시글 삭제 수정버튼의 끝------------------------------------>


<!-------------------------------------------에러메세지출력의시작---------------------------------------->
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<!-------------------------------------------에러메세지출력 끝----------------------------------------------------------->


<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<c:if test="${not empty errors}">
    <div class="error-message">
        <c:forEach items="${errors}" var="error">
            <div class="border-bottom border-dark">${error.defaultMessage}</div>
        </c:forEach>
    </div>
</c:if>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->



<!-------------------------------------------댓글출력의 시작----------------------------------------------------------->
<div class="border-dark border-bottom">
    <h2>댓글작성</h2>
    <c:forEach items="${comments}" var="comment">
        <p>댓글id : ${comment.id}</p>
        <p>댓글작성자: ${comment.userInfo.username}</p>
        <p>${comment.content}</p>
        <p>작성시간: ${comment.createdDate}</p>
        <p>게시글 id : ${comment.postId}</p>
        <p>Likes: ${commentLikeCount[comment.id]}</p>
        <a href="/post/${comment.postId}/comment/${comment.id}/like">추천</a>


        <!---------------------------------------댓글 삭제및수정버튼의 시작---------------------------------->

        <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or (hasRole('ROLE_USER')and
        post.author != null and
        rincipal.username == post.author.username))">
            <a href="/post/${post.id}/delete/${comment.id}">댓글 삭제</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or (hasRole('ROLE_USER')and
        post.author != null and
        principal.username == post.author.username))">
            <a href="/post/${post.id}/c/modify/${comment.id}#commentForm">댓글 수정</a>
        </sec:authorize>
        <!---------------------------------------댓글 삭제및수정버튼의 끝------------------------------------>

    </c:forEach>
</div><!-------------------------------------------댓글출력의 끝----------------------------------------------------------->






<!-------------------------------------------댓글폼----------------------------------------------------------->
댓글생성
<div id="commentForm">
<form class="id" action="${formActionUrl}" method="post">
    <label for="content">댓글:</label>
    <input type="text" id="content" name="content" value="${updateComment.content}"><br><br>
    <input type="hidden" name="postId" value="${post.id}">
    <input type="submit" value="작성하기">
</form>
</div>
<!-------------------------------------------댓글폼----------------------------------------------------------->

