<jsp:include page ="/WEB-INF/views/common/header.jsp"><jsp:param value="" name="pageTitle"/></jsp:include>

<script>
var msg = "${msg != null ? msg : null}";

if( msg != null )
	alert(msg);

	
location.href="${pageContext.request.contextPath}${loc}";
</script>

<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
