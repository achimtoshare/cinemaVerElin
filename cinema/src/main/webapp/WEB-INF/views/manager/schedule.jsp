<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/manager_header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	
<style>
ul{
 list-style: none;
}
div.scheduleFrm-wrap, div.time-wrap{
	
}
ul.time-list{
	height:400px; 
	overflow-y:scroll;
}
ul.time-list li{
	cursor:pointer;
}
ul.time-list li:hover{
	background:lightcoral;
}
div.schedule-container{
	
}
.chooseTime{
	background:lightblue;
}

#autoComplete{position:absolute; background:#fff; border:1px solid #e0e0e0; padding-left:0px; margin-bottom:0px;}
#autoComplete li{padding:10px; border-bottom:1px solid #ececec;}
.movieChoose{position:absolute; background:#fff; border:1px solid #e0e0e0;}
.movieChoose li{padding:10px; border-bottom:1px solid #ececec;}
</style>
<script>
$(function(){
	showTimeList();
	$(".movieChoose").hide();
	
	//영화관의 상영관 가져오기
	$.ajax({
		url:"selectRoomByTheater.do",
		data:{tno:${managerLoggedIn.getTno()}},
		dataType:"json",
		success:function(data){
			var html="";
			for(var i in data){
				html+="<option value='"+data[i].RNO+"'>"+data[i].RNAME+"</option>";
				
			}
			$("select#room").html(html);
		}
	});
	
	
	//시간을 선택한다. 
	$("ul.time-list").on("click","li",function(){
		if($("input#date").val()=="") alert("상영날짜를 선택하세요");
		if($("input#searchName").val().trim()=="") alert("영화를 선택하세요");
		
		//전에 또 선택한 시간들이 있다면 선택을 지워줘야함.
		if($(".chooseTime").length!=0){
		      $('.chooseTime').each(function(index, element){
		    	  $(this).removeClass("chooseTime");
		      });
		      
		}
		
		var start = parseInt( $(this).attr("total-min"));
		var end= start+ parseInt($("input#runtime").val());
	
		//시간 체크하기. 이미 예정된 스케쥴에 대해서도 잡아줘야함. 
		//끝나는 시간에서 30분은 휴게시간이므로 넣어줌. 서버단에서도 잡아봐야함.
		$("ul.time-list li").each(function(index,element){
			console.log("each문 돌아염");
			if(parseInt($(this).attr("total-min"))>=start&&parseInt($(this).attr("total-min"))<=end+30){
				$(this).addClass("chooseTime");
			}
		});
		
		
		//시작 시간, 종료 시간을 나타냄.
		
		$("td.startTime").text($("input#date").val()+" "+$(this).children("span.time-exp").text());
	
		$("td.endTime").text($("input#date").val()+" "+$("li.chooseTime:last").children("span.time-exp").text());
		
		$("input[name=eTime]").val($("td.endTime").text());
		$("input[name=sTime]").val($("td.startTime").text());
		
	});
	
	
	
	
	
	
	//시간 리스트 보여주기
	function showTimeList(){
		
		console.log("실행되냐");
		var createli = "";
		var shour=7;
		var ehour= 24;
		var min= 60;
		
		for(var i=shour;i<=ehour;i++){
			for(var j=0;j<min;j+=10){
				createli +="<li time-hour='"+i+"' time-min='"+(j<10? "0"+j:j)+"' total-min='"+((i*60)+j)+"'><span class='time-exp'>"+(i<10? "0"+i:i)+":"+(j<10? "0"+j:j)+"</span><span class='reservedMovie'></span></li>";
			}
		}
		$("ul.time-list").html(createli);
		
	}
	
	$("#searchName").keyup(function(e){
		console.log(e);
		console.log(e.key+", " + $(this).val());
		
		//방향키 (ArrowUp, ArrowDown), 엔터(Enter)일 경우, 선택효과
		//그 외의 키일 경우 ajax요청처리
		if($(this).val()==""){
			return;
		}
		var sel = $(".sel");
		var li = $("#autoComplete li");
		
		var autoComplete = $("ul#autoComplete");
		autoComplete.show();
		
		console.log(sel);
		
		if(e.key == 'ArrowDown'){
			console.log('ArrowDown');
			//아무것도 선택되지 않은경우
			if(sel.length == 0) {
				$("#autoComplete li:first").addClass("sel");			
				console.log("왜 클래스 안붙어");
			//선택된 sel이 마지막 li태그인 경우	
			}else if(sel.is(li.last())){
				sel.removeClass("sel");
			}else{
				sel.removeClass("sel").next().addClass("sel");
			}
		}else if(e.key =='ArrowUp'){
			console.log('ArrowUp');
			if(sel.length == 0) {
				$("#autoComplete li:last").addClass("sel");			
				
			//선택된 sel이 마지막 li태그인 경우	
			}else if(sel.is(li.first())){
				sel.removeClass("sel");
				
			}else{
				sel.removeClass("sel").prev().addClass("sel");
			}	
		}else if(e.key == 'Enter'){
			console.log('Enter');
			$(this).val(sel.text());
			
			$("#autoComplete").hide().children().remove();
		}else{
			var searchNamed =  $(this).val();
			$.ajax({
				url:"${rootPath}/manager/searchMovie.do",
				type:"post",
				data:{searchName : searchNamed},
				dataType:"json",
				success:function(data){
					console.log(data);
					//아무값도 넘어오지 않는 경우, data.split(",")의 배열 길이가 1임.
					autoComplete.empty();
					/* movieChoose.append("<ul id='autoComplete'>") */
					
					for(i in data.list){
						var mv=data.list[i];
						//var moviedata = JSON.stringify(data[i]);
						autoComplete.append("<li onclick='fn_selectMovie("+mv.MVNO+", \""+mv.MVNAME+"\","+mv.RUNTIME+")'>" + mv.MVNO+ " , "+mv.MVNAME +"</li>" );
/* 						movieChoose.append("<li onclick='fn_selectMovie("+mv.MVNO+", \""+mv.MVNAME+"\","+mv.RUNTIME+")'>" + mv.MVNO+ " , "+mv.MVNAME +"</li>" ); */
					}
					/* movieChoose.append("</ul>"); */

					
				}
			});
		}
		
		
	});

});
function checkSchedule(){
	var date = $("#date").val();
	
	if(date=="") return;
	
	$.ajax({
		url:"${rootPath}/manager/checkSchedule.do/"+date,
		dataType:"json",
		success:function(data){
			
			console.log("checkSchedule");
			console.log(data);
			
			showSchedule();
		}
	});
	
}

function showSchedule(){
	console.log("showSchedule");
	
}
//영화 선택시 처리
//영화 이름을 검색 창에 넣어주고 mvno값, runtime값을 저장한다.
function fn_selectMovie(mvno, mvname,runtime){
	console.log("fn_selectMovie");
	console.log(mvno);
	$("ul#autoComplete").empty();
	$("#autoComplete").hide();
	$("#searchName").val(mvname);
	$("input#mvno").val(mvno);
	$("input#runtime").val(runtime);
	
	console.log("mvno");
	console.log($("input#mvno").val());
}
function validate(){
	
	
	return true;
}

</script>
<div class="schedule-container">
	<div class="scheduleFrm-wrap">
		<form action="scheduleEnroll.do" name="scheduleFrm" method="post" onsubmit="return validate()">
			<table>
				<tr>
					<th>날짜</th>
					<td><input type="date" name="" id="date" /></td>
					<td><button type="button" onclick="checkSchedule()">시간표 조회</button></td>
				</tr>
				<tr>
					<th>영화 검색</th>
					<td><input type="text" id="searchName" /><ul id="autoComplete"></ul>
						<input type="hidden" name="mvno" id="mvno"/><input type="hidden" id="runtime" />
					</td>
					<td></td>
				</tr>
				<tr>
					<th>상영관</th>
					<td>
						<select name="rno" id="room">
						
						</select>
					</td>
					<td>좌석수 : </td>
				</tr>
				<tr>
					<th>좌석타입</th>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>시작시간</th>
					<td class="startTime"></td>
					<td><input type="hidden" name="sTime" /></td>
				</tr>
				<tr>
					<th>종료시간</th>
					<td class="endTime"></td>
					<td><input type="hidden" name="eTime" /></td>
				</tr>
				<tr>
					<td colspan="3">
						<button type="submit" class="btn btn-insert" value="insert">등록</button>
						<button type="submit" class="btn btn-update" value="update">수정</button>
						<button type="button" class="btn btn-delete" value="delete">삭제</button>
						<input type="hidden" name="sno" />
					</td>
				</tr>
			
			</table>
		</form>
	</div>
	<div class="time-wrap">
		<ul class="time-list">
		
		
		</ul>
	
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/manager_footer.jsp"/>	
