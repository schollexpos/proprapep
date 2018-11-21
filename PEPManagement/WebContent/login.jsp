<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<h1>Login</h1>
<%
	if(request.getParameter("error") != null) {
		String str = request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "E-Mail/Passwort falsch!";
		}
		out.println("<div style=\"border: 1px solid darkred;background-color: red;margin: 10px;\"><p>" + errorMessage + "</p></div>");
	}
%>

<form action="LoginServlet" method="post">

Username: <input type="email" name="email">
<br>
Password: <input type="password" name="password">
<br>
<input type="submit" value="Login">
</form>

</body>
</html>