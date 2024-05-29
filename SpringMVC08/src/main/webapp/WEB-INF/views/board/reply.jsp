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
  <script type="text/javascript">
  $(document).ready(function(){
	  $("button").on("click", function(e){
		  var formData = $("#frm");
		  var btn=$(this).data("btn"); // data-btn="list"  <-- 제이쿼리에서 지원해주는 data- 태그를 이용한다.  data-태그의 btn의 값을 다 가져와서 값을 찾는다.
		  if(btn == 'reply'){
			  formData.attr("action", "${cpath}/board/reply");
		  } else if(btn == 'list'){
			  formData.find("#idx").remove();
			  formData.find("#memID").remove();
			  formData.find("#title").remove();
			  formData.find("#content").remove();		
			  formData.find("#writer").remove();				  
			  formData.attr("action", "${cpath}/board/list");
			  formData.attr("method", "get");
		  } else if(btn == 'reset'){
			  formData[0].reset();
			  return;
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
    <div class="panel-heading">BOARD</div>
    <div class="panel-body">
    	<form id="frm" method="post">
 			<input type="hidden" name="page" value="<c:out value='${cri.page}'/>" />
 			<input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>    	
			<!--  idx부모글(원글)의 idx가 있어야 DB에 댓글 정보를 넣을 수 있다. -->
    		<input type="hidden" name="idx" value="${vo.idx}" /><!--  부모글(원글)의 idx값 : 원글의 idx가 있어야 원글을 기준으로 그룹화해서 답글을 관리한다.-->    	
    		<input type="hidden" name="memID" value="${mvo.memID}" />
    		<div class="form-group">
    			<label>제목</label>
    			<input type="text" id="title" name="title" class="form-control" value="${vo.title}"/>
    		</div>
    		<div class="form-group">
    			<label>답변</label>
    			<textarea rows="10" id="content" name="content" class="form-control"></textarea>
    		</div>
    		<div class="form-group">
    			<label>작성자</label>
    			<input type="text" readonly="readonly" id="writer" name="writer" class="form-control" value="${mvo.memName}"/>
    		</div>
    		<button data-btn="reply" type="button" class="btn btn-default btn-sm">답변</</button>
    		<button data-btn="reset"  type="button" class="btn btn-default btn-sm">취소</</button>
	 		<button data-btn="list" type="button" class="btn btn-default btn-sm">목록</button>
    	</form>
    </div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>