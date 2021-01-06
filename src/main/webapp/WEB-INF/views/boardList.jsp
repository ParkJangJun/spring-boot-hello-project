<%@ page import="com.helloproject.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script type="text/javascript">
/* /boardDelete에서 오는 msg */
var msg = '${msg}'
if(msg == "success") {
	alert("해당 글이 삭제되었습니다.")
} else if(msg == "fail") {
	alert("타인의 글은 삭제할 수 없습니다. 리스트로 돌아갑니다.")
}
</script>
</head>
<body>
<h2>[게시판 리스트]</h2>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<c:if test="${stateCode == '2'}">
	<button type="button" onclick="location.href='kakao_logout'">카카오 로그아웃</button>
	<button type="button" onclick="location.href='securityAdmin'">관리자용 페이지</button>
</c:if>
<c:if test="${stateCode == '1'}">
	<button type="button" onclick="location.href='memberModify?stateCode=${stateCode}'">회원정보 수정</button>
	<button type="button" onclick="location.href='logout'">로그아웃</button>
	<button type="button" onclick="location.href='securityAdmin'">관리자용 페이지</button>
</c:if>
<table border="1">
	<tr>
		<th>글번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성시간</th>
	</tr>
	<c:forEach items="${list}" var="data">
	<tr>
		<td>${data.num}</td>
		<td>${data.writer}</td>
		<td><a href="/boardRead?num=${data.num}&stateCode=${stateCode}">${data.title}</a></td>
		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${data.regdate}"/></td>
	</tr>
	</c:forEach>
</table>
<button type="button" onclick="location.href='boardWriteForm'">글쓰기</button> 

<ul class="paging">
    <c:if test="${paging.prev}">
    	<span><a href='<c:url value="/boardList?page=${paging.startPage-1}"/>'>이전</a></span>
    </c:if>
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
    	<span><a href='<c:url value="/boardList?page=${num}"/>'>${num}</a></span>
    </c:forEach>
    <c:if test="${paging.next && paging.endPage>0}">
    	<span><a href='<c:url value="/boardList?page=${paging.endPage+1}"/>'>다음</a></span>
    </c:if>
</ul>
</body>
</html>