<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bewertungskriterien</title>
</head>
<body>
<h1>Bewertungskriterien</h1>

<%
	if(request.getParameter("error") != null) {
		String str = request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {

			errorMessage = "Datenbankfehler!";
		}
	}
%>

<form action="BewertungskriteriumServlet" method="post">

Hauptkriterium: <input type="text" name="hauptkriterium">
<br>
Teilkriterium: <input type="text" name="teilkriterium">
<br>
Maximale Punktzahl: <input type="number" name="maxpunkte">

<input type="submit" value="Bewertung anlegen">
</form>

</body>
</html>