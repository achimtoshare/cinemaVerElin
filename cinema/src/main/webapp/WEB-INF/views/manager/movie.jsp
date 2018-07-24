<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="${rootPath }/resources/css/trix.css">
<script type="text/javascript" src="${rootPath }/resources/js/trix.js"></script>
<jsp:include page="/WEB-INF/views/common/manager_header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	
<style>
table{
	border-collapse: collapse;
	width:60%;
	
}
div.forCopy{
	display:none;
}

</style>
<script>
function validate(){
	
	return true;
}
$(function(){
	//첨부파일이름 표시
	$("form[name=movieFrm]").on("change","[name=upFile]",function(){
		var fileName= $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
	$("form[name=movieFrm]").on("change","[name=posterImg]",function(){
		var fileName= $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
	//첨부파일 이미지추가 버튼 클릭시 첨부파일창이 밑에 더 생긴다.
	$("form[name=movieFrm]").on("click","button.addFile",function(){
		if($("div.fileWrapper").length<4){
			$("div.fileWrapper:last").after($("div.forCopy").clone().removeClass("forCopy").addClass("fileWrapper"));
		}
			
	});
	
	//첨부파일 삭제 버튼 클릭시  해당 첨부파일 영역이 사라진다.
	$("form[name=movieFrm]").on("click","button.removeFile",function(){
		console.log($("div.fileWrapper:eq(0)"));
		$(this).parent("div.fileWrapper").remove();
	});	
});
</script>
<c:set var="arr_genre" value="${fn:split('코미디,판타지,모험,SF,액션,드라마,스릴러/서스펜스,멜로/로맨스,전쟁,가족,범죄,애니메이션,호러,뮤지컬,다큐멘터리',',')}" />
<div class="movieform-container">
<form action="movieEnroll.do" method="post" name="movieFrm" enctype="multipart/form-data" onsubmit="return validate()">
<table>
	<tr>
		<th>영화명</th>
		<td><input type="text" name="mvname" id="mvname" /></td>
	</tr>
	<tr>
		<th>영문명</th>
		<td><input type="text" name="ename" id="ename" /></td>
	</tr>
	<tr>
		<th>개봉일자</th>
		<td><input type="date" name="relDate" id="relDate" /></td>
	</tr>
	<tr>
		<th>영화등급</th>
		<td>
			<select name="grade" id="grade">
				<option value="전체">전체</option>
				<option value="12세">12세</option>
				<option value="15세">15세</option>
				<option value="청불">청불</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>러닝타임</th>
		<td><input type="number" name="runtime" id="runtime" min="1"  max="300"/>분</td>
	</tr>
	<tr>
		<th>장르(최대4개)</th>
		<td>
		 	<c:forEach var="i" items="${arr_genre}" varStatus="vs">
		 		<label for="">${i }</label><input type="checkbox" name="genres" value="${i }" />	 		
		 	</c:forEach>
		</td>
	</tr>
	<tr>
		<th>감독</th>
		<td><input type="text" name="director" id="director" /></td>
	</tr>
	<tr>
		<th>연기자</th>
		<td><input type="text" name="actor" id="actor" /></td>
	</tr>
	<tr>
		<th>포스터</th>
		<td>
			<div class="input-group mb-3 poster" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">포스터</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="posterImg" accept="image/*" required >
			    <label class="custom-file-label">사진을 선택하세요</label>
			  </div>
		    </div>
		</td>
	</tr>
	<tr>
		<th>서브이미지</th>
		<td>
			<button class="btn-file addFile">이미지 추가</button>
			<div class="input-group mb-3 fileWrapper" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">서브이미지</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" accept="image/*" required >
			    <label class="custom-file-label">사진을 선택하세요</label>
			  </div>
			  &nbsp;
			  <button type="button" class="btn-file removeFile">삭제</button>
		    </div>
		</td>
	</tr>
	<tr>
		<th>줄거리</th>
		<td>
			<input type="hidden" name="story" id="editor" />
			<trix-editor input="editor"></trix-editor>
		</td>
	</tr>
	<tr>
		<th>예고편</th>
		<td><input type="text" name="trailer" id="trailer" /></td>
	</tr>
</table>
<input type="submit" value="등록하기" />
<input type="submit" value="수정하기" />
<input type="submit" value="삭제하기" />
</form>
<div class="selectMovie-container">

</div>
<div class="input-group mb-3 forCopy" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">서브이미지</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" accept="image/*" required >
			    <label class="custom-file-label">사진을 선택하세요</label>
			  </div>
			  &nbsp;
			  <button type="button" class="btn-file removeFile">삭제</button>
</div>
</div>

<jsp:include page="/WEB-INF/views/common/manager_footer.jsp"/>	
