# JSP_BOARD_service

JSP 와 MyBatis 를 활용한 기본적인기능들의 게시판 개인 프로젝트 입니다.

# 💻프로젝트 소개
한달 이라는 기간을 미리 정해두고 여러 게시판 사이트를 참고 하여 제작하게된 회원 전용 게시판 사이트 입니다.
css는 부트스트랩을 이용하여 직접 여러 사이트를 방문하여 커스터마이징 하였습니다.

* #### 개발기간 : 2023.07.05 ~ 2023.07.29
* #### 개발 인원 : 1명(노태현)
* #### 개발 언어: JAVA 19.02
* #### 백엔드 개발 환경: SpringBoot 3.0.5, IntelliJ IDEA, MyBatis, Spring Security ,oracle(22.3.3)
* #### 프론트 개발환경 : JSP, bootstrap template
* #### 데이터 베이스: oracle(22.3.3)
* #### 형상관리 : GitHub 


### ⚙ 주요기능
* #### 회원 가입 페이지

 유효성 검사
 @NotEmpty 유효성 검사 이후 회원가입가능

이미등록된 회원의 경우 에러메세지를 사용자에게 반환
<br>
데이터베이스에 존재하는 아이디를 입력한 채 회원가입 버튼을 누른 경우 "이미 사용중인 아이디입니다."의 메시지를 보여주기
<br>모든 검사가 통과되었다면 메인페이지로 이동시키기
이후 데이터베이스에 BCryp로 비밀번호를 암호화 하여 저장하였습니다.


* #### 로그인 페이지

로그인을 하지 않은 경우 아래 페이지만 이용가능
회원가입 페이지
로그인 페이지
게시글 목록 조회 페이지
게시글 상세보기 페이지
게시글 검색 페이지
그 외 로그인을 하지 않거나 올바르지 않은 경로로 접속한 사용자가 로그인이 필요한 경로에 접속한 경우 로그인 페이지로 이동 및 에러메세지르 반환
@PreAuthorize("isAuthenticated()") 어노테이션을 사용


* #### 로그인 검사

아이디와 비밀번호가 일치하지 않을 시 "아이디 또는 비밀번호가 일치하지 않습니다. "의 메시지를 보여주기


* #### 게시글부분

게시글 작성, 수정 시 제목과 내용은 공백 혹은 빈칸으로 작성불가능
내가 작성한 글만 수정, 삭제 가능하게 하며 버튼을 노출시키지 않음
<br>
<br>
<pre>
   public boolean AccessCheckPostButton(Principal principal, Post post){
        boolean canEditPost = SecurityContextHolder.getContext().getAuthentication().isAuthenticated() &&
                (SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")) ||
                        (principal != null && post.getUserInfo().getUsername().equals(principal.getName())));
        return canEditPost;
    }
</pre>
메서드를 통해 모델로 사용자의 권한을 체크 후 버튼을 노출 시켜줍니다.<br>
이후 뷰에서도 한번더 체크하여 이중으로 체크하였습니다.<br>
로그인을 하지 않고 글 작성 버튼을 누른 경우 로그인 페이지로 이동<br>
그 외 일반적인 방법이 아닌 직접 링크로 접속하는것 또한 방지, 및 공지사항은 관리자 계정만 작성가능<br>
홈화면에서 공지사항 과 추천수가 많은 인기글 순으로 확인가능<br>

* #### 댓글 검사

댓글은 로그인한 사용자만 작성 가능하게 하기
댓글 작성 및 수정시 빈칸 혹은 공백으로 된 경우 “내용은 필수 항목입니다.”의 메시지 보여주기

* #### 추천 기능
추천은로그인 유저만 가능하며 set 으로 입력받아 중복되지 않도록 한번만 추천가능

* #### 검색 기능

  검색은 현재 사용자가 접속한 게시글 카테고리(공지,자유,건의,질문 등) 을 기반으로 제목+내용 혹은 유저이름으로 검색가능

*  #### 회원정보

  회원정보에서는 회원 탈퇴 및 가입일 , 내가 쓴 글 모아보기 , 내가 쓴 댓글 모아보기가 가능합니다.

* #### 인기글 기능

  전체게시글에서 좋아요수 가 가장 많은 순으로 5개의 항목을 메인 화면에서 보여줍니다.
    
# 🧰 DB 설계

##### ERD

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/9525fd3c-927e-4bf7-8ef4-c25d35da7235.JPG" width="500" height="300">

<br>
#  💻화면 설계
<br>


<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/37b35812-71e2-4155-a60b-e8add87277cc.JPG" width="500" height="300">
<br>
#### 💻메인화면
<br>
메인화면에서는 로그인 버튼/회원가입 버튼 및 <br>가장 최근의 공지사항 글 5개 / 인기글 5개를 조회 할 수 있습니다.

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/aa23b5aa-55c8-4c0d-aeda-f55a3ffe443d.JPG" width="500" height="300">
<br>
#### 💻게시물리스트
<br>

게시물 리스트 페이지에서는 게시물의 카테고리 별로 공지사항/자유게시판/건의사항 등으로 이동 할 수 있으며<br>
컨트롤러에서 한 화면으로 뷰를 반환 시켰습니다. <br>
이후 게시글 검색시 현재 카테고리에 맞게 검색된 게시글을 조회 할 수 있습니다.

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/176418d0-e33a-40f2-a9f1-896d4b33b7b3.JPG" width="500" height="300">
<br>
#### 💻사용자 정보 화면
<br>
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/bc0121c6-7f23-485b-83be-c7ecc78f15b4.JPG" width="500" height="300">
ㅁㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㅇㄴㅁㅇㄴㅁㅇ
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/6aacbebe-bac5-4237-9256-b900817192ac.JPG" width="500" height="300">
ㅁㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㅇㄴㅁㅇ
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/5706c18a-7c3b-4813-babc-ac0728713a6e.JPG" width="500" height="300">

