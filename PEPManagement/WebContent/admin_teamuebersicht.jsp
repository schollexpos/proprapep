<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminTeamUebersicht");
}

Database db = new Database();
db.connect();
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Main PEP</title>
</head>

<body class="flex-grow-1">

<%
	if(request.getParameter("error") != null) {
		String str = request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		}
		out.println("<div class=\"errormessage\"><p>" + errorMessage + "</p></div>");
	}
%>

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
                        <li class="nav-item  mx-2">
                            <a class="nav-link" href="index.html">Planungs- und Entwicklungsprojekt</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="team.html">Team</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="#">Upload</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="zuordnung.html">Zuordnung Gruppen</a>
                        </li>
                        <li class="nav-item active mx-2">
                            <a class="nav-link" href="#">Team Übersicht<span class="sr-only">(current)</span></a>
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


    <div class="container-fluid myrow mt-2 p-2">
        <div class="p-2 w-25 " style="min-width:450px;">

            <div class="myrow">
                <p class="" style="height:16px; text-align: left; padding-left: 10px;">
                    Teilnehmeranzahl</p>
            </div>

			<%
	    		
				int min = db.getMinTeamSize();
				int max = db.getMaxTeamSize();
			
			%>
			
			<form action="AdminTeamUebersicht" method="post">
	            <div class="myrow m-0 p-0">
	                <div class="relem1 w-25 m-0 pt-1">
	                    <h5 class="text-left">Minimum</h5>
	                </div>
	                <input id="matrikh" name="min" value="<%=min %>" type="text" class="inputl border border-dark w-50 ">
	
	
	            </div>
	
	            <div class="myrow">
	                <div class="srow">
	                    <div class="relem1 w-25 pt-1">
	                        <h5 class="inlabel">Maximum</h5>
	                    </div>
	                    <input id="matrikh" name="max" value="<%=max %>" type="text" class="inputl border border-dark w-50   ">
	                </div>
	            </div>
	
	            <div class="myrow mt-1">
	                <div class="relem2 w-100">
	                    <input type="submit" class="addi  p-1 border border-dark" style="max-height:50px; min-width:300px; width:410px" value="Ändern">
	                </div>
	            </div>
            </form>
        </div>

        <div class="p-2" style="min-width:500px; width:40%">
            <div class="myrow ">
                <h1 class="m-auto">Team Übersicht</h1>
            </div>
            <div class="myrow mt-3">
                <select class="custom-select inputl w-50 m-auto p-1 border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>
            </div>
            <div class="myrow mt-2">
                <input type="search" placeholder="Projkettitel suchen..." class=" pl-1 suchen ml-auto border border-dark">
                <a href="projektdetail.html" target="_blank" class="standard p-0 senden mr-auto ml-1 border border-dark">Suchen</a>
            </div>
        </div>

        <div class="p-2 pr-2 m-auto" style="width:20%">
            <div class="myrow mt-2">
                <div class="relem2 w-100">
                    <h2><input type="submit" onclick="window.print();" class="addi p-1 border border-dark" style="height:150px;"
                            value="Drucken">
                    </h2>
                </div>
            </div>
        </div>
    </div>

    <div class="p-5 container-fluid h-50 m-auto">
        <div class="row mb-4">
            <div class="table-wrapper-scroll-y m-auto" style="max-height:500px; width:95% ">

                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">Projekttitel</th>
                            <th class="sortable" scope="col">Vorsitzender</th>
                            <th class="sortable" scope="col">Dokumentation Vorhanden</th>
                            <th class="sortable" scope="col">Bestätigt</th>
                            <th class="sortable" scope="col">Kennummer</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<%
                    		//TODO: via get: group stuff
                    			
                    		ArrayList<Pair<Integer, String>> teamListe = db.getTeams();
                    		
                    		for(int i = 0;i < teamListe.size();i++) {
                    			int teamID = teamListe.get(i).x;
                    			
                    			out.print("<tr>");
                    			out.print(" <th scope=\"row\">" + teamListe.get(i).y + "</th>");
                    			out.print("<td>" + db.getTeamVorsitzenderName(teamID) + "</td>");
                    			out.print("<td>Ja</td>");
                    			out.print("<td>Best&auml;tigt</td>");
                    			out.print("<td>" + db.getTeamKennnummer(teamID) + "</td>");
                    			
                    			out.print("</tr>");
                    		}
                    		
                    	%>

                    </tbody>
                </table>

            </div>
        </div>
    </div>


</body>