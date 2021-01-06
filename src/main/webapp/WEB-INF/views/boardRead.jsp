<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<html>
<head>
<script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
</head>
<body>
<h2>[게시판 내용]</h2>
<form name="form" method="post">
	<div>글번호<input name="num" readonly="readonly" value="${data.num}"></div>
	<div>제목<input name="title" readonly="readonly" value="${data.title}"></div>
	<div>내용<input name="content" readonly="readonly" value="${data.content}"></div>
	<div>작성자<input name="writer" readonly="readonly" value="${data.writer}"></div>
</form>
<button id="modify" onclick="location.href='boardModifyForm?num=${data.num}&stateCode=${stateCode}&writer=${data.writer}'">수정</button>
<button id="delete" onclick="location.href='boardDelete?num=${data.num}&stateCode=${stateCode}&writer=${data.writer}'">삭제</button>
<button onclick="stateCode()">목록</button>

<%-- <a href='<c:url value='/boardDelete?bno=${data.bno}'/>'>삭제</a> --%>
<!-- 두가지 모두 가능 -->
</body>
</html>