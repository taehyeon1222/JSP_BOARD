<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/jsp/layout/header.jsp" %>

<html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        $("form").on("submit", function(event){
            event.preventDefault();

            var formData = $(this).serialize();
            var url = $(this).attr("action");
            var method = "post"; // 또는 필요한 HTTP 메소드를 지정합니다

            $.ajax({
                type: method,
                url: url,
                data: formData,
                success: function(response){
                    // 성공적으로 응답을 받았을 때의 처리
                    // 예를 들면, 페이지를 특정 게시물의 페이지로 이동시킬 수 있습니다.
                    window.location.href = "/post/" + response;
                },
                error: function(xhr, status, error){
                    // 요청이 실패했을 때의 처리
                    // 예를 들면, 오류 메시지를 사용자에게 표시할 수 있습니다.
                    alert("게시물 생성에 실패했습니다: " + error);
                }
            });
        });
    });
</script>

<form action="${formActionUrl}" method="post">
    <select name="category">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <option value="공지" ${postForm.category == '공지사항' ? 'selected' : ''}>공지사항</option>
        </sec:authorize>
        <option value="자유" ${postForm.category == '자유' ? 'selected' : ''}>자유</option>
        <option value="질문" ${postForm.category == '질문게시판' ? 'selected' : ''}>질문게시판</option>
        <option value="건의" ${postForm.category == '건의사항' ? 'selected' : ''}>건의사항</option>
    </select>
    <input type="text" name="title" placeholder="제목" value="${postForm.title}">
    <div>
    <textarea style="resize: none;"
              rows="40"
              class="form-control"
              name="content"
              placeholder="내용을 작성해주세요">${postForm.content}</textarea>
    </div>
    <!--내용 입력창-->
    <button type="submit">게시글 작성</button>
</form>
<!-- 생략 -->
</html>

