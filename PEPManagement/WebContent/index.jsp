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
<h1>Startseite</h1>
<header>
<%	
	if(request.getAttribute("loggedin") != null) {
		boolean loggedIn = ((Boolean) request.getAttribute("loggedin")).booleanValue();
		if(loggedIn) {
			out.println("<a href=\"index.jsp\">index</a> <a href=\"Logout\">Logout</a>");
		} else {
	
			out.println("<a href=\"index.jsp\">index</a> <a href=\"login.jsp\">Login</a> <a href=\"register.jsp\">Registrieren</a>");
		}
	} else {
		out.println("Please move to <a href=\"index\">index</a>");
	}
%>
</header>
<h3>Nachricht der Datenbank</h3> 

<c:out value='${requestScope.message}'/>

</body>
</html>