<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/member/enroll.js"></script> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	
<script>
$(function(){

});
function validate(){
	
	
}

</script>
회원가입
<form action="memberEnrollEnd.do" method="post" enctype="multipart/form-data" onsubmit="return validate()">

<div id="userId-container">
					<input type="text" name="memberId" id="userId_" placeholder="아이디(필수)"  maxlength="15" required autocomplete="off" />
					<button type="button" onclick="fn_checkID();" class="btn btn-primary">아이디 확인</button>
					<br />
					<div id="check-id">
					<span class="guide ok"></span> 
					<span class="guide error"></span> 
					</div>
					<input type="hidden" id="idDuplicateCheck" value="0" />
				</div>
				<div>
					<input type="password" name="pw" id="password_"  maxlength="15" placeholder="비밀번호(필수)" required autocomplete="off"  /> <br /> 
					<span id="pwd"></span>  
					<span id="pwdok"></span>  
					<br />
					<input type="password" id="password2" placeholder="비밀번호 확인(필수)"  maxlength="15"  required autocomplete="off"  /> <br /> 
					<span id="pwd2"></span> 
					<span id="pwd2ok"></span> 
					<input type="hidden" id="pwdDuplicateCheck" value="0" />
				</div>
				<br />
				
			</div>
			
			<div id="name-phone-email-gender-div-ik">
			
			<!-- 이름 -->
			<div>
				<input type="text" name="mname" id="name" placeholder="이름(필수)"  maxlength="7" required  autocomplete="off"  /><br />
				<span id="nameerr" class="name"></span> 
				<span id="nameok" class="name"></span> <br /> 
			</div>
			
			<!-- 전화번호 -->
			<div>
				<input type="text" name="phone" id="phone" maxlength="11"  placeholder="전화번호(필수)" required required autocomplete="off"  /> <br /> 
				<span id="phoneerr" class="phone"></span> 
			</div>
			<br />
			<!-- 이메일 -->
			<input type="text" name="email" id="email" placeholder="이메일(필수)"  maxlength="15" required  autocomplete="off"  /> 
			<!-- @ 
			<input type="text" name="email" id="emailaddr" placeholder="직접입력"  maxlength="20" required  autocomplete="off"  /> -->
			<!-- <input type="button" value="인증번호" onclick="fn_certification();" class="btn btn-primary"/> 
			<input type="hidden" id="checkcertification" value="0" /> 
			<br /><br />
			<input type="text" id="inputCode" placeholder="인증번호를 입력하세요" required autocomplete="off"/>
			<input type="button" value="확인" onclick="checkJoinCode();" class="btn btn-primary" /> 
			<span id="countDown"></span>
			<input type="hidden" id="checkPoint" value="0" /> <br /> -->
			<br />
			<!-- 생일 -->
			<p class="textP">생년월일(필수)</p><input type="date" name="birth" id="birth" placeholder="생년월일" required/><br />
			<br />
			<!-- 성별 -->
			<span class="jender">
			<input type="radio" name="gender" value="M" id="male" checked /> <label for="male">남</label> 
			</span>
			<span class="jender">
			<input type="radio" name="gender" value="F"id="fmale" /> <label for="fmale">여</label> <br /> 
			</span>
			<br />	<br />
			</div>
			<br />
			<button type="button" class="btn btn-primary" id="btn_upFile">프로필 사진(선택)</button> <input type="file" name="upFile" id="upFile" accept="image/*" /> 
			<button type="button" class="btn btn-primary" id="btn_noFile">취소</button> 
			<input type='hidden' name='mprofile' id="mprofile" value='noprofile.jpg'> <br /><br />
			<div id="div-img-ik"></div>
			<div>
			<br />

			</div>
			<br />
			<input type="submit" id="submit" value="가입하기" class="btn btn-primary"/>


</form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	
