<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
<h1>Registrierung</h1>
<%
	if(request.getParameter("error") != null) {
		String str = request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {

			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "Ihre E-Mail Adresse muss von der Universit&auml;t Siegen sein!";
		} else if(str.equals("4")) {
			errorMessage = "Diese E-Mail Adresse existiert bereits";
		} else if(str.equals("5")) {
			errorMessage = "Ihr Passwort muss mindestens 8 Zeichen haben.";
		} else if(str.equals("6")) {
			errorMessage = "Falscher Zugangscode!";
		}
		
		out.println("<div style=\"border: 1px solid darkred;background-color: red;margin: 10px;\"><p>" + errorMessage + "</p></div>");
	}
%>

<form action="AdminRegister" method="post">

E-Mail: <input type="email" name="email">
<br>
Passwort: <input type="password" name="password">
<br>
Zugangscode:
<input type="text" name="zugangscode">
<br>
<input type="submit" value="Registrieren">
</form>

</body>
</html>