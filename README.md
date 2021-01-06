# spring boot hello_project
## spring boot MVC게시판 & 로그인 / 카카오 API로그인



목적 : (TMI 주의)
과거에 학원을 다녔을때 요즘은 잘 사용하지 않는 오래된 방식으로 
이클립스 게시판을 만든 적이 있다.
요즘은 학원에서도 스프링부트를 배운다던데,
내가 학원에 다닐때는 못배웠고, 회사로 바로 들어가서 만난 스프링부트는 신세계였다.
하지만 바쁜 일정으로 게시판을 만들일이 없다가
일을 쉬면서 스스로 복기하는 의미해서 스프링부트 버젼으로 게시판을 만들었다.
생각보다 스프링부트 버전으로 만든 게시판이 없어서 초반에 설정때문에 약간 애먹었다.

*요약 : 스스로 복기하는 의미해서 스프링부트 버젼으로 게시판을 만들었다.



***


### 1. 환경 구성 : 
+ Server OS : Windows 10
+ Spring boot Framework : 2.1.4.RELEASE
+ java version : 1.8
+ build tool : maven 4.0.0
+ Language : JAVA 1.8
+ WEB Server : Apache 
+ WAS Server : Tomcat 7
+ DB : MySQL 5.7.22(navicat)
+ ORM : mybatis 2.1.1


### 2. 기능 :
1. MVC게시판/crud
+ 리스트 
+ 글쓰기 
+ 글읽기 
+ 글수정 
+ 글삭제 

2. 회원관련
+ 회원가입(일반멤버만 가능) 
+ 회원수정(일반멤버만 가능)
+ 회원탈퇴(일반멤버만 가능)

3. 로그인/로그아웃 관련
+ 일반멤버 로그인/로그아웃
+ 카카오멤버 로그인/로그아웃


### 3. controller url 설명

1. MVC게시판/crud

#### /boardList
오로지 페이징처리에만 집중할 수 있도록 하였으며, 
리스트처리는 boardList?stateCode="+stateCode 이런식으로 무조건 
세션에서 가지고온  멤버상태에 따른 코드를 파라미터로 잡고 화면으로 들어올 수 있게 진행했다.

#### /boardWriteForm(get), /boardWrite(post)
get방식의 url을 글쓰기폼 뷰를 리턴한다. 
현재 session이 일반회원인지, 카카오회원인지에 따라 상태값이 달라지며
제대로 입력하지 않을시 넘어가지 않도록 했고, 
input type을 hidden으로 지정해서 드러내지 않고 stateCode를 보내도록 하였다.

#### /boardRead
글번호인 num을 이용하여 해당 글을 보여주도록 함

#### /boardModifyForm(get), /boardModify(post)
글수정시 카카오유저인지 일반유저인지에 따라 
기본으로 바인딩되는 boardVO의 writer값을 새로 세팅하는 형태로 진행하였다.
우선 session을 통해 해당 일반멤버, 카카오멤버가 있는지를 확인하고
있는 경우 글을 쓴 아이디와 접속 아이디가 맞는경우 수정이 가능하도록 하였다.
일반멤버의 아이디와 카카오멤버의 이메일이 같을 경우는 따로 처리하지 않았다.

#### /boardDelete
글삭제시 현재 접속한 멤버와 글작성자가 맞는지를 판단하고 
맞는 경우만 글을 삭제할 수 있도록 처리하였다.
또한, 회원의 편의를 위해 맞을때 ModelAndView를 통해 메시지를 따로 저장하여 
forward로 boardList로 이동한뒤 메시지에 따라 alert를 띄우게 하였다.


2. 회원가입
#### /register(get), /register(post)
회원가입을 할때는 두가지 체크를 하는데, 아이디 중복체크와 가입완료시 유효성 체크이다.
자바스크립트와 ajax 비동기처리를 통해 공백으로 가입할 수 없도록 아이디 공백체크를 하는 부분과
해당아이디가 존재하는지 쿼리의 count로 체킹한다.
아이디중복체크를 눌러야만 가입완료버튼이 활동화되도록 만들었다.
또한, BCryptPasswordEncoder 클래스를 이용하여 가입시 사용한 비밀번호를 암호화한다.


3. 회원정보수정
#### /memberModify(get), /memberModify(post)
회원정보수정란에 들어가면 무조건 새비밀번호를 입력하도록 해두었다. 
그리고 ajax를 이용하여 /memberModify(post)와 비동기 통신으로 처리하였다.


4. 회원탈퇴
#### /memberDelete
ajax를 이용하여 /memberDelete와 비동기 통신으로 탈퇴처리하였다.
탈퇴시에는 prompt창을 이용하여 비밀번호를 직접쓰고 탈퇴하도록 유도하고
컨트롤러에서 @ResponseBody를 이용, 간단히 String을 리턴하여 
비밀번호가 맞은경우 success를 리턴하여 화면을 처리하였다.

5. 로그인 및 로그아웃
#### /userCheck
+ 카카오로그인과 일반 로그인 동시에 처리
+ BCryptPasswordEncoder 클래스를 이용하여 암호화 처리 및 비교
+ ModelAndView를 활용하여 리턴값은 하나지만 각각 다르게 이동할 수 있도록 사용하였음
+ 로그인 완료시 게시판으로 이동


6. 카카오로그인 및 로그아웃
#### /userCheck
+ oauth2 + REST API로 구현한 로그인
+ 인가 코드받기 / 토큰 받기의 2단계 형태로 진행
+ KakaoAPI라는 서비스를 통해 getAccessToken, getUserInfo, kakaoLogout(토큰받기, 유저정보, 로그아웃)의 3가지 구현체를 만들었다.
+ /userCheck를 통해 카카오로그인과 일반 로그인 동시에 처리(stateCode라는 별로의 코드사용)
+ /boardList 뷰에 진입시, 일반 로그인의 경우와 카카오 로그인의 경우가 다르게 나오도록 
+ 자바스크립트용 로그인창을 띄우는 Kakao.Auth.login()도 포함되어있다.
+ 카카오 로그아웃은 REST API로 세션제거

