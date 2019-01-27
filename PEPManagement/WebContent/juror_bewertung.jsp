<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page
	import="pepmanagement.Bewertungskriterium,pepmanagement.Database.Team,pepmanagement.Database,java.util.*,pepmanagement.FileManager"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("JurorBewertung");
}
    %>
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
	
	 
	int jurorID = (Integer) request.getAttribute("jurorID");
    int jurorGruppe = db.getJurorGruppe(jurorID);
    
     if(request.getParameter("error") != null || request.getAttribute("error") != null) {
 		String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
		String errorMessage = "???";
		if(str.equals("1") || str.equals("7")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Sie müssen zunächst ein Team auswählen!";
		} else if(str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		} else if(str.equals("9")){
				errorMessage = ">Sie wurden bisher keiner Gruppe zugeteilt! Melden sie sich beim Administrator, wenn dies ein Fehler ist.";
		} else if(str.equals("10")){
			errorMessage = "Die Bewertung ist nicht offen!";
		}
		
		
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
		
	} else if(jurorGruppe == -1) {
		out.println(pepmanagement.Menu.getErrorMessage("<div class=\"errormessage\"><p>Sie wurden bisher keiner Gruppe zugeteilt! Melden sie sich beim Administrator, wenn dies ein Fehler ist.</p></div>"));
	}
	
%>


<body class="flex-grow-1">
	<div class="py-2 px-2 mb-0">
		<div class="container-fluid logo border border-dark">
			<nav
				class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
				<a class="navbar-brand mr-auto"
					href="https://www.uni-siegen.de/start/"> <img class="log"
					src="logo_u_s.png" width="180">
				</a>
				<h1 class="nav-item m-auto ">
					<b>Planungs- und Entwicklungsprojekt</b>
				</h1>

				<%
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.JUROR);
					out.println(str);
				%>
			</nav>
		</div>
	</div>


	<div class="container-fluid mt-2 p-2">


		<div class="row ">

			<div class="col-12">

				<h1 class="text-center">Bewertungen</h1>
			</div>
		</div>


		<%
           
            int team = -1;
        	if(request.getParameter("team") != null) {
        		try {
        			team = Integer.valueOf(request.getParameter("team"));
        		} catch(Exception e) {
        			team = -1;
        		}
        	}

            ArrayList<Team> teamList = (ArrayList<Team>) db.getTeams(jurorGruppe);
            %>












		<div class="myrow">
			<div class="col-lg-9 col-12 p-2">
				<form action="JurorBewertung" method="post">

					<div class="table-wrapper-scroll-y m-auto"
						style="max-height: 500px">
						<%if (team == -1){
            		out.println("<h1>Noch kein Team ausgewählt!</h1>");            		
            	} else {
            		Team t = db.getTeam(team);
            		out.println("<h1>Ausgewähltes Team: " + t.getKennnummer() + " - " + t.getTitel() + " </h1>");  
            		
            	}
            	ArrayList<String> hauptkriterien = (ArrayList<String>) request.getAttribute("hauptkriterien");
            	%>

						<table class="table table-hover " id="myTable">

							<%
					for(int j = 0; j<hauptkriterien.size(); j++) {
                  			int summeAktuell = 0;
                  			int summeGesamt = 0;
                  			
                   		ArrayList<Bewertungskriterium> kriterien = db.getKriterien();
                   		out.println("<thead class=\"thead-dark\">");
                   		out.println("<th class=\"sortable\" scope=\"col\">" + hauptkriterien.get(j) + "</th>");
                   		out.println("<th class=\"sortable\" scope=\"col\">" + "Bewerten" + "</th>");
                   		out.println("<th class=\"sortable\" scope=\"col\">" + "Skala" + "</th>");
                   		out.println("<th class=\"sortable\" scope=\"col\">" + "Aktuelle Punktzahl" + "</th>");
                   		out.println("<tbody>");
               			for (int i = 0; i<kriterien.size(); i++){
               				if (!kriterien.get(i).getHauptkriterium().equals(hauptkriterien.get(j))){
               					continue;
               				}else{
               					
	       						out.println("<tr>");			       					
	       						out.println("<td>" + kriterien.get(i).getTeilkriterium() + "</td>");
	       						out.println("<td><input type=\"number\" name=\"punktzahl" + i  + "\"" +  " min= " + kriterien.get(i).getMinpunkte() + "\" max=" + kriterien.get(i).getMaxpunkte() + "></td>");
	       						out.println("<td>" + kriterien.get(i).getMinpunkte() + "-" + kriterien.get(i).getMaxpunkte() + "</td>");
	       						out.println("<td>" + db.getBewertung(team, kriterien.get(i).getBewertungID()));
	       						out.println("<tr>");

	       						out.println("<input type=\"hidden\" name=\"bewertungid" + i  + "\" value=\""  + kriterien.get(i).getBewertungID() + "\"" + ">");
	       						out.println("<input type=\"hidden\" name=\"tt\" value=\""  + team + "\">");
								summeAktuell += kriterien.get(i).getMaxpunkte();
								summeGesamt += db.getBewertung(team, kriterien.get(i).getBewertungID());
               				}
               			}
               			out.println();
               			out.println("<th colspan=\"4\">" + "Maximale Punktzahl: " + summeAktuell + "  Erreichte Punktzahl: " + summeGesamt + "</th>");
               			
                  		}
                  		                    		
                  		%>







							</tbody>
						</table>
					</div>
					<div class="row mb-2">
						<div class="col-md-6 col-sm-12">
							<input type="submit"
								class="wichtigUp fstilp-2 uploadbtn border border-dark"
								value="Bewertung hinzufügen" style="height: 40px"
								name="bewerten">
						</div>
					</div>
				</form>



			</div>
			<div class="col-lg-3 col-12 ">

				<div class="row">
					<div class="col-12">
						<h3 class="">Team Auswählen</h3>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<form name="form1" action="JurorBewertung">
							<select class="custom-select w-100 p-1 border border-dark"
								id="teamid" name="teamid" onchange="changeTeam();">
								<option value="-1" <% if(team==-1) out.print(" selected"); %>>Team
									auswählen</option>

								<%
	                	for (int j = 0;j<teamList.size(); j++){
		                    out.println("<option" + (teamList.get(j).getID() == team ? " selected" : "") +" value=" + teamList.get(j).getID() + ">" + teamList.get(j).getKennnummer() + ": " + teamList.get(j).getTitel() + "</option>");						
	                	}		                    
		            %>

							</select>

						</form>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-12">
						<h3 class="m-auto p-3 ">Downloads</h3>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<a class="blank"
							href="<%=FileManager.getPDFServe(team, FileManager.getFileIdentifier(0))%>">
							<input type="button"
							class="fstil wichtigUp mb-2 p-2 uloadbtn border border-dark"
							value="Dokumentation">
						</a>
					</div>
				</div>

				<div class="row">
					<div class="col-12">
						<a class="blank"
							href="<%=FileManager.getPDFServe(team, FileManager.getFileIdentifier(1))%>">
							<input type="button"
							class="fstil wichtigUp mb-2 p-2 wuloadbtn border border-dark"
							value="Poster">
						</a>
					</div>
				</div>

				<div class="row">
					<div class="col-12">
						<a class="blank"
							href="<%=FileManager.getPDFServe(team, FileManager.getFileIdentifier(2))%>">
							<input type="button"
							class="fstil wichtigUp mb-2 p-2 uloadbtn border border-dark"
							value="Kurzbeschreibung">
						</a>
					</div>
				</div>

				<div class="row">
					<div class="col-12">
						<a class="blank"
							href="<%=FileManager.getPDFServe(team, FileManager.getFileIdentifier(3))%>">
							<input type="button"
							class="fstil wichtigUp mb-2 p-2 uloadbtn border border-dark"
							value="Präsentation">
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
      function changeTeam(){
    	  var e = document.getElementById("teamid");
    	  var team = e.options[e.selectedIndex].value;
    	  window.location.href = "http://localhost:8080/PEPManagement/JurorBewertung?team=" + team;
      }
</script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>


</body>