<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	
<script>
function moveMemberEnroll(){
	location.href="${pageContext.request.contextPath}/member/memberEnroll";
}
</script>
<button onclick="moveMemberEnroll()">회원 가입</button>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

