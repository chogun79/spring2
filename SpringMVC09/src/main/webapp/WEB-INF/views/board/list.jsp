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
	//검색기능
	// http://localhost:8081/sp09/board/list
	//
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
  		//페이지 번호 클릭시 이동 하기(Jquery로 컨트롤하기)
  		var pageFrm = $("#pageFrm");
  		$(".pagenate_button a").on("click", function(e){
  			e.preventDefault(); // a 태그의 기능을 막는 부분
  			var page=$(this).attr("href"); // 페이지 번호 가져오기
  			pageFrm.find("#page").val(page);
  			pageFrm.submit(); // /sp08/board/list
  		});
  		// 상세보기 클리시 이동 하기
  		$(".move").on("click",function(e){
  			e.preventDefault(); // a 태그의 기능을 막는 부분
  			var idx=$(this).attr("href"); // 페이지 번호 가져오기
  			var tag = "<input type='hidden' name='idx' value='"+idx+"' />";
  			pageFrm.append(tag);
  			pageFrm.attr("action","${cpath}/board/get");
  			pageFrm.attr("method","get");
  			pageFrm.submit(); // /sp09/board/get
  			
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
		alert("삭제된 게시물입니다.");
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
	     					<a class="move" href="${vo.idx}">[RE] <c:out value="${vo.title}"/></a><!--  XSS 보안취약점 보완조치 c:out사용 -->
     					</c:if>
     					<c:if test="${vo.boardAvailable==0}">
	     					<img src="${cpath}/resources/images/reply.png" style="width: 5%; height: 20px;"/>
	     					<a href="javascript:goMsg()"><del>${vo.title}</del>[삭제]</a>
     					</c:if>     					
     				</c:if>
     				<c:if test="${vo.boardLevel == 0}">
     					<c:if test="${vo.boardAvailable==1}">		   <!--  XSS 보안취약점 보완조치 c:out사용 -->
     						<a class="move" href="${vo.idx}"><c:out value="${vo.title}"/></a>
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
    	<!-- 검색메뉴 -->
    	<div style="text-align : center;">
		<form class="form-inline" action="${cpath}/board/list" method="post">
		  <div class="form-group">
			<select name="type" class="form-control">
				<option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : '' }>이름</option>
				<option value="title" ${pageMaker.cri.type=='title' ? 'selected' : '' }>제목</option>
				<option value="content" ${pageMaker.cri.type=='content' ? 'selected' : '' }>내용</option>								
			</select>
		  </div>
		  <div class="form-group">
		    <input type="text" class="form-control" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
		  </div>
		  <button type="submit" class="btn btn-default">검색</button>
		</form>
    	</div>
    	
    	<!-- 부트스트렙공식 사이트 Docs의 Pagination 이용 하면 더깔끔한 페이징디자인을 할수있다. 참고만-->
    	<!-- https://getbootstrap.com/docs/5.3/components/pagination/ -->
    	<!-- 페이징 START -->
    	<div style="text-align: center">
			<ul class="pagination">
		<!-- 이전처리 -->
			<c:if test="${pageMaker.prev}">
				<li class="pagenate_button previous">
					<a href="${pageMaker.startPage -1}">◀</a>
				</li>
			</c:if>
			
		<!-- 페이지번호 처리  반복문에사용될변수이름       시작번호 ~ 종료번호                   -->
				<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
	
						<li class="pagenate_button ${ pageMaker.cri.page==pageNum ? 'active' : ''}"><a href="${pageNum}">${pageNum}</a></li>

				</c:forEach>	
		<!-- 다음처리 -->
			<c:if test="${pageMaker.next}">
				<li class="pagenate_button next">
					<a href="${pageMaker.endPage +1}">▶</a>
				</li>
			</c:if>
			</ul>
    	</div>
    	<!-- END -->
    	
    	<!-- 현재페이지 정보 -->
    	<form id="pageFrm" action="${cpath}/board/list" method="post">
    		<!-- 게시물 번호(idx) 추가 -->
    		<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/><!-- 현재의 페이지번호 -->
    		<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/><!--  // 한페이지에 보여줄 게시글의 수 --> 		
    		<input type="hidden" name="type" value="${pageMaker.cri.type}"/><!-- 현재의 페이지번호 -->
    		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/><!--  // 한페이지에 보여줄 게시글의 수 --> 		
    	</form>
    	
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
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)<br/>
    장상현 21/12/21<br/>
    <p>안녕하세요?</p><p>어제 2주 개발 기간 이야기 됐었는데...ㅠㅠ</p><p>차주 28일까지 가능할까요?</p>
    <br/>
    권오진 21/12/22<br/>
    <p>네 이사님 가능합니다!</p><p>혹시 조건이나 내용이 또 변경하게 되면 업데이트 해주시고 연락주세요.</p>
    <br/>
    장상현 21/12/30<br/>
    <p>네...아직 애터미에서 이에 대한 정확한 피드백을 안주고 있네요....</p><p>급하다고 하더니.....</p><p>피드백 오면 말씀드릴 수 있도록 하겠습니다.&nbsp;</p>
    <br/>
    정욱채 23/12/30<br/>
    <div>SELECT BC.RMRK_V, CLNT.CLNT_NM, USE.LOGIN_USER_NM, USE.LOGIN_ID, DTL.BIRD_V,ECHELON.PI_DECRYPT(DTL.RES_NO) AS RES_NO, TEL.TEL_NO&nbsp;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; FROM TB_LS_USER USE, TB_LS_USER_DTL DTL, TB_LS_USER_TEL TEL,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (SELECT * FROM TB_LS_USER_PSNL_CD WHERE PSNL_CD IN ('0000011197','0000011196','0000011201','0000011204','0000011200','0000011207','0000011208','0000011213','0000011209','0000011214','0000011219','0000011220','0000011223','0000011222','0000011227','0000011229','0000011228'</div><div>&nbsp; &nbsp; ,'0000011230','0000011233','0000011235','0000011236','0000011237','0000011210','0000011238','0000011241','0000011239','0000011240','0000011244','0000011245','0000011246','0000011247','0000011248','0000011249','0000011264'</div><div>&nbsp; &nbsp; ,'000011265','0000011269','0000011270','0000011271','0000011272','0000011273','0000011277','0000011278','0000011279','0000011280','0000011281','0000011282','0000011283','0000011284','0000011285','0000011287','0000011288'</div><div>&nbsp; &nbsp; ,'0000011292','0000011289','0000011290','0000011276','0000011293','0000011294','0000011295','0000011296','0000011291','0000011297','0000011298','0000011299','0000011300','0000011301','0000011302','0000011303','0000011304'</div><div>&nbsp; &nbsp; ,'0000011305','0000011306','0000011307','0000011308','0000011309','0000011310','0000011311','0000011318','0000011326','0000011327','0000011328','0000011329','0000011330','0000011336','0000011342','0000011343','0000011341'</div><div>&nbsp; &nbsp; ,'0000011337')) BC, (SELECT * FROM TB_LS_BLNG_CLNT_MAPP WHERE BLNG_CD IN ('0000011197','0000011196','0000011201','0000011204','0000011200','0000011207','0000011208','0000011213','0000011209','0000011214','0000011219','0000011220','0000011223','0000011222','0000011227','0000011229','0000011228'</div><div>&nbsp; &nbsp; ,'0000011230','0000011233','0000011235','0000011236','0000011237','0000011210','0000011238','0000011241','0000011239','0000011240','0000011244','0000011245','0000011246','0000011247','0000011248','0000011249','0000011264'</div><div>&nbsp; &nbsp; ,'000011265','0000011269','0000011270','0000011271','0000011272','0000011273','0000011277','0000011278','0000011279','0000011280','0000011281','0000011282','0000011283','0000011284','0000011285','0000011287','0000011288'</div><div>&nbsp; &nbsp; ,'0000011292','0000011289','0000011290','0000011276','0000011293','0000011294','0000011295','0000011296','0000011291','0000011297','0000011298','0000011299','0000011300','0000011301','0000011302','0000011303','0000011304'</div><div>&nbsp; &nbsp; ,'0000011305','0000011306','0000011307','0000011308','0000011309','0000011310','0000011311','0000011318','0000011326','0000011327','0000011328','0000011329','0000011330','0000011336','0000011342','0000011343','0000011341'</div><div>&nbsp; &nbsp; ,'0000011337')) MAPP, TB_LS_CLNT CLNT</div><div>&nbsp; &nbsp; WHERE&nbsp; BC.USER_NO = USE.USER_NO</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND BC.USER_NO = DTL.USER_NO</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND BC.USER_NO = TEL.USER_NO</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND TEL.TEL_NO LIKE '010%'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND USE.LOGIN_ID NOT LIKE'%test%'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND USE.LOGIN_ID NOT LIKE'%hrd01'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND USE.LOGIN_USER_NM NOT LIKE'%인키움%'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND USE.LOGIN_USER_NM NOT LIKE'%테스트%'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND USE.USER_NO &gt; '263337'</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND BC.PSNL_CD = MAPP.BLNG_CD</div><div>&nbsp; &nbsp; &nbsp; &nbsp; AND MAPP.CLNT_ID = CLNT.CLNT_ID</div><div>;</div>
    <br/>
    </div>
  </div>
</div>

</body>
</html>