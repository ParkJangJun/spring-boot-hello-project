<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<html>
<head>
</head>
<body>
<h2>[게시판 수정]</h2>
<form action='<c:url value='/boardModify'/>' method="post">
	<div><label>글번호</label>
		 <input name="num" readonly="readonly" value="${data.num}">
	</div>
	<div><label>작성자</label>
		 <input name="writer" readonly="readonly" value="${data.writer}">
	</div>
	<div>
		<label>제목</label>
		<textarea rows="5" cols="13" name="title">${data.title}</textarea>
	</div>
	<div>
		<label>내용</label>
		<textarea rows="5" cols="13" name="content">${data.content}</textarea>
	</div>	
	<button type="submit">수정</button>
	<button type="button" onclick="location.href='/boardList?stateCode=${stateCode}'">돌아가기</button>
	<input type="hidden" name="stateCode" value="${stateCode}">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
<input type="hidden" name="num" value="${data.num}">
</body>
</html>