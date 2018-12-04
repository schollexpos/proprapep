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

int group = 1;
try {
	if(request.getAttribute("group") != null) {
		group = Integer.parseInt((String) request.getAttribute("group"));
		if(group < 1 || group > 2) group = 1;
	}
} catch(Exception e) {
	
}

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
                <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
                    <img class="log" src="logo_u_s.png" width="180">
                </a>
                <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

                <div class="dropdown show ml-auto mr-4">
                    <a style="text-decoration:none;" class=" dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="" src="Bilder/Men�.png" width="60">
                    </a>

                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="index.html">Planungs- und Entwicklungsprojekt</a>
                        <a class="dropdown-item" href="team.html">Team</a>
                        <a class="dropdown-item" href="#">Upload</a>
                        <a class="dropdown-item" href="zuordnung.html">Zuordnung Gruppen</a>
                        <a class="dropdown-item" href="teamuebersicht.html">Team �bersicht</a>
                        <a class="dropdown-item " href="zuojuror.html">Bewertung</a>
                        <a class="dropdown-item" href="siegerehrung.html">Siegerehrung</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Logout</a>
                    </div>

                </div>
            </nav>
        </div>
    </div>


    <div class="container-fluid myrow mt-2 p-2">
        <div class="p-2 w-25 col-4" style="">

            <div class="myrow">
                <p class="" style="height:16px; text-align: left; padding-left: 10px;">
                    Teilnehmeranzahl
                </p>
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
	                <input id="matrikh"  name="min" value="<%=min %>" type="text" class="inputl border border-dark w-50 ">
	
	
	            </div>
	
	            <div class="myrow">
	                <div class="srow">
	                    <div class="relem1 w-25 pt-1">
	                        <h5 class="inlabel">Maximum</h5>
	                    </div>
	                    <input id="matrikh"  name="max" value="<%=max %>" type="text" class="inputl border border-dark w-50   ">
	                </div>
	            </div>
	
	            <div class="myrow mt-1">
	                <div class="relem2 w-100">
	                    <input type="submit" formid="teilnehmer" class="addi p-1 w-75 border border-dark" style="max-height:50px; "
	                        value="�ndern">
	                </div>
	            </div>
            </form>
        </div>

        <div class="p-2 m-auto col-4">
            <div class="myrow ">
                <h1 class="m-auto">Team �bersicht</h1>
            </div>
            <div class="myrow mt-3">
                <select id="groupselect" class="custom-select inputl w-50 m-auto p-1 border border-dark" onchange="updateTable();">
             		<%
             			out.print("<option value=\"1\" " + (group == 1 ? "selected" : "") + ">Gruppe 1</option>");
             			out.print("<option value=\"2\" " + (group == 2 ? "selected" : "") + ">Gruppe 2</option>");
             		%>
                </select>
            </div>
            <div class="myrow mt-2">
                <input type="search" placeholder="Projkettitel suchen..." class=" p-1 suchen m-auto border border-dark">

            </div>
        </div>

        <div class="col-4 p-2 pr-2 ml-auto" style="">
            <div class="myrow mt-2">
                <div class="relem2 w-100">
                    <h2><input type="submit" onclick="window.print();" class="addi ml-auto p-1 border border-dark"
                            style="height:150px; max-width: 300px;" value="Drucken">
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
                            <th class="sortable" scope="col">Best�tigt</th>
                            <th class="sortable" scope="col">Kennummer</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<%
                    		//TODO: via get: group stuff
                    			
                    		ArrayList<Database.Team> teamListe = db.getTeams(group);
                    		
                    		for(int i = 0;i < teamListe.size();i++) {
                    			Database.Team team = teamListe.get(i);
                    			
                    			out.print("<tr>");
                    			out.print("<th scope=\"row\"><a href=\"admin_teamdetails.jsp?teamid=" + team.getID() + "\">" + team.getTitel() + "</a></th>");
                    			out.print("<td>" + db.getTeamVorsitzenderName(team.getID()) + "</td>");
                    			out.print("<td>Ja</td>");
                    			out.print("<td>Best&auml;tigt</td>");
                    			out.print("<td>" + team.getKennnummer() + "</td>");
                    			
                    			out.print("</tr>");
                    		}
                    		
                    	%>

                    </tbody>
                </table>

            </div>
        </div>
    </div>

	<script>
		function updateTable() {
			e = document.getElementById("groupselect");
			var strUser = e.options[e.selectedIndex].value;
		
			document.location.href = "AdminTeamUebersicht?group=" + strUser;
		}
	</script>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</body>