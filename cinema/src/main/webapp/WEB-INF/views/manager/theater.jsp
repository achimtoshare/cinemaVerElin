<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/manager_header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
tr{
	cursor:pointer;
}
</style>	
<script>
selectLocalList();

$(function(){
	$("button#addLocal").click(function(){
		var tHtml="<tr><td><input type</td><td></td></tr>";
	});
	
});
function selectTheater(lno){
	$.ajax({
		url:"selectTheater.do",
		data:{lno:lno,type:'manager'},
		dataType:"json",
		success:function(data){
			console.log(data.list);
			var html="";
			html+="<table><tr><th>NO</th><th>지역</th><th>지점이름</th><th>전화번호</th><th>주소</th><th>매니저이름</th><th>매니저아이디</th><th>매니저사진</th></tr>";
			for(var index in data.list){
				var th=data.list[index];
				html+="<tr><td>"+th.TNO+"</td><td><input type='hidden' value='"+th.LNO+"'>"+th.LNAME+"</td><td>"+th.TNAME+
				"</td><td>"+th.TEL+"</td><td>"+th.ADDR+"</td><td>"+th.MGNAME+"</td><td>"+th.MANAGERID+"</td><td>"+th.PHOTO+"</td></td></tr>";
			}
			html+="</table>";
			
			$("div.theater-container").html(html);
		}
		
		
		
	});
}
function selectLocalList(){
	console.log("호출을 했는데 왜 답이 안오냐");
	$.ajax({
		url:"selectLocal.do",
		dataType:"json",
		success:function(data){
			console.log(data);
			var html="";
			html+="<table><tr><th>No</th><th>지역이름</th><th>수정</th><th>삭제</th></tr>";
			html+="<tr><td colspan='2'><input type='text' id='lname' placeholder='새로운 지역을 입력하세요'></td><td colspan='2'><button type='button' style='width:100%'>등록</button></td></tr>";
			
			for(var index in data.list){
				var local=data.list[index];
				html+="<tr onclick='selectTheater("+local.LNO+")'><td>"+local.LNO+"</td><td>"+local.LNAME+"</td><td><button class='btn-update'>수정</button></td><td><button class='btn-delete'>삭제</button></td></tr>";	
			}
			html+="</table>";
			
			$("div.local-container").html(html);
		}
	});
	
}
</script>
<div class="localTheater-container">

	<div class="local-container">
		
	
	</div>
	
	<div class="theater-container">
	
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/manager_footer.jsp"/>	
