<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">  
<title>PEP Management</title>
</head>
<body>

<h1>Nachricht der Datenbank</h1> 

<c:out value='${requestScope.message}'/>

</body>
</html>