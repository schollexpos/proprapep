<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="pepmanagement.Bewertungskriterium,pepmanagement.Database.Team,pepmanagement.Database,java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Juror Bewertung</title>
</head>

<%	
	Database db = new Database();
	db.connect();
	
	if(request.getParameter("error") != null) {
		String str = (String) request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1") || str.equals("7")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Sie müssen zunächst ein Team auswählen!";
		} else if(str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		} 
		
		out.println("<div class=\"errormessage\"><p>" + errorMessage + "</p></div>");
	}
	
%>


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
                  <a class="nav-link" href="#">Planungs- und Entwicklungsprojekt</a>
                </li>
                <li class="nav-item mx-2">
                  <a class="nav-link" href="team.html">Team</a>
                </li>
                <li class="nav-item active mx-2">
                  <a class="nav-link" href="upload.html">Upload<span class="sr-only">(current)</span></a>
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
    <form action="JurorBewertung" method="post">
    
    <div class="container-fluid myrow mt-2 p-2">
        <div class="col-sm ml-auto">
        </div>
        <div class="col-sm m-auto">
            <div class="myrow ">
                <h1 class="m-auto">Bewertung Übersicht</h1>
            </div>
            <div class="myrow m-auto p-2">
            <%
            int jurorID = (Integer) request.getAttribute("jurorID");
    		int jurorGruppe = db.getJurorGruppe(jurorID);

            ArrayList<Team> teamList = (ArrayList<Team>) db.getTeams(jurorGruppe);
            %>
            
            	<form name = "form1" action="JurorBewertung">
	                <select class="custom-select inputl w-50 m-auto p-1 border border-dark" id = "teamid" name="teamid" onchange="changeTeam();">
	                  <option selected="">Team auswählen</option>
	                
	                <%
	                	for (int j = 0;j<teamList.size(); j++){
		                    out.println("<option>" + teamList.get(j).getID() + "</option>");						
	                	}		                    
		            %>                 
                  
                </select>
                
                </form>  
                
               
            </div>
        </div>
        
        
        <div class="col-sm mr-auto">
        </div>
    </div>
	<%int team = -1;
	if(request.getParameter("team") != null) {
		team = Integer.valueOf(request.getParameter("team"));
	} %>
    <div class="p-5 container-fluid h-50 m-auto">
        <div class="row mb-4">
            <form action="JurorBewertung" method="post">
        
            <div class="table-wrapper-scroll-y m-auto" style="max-height:500px; width:95% ">
            	<%if (team == -1){
            		out.println("<h1>Noch kein Team ausgewählt!</h1>");            		
            	} else {
            		out.println("<h1>Ausgewähltes Team:" + db.getTeamTitel(team) + " </h1>");  
            	}
            	
            	%>
				
                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">Hauptkriterium</th>
                            <th class="sortable" scope="col">Teilkriterium</th>
                            <th class="sortable" scope="col">Bewerten</th>
                            <th class="sortable" scope="col">Maximale Punktzahl</th>
                            <th class="sortable" scope="col">Aktuelle Punktzahl</th>
                            
                        </tr>
                            
                    <tbody>
							<%
                    		
                    		ArrayList<Bewertungskriterium> kriterien = db.getKriterien();
                    		
                			for (int i = 0; i<kriterien.size(); i++){
	       						out.println("<tr>");
	       						out.println("<th scope=\"row\">"+ kriterien.get(i).getHauptkriterium() +"</th>");	
	       						out.println("<td>" + kriterien.get(i).getTeilkriterium() + "</td>");
	       						out.println("<td><input type=\"number\" name=\"punktzahl" + i  + "\"" +  " min=\"0\" max=" + kriterien.get(i).getMaxpunkte() + "></td>");
	       						out.println("<td>" + kriterien.get(i).getMaxpunkte() + "</td>");
	       						out.println("<td>" + db.getBewertung(team, kriterien.get(i).getBewertungID()));
	       						out.println("<tr>");

	       						out.println("<input type=\"hidden\" name=\"bewertungid" + i  + "\" value=\""  + kriterien.get(i).getBewertungID() + "\"" + ">");
	       						out.println("<input type=\"hidden\" name=\"tt\" value=\""  + team + "\">");

                			}
                    		                    		
                    		%>


   							
                        
                    </tbody>
                </table>
            </div>
            
            <input type="submit" class="btn btn-primary m-2" value="Bewertung hinzufügen" style="width: 200px; min-width:100px; height:40px" name = "bewerten">
            </form>
            


        </div>
        
    </div>
    </form>
</body>
<script>

      function changeTeam(){
    	  var e = document.getElementById("teamid");
    	  var team = e.options[e.selectedIndex].text;
    	  window.location.href("http://localhost:8080/PEPManagement/JurorBewertung?team=" + team);
      }
</script>

