# JSP_BOARD_service

JSP와 MyBatis를 활용한 기본적인 기능들이 있는 게시판 개인 프로젝트입니다.

# 💻프로젝트 소개

미리 정해둔 한 달이라는 기간 동안 여러 게시판 사이트를 참고하여 제작하게 된 회원 전용 게시판 사이트입니다.
CSS는 부트스트랩을 이용하고, 여러 사이트를 직접 방문하여 커스터마이징하였습니다.

>**개발기간**<br>
>  2023.07.05 ~ 2023.07.29

>**개발 인원** <br>
>1명(노태현)

<br>

**사용언어**
<br>
![Java](https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white)

**백엔드 개발 환경**<br>
 <img src="https://img.shields.io/badge/springBoot 3.0.5-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> 
   IntelliJ IDEA, MyBatis, Spring Security
   
   ![intellijidea](https://img.shields.io/badge/intellijidea-ffffff?style=for-the-badge&logo=react&logoColor=green)
   
![React](https://img.shields.io/badge/react-ffffff?style=for-the-badge&logo=react)
![React](https://img.shields.io/badge/react-444444?style=for-the-badge&logo=react)
![React](https://img.shields.io/badge/react?style=for-the-badge&logo=react)
  
**프론트 개발환경**<br>
 JSP,   <img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
 
**데이터 베이스**<br>
<img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> 

**형상관리**<br> 
 <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">


## ⚙ 주요기능

#### 회원 가입 페이지

@NotEmpty 유효성 검사 후에 회원가입 가능
<br>
이미 등록된 회원의 경우 사용자에게 에러 메시지를 반환합니다.
<br>
데이터베이스에 존재하는 아이디를 입력한 상태에서 회원가입 버튼을 누른 경우, "이미 사용 중인 아이디입니다."라는 메시지를 보여줍니다.
<br>모든 검사가 통과되었다면 메인 페이지로 이동합니다.
이후 데이터베이스에 BCrypt로 비밀번호를 암호화하여 저장합니다

#### 로그인 페이지

로그인을 하지 않은 경우, 아래 페이지들만 이용 가능합니다:

+ 회원가입 페이지
+ 로그인 페이지 
+ 게시글 목록 조회 페이지
+ 게시글 상세보기 페이지
+ 게시글 검색 페이지
+ 그 외 로그인을 하지 않거나 올바르지 않은 경로로 접속한 사용자가 로그인이 필요한 경로에 접속한 경우, 로그인 페이지로 이동 및 에러 메시지를 반환합니다. <br>

@PreAuthorize("isAuthenticated()") 어노테이션을 사용합니다.


#### 로그인 검사

아이디와 비밀번호가 일치하지 않을 시 "아이디 또는 비밀번호가 일치하지 않습니다. "의 메시지를 보여주기


 #### 게시글부분

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

 #### 댓글 검사

댓글은 로그인한 사용자만 작성 가능하게 하기
댓글 작성 및 수정시 빈칸 혹은 공백으로 된 경우 “내용은 필수 항목입니다.”의 메시지 보여주기

 #### 추천 기능
추천은로그인 유저만 가능하며 set 으로 입력받아 중복되지 않도록 한번만 추천가능

 #### 검색 기능

  검색은 현재 사용자가 접속한 게시글 카테고리(공지,자유,건의,질문 등) 을 기반으로 제목+내용 혹은 유저이름으로 검색가능

#### 회원정보

  회원정보에서는 회원 탈퇴 및 가입일 , 내가 쓴 글 모아보기 , 내가 쓴 댓글 모아보기가 가능합니다.

 #### 인기글 기능

  전체게시글에서 좋아요수 가 가장 많은 순으로 5개의 항목을 메인 화면에서 보여줍니다.
    
# 🧰 DB 설계

##### ERD

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/9525fd3c-927e-4bf7-8ef4-c25d35da7235.JPG" width="100%" height="300">

<br>

# 💻화면설계

#### 💻메인화면

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/37b35812-71e2-4155-a60b-e8add87277cc.JPG" width="100%" height="300">

<br>

메인화면에서는 로그인 버튼/회원가입 버튼 및 <br>가장 최근의 공지사항 글 5개 / 인기글 5개를 조회 할 수 있습니다.

<br>

#### 💻게시물리스트

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/aa23b5aa-55c8-4c0d-aeda-f55a3ffe443d.JPG" width="100%" height="300">

<br>
게시물 리스트 페이지에서는 게시물의 카테고리 별로 공지사항/자유게시판/건의사항 등으로 이동 할 수 있으며<br>
컨트롤러에서 한 화면으로 뷰를 반환 시켰습니다. <br>
이후 게시글 검색시 현재 카테고리에 맞게 검색된 게시글을 조회 할 수 있습니다.

#### 💻사용자 정보 화면

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/176418d0-e33a-40f2-a9f1-896d4b33b7b3.JPG" width="100%" height="300">

<br>
사용자 정보 화면에서는 회원탈퇴,비밀번호 변경,내가쓴글,내가쓴 댓글 을 확인 할 수 있습니다.

#### 💻비밀번호 변경

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/bc0121c6-7f23-485b-83be-c7ecc78f15b4.JPG"  width="100%" height="300">

<br>
비밀번호 변경에서는 기존의 비밀번호를 확인 후 새로운 비밀번호로 변경이 가능합니다.
<br>

#### 💻내가쓴글 및 내가쓴 댓글 확인

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/6aacbebe-bac5-4237-9256-b900817192ac.JPG" width="100%" height="500">
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/5706c18a-7c3b-4813-babc-ac0728713a6e.JPG" width="100%" height="500">

내가쓴 글 과 내가 쓴 댓글을 페이징으로 확인이 가능합니다.
<br>

#### 💻게시물 상세페이지

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/0a22ac29-31d9-435a-81e9-bee4480b14cb" width="100%" height="500">
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/a15fcd19-c9ac-4c98-a95d-4a8435d5667d" width="100%" height="500">


게시물 상세페이지에서는 관리자 및 게시물 작성자만 수정 및 삭제 할 수 있으며 게시물 작성자와 관리자가 아닐 경우 버튼이 노출 되지 않습니다.
<br>


<h4>💻로그인/회원가입페이지</h4>

 <img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/7eb56a2c-a372-4f1d-b270-9ba4b1bcaa94" width="100%" height="500">
 <img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/dd46bc50-afef-440a-82f7-8864f42edd22" width="100%" height="500">
 

<br>


# API 설계


<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/96f21a69-23c3-4051-961e-82c6e237f589.JPG">

#### 게시물

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/7d0dbc08-5a57-4c5c-bd09-7768243a4b4e.JPG">

#### 댓글
<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/eaad3f72-c0e6-40f8-96e6-e14affb567c0.JPG">

#### 좋아요

<img src="https://github.com/taehyeon1222/JSP_BOARD/assets/129807676/928e04d2-9344-4933-8e82-0630493380d2.JPG">


#### 유저정보

# 💭프로젝트후기

> 전체적인 부분
이전 JPA 프로젝트를 통해 MVC 패턴이나 CRUD는 익숙해져서 기존 프로젝트에서 했던것보다 수월하게 프로젝트를 진행 할 수 있었습니다.

> 기능적인 부분

JPA와 다르게 마이바티스에서는 조금 더 쿼리공부의 중요성을 느꼇습니다.
예를 들면 JPA에서는 자동으로 쿼리를 만들어 주기 때문에 간단한 쿼리는 간단하게 구현이 되었지만 마이바티스에서는 간단한 쿼리도 직접
제작 해야했습니다. 이때 쿼리를 만들고 쿼리 공부하는것에 재미를 느꼈으며 쿼리 공부가 부족함을 느꼈습니다.


> 습관적인 부분

이전 프로젝트에서는 콘솔창에 로그를 찍지 않고 오류가 나면 그때 그때 수정하였습니다. 로그를 사용하는 습관이 되어 있지 않아서 그랬던것도 있는거 같습니다.
공부 도중 로그찍는것을 보게 되었고 실제로 대부분의 메소드에서 로그를 출력하니 데이터의 흐름이라던가 내 프로젝트에서 애플리케이션의 흐름을 이해하고
어디서 문제가 발생했는지 좀 더 쉽게 확인 할 수 있었습니다.


> 좋았던점

로그를 통해 프로그램이 실행되는 과정을 눈으로 확인 하는것이 즐거웠고
쿼리를 작성하여 잘 작동하고 쿼리를 배워가는것에 즐거움을 느꼈습니다.


> 어려웠던점

jsp 와 스프링부트를 사용했습니다. 환경설정 부분이 가장 어려웠습니다.
특히 프로젝트를 실행하기전 환경설정을 하는 부분에서 스프링부트에서 jsp를 지원하지 않는 다는 이슈를 알게되엇고.
이를 사용하려고 하니 여러가지 환경설정문제에서 오랜시간 고민해야했었습니다.

> 아쉬웠던 부분
> 
우선 레스트풀 하게 프로그래밍 하지 못한점이 아쉬웠고 초반 설계단계에서 실서비스를 목표로 진행하였던 aws로 배포는 시도해보지 못한 부분이 가장 아쉬웠습니다.

