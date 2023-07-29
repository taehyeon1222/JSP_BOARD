<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="sce" uri="http://www.springframework.org/security/tags" %>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>NTH</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
</head>

<%@ include file="../layout/nav.jsp"%>

<%@ include file="../layout/form2.jsp" %>

<section class="bg-white py-10">
    <div class="container px-5">
        <br>
        <span>
회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해 주세요.
<br>
사용하고 계신 계정은 은 탈퇴할 경우 복구가 불가능합니다.
<br>
탈퇴 후 회원정보 및 서비스 이용 기록은 모두 삭제 됩니다.
<br>
삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업해 주세요.
<br>
     </span>

        <form action="/userinfo/delete" method="get">
            <input type="checkbox" id="agreement" name="agreement" value="agree" onchange="checkAgreement()">
            <label for="agreement">안내 사항을 모두 확인하였으며 이에 동의합니다.</label>
            <button class="btn-danger btn" type="submit" id="submitBtn" disabled>탈퇴</button>
        </form>

        <script>
            function checkAgreement() {
                var agreement = document.getElementById('agreement');
                var submitBtn = document.getElementById('submitBtn');

                // If the checkbox is checked, enable the submit button, else disable it
                if (agreement.checked) {
                    submitBtn.disabled = false;
                } else {
                    submitBtn.disabled = true;
                }
            }
        </script>

    </div>
    <div class="svg-border-rounded text-dark">
        <!-- Rounded SVG Border-->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 144.54 17.34" preserveAspectRatio="none" fill="currentColor"><path d="M144.54,17.34H0V0H144.54ZM0,0S32.36,17.34,72.27,17.34,144.54,0,144.54,0"></path></svg>
    </div>
</section>
<div>
    <%@ include file="../layout/footer.jsp" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</html>

