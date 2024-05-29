<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!-- bit01 / bit01 http://localhost:8081/controller/board/list -->
<%
	//게시글 목록 화면
	//views/board/list.jsp
	//답글, 답글에 답글, 페이징처리, 검색기능
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
 		var result = '${result}';
 		checkModal(result);
 		
  		$("#regBtn").click(function(){
  			location.href="${cpath}/board/register";	
  		});
  	});
  	function checkModal(result){
  		if(result==''){
  			return;
  		}
  		if(parseInt(result)>0){
  			$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
  			$("#myModal").modal("show"); // 모달 띄우기   .modal
  		}
  	}
  	function goMsg(){
		alert("삭제된 게시물입니다.")
  	}
  </script>

</head>
<body>

<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">
    	<c:if test="${empty mvo}"><!-- 로그인 안한경우 -->
	    	<form class="form-inline" action="${cpath}/login/loginProcess" method="post">
			  <div class="form-group">
			    <label for="memID">ID:</label>
			    <input type="text" class="form-control" id="memID" name="memID">
			  </div>
			  <div class="form-group">
			    <label for="memPwd">Password:</label>
			    <input type="password" class="form-control" id="memPwd" name="memPwd">
			  </div>
			  <button type="submit" class="btn btn-default">Submit</button>
			</form>   
		</c:if>
    	<c:if test="${!empty mvo}"><!-- 로그인에 성공한 경우 -->
	    	<form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
			  <div class="form-group">
			    <label>${mvo.memName}님 방문을 환영합니다.</label>
			  </div>

			  <button type="submit" class="btn btn-default">로그아웃</button>
			</form>   
		</c:if>		
    </div>
 
    <div class="panel-body">
    	<table class="table table-bordered table-hover">
    		<thead>
    			<tr>
    				<th>번호</th>
     				<th>제목</th>
				    <th>작성자</th>
				    <th>작성일</th>
				    <th>조회수</th>		
    			</tr>
    		</thead>
    		<c:forEach var="vo" items="${list}">
    			 <tr>
    				<td>${vo.idx}</th>
     				<td>
     				<!-- 댓글 들여쓰기 -->
    				<c:if test="${vo.boardLevel>0}">
    					<c:forEach begin="1" end="${vo.boardLevel}">
    						<span style="padding-left: 8px"></span>
    					</c:forEach>
    				</c:if>
    				<!-- 래벨이 존재하면 댓글이미지와 댓글'[RE]'표시 -->     				
     				<c:if test="${vo.boardLevel > 0}">
     					<c:if test="${vo.boardAvailable==1}">
	     					<img src="${cpath}/resources/images/reply.png" style="width: 5%; height: 20px;"/>
	     					<a href="${cpath}/board/get?idx=${vo.idx}">[RE] <c:out value="${vo.title}"/></a><!--  XSS 보안취약점 보완조치 c:out사용 -->
     					</c:if>
     					<c:if test="${vo.boardAvailable==0}">
	     					<img src="${cpath}/resources/images/reply.png" style="width: 5%; height: 20px;"/>
	     					<a href="javascript:goMsg()"><del>${vo.title}</del>[삭제]</a>
     					</c:if>     					
     				</c:if>
     				<c:if test="${vo.boardLevel == 0}">
     					<c:if test="${vo.boardAvailable==1}">		   <!--  XSS 보안취약점 보완조치 c:out사용 -->
     						<a href="${cpath}/board/get?idx=${vo.idx}"><c:out value="${vo.title}"/></a>
     					</c:if>
     					<c:if test="${vo.boardAvailable==0}">
     						<a href="javascript:goMsg()"><del>${vo.title}</del>[삭제]</a>
     					</c:if>     					
     				</c:if>
     				</th>
				    <td>${vo.writer}</th>
				    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}" /></th>
				    <td>${vo.count}</th>		
    			</tr>
    		</c:forEach>
    		<c:if test="${!empty mvo}">
    		<tr>
    			<td colspan="5">
    				<button id="regBtn" class="btn btn-sm btn-primary pull-right">글쓰기</</button>
    			</td>
    		</tr>
    		</c:if>
    		
    	</table>
    	<!-- Modal 추가 -->
		<div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Modal Header</h4>
		      </div>
		      <div class="modal-body">

		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!-- Modal END -->
    </div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>