<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<script type="text/javascript">
function confirm() {
	var title = $("#title").val().trim();
	var content =  $("#content").val().trim();

	if(title == "") {
		alert("제목을 입력해주세요.");
	} else if(content == "") {
		alert("내용을 입력해주세요.");
	}
	
	if(title != "" && title != "") {
		location.href="/boardWrite";
	}
}
</script>
</head>
<body>
<h2>[게시판 글쓰기]</h2>
<form action='<c:url value='/boardWrite'/>' method="post">
	<div>작성자<input type="text" name="writer" value="${modifyId}" readonly="readonly"></div>
	<div>제목<input type="text" id="title" name="title"></div>
	<div>내용<textarea rows="5" cols="13" id="content" name="content"></textarea></div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="stateCode" value="${stateCode}"/>
	<button type="button" onclick="location.href='/boardList?stateCode=${stateCode}'">목록</button>
	<button type="submit" onclick="confirm()">완료</button>
</form>
</body>
</html>