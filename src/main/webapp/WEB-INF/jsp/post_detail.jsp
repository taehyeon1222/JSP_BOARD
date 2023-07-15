<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Post Detail</h2>
<p>Post ID: ${post.id}</p>
<p>Title: ${post.title}</p>
<p>작성자: ${post.userInfo.username}</p>
<p>Content: ${post.content}</p>
<a href="/post/delete/${post.id}">게시글 삭제</a>
<a href="/post/modify/${post.id}">게시글 수정</a>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<c:if test="${not empty errors}">
    <div class="error-message">
        <c:forEach items="${errors}" var="error">
            <div class="border-bottom border-dark">${error.defaultMessage}</div>
        </c:forEach>
    </div>
</c:if>
<!-------------------------------------------에러메세지출력----------------------------------------------------------->
<div class="border-dark border-bottom">
    <h2>댓글작성</h2>
    <c:forEach items="${comments}" var="comment">
        <p>댓글id : ${comment.id}</p>
        <p>댓글작성자: ${comment.userInfo.username}</p>
        <p>${comment.content}</p>
        <p>작성시간: ${comment.createdDate}</p>
        <p>게시글 id : ${comment.postId}</p>
        <!-- 댓글 삭제 링크 추가 -->
        <a href="/post/${post.id}/delete/${comment.id}">댓글 삭제</a>
        <a href="/post/${post.id}/c/modify/${comment.id}">댓글 수정</a>
    </c:forEach>
</div>
댓글생성
<form action="${formActionUrl}" method="post">
    <label for="content">댓글:</label>
    <input type="text" id="content" name="content" value="${updateComment.content}"><br><br>
    <input type="hidden" name="postId" value="${post.id}">
    <input type="submit" value="Create">
</form>


