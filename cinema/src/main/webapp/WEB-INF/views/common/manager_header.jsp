<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Page Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css">
    
</head>
<section>
<header>
	<nav id="navbar-example2" class="navbar navbar-light bg-light">
	  <a class="navbar-brand" href="#">Cinema</a>
	  <ul class="nav nav-pills">
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/movie">영화</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/theater">영화관</a><!-- 팝업창. -->
	    </li>
	        <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/">영화관</a><!-- 팝업창. -->
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/room">상영관</a><!-- 팝업창. -->
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/seat">좌석</a><!-- 팝업창. -->
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/schedule">상영시간표</a><!-- 팝업창. -->
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${rootPath }/manager/ticket">예매관리</a><!-- 팝업창. -->
	    </li>
	      <li class="nav-item">
	      <c:if test="${memberLoggedIn!=null }">
	      	   <a class="nav-link" href="${rootPath }/member/memberView.do?mno=${memberLoggedIn.getMno()}" >${memberLoggedIn.getMname() }님</a>
	      </c:if>
	      
	    </li>
	    <li class="nav-item">
	    	 <c:if test="${managerLoggedIn!=null }">
	    	 	 <c:if test="${managerLoggedIn.getManagerId() eq 'admin' }">
	    	 	 	<label for="">admin님</label>
	    	 	 </c:if>
	    	 	 <c:if test="${managerLoggedIn.getManagerId() ne 'admin' }">
	    	 	 	<a class="nav-link" href="${rootPath }/manager/managerView.do?nno=${managerLoggedIn.getNno()}" >${managerLoggedIn.getMgname() }님</a>
	    	 	 </c:if>
	    	 
	    	 </c:if>
	    </li>
	    <c:if test="${managerLoggedIn!=null }">
	    	  <li class="nav-item"><a class="nav-link" href="">로그아웃</a></li>
	    </c:if>
	  
	    
	  </ul>
	</nav>


</header>




