<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bewertung</title>
</head>
<body>
<table>
    <c:forEach items="${kriterien}" var="kriterium">
        <tr>
            <td><c:out value="${kriterium.hauptkriterium}" /></td>
            <td><c:out value="${kriterium.teilkriterium}" /></td>
            <td><c:out value="${kriterium.maxpunkte}" /></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>