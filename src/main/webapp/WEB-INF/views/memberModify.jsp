<%@ page import="com.helloproject.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<html>
<head>
<script type="text/javascript">

/* ajax를 통한 비밀번호 수정처리 */
function modifyMember() {

	var memberId = $("#memberId").val();
	var memberPass = $("#memberPass").val();
	
	var param = {"memberId":memberId, "memberPass":memberPass}
	var stateCode = '?stateCode=1';
	
	if(memberPass == '') {
		alert("새비밀번호를 올바르게 입력해주세요.");
	} else {
		$.ajax({
			async:true,
			type:'POST',
			data: JSON.stringify(param),
			beforeSend: function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			url:"/memberModify",
			dataType: "text",
			contentType: "application/json; charset=UTF-8",
			success : function() {	
				alert("비밀번호 변경이 완료되었습니다.");
				location.href="/boardList"+stateCode;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("ERROR : " + textStatus + " : " + errorThrown);
			}
		})
	}
	
}


/* ajax를 통한 탈퇴처리 */
function deleteMember() {	
	
	var inputPass = prompt("비밀번호를 입력해주세요.");
	
	if(inputPass.trim() != '') {
		
		var memberId = $("#memberId").val();
		var param = {"memberId":memberId, "memberPass":inputPass}
		
			$.ajax({			
				async: true,
				type: 'POST',
				data: JSON.stringify(param),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				url: "/memberDelete",
				dataType: "text",
				contentType: "application/json; charset=UTF-8",
				success: function(data) {	
					if(data == "success") {					
						alert("탈퇴가 처리되었습니다.");
						location.href="/login";
					} else {
						alert("비밀번호가 맞지 않습니다.");
					}	
				},
				error:function(request, status, error){
			        alert("code:"+request.status+"\n"+
			        	  "message:"+request.responseText+"\n"+"error:"+error);
			    }		
			})		
	} else {
		alert("비밀번호를 제대로 입력해주세요.");
	}
}
</script>
</head>
<body>
<h2>[회원정보 수정]</h2>
<form action='<c:url value='/register'/>' method="post">
	<div>이름<input type="text" name="memberName" id="memberName" value="${modifyName}" readonly="readonly"></div>	
	<div>아이디<input type="text" name="memberId" id="memberId" value="${modifyId}" readonly="readonly"></div>
	<div>새비밀번호<input type="password" name="memberPass" id="memberPass"></div>
</form>
	<button type="button" id="submit" onclick="modifyMember()">수정완료</button>
	<button type="button" onclick="location.href='/boardList?stateCode=${stateCode}'">처음으로</button>
	<button type="button" onclick="deleteMember()">회원 탈퇴</button>
</body>
</html>