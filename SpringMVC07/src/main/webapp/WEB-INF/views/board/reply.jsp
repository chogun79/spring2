<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%
	//게시글 등록 화면
	//views/board/register.jsp
%>
<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body">
    	<form action="${cpath}/board/reply"} method="post">
			<!--  idx부모글(원글)의 idx가 있어야 DB에 댓글 정보를 넣을 수 있다. -->
    		<input type="hidden" name="idx" value="${vo.idx}" /><!--  부모글(원글)의 idx값 : 원글의 idx가 있어야 원글을 기준으로 그룹화해서 답글을 관리한다.-->    	
    		<input type="hidden" name="memID" value="${mvo.memID}" />
    		<div class="form-group">
    			<label>제목</label>
    			<input type="text" name="title" class="form-control" value="${vo.title}"/>
    		</div>
    		<div class="form-group">
    			<label>답변</label>
    			<textarea rows="10" name="content" class="form-control"></textarea>
    		</div>
    		<div class="form-group">
    			<label>작성자</label>
    			<input type="text" readonly="readonly" name="writer" class="form-control" value="${mvo.memName}"/>
    		</div>
    		<button type="submit" class="btn btn-default btn-sm">답변</</button>
    		<button type="reset" class="btn btn-default btn-sm">취소</</button>
	 		<button type="button" class="btn btn-default btn-sm" onclick="location.href='${cpath}/board/list'">목록</button>	
    	</form>
    </div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>