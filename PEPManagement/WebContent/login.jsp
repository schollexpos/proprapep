<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="theme.css" type="text/css">
<title>Anmeldung PEP</title>
</head>
<body class="flex-grow-1">

	<%
	if(request.getParameter("error") != null || request.getAttribute("error") != null) {
		String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "E-Mail/Passwort falsch!";
		} else if(str.equals("543")) {
			errorMessage = "Bitte best&auml;tigen Sie Ihre E-Mail Adresse mit dem Ihnen zugesandten Link!";
		} else if(str.equals("9")) {
			String minutes = "???";
			if(request.getParameter("minutes") != null) minutes = request.getParameter("minutes");
			
			errorMessage = "Zu viele fehlgeschlagene Anmeldeversuche! Versuchen Sie es in " + minutes + " Minuten erneut!";
		}
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}

	String sonderMessage = "";
	if(request.getParameter("plzactivate") != null || request.getAttribute("plzactivate") != null) {
		String str = (request.getParameter("plzactivate") != null ? request.getParameter("plzactivate") : (String) request.getAttribute("plzactivate"));
		if(str.equals("1")) {
			sonderMessage = "Sie haben einen Bestätigungslink per E-Mail erhalten!";
		} else if(str.equals("yay")) {
			sonderMessage = "Bestätigung erfolgreich!";
		} else if(str.equals("no")) {
			sonderMessage = "Bestätigungskey ist falsch!";
		}
	
	}
%>


	<div class="py-2 px-2 mb-0">
		<div class="container-fluid logo border border-dark">
			<nav
				class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">

				<div class="col-sm-3 navbar-brand mr-0">
					<a class="mr-auto" href="https://www.uni-siegen.de/start/"> <img
						class="log" src="logo_u_s.png" width="180">
					</a>
				</div>
				<div class="col-sm-6 col-12 nav-item pt-1">
					<div class="row">
						<h1 class="col-12 text-center mb-0">
							<b>PEP</b>
						</h1>
					</div>
					<div class="row">
						<h5 class="text-center col-12 mt-0">
							<b>Planungs- und Entwicklungsprojekt</b>
						</h5>
					</div>
				</div>
				<div class="col-sm-3 col-0"></div>
			</nav>
		</div>
	</div>
	<div class="py-3 w-100 mt-5">
		<div class="container-fluid text-center">
			<div class="row">
				<h3 class="m-auto col-12">
					Herzlich willkommen beim Planungs- und Entwicklungsprojekt.<br>
					<b>PEP</b><br>
				</h3>
			</div>
		</div>
	</div>

	<% if(!sonderMessage.equals("")) { %>
	<div class="w-100">
		<div class="container-fluid text-center">
			<div class="row">
				<h4 class="m-auto col-12">
					<% out.print(sonderMessage);  %><br />
				</h4>
			</div>
		</div>
	</div>
	<% } %>



	<div class="py-1 mt-2">
		<div class="container-fluid">
			<form action="LoginServlet" method="post">

				<div class="row">
					<div class="col-xl-4 col-sm-2 col-0"></div>
					<div class="col-xl-1 col-sm-3 col-12 mr-2">
						<h4 class="inlabel pt-1">E-Mail</h4>
					</div>
					<div class="col-xl-3 col-sm-5 col-12">
						<input id="emailfield"
							<% if(request.getParameter("email") != null) out.print("value=\"" + request.getParameter("email") + "\""); %>
							placeholder="mail@uni-siegen.de" name="email" type="email"
							class="w-100 border border-dark p-1 mt-1">
					</div>
					<div class="col-xl-4 col-sm-2 col-0"></div>

				</div>

				<div class="row">
					<div class="col-xl-4 col-sm-2 col-0"></div>
					<div class="col-xl-1 col-sm-3 col-12 mr-2">
						<h4 class="inlabel pt-1">Passwort</h4>
					</div>
					<div class="col-xl-3 col-sm-5 col-12">
						<input id="passwordfield" type="password" name="password"
							class="w-100 border border-dark p-1 mt-1">
					</div>
					<div class="col-xl-4 col-sm-2 col-0"></div>

				</div>

				<div class="row mt-2">
					<div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
					<div class="col-xl-2 col-sm-4 col-6">
						<%
	           			if(request.getParameter("returnto") != null) {
	           				out.println("<input type=\"hidden\" name=\"returnto\" value=\"" + request.getParameter("returnto") + "\" />");
	           			}
	           		%>
						<input class="standard border border-dark" type="submit"
							value="Anmelden">
					</div>
					<div class="col-xl-2 col-sm-4 col-6">
						<a class="standard border border-dark"
							href="https://www.uni-siegen.de/start/">Abbrechen</a>
					</div>
					<div class="col-xl-4 col-sm-2 col-0"></div>

				</div>
			</form>

			<div class="row">
				<div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
				<div class="col-xl-4 col-sm-8 col-12">
					<p class=""
						style="height: 16px; text-align: left; padding-top: 10px;">
						Noch keinen Account?</p>
				</div>
			</div>
			<div class="row">
				<div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
				<div class="col-xl-4 col-sm-8 col-12">
					<a class="wichtig w-100 m-0 border border-dark"
						href="student_register.jsp">Registrieren</a>
				</div>

			</div>
		</div>
	</div>
</body>
</html>