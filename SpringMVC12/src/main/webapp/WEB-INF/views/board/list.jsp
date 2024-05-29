<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script><!--  autocomplete 사용하기위해 추가해야한다. -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f166fea4e0fca13242bb06f83c0eb13"></script><!-- 내 JavaScript키로 교체 0f166fea4e0fca13242bb06f83c0eb13 -->
  <script type="text/javascript">
  $(document).ready(function(){
  	var result='${result}';     	
  	checkModal(result); 
  	 
  	$("#regBtn").click(function(){
  		location.href="${cpath}/board/register";
  	}); 
  	//페이지 번호 클릭시 이동 하기
  	var pageFrm=$("#pageFrm");
  	$(".paginate_button a").on("click", function(e){
  		e.preventDefault(); // a tag의 기능을 막는 부분
  		var page=$(this).attr("href"); // 페이지번호
  		pageFrm.find("#page").val(page);
  		pageFrm.submit(); // /sp08/board/list   		
  	});    	
  	// 상세보기 클릭시 이동 하기
  	$(".move").on("click", function(e){
  		e.preventDefault(); // a tag의 기능을 막는 부분
  		var idx=$(this).attr("href");
  		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
  		pageFrm.append(tag);
  		pageFrm.attr("action","${cpath}/board/get");
  		pageFrm.attr("method","get");
  		pageFrm.submit();
  	});
  	// 책 검색 버튼이 클릭 되었을때 처리
  	$("#search").click(function(){
  		var bookname=$("#bookname").val();
  		if(bookname==""){
  			alert("책 제목을 입력하세요");
  			return false;
  		}
  		// KaKao 책 Daum검색 REST API openAPI를 연동하기(키 발급)
  		// 키발급방법 : 1. https://developers.kakao.com 접속 -> 상단 '내애플리케이션'클릭 -> 애플리케이션 추가하기클릭 -> '앱이름' '회사명' 임의로 입력
  		//           2. 다시 돌아와서 '내어플리케이션' > 앱 설정 > 플랫폼 > Web플랫폼등록 버튼클릭 > 사이트도메인입력란에 내 PC 아이피와 톰켓포트입력 : http://192.168.0.133:8081 > 저장
  		//           3. 좌측목록에서 '앱키' 클릭 해서 'REST API 키', 'JavaScript 키' 기억하기
  		
  		// - https://developers.kakao.com/   -> 메인화면 중앙 검색쎅션 '문서보기'클릭 -> Daum검색 REST API 클릭 -> '책 검색하기'확인
  		// URL : https://dapi.kakao.com/v3/search/book?target=titlec
  		// H : Authorization: KakaoAK 	260bf790c4b9969507dd7511de7de3ba       //해더에 형식으로 json데이터 추가
  		// 진짜 내키                    	50c1d1e20e67f0ca8745f4902eef13ec
  		$.ajax({
  			url : "https://dapi.kakao.com/v3/search/book?target=title",
  			headers : {"Authorization": "KakaoAK 50c1d1e20e67f0ca8745f4902eef13ec"},
  			type : "get",
  			data : {"query" : bookname},
  			dataType : "json",
  			success : bookPrint,
  			error : function(){ alert("error");}	
  		});
  		$(document).ajaxStart(function(){ $(".loading-progress").show(); });
  		$(document).ajaxStop(function(){ $(".loading-progress").hide(); });
  	});    	
  	// input box에 책 제목이 입려되면 자동으로 검색을하는 기능
  	$("#bookname").autocomplete({ // autocomplete : inputbox에 데이터가 입력되면 자동으로 검색하는 기능
  		source : function(){ 
  			var bookname=$("#bookname").val();
  			$.ajax({
      			url : "https://dapi.kakao.com/v3/search/book?target=title",
      			headers : {"Authorization": "KakaoAK 50c1d1e20e67f0ca8745f4902eef13ec"},
      			type : "get",
      			data : {"query" : bookname},
      			dataType : "json",
      			success : bookPrint,
      			error : function(){ alert("error");}	
      		});
  		},
  		minLength : 1    		
  	});

  	// 카카오 지도서비스 : 지도서비스를 이용할때는 반드시 developers.kakao.com의 Web플랫폼등록 URL로 프로젝트를 띄워야한다.
  	// 가이드는 https://apis.map.kakao.com/web/sample/ 를 참고해서 지도 생성, 마커 마커이벤트생성 등등 개발시 참고
  	// 기존 http://localhost:8081/sp12/board/list에서 지도 API호출하면 에러남
  	// http://192.168.0.133:8081/sp12/board/list 로 지도 API호출해야 함(url을 localhost에서 192.168.0.133로 변경)
  	
  	// 1. '주소검색'(https://developers.kakao.com/docs/latest/ko/local/dev-guide) -> 받아온 위도, 경도 값으로 '지도검색' 연결  
  	//지도 mapBtn 클릭시 지도가 보이도록 하기 
  	$("#mapBtn").click(function(){
  		var address=$("#address").val();
  		if(address==''){
  			alert("주소를 입력하세요");
  			return false;
  		}
  		$.ajax({
  			url : "https://dapi.kakao.com/v2/local/search/address.json",
  			headers : {"Authorization": "KakaoAK 50c1d1e20e67f0ca8745f4902eef13ec"},
  			type : "get",
  			data : {"query" : address},
  			dataType : "json",
  			success : mapView,
  			error : function() { alert("error"); }  			
  		});
  	});
   });
   function checkModal(result){
       	 
  	 if(result==''){
  		 return;
  	 }    	 
  	 if(parseInt(result)>0){
  		 // 새로운 다이얼로그 창 띄우기
  		 $(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다.");
  	 }
  	 $("#myModal").modal('show');
   }
   function goMsg(){
  	 alert("삭제된 게시물입니다."); // Modal창
   }
   function bookPrint(data){
  	 var bList="<table class='table table-hover'>";
  	 bList+="<thead>";
  	 bList+="<tr>";
  	 bList+="<th>책이미지</th>";
  	 bList+="<th>책가격</th>";
  	 bList+="</tr>";
  	 bList+="</thead>";
  	 bList+="<tbody>";
  	 $.each(data.documents,function(index, obj){
  		 var image=obj.thumbnail;
  		 var price=obj.price;
  		 var url=obj.url;
  		 bList+="<tr>";
      	 bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
      	 bList+="<td>"+price+"</td>";
      	 bList+="</tr>";
  	 }); 
  	 bList+="</tbody>";
  	 bList+="</table>";
  	 $("#bookList").html(bList);
   }
   function mapView(data){
	var y=data.documents[0].y; // 위도
	var x=data.documents[0].x; // 경도

  	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  	    mapOption = { 
  	        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
  	        level: 3 // 지도의 확대 레벨
  	    };
  	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  	var map = new kakao.maps.Map(mapContainer, mapOption); 
  	
  	// 마커가 표시될 위치입니다 
  	var markerPosition  = new kakao.maps.LatLng(y, x); 

  	// 마커를 생성합니다
  	var marker = new kakao.maps.Marker({
  	    position: markerPosition
  	});
     
  	// 마커가 지도 위에 표시되도록 설정합니다
  	marker.setMap(map);
  	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
  	var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
  	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

  	// 인포윈도우를 생성합니다
  	var infowindow = new kakao.maps.InfoWindow({
  	    content : iwContent,
  	    removable : iwRemoveable
  	});

  	// 마커에 클릭이벤트를 등록합니다
  	kakao.maps.event.addListener(marker, 'click', function() {
  	      // 마커 위에 인포윈도우를 표시합니다
  	      infowindow.open(map, marker);  
  	});
   }
  </script>
 
</head>
<body>

  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring Framework~~</h1>
		    <p>자바 TPC->나프1탄->나프2탄->스프1탄->스프2탄</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
		<div class="row">
		  <div class="col-lg-2">
		    <jsp:include page="left.jsp"/>
		  </div>
		  <div class="col-lg-7">
	   <table class="table table-hover">
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
            <td>${vo.idx}</td>           
            <td>
            <c:if test="${vo.boardLevel>0}">
              <c:forEach begin="1" end="${vo.boardLevel}">
                 <span style="padding-left: 10px"></span>
              </c:forEach> 
              <i class="bi bi-arrow-return-right"></i>           
            </c:if>
            <c:if test="${vo.boardLevel>0}">
              <c:if test="${vo.boardAvailable==1}">
               <a class="move" href="${vo.idx}"><c:out value='[RE]${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
               <a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            <c:if test="${vo.boardLevel==0}">
              <c:if test="${vo.boardAvailable==1}">
                <a class="move" href="${vo.idx}"><c:out value='${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
                <a href="javascript:goMsg()">삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            </td>
            <td>${vo.writer}</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>
            <td>${vo.count}</td>
          </tr>
        </c:forEach>
        <c:if test="${!empty mvo}"> 
        <tr>
          <td colspan="5">
            <button id="regBtn" class="btn btn-sm btn-secondary pull-right">글쓰기</button>            
          </td>
        </tr>
        </c:if>
      </table>
       <!-- 검색메뉴 -->
      <form class="form-inline" action="${cpath}/board/list" method="post">
	   <div class="container">
	   <div class="input-group mb-3">
	      <div class="input-group-append">
		     <select name="type" class="form-control">
		      <option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option>
		      <option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
		      <option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
		   </select>
		  </div>
		  <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="submit">Search</button>
		  </div>
		</div>
		</div>
       </form>    
      <!-- 페이징 START -->
      <ul class="pagination justify-content-center">
      <!-- 이전처리 -->
      <c:if test="${pageMaker.prev}">
        <li class="paginate_button previous page-item">
          <a class="page-link" href="${pageMaker.startPage-1}">Previous</a>
        </li>
      </c:if>      
      <!-- 페이지번호 처리 -->
          <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	         <li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
		  </c:forEach>    
      <!-- 다음처리 -->
      <c:if test="${pageMaker.next}">
        <li class="paginate_button next page-item">
          <a class="page-link" href="${pageMaker.endPage+1}">Next</a>
        </li>
      </c:if> 
        </ul>
   
      <!-- END -->
      <form id="pageFrm" action="${cpath}/board/list" method="post">
         <!-- 게시물 번호(idx)추가 -->         
         <input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/>
         <input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
         <input type="hidden" name="type" value="${pageMaker.cri.type}"/>
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/>
      </form>      
      <!-- Modal 추가 -->
	  <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">MESSAGE</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>		        
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
		  <div class="col-lg-3">
		    <jsp:include page="right.jsp"/>
		  </div>
		</div>
    </div> 
    <div class="card-footer">인프런_스프2탄_박매일</div>
  </div>


</body>
</html>