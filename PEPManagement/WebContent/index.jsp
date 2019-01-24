<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    boolean loggedIn = false;
    if(request.getAttribute("loggedin") != null) {
		loggedIn = ((Boolean) request.getAttribute("loggedin")).booleanValue();
    }
    int rank = 0;
    if(request.getAttribute("rank") != null) {
    	rank = ((Integer) request.getAttribute("rank")).intValue();
    }
    int teamID = -1;
    if(request.getAttribute("teamID") != null) {
    	teamID = ((Integer) request.getAttribute("teamID")).intValue();
    }
    
    %>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">  
<title>PEP Management </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="theme.css" type="text/css">
</head>

<body>
	<header>

			<div class="py-2 px-2 mb-0">
					<div class="container-fluid logo border border-dark">
						<nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
							<a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
								<img class="log" src="logo_u_s.png" width="180">
							</a>
							<h1 class="nav-item m-auto"><b>Planungs- und Entwicklungsprojekt</b></h1>
			
								<%
								{
								pepmanagement.AccountControl.UserRank r = pepmanagement.AccountControl.UserRank.STUDENT;
								if(rank == 1) r = pepmanagement.AccountControl.UserRank.JUROR;
								if(rank == 2) r = pepmanagement.AccountControl.UserRank.ADMIN;
								String str = pepmanagement.Menu.getMenu(r);
								out.println(str);
								}
							%>
						</nav>
					</div>
				</div>			

			<% 
			
				if(loggedIn != false) {%>
				
				
				
			<% 
				if(rank == 0) {
			%>
			
				<div class="row">
				<div class="col-lg-4 col-sm-4 col-0"></div>
				<div class="col-lg-4 col-sm-4 col-12">
					<% if(teamID == -1) { %>
					<h2><a href="StudentSelectTeam">Team auswählen</a></h2>
					<% } else { %>
					<h2><a href="StudentUpload">Dateien hochladen</a></h2>
					<% } %>
				</div>
				<div class="col-lg-4 col-sm-4 col-0"></div>
			</div>
			
			<%
				}
			%>
				<% if(rank == 2) { %>
	
				<div class="row">
					<div class="col-xl-4 col-sm-4 col-0"></div>
					<div class=" text-center col-xl-4 col-sm-4 col-12">
						<h2>Willkommen Administrator dies ist ihre Startseite</h2>
						<h3 class=" mt-3">Neue Nachricht verfassen</h3>
						<form method="post" action="index">
						<fieldset>
						<legend>Informationen</legend>
						Adressat:<br/><select name="usercat">
									<option value="-1">Alle</option>
									<option value="1">Juroren</option>
									<option value="0">Studenten</option>
								</select>
						<br />
						Team (nur bei Studenten):<br/>
								<select name="userteam">
									<option value="-1">Alle</option>
								</select>
						</fieldset>
						Text:<br/>
						<textarea name="textde"></textarea><br/>
						<input type="button" class="wichtigUp w-25 mt-2 uploadbtn border border-dark" value="Posten">
						</form>
					</div>
					<div class="col-lg-4 col-sm-4 col-0"></div>
				</div>
				
				<% } %>			
			<div class="row">
				<div class="col-lg-4 col-sm-4 col-0"></div>
				<div class="col-lg-4 col-sm-4 col-12">
					<%
						if(request.getAttribute("messages") != null) {
							ArrayList<Database.Message> messages = (ArrayList<Database.Message>) request.getAttribute("messages");
							
							SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy");
							
							for(Database.Message m  : messages) {
								out.print("<fieldset><legend>");
								if(m.getRank() == 0) out.print("An " + (m.getTeam() == -1 ? " Alle Studierenden " : " Ihr Team "));
								if(m.getRank() == 1) out.print("An alle Juroren");
								out.print(format.format( m.getDate()  ));
								out.print("</legend>");
								
								out.print("<p>" + m.getMessageDe() + "</p>");
								
								out.print("</fieldset>");
							}
						}
					%>
				</div>
				<div class="col-lg-4 col-sm-4 col-0"></div>
			</div>
			<% } %>
		</main>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>

