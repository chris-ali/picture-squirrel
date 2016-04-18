<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="pic"%>

<c:import url="header.jsp">
	<c:param name="title" value="Picture Squirrel - View Image" />
</c:import>

<center>
	<sql:transaction dataSource="jdbc/picturesquirrel" >

		<sql:query sql="select * from images where id=?"
			var="results">
			<sql:param>${param.image}</sql:param>
		</sql:query>

		<c:set scope="page" var="image" value="${results.rows[0]}" />
		<c:set scope="page" var="average_ranking" value="${image.average_ranking}" />

		<c:if test='${param.action == "rate"}'>
			<c:set scope="page" var="newRating"
				value="${(image.average_ranking* image.rankings + param.rating)/(image.rankings + 1)}" />
			<c:set scope="page" var="average_ranking" value="${newRating}" />

			<sql:update sql="update images set average_ranking=? where id=?">
				<sql:param>${newRating}</sql:param>
				<sql:param>${param.image}</sql:param>
			</sql:update>

			<sql:update sql="update images set rankings=? where id=?">
				<sql:param>${image.rankings+1}</sql:param>
				<sql:param>${param.image}</sql:param>
			</sql:update>
		</c:if>

	</sql:transaction>

	<H2>
		<c:out
			value="${fn:toUpperCase(fn:substring(image.stem, 0, 1))}${fn:toLowerCase(fn:substring(image.stem, 1, -1))}" />
	</H2>

	<span class="rating">Rated: <fmt:formatNumber value="${average_ranking}" maxFractionDigits="1" /></span>

	<table style="border: none;">
		<tr>
			<td><br style="margin-bottom: 1px">
				<span class="attribution">Image by: <a class="attribution"	target="_blank" href="${image.attribution_url}">
				<c:out value="${image.attribution_name}" /></a></span><br> 
				<pic:image width="200" stem="${image.stem}" extension="${image.image_extension}"/></td>

			<td>
				<form action='<c:url value="/gallery" />' method="post">
					<input type="hidden" name="action" value="rate" /> <input
						type="hidden" name="image" value="${image.id}" />

					<table style="padding: 20px; border: none;">
						<tr>
							<td><h3>
									<i>Rate it!</i>
								</h3></td>
						</tr>
						<tr>
							<td align="left"><input type="radio" name="rating" value="5">5
								- Amazing</input></td>
						</tr>
						<tr>
							<td align="left"><input type="radio" name="rating" value="4">4
								- Good</input></td>
						</tr>
						<tr>
							<td align="left"><input type="radio" name="rating" value="3"
								checked="checked">3 - Average</input></td>
						</tr>
						<tr>
							<td align="left"><input type="radio" name="rating" value="2">2
								- Bad</input></td>
						</tr>
						<tr>
							<td align="left"><input type="radio" name="rating" value="1">1
								- Horrible</input></td>
						</tr>
						<tr>
							<td align="left"><input type="submit" name="submit"
								value="OK"></input></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
</center>

<c:import url="footer.jsp" />