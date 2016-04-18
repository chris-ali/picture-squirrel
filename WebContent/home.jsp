<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="pic"%>

<c:import url="header.jsp">
	<c:param name="title" value="Picture Squirrel Home"/>  
</c:import>

<sql:setDataSource var="ds" dataSource="jdbc/picturesquirrel"/>
<sql:query dataSource="${ds}" sql="select * from images order by average_ranking desc limit 100" var="results"/>

<table class="images">

<c:set var="tablewidth" value="8"/>

<c:forEach var="image" items="${results.rows}" varStatus="row">
	<c:if test="${row.index % tablewidth == 0}">
		<tr>
	</c:if>
			<td>
				<a href="<c:url value="/gallery?action=image&image=${image.id}"/>">	
					<pic:image width="80" stem="${image.stem}" extension="${image.image_extension}"/>
				</a>
			</td>
	<c:if test="${row.index+1 % tablewidth == 0}">
		</tr>
	</c:if>
</c:forEach>

</table>


<c:import url="footer.jsp"/>