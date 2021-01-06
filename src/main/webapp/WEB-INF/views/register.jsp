<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script type="text/javascript">

/* 회원가입 유효성 체크 */
function registerCheck() {
	if($.trim($('#memberName').val()) == '') {
		alert("이름을 입력해주세요.");
		return false;
	}
	if($.trim($('#memberId').val()) == '') {
		alert("아이디를 입력해주세요.");
		return false;
	}
	if($.trim($('#memberPass').val()) == '') {
		alert("비밀번호를 입력해주세요.");
		return false;
	}

	if(confirm("회원가입을 하시겠습니까?")){
		alert("회원가입이 완료되었습니다. 감사합니다.");
		 $("form").submit();	
	}
}
 

/* 아이디 중복 체크 : ajax 비동기처리 */
function idCheck() {
	
	var memberId = $("#memberId").val();
	
	if(memberId.search(/\s/) != -1) { 
		alert("아이디에는 공백이 들어갈 수 없습니다.");		
	} else { 			
		if(memberId.trim().length != 0) {
			console.log(memberId.trim().length);
			$.ajax({
				async : true, 
				type : 'POST', 
				data: memberId,
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				url: "/idCheck",
				dataType: "json",
				contentType: "application/json; charset=UTF-8",
				success: function(count) {	
					if(count > 0) {
						alert("해당 아이디 존재");	
						$("#submit").attr("disabled", "disabled");
						window.location.reload();
					} else {
						alert("사용가능 아이디");
						$("#submit").removeAttr("disabled");
					}			
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log(errorThrown + " " + textStatus);
					alert("아이디를 입력해주세요.");
				}		
			});
		} else {
			alert("아이디를 입력해주세요.");
		}		
	}
}
</script>
<head>
</head>
<body>
<h2>[회원가입]</h2>
<form action='<c:url value='/register'/>' method="post">
	<div>이름<input type="text" name="memberName" id="memberName" placeholder="이름을 입력하세요."></div>	
	<div>아이디<input type="text" name="memberId" id="memberId" placeholder="아이디를 입력하세요."></div>
	<button type="button" onclick="idCheck()">아이디 중복확인</button>
	<div>비밀번호<input type="password" name="memberPass" id="memberPass" placeholder="비밀번호를 입력하세요."></div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
	<button type="button" id="submit" disabled="disabled" onclick="registerCheck()">가입완료</button>
	<button type="button" onclick="location.href='/'">처음으로</button>
</body>
</html>
