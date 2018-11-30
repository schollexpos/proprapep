<%@ page import="pepmanagement.Database, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Team PEP</title>
</head>

<body class="flex-grow-1">

    <div class="py-2 px-2 mb-0">
        <div class="container-fluid logo border border-dark">
            <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
                <a class="navbar-brand" href="https://www.uni-siegen.de/start/">
                    <img class="log" src="logo_u_s.png" width="180">

                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="index.html">Planungs- und Entwicklungsprojekt</a>
                        </li>
                        <li class="nav-item active mx-2">
                            <a class="nav-link" href="team.html">Team<span class="sr-only">(current)</span></a>
                        </li>

                        <li class="nav-item mx-2">
                            <a class="nav-link" href="#">Upload</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="zuordnung.html">Zuordnung Gruppen</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="teamuebersicht.html">Team Übersicht</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="zuojuror.html">Bewertung</a>
                        </li>
                    </ul>
                    <form class="form-inline">
                        <a class="nav-link mx-2" href="#">Logout</a>
                    </form>

                </div>
            </nav>
        </div>
    </div>
    <div class="py-1 mt-5">
        <div class="container-fluid">
        	<div class="myrow">
    		<%
			if(request.getParameter("error") != null) {
				String str = request.getParameter("error");
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Datenbankfehler!";
				} else if(str.equals("3")) {
					errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
				}  else if(str.equals("4")) {
					errorMessage = "Das Gew&auml;hlte Team existiert nicht!";
				} 
				
				out.println("<div class=\"errormessage\"><p>" + errorMessage + "</p></div>");
			}
		%>
    	</div>
    
        
        
            <div class="myrow">
                <div class="srow" style="width:800px;">
                    <p class="text-center border border-secondary impmsg">Sie haben sich noch keinem Team zu geordnet!<br>
                        Wählen Sie dringend das von Ihrem Vorsitzendem erstellte Projekt aus!
                    </p>
                </div>
            </div>

			<form action="StudentSelectTeam" method="post">

	            <div class="myrow mt-3">
	                <div class="srow">
	                    <div class="relem1">
	                        <h4 class="inlabel">Projekttitel</h4>
	                    </div>
	                    <div class="relem2">
	                        <select name="teamid" class="custom-select mt-1 p-1 border border-dark"><span>Projekttitel</span>
	                            <option value="-1">Projekt auswählen</option>
	                              <%
			                    	pepmanagement.Database db = new pepmanagement.Database();
			                       	db.connect();
			                       	ArrayList<pepmanagement.Pair<Integer, String>> list = db.getTeams();
			                       	for(int i = 0;i < list.size();i++) {
			                       		pepmanagement.Pair<Integer, String> p =  list.get(i);
			                       		String name = db.getTeamVorsitzenderName(p.x);
			                       		
			                       		out.print("<option value=\"" + p.x + "\">\"" + p.y + "\" Vorsitzender: " + name + "</option>");
			                 
			                       	}
			                    %>
	
	                        </select>
	                    </div>
	                </div>
	            </div>
	
	            <div class="myrow">
	                <div class="srow">
	                    <div class="relem3">
	                        <input type="submit" value="Bestätigen" class="wichtig border border-dark" href="">
	
	                    </div>
	                </div>
	            </div>
            
            </form>

        </div>
    </div>

</body>