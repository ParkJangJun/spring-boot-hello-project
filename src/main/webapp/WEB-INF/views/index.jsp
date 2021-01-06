<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script type="text/javascript">

/* session 상태확인 */
var userId = '<%=(String)session.getAttribute("userId")%>';
if(userId =="null"){ 
	console.log("세션 null상태"); 
 } else { 
	console.log(userId);
 }

/* /boardDelete에서 오는 msg */
var msg = '${msg}'
if(msg == 'sessionFin') {
	alert("로그인이 풀렸으니 재로그인해주세요.")
} 



/* javascript용  */
function kakao_login() {

	// **자바스크립트 앱키(SDK 초기화)
	Kakao.init('3fa8f32d6b0f3bb0d15238e9ab0f4a4a');

	// **로그인 창 띄우기
	Kakao.Auth.login({
		  success: function(res) {    
		    // **로그인 성공시 사용자 정보 가져오기
		    Kakao.API.request({
		    	url: '/v2/user/me',
		    	success: function(res) {
		    		var id = res.id; 
		    	 	var name = res.properties.nickname; 
		    		var email = res.kakao_account.email; 	
	    		
		    		$.ajax({ // **카카오 로그인 관련 컨트롤러와 통신	 
		    			type: 'POST',
		    			url: "/kakao_login",
		    			data: {"id":id, "name":name ,"email":email},
		    			dataType: "text",
						success: function(data) {
							// **토큰 할당
							var getToken = Kakao.Auth.getAccessToken();
							Kakao.Auth.setAccessToken(getToken, true);
							
							//window.location.href="/boardList";
						},
						error: function(jqXHR, textStatus, errorThrown) {
							alert("ERROR : " + textStatus + " : " + errorThrown);
						}		
		    		});
		    	},
		    	fail: function(error) {
				    console.log(error);
				}
		    });	    
		  },
		  fail: function(error) {
		    console.log(error + "로그인 실패입니다.");
		  }
		}); 	
}
</script>
</head>
<body>
<form action='<c:url value='userCheck'/>' method="post">
	<div>
		<label>아이디</label>
		<input type="text" id="memberId" name="memberId">	
	</div>
	<div>
		<label>비밀번호</label>
		<input type="password" id="memberPass" name="memberPass">
	</div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="로그인">		
	<input type="button" value="회원가입" onclick="location.href='register'">
</form>
<!-- javascript용-->
<!-- <a id="kakao_login" href="javascript:kakao_login()">
	<img src='/static/img/kakao_login.png' style="float: left; margin: 10px;">
</a> -->
<!-- REST API kakao Login -->
<a href="https://kauth.kakao.com/oauth/authorize?client_id=6b7c2217bf1a0a9a6df66953a236f6dc&
	redirect_uri=http://localhost:8282/userCheck&response_type=code">
		<img src='/static/img/kakao_login.png' style="float: left; margin: 10px;">
</a>
</body>
</html>