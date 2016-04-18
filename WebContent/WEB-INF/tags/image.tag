<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="width" required="false" type="java.lang.Integer" description="Width of the image in pixels"%>
<%@ attribute name="stem" required="true" type="java.lang.String" description="Name of the image minus the extension"%>
<%@ attribute name="extension" required="true" type="java.lang.String" description="File extension of the image"%>

<c:if test="${empty width}">
	<c:set var="width" value="200"/>
</c:if>

<c:set scope="page" var="imgname" value="${stem}.${extension}" />

<img width = "${width}" src="${pageContext.request.contextPath}/pics/${imgname}" />

