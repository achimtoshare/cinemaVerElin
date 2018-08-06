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
	width:750px;
	
	
}
th{
	width:81px;
}
div.forCopy{
	display:none;
}
ul#movie-list{
	padding-left:0px;
	position:relative;
}
li.movie-item{
	border:1px solid black;
	list-style: none;
	float:left;
	width:200px;
	height:260px;
	cursor:pointer;
	position: relative;
}
div.movie-poster img{
	width:100%;
	height:180px;
}
.detail{
	display:none;
}
.notwanted{
	display:none;
}
div.modal-content{
	width:957px;
	padding-left:10px;
	padding-top:20px;
	padding-right:10px;
}
.modal {
  text-align: center;
  padding: 0!important;
}

.modal:before {
  content: '';
  display: inline-block;
  height: 100%;
  vertical-align: middle;
  margin-right: -4px;
}

.modal-dialog {
  display: inline-block;
  text-align: left;
  vertical-align: middle;
  max-width:800px;
}
img.detail-poster{
	width:315px;
	height:450px;
}
div.left-wrap{
	width:315px;
	height:450px;
	float:left;
	overflow:hidden;
}
div.right-wrap{
	margin-left:30px;
	float:left;
	overflow:hidden;
}
div.row-2{
	clear:both;
	overflow:hidden;
}
img.gradeimg{
	width:20px;
	height:20px;
}
button.btn-update, button.btn-delete{
	width:40px;
	height:35px;
	background-color:lightgray;
	padding:0px;
}
span.movie-dday{
	background:black;
	color:white;
	opacity: 0.6;
	border-radius: 7px;
	font-weight: bold;
	position: relative;
	top:-202px;
	left: 68px;
}
.container{
	height:100%;
}
/* button.btn-detail{
	width:70px;
	height:35px;
	background-color:lightgray;
	padding:0px;
} */

</style>
<script>
function validate(){
	
	return true;
}
$(function(){
	
	selectMovieList();
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
	
	
	
	
	$("form[name=movieFrmUP]").on("change","[name=upFile]",function(){
		var fileName= $(this).prop("files")[0].name;
		console.log("왜여깅 ㅏㄴ되냐");
		$(this).siblings(".custom-file-label").html(fileName);
		$(this).next("input.isNew").val("true");
	});
	
	$("form[name=movieFrmUP]").on("change","[name=posterImg]",function(){
		var fileName= $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
	//첨부파일 이미지추가 버튼 클릭시 첨부파일창이 밑에 더 생긴다.
	$("form[name=movieFrmUP]").on("click","button.addFile_",function(){
		if($("div.fileWrapper_").length<4){
			$("div.fileWrapper_:last").after($("div.forCopy").clone().removeClass("forCopy").addClass("fileWrapper_"));
			
		}
			
	});
	
	//첨부파일 삭제 버튼 클릭시  해당 첨부파일 영역이 사라진다.
	
	
	
	//첨부파일 삭제 버튼 클릭시  해당 첨부파일 영역이 사라진다.
	$("form[name=movieFrmUP]").on("click","button.removeFile_",function(){
		if($("div.fileWrapper_").length>1){
			console.log($(this).parent("div.fileWrapper_"));
			$(this).parent("div.fileWrapper_").remove();
			
		}
			
	});
		
	//영화 목록 중에서 하나 클릭했을 때 이벤트 - 모달창에 영화 상세띄움.
	$("ul#movie-list").on("click","li.movie-item",function(){
		
	});
	
	//수정버튼을 클릭하여 수정폼이 있는 모달을 띄움. 
	$("ul#movie-list").on("click","button.btn-update",function(){
		
		console.log("실행안됨?");
		$("#mvname_").val($(this).siblings("span.movie-name").text());
		$("#ename_").val($(this).siblings("span.movie-ename").text());
		$("#reldate_").val($(this).siblings("span.movie-reldate").text());
		//등급은 이미지로 대체하되 값은 가지고 있어야 한다. 
		$("#grade_").val($(this).siblings("span.movie-grade").text());
		$("input#mvno").val($(this).siblings("span.movie-mvno").text());
		$("#runtime_").val($(this).siblings("span.movie-runtime").text());
		$("#relDate_").val($(this).siblings("span.movie-reldate").text());
		var genre=$(this).siblings("span.movie-genre").text();
		
		 //기존에 택했던 장르 체크
		$("input[name=genres_]").each(function(index,element){
			if(genre.indexOf($(this).val())!=-1){
				$(this).attr("checked",true);
				
			}else{
				$(this).removeAttr("checked");
			}
		}); 
		
		$("#director_").val($(this).siblings("span.movie-director").text());
		$("#actor_").val($(this).siblings("span.movie-actor").text());
	
		var element =$("trix-editor[input=editor2]");	
		element.html($(this).siblings("div.movie-story").html());
		if($(this).siblings("span.movie-trailer").html()!="") $("#trailer_").val($(this).siblings("span.movie-trailer").html());
		
		//기존의 서브이미지 첨부 파일 폼 개수 나타내기
		var arr_subimg=$(this).siblings("span.movie-subimg").text().split(",");
		var subimg_cnt=$("div.fileWrapper_").length;
		console.log(arr_subimg.length);
		console.log(subimg_cnt);
		if(arr_subimg.length>subimg_cnt){
			console.log("등록된 이미지가 폼보다 많음 증가시켜야함.");
			for(var i=0;i<arr_subimg.length-subimg_cnt;i++){
				$("button.addFile_").trigger('click');
				$("input.isNew:last").val("false");
		}
		}else if(arr_subimg.length<subimg_cnt){
			console.log("폼이 이미지 보다 많음 줄여야 함.");
			for(var i=0;i<subimg_cnt-arr_subimg.length;i++){
				$("div.fileWrapper_").eq(i).remove();
			}
		}
		
		//기존에 업로드했던 사진 파일 이름을 나타냄.
		$("div.fileWrapper_").each(function(index,element){
			$(this).find("label.custom-file-label").text(arr_subimg[index]);
			
		});  
		
		$("div.poster_").find("label.custom-file-label").text($(this).siblings("span.movie-poster").text());
		
		
		
	});
	
	//영화 상세보기 버튼 클릭 이벤트
	$("button.btn-detail").click(function(){
		$("h3.detail-title").text($(this).siblings("span.movie-name").text());
		$("h6.detail-etitle").text($(this).siblings("span.movie-ename").text());
		$("span.detail-reldate").text($(this).siblings("span.movie-reldate").text());
		//등급은 이미지로 대체하되 값은 가지고 있어야 한다. 
		$("input.detail-grade").val($(this).siblings("span.movie-grade").text());
		$("input.detailMvno").val($(this).siblings("span.movie-mvno").text());
		$("span.detail-runtime").text($(this).siblings("span.movie-runtime").text());
		$("span.detail-genre").text($(this).siblings("span.movie-genre").text());
		$("span.detail-director").text($(this).siblings("span.movie-director").text());
		$("span.detail-actor").text($(this).siblings("span.movie-actor").text());
		$("img.detail-poster").attr("src","${rootPath}/resources/upload/movie/"+$(this).siblings("span.movie-poster").text()+"");
		
	});
	
	
	//영화 삭제 버튼 클릭 이벤트
	$("ul#movie-list").on("click","button.btn-delete",function(){
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				url:"deleteMovie.do",
				type:"post",
				dataType:"json",
				data:{mvno:$(this).siblings("span.movie-mvno").text()},
				success:function(data){
					if(data>0){
						alert("삭제하였습니다.");
					}else{
						alert("삭제 실패");
					}
					
				}
			});
		}
	});
	
	function selectMovieList(){
		
		console.log("영화 목록을 가져와라 ");
		$.ajax({
			url:"selectMovieAll.do",
			dataType:"json",
			success:function(data){
				console.log(data);
				var html="";
				for(var index in data){
					var m=data[index];
					var gradeimgname="";
					switch(m.GRADE){
						case '전체' : gradeimgname="all.png"; break;
						case '12세' : gradeimgname="12.png"; break;
						case '15세' : gradeimgname="15.png"; break;
						case '청불' : gradeimgname="19.png";  break;
					
					}
					
					html+="<li class='movie-item'>";
					html+="<div class='movie-poster'><img src='${rootPath}/resources/upload/movie/"+m.POSTER+"'/></div>";
					html+="<div class='movie-info'>";
					html+="<span><img class='gradeimg' src='${rootPath}/resources/img/"+gradeimgname+"'/></span>";
					html+="<span class='movie-name'>"+m.MVNAME+"</span><br/>";
					html+="&nbsp;<button type='button' class='btn btn-update' data-toggle='modal' data-target='#movieUpdateModal'>수정</button>&nbsp;<button type='button' class='btn btn-delete' >삭제</button>&nbsp;";
					if(m.DDAY<0) html+="<span class='movie-dday'>D-"+(m.DDAY)*-1+"</span>";
					//html+="<button type='button'class='btn btn-detail' data-toggle='modal' data-target='#movieModal'>상세보기</button>";
					html+="<span class='movie-runtime detail'>"+m.RUNTIME+"</span>";
					html+="<span class='movie-grade detail'>"+m.GRADE+"</span>";
					html+="<span class='movie-mvno detail'>"+m.MVNO+"</span>";
					html+="<span class='movie-genre detail'>"+m.GENRE+"</span>";
					html+="<span class='movie-ename detail'>"+m.ENAME+"</span>";
					html+="<span class='movie-director detail'>"+m.DIRECTOR+"</span>";
					html+="<span class='movie-actor detail'>"+m.ACTOR+"</span>";
					html+="<span class='movie-poster detail'>"+m.POSTER+"</span>";
					html+="<div class='movie-story detail'>"+m.STORY+"</div>";
					html+="<span class='movie-subimg detail'>"+m.SUBIMG+"</span>";
					if(m.TRAILER) html+="<span class='movie-trailer detail'>"+m.TRAILER+"</span>";
					html+="<span class='movie-reldate detail'>"+m.RELDATE+"</span>";
					
					
					
					html+="</div></li>";
					
					
				}
				$("ul#movie-list").html(html);
			}
		});
	}
	
	$("input.btn-init").click(function(){
		$("label.custom-file-label").text("사진을 선택하세요");
	});
	
	$("button#enroll-trigger").click(function(){
		$("div.movieEnroll-wrap").toggleClass("notwanted");
		if($(this).text()=='영화 등록'||$(this).text()=='영화 수정') {
			$(this).text("취소");
		}
		else $(this).text("영화 등록");
		
	});
	
	function validate(){
		
	}
	

	
	
});
 function validateUpdate(){
	
	//기존의 파일 이름 연결해서 보내기 
	   var oldFiles="";
	   $("div.fileWrapper_ div.custom-file input.isNew").each(function(index){
		   if($(this).val()=="false"){
			   if(index!=0) oldFiles+=",";
			   oldFiles+=$(this).next("label").text();
			   
		   }
	   });
	   $("input#origin_subimg").val(oldFiles);
	   console.log("oldFiles"+oldFiles);
	   return true;
} 
</script>
<c:set var="arr_genre" value="${fn:split('코미디,판타지,모험,SF,액션,드라마,스릴러/서스펜스,멜로/로맨스,전쟁,가족,범죄,애니메이션,호러,뮤지컬,다큐멘터리',',')}" />
<div class="movieform-container container">
<button type="button" id="enroll-trigger" class="btn">영화 등록</button>
<div class="movieEnroll-wrap notwanted">
	<form action="movieEnroll.do" method="post" name="movieFrm" enctype="multipart/form-data" onsubmit="validate()">
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
			<th>장르<br>(최대4개)</th>
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
			<th>서브<br>이미지</th>
			<td>
				<button class="btn-file addFile btn">이미지 추가</button>
				<div class="input-group mb-3 fileWrapper" style="padding:0px">
				  <div class="input-group-prepend" style="padding:0px">
				    <span class="input-group-text">서브이미지</span>
				  </div>
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" name="upFile" accept="image/*" required >
				    <label class="custom-file-label">사진을 선택하세요</label>
				  </div>
				  &nbsp;
				  <button type="button" class="btn-file removeFile btn">삭제</button>
			    </div>
			</td>
		</tr>
		<tr>
			<th>줄거리</th>
			<td>
				<input type="hidden" name="story" id="editor" value=""/>
				<trix-editor input="editor"></trix-editor>
			</td>
		</tr>
		<tr>
			<th>예고편</th>
			<td><input type="text" name="trailer" id="trailer" /></td>
		</tr>
	</table>
	<input type="submit" class="btn btn-insert" value="등록하기" />
	<input type="reset" class="btn btn-init"  value="폼 초기화" />
	</form>
</div>

<div class="selectMovie-container">

</div>
<div class="movieList-wrap">
	<ul id="movie-list">
		
	</ul>
</div>

<!-- 파일 업로드 폼.. 복사용 -->
<div class="input-group mb-3 forCopy" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">서브이미지</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" accept="image/*" >
			    <input type="hidden" class="isNew" value="true" />
			    <label class="custom-file-label">사진을 선택하세요</label>
			  </div>
			  &nbsp;
			  <button type="button" class="btn-file removeFile removeFile_ btn">삭제</button>
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="movieModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
    	<!-- <input type="hidden" id="detailMvno" /> -->
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
      </button><br />
      <div class="movie-detail-wrap">
	      <div class="row-1">
		      <div class="left-wrap">
		      	<img src="" alt="" class="detail-poster"/>
		      </div>
		      <div class="right-wrap">
		      	<div class="title-wrap">
		      		<input type="hidden" class="detail-grade" />
		      		<h3 class="detail-title">한글이름</h3>
		      		<h6 class="detail-etitle">영어이름</h6>
		      	</div>
		      	<div class="etc">
			        개봉일 : <span class="detail-reldate"></span><br />
			        감독 : <span class="detail-director"></span><br />
			        출연진 : <span class="detail-actor"></span><br />
			        장르 : <span class="detail-genre"></span><span class="detail-runtime"></span><br />
			      	
		      	</div>
		      </div>
	      </div>
	      <div class="row-2">
		      <h3>줄거리</h3>
		      <div class="detail-story">
		      
		      </div>
	      
	      </div>
	      <div class="row-3">
	      	<div class="detail-subimg">
	      
	      	</div>
	      	<div class="detail-trailer">
	      	
	      	</div>
	      
	      </div>
	 
      
      
      </div>  
          <!--  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button> -->
      </div>
     
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="movieUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
    	
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
      </button><br />
      <div class="movie-detail-wrap">
	      <form action="movieUpdate.do" method="post" name="movieFrmUP" enctype="multipart/form-data"  onsubmit="return validateUpdate()"> 
			<table>
				<tr>
					<th>영화명</th>
					<td><input type="text" name="mvname" id="mvname_" /></td>
				</tr>
				<tr>
					<th>영문명</th>
					<td><input type="text" name="ename" id="ename_" /></td>
				</tr>
				<tr>
					<th>개봉일자</th>
					<td><input type="date" name="relDate" id="relDate_" /></td>
				</tr>
				<tr>
					<th>영화등급</th>
					<td>
						<select name="grade" id="grade_">
							<option value="전체">전체</option>
							<option value="12세">12세</option>
							<option value="15세">15세</option>
							<option value="청불">청불</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>러닝타임</th>
					<td><input type="number" name="runtime" id="runtime_" min="1"  max="300"/>분</td>
				</tr>
				<tr>
					<th>장르<br>(최대4개)</th>
					<td>
					 	<c:forEach var="i" items="${arr_genre}" varStatus="vs">
					 		<label for="">${i }</label><input type="checkbox" name="genres_" value="${i }" />	 		
					 	</c:forEach>
					</td>
				</tr>
				<tr>
					<th>감독</th>
					<td><input type="text" name="director" id="director_" /></td>
				</tr>
				<tr>
					<th>연기자</th>
					<td><input type="text" name="actor" id="actor_" /></td>
				</tr>
				<tr>
					<th>포스터</th>
					<td>
						<div class="input-group mb-3 poster_" style="padding:0px">
						  <div class="input-group-prepend" style="padding:0px">
						    <span class="input-group-text">포스터</span>
						  </div> 
						  <div class="custom-file">
						    <input type="file" class="custom-file-input" name="posterImg" accept="image/*">
						    <label class="custom-file-label">사진을 선택하세요</label>
						  </div>
					    </div>
					</td>
				</tr>
				<tr>
					<th>서브<br>이미지</th>
					<td>
						<button type='button' class="btn-file addFile_">이미지 추가</button>
						<div class="input-group mb-3 fileWrapper_" style="padding:0px">
						  <div class="input-group-prepend" style="padding:0px">
						    <span class="input-group-text">서브이미지</span>
						  </div>
						  <div class="custom-file">
						    <input type="file" class="custom-file-input" name="upFile" accept="image/*">
						    <input type="hidden" class="isNew" value="false" />
						    <label class="custom-file-label">사진을 선택하세요</label>
						  </div>
						  &nbsp;
						  <button type="button" class="btn-file removeFile_">삭제</button>
					    </div>
					    <input type="hidden" name="origin_subimg" id="origin_subimg" />
					</td>
				</tr>
				<tr>
					<th>줄거리</th>
					<td>
						<input type="hidden" name="story" id="editor2" value="" />
						<trix-editor input="editor2"></trix-editor>
					</td>
				</tr>
				<tr>
					<th>예고편</th>
					<td><input type="text" name="trailer" id="trailer_" /></td>
				</tr>
			</table>
			<input type="hidden" id="mvno" name="mvno" />		
		   <input type="submit" class="btn btn-updateEnd" value="수정하기" /> 
			<input type="reset" class="btn btn-init"  value="폼 초기화" />
	  </form> 
	 
      
      
      </div>  
          <!--  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button> -->
      </div>
     
    </div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/common/manager_footer.jsp"/>	
