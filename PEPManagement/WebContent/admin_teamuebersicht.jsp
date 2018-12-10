<%@ page import="pepmanagement.Database, pepmanagement.Menu, pepmanagement.AccountControl, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
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

System.out.println("Req: " + request.getAttribute("group") + " Group: " + group);

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Teamübersicht PEP</title>
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
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		}
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>



    <div class="py-2 px-2 mb-0">
        <div class="container-fluid logo border border-dark">
            <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
                <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
                    <img class="log" src="logo_u_s.png" width="180">
                </a>
                <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

                     
				<%
					String str = Menu.getMenu(AccountControl.UserRank.ADMIN);
					out.println(str);
				%>
            </nav>
        </div>
    </div>
    
    
    	<%
			int min = db.getMinTeamSize();
			int max = db.getMaxTeamSize();
		%>

    <div class="container-fluid myrow mt-2 p-2">
        <div class="col-sm m-auto">
        	<form action="AdminTeamUebersicht" method="post">
	            <div class="myrow">
	                <div class="col-sm m-auto">
	                    <h4 class="inlabel text-left">Teilnehmeranzahl</h4>
	                </div>
	            </div>
	
	            <div class="myrow p-1">
	                <div class="col-sm m-auto">
	                    <h5 class="inlabel text-left">Minimum</h5>
	                </div>
	                <div class="col-sm">
	                    <input type="text" name="min" value="<%=min %>" class ="iputl p-1 w-100">
	                </div>
	            </div>
	
	            <div class="myrow p-1">
	                <div class="col-sm m-auto">
	                    <h5 class="inlabel text-left">Maximum</h5>
	                </div>
	                <div class="col-sm">
	                    <input type ="text" name="max" value="<%=max %>" class ="iputl p-1 w-100">
	                </div>
	            </div>
	            <div class="myrow p-1">
	                <div class="col-sm">
	                    <input type ="submit" class="wichtigUp w-100 mr-auto ml-0 uploadbtn border border-dark" value ="Ändern" >
	                </div>
	            </div>
            </form>
        </div>

        <div class="col-sm m-auto">
            <div class="myrow ">
                <h1 class="m-auto">Team Übersicht</h1>
            </div>
            <div class="myrow mt-3">
                <select class="custom-select inputl w-50 m-auto p-1 border border-dark" id="groupselect" onchange="updateTable();">
                	<%
             			out.print("<option value=\"1\" " + (group == 1 ? "selected" : "") + ">Gruppe 1</option>");
             			out.print("<option value=\"2\" " + (group == 2 ? "selected" : "") + ">Gruppe 2</option>");
             		%>

                </select>
            </div>
            <div class="myrow mt-2">
                <input type="text" id="searchinput" onkeyup="searchtable()" placeholder="Projekttitel suchen..." class=" p-1 mw-200 suchen m-auto w-50 border border-dark">

            </div>
        </div>

        <div class="col-sm m-auto">
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

                <table class="table table-hover " id="teamtable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">Projekttitel</th>
                            <th class="sortable" scope="col">Vorsitzender</th>
                            <th class="sortable" scope="col">Dokumentation Vorhanden</th>
                            <th class="sortable" scope="col">Bestätigt</th>
                            <th class="sortable" scope="col">Kennummer</th>
                            <th class="sortable" scope="col">Details</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                       <%
                       ArrayList<Database.Team> teamListe = db.getTeams(group);
               		
	               		for(int i = 0;i < teamListe.size();i++) {
	               			Database.Team team = teamListe.get(i);
	               			
	               			out.print("<tr>");
	               			out.print("<th scope=\"row\">" + team.getTitel() + "</th>");
	               			out.print("<td>" + db.getTeamVorsitzenderName(team.getID()) + "</td>");
	               			out.print("<td>Ja</td>");
	               			if(!team.getKennnummer().equals("-1")) {
		               			out.print("<td>Best&auml;tigt</td>");
		               			out.print("<td>" + team.getKennnummer() + "</td>");
	               			} else {
		               			out.print("<td><a href=\"AdminTeamUebersicht?team=" + team.getID() + "\">Best&auml;tigen</a></td>");
		               			out.print("<td> - </td>");
	               			}
	               			
	               			out.print("<td><a href=\"AdminTeamDetails?teamid=" + team.getID() + "\">Details</a></td>");
	               			
	               			out.print("</tr>");
	               		}
               		
                       %>
                       <tr id="noresults" style="display: none;">
                       		<th colspan="6" style="text-align: center;">Keine Ergebnisse</th> 
                       </tr>

                    </tbody>
                </table>

            </div>
        </div>
    </div>
    <script>
		function searchtable() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("searchinput");
			filter = input.value.toUpperCase();
			table = document.getElementById("teamtable");
			tr = table.getElementsByTagName("tr");
			 
			var results = false;
			for (i = 1; i < tr.length-1; i++) {
				td = tr[i].getElementsByTagName("th")[0];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
						results = true;
					} else {
						tr[i].style.display = "none";
					}
				}
			}
			
			if(!results) {
				document.getElementById("noresults").style.display = "";
			} else {
				document.getElementById("noresults").style.display = "none";
			}
		}
            
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

</html>