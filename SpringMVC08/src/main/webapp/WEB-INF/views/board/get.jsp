<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%
	//게시글 상세화면
	//views/board/get.jsp
	//제이쿼리를 이용한 링크처리 응용(여러가지 방식 data- 이용)
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
  <script type="text/javascript">
  $(document).ready(function(){
	  $("button").on("click", function(e){
		  var formData = $("#frm");
		  var btn=$(this).data("btn"); // data-btn="list"  <-- 제이쿼리에서 지원해주는 data- 태그를 이용한다.  data-태그의 btn의 값을 다 가져와서 값을 찾는다.
		  if(btn == 'reply'){
			  formData.attr("action", "${cpath}/board/reply");
		  } else if(btn == 'modify'){
			  formData.attr("action", "${cpath}/board/modify");
		  } else if(btn == 'list'){
			  formData.find("#idx").remove();
			  formData.attr("action", "${cpath}/board/list");
		  }
		  
		  formData.submit();
	  });
  });
  </script>
</head>
<body>

<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD Detail</div>
    <div class="panel-body">
 		<table class="table table-bordered">
	 		<tr>
	 			<td>번호</td>
	 			<td><input type="text" class="form-control" name="idx" readonly="readonly" value="${vo.idx}" /></td>
	 		</tr>
	 		<tr>
	 			<td>제목</td>																			<!--  XSS 보안취약점 보완조치 c:out사용 -->
	 			<td><input type="text" class="form-control" name="title" readonly="readonly" value="<c:out value='${vo.title}'/>" /></td>
	 		</tr>	
	 		<tr>
	 			<td>내용</td>
	 			<td><textarea rows="10" class="form-control" name="content" readonly="readonly">${vo.content}</textarea></td>
	 		</tr>	
	 		<tr>
	 			<td>작성자</td>
	 			<td><input type="text" class="form-control" name="writer" readonly="readonly" value="${vo.writer}"/></td>
	 		</tr>
	 		<tr>
	 			<td colspan="2" style="text-align:center;">
	 				<c:if test="${!empty mvo}"><!-- 로그인한 사용자만 답글 누를수있게 -->
		 				<button data-btn="reply" class="btn btn-sm btn-primary">답글</button><!-- onclick 또는 jquery 등으로 서버로 보낼수있다. -->
		 				<!-- 로그인한 사용자이면서 작성자 본인인 경우에만 수정(수정화면으로 이동)버튼 누를수있게 -->
		 				<c:if test="${mvo.memID eq vo.memID}">
		 				<button data-btn="modify" class="btn btn-sm btn-success">수정</button>
	 					</c:if>
	 				</c:if>
	 				<c:if test="${empty mvo}"><!-- 로그인 안한 사용자만 답글과 수정하기버튼 못누르게 -->
		 				<button disabled="disabled" class="btn btn-sm btn-primary">답글</button>
		 				<button disabled="disabled" class="btn btn-sm btn-success">수정</button>
	 				</c:if>	 				
	 				<button class="btn btn-sm btn-info" data-btn="list">목록</button>
	 			</td>
	 		</tr>		 			 		 		
 		</table>
 		<form id="frm" action="post">
 			<input type="hidden" name="idx" value="<c:out value='${vo.idx}' />" />
 			<input type="hidden" name="page" value="<c:out value='${cri.page}' />" />
 			<input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}' />"/> 			 			
 		</form>
    </div>
    <div class="panel-footer">상세화면</div>
  </div>
</div>

</body>
</html>