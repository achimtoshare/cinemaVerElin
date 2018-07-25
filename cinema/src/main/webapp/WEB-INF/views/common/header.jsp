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
	      <a class="nav-link" href="${rootPath }/movie/movieList">영화</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="">예매</a><!-- 팝업창. -->
	    </li>
	      <li class="nav-item">
	      <c:if test="${memberLoggedIn==null }">
	     	 <a class="nav-link" href="" data-toggle="modal" data-target="#loginModal">로그인</a>
	      </c:if>
	      <c:if test="${memberLoggedIn!=null }">
	      	   <a class="nav-link" href="${rootPath }/member/memberView.do?mno=${memberLoggedIn.getMno()}" >${memberLoggedIn.getMname() }님</a>
	      </c:if>
	      
	    </li>
	    <li class="nav-item">
	    	 <a class="nav-link" href="" data-toggle="modal" data-target="#AdminloginModal">관리자 로그인</a>
	    </li>
	    
	  </ul>
	</nav>

<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="${rootPath }/member/memberLogin.do">
        	<label for="idForm">아이디 : </label>
        	<input type="text" name="memberId" id="memberId" placeholder="아이디를 입력하세요" required="required" /><br />
        	<label for="pwForm">비밀번호 : </label>
        	<input type="password" name="pw" id="mpw" placeholder="비밀번호를 입력하세요" required="required"/>
        	<input type="submit" value="로그인" /><br />
        	<a href="${rootPath }/member/memberEnroll">회원가입</a>
        </form>
           <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
      <div class="modal-footer">
     
      </div>
    </div>
  </div>
</div>
<!-- 관리자 로그인 모달 -->
<div class="modal fade" id="AdminloginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="${rootPath }/manager/managerLogin.do" method="post">
        	<label for="idForm">아이디 : </label>
        	<input type="text" name="managerId" id="managerId" placeholder="아이디를 입력하세요" required="required" /><br />
        	<label for="pwForm">비밀번호 : </label>
        	<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요" required="required"/>
        	<input type="submit" value="로그인" /><br />
        </form>
           <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
      <div class="modal-footer">
     
      </div>
    </div>
  </div>
</div>
</header>




