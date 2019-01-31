<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminTeamDetails");
}
if(request.getParameter("teamid") == null) {
	response.sendRedirect("AdminTeamUebersicht");
}
    %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="theme.css" type="text/css">
	    <title>Projektdetails PEP</title>
	</head>
	<body class="flex-grow-1">
	<% 
	if(request.getParameter("error") != null || request.getAttribute("error") != null) {
		String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
		String errorMessage = "???";
		if(str.equals("1")) {

			errorMessage = "Füllen Sie alle Felder aus!";
		} else if(str.equals("2")) {

			errorMessage = "Datenbankfehler";
		} else if(str.equals("3")) {
			errorMessage = "Bitte geben sie als Matrikelnummer ausschließlich eine Zahl ein";
		} else if(str.equals("4")) {
			errorMessage = "Nur studentische E-Mail-Adressen der Universität Siegen sind erlaubt!";
		} else {
			errorMessage = "Unbekannter Fehler!";
		}
		
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
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
					<div class="col-sm-2 col-0"></div>

        	<%
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.ADMIN);
					out.println(str);
				%>
      </nav>
    </div>
	    </div>
	    
	    <%
	    Database db = new Database();
		db.connect();
		
		String titel = "";
		String kennnummer = "-";
		int teamID = -1;
		
		try {
			teamID = Integer.parseInt(request.getParameter("teamid"));
			Database.Team team = db.getTeam(teamID);
			kennnummer = team.getKennnummer();
			titel = team.getTitel();
		} catch(Exception e) {
			System.out.println("ach mann.." + request.getParameter("teamid"));
		}
	    	
	    %>
	
	    <div class="container-fluid myrow mt-3 p-4">
	        <div class="myrow w-50 mr-auto ml-0">
	            <h2 class="align-left mr-4 ">Projekttitel</h2>
	            <div class="outlab w-50 text-center" style="min-width:400px;">
	                <h3 class="inlabel text-center"><%=titel %></h3>
	            </div>
	        </div>
	        <div class="w-50 myrow mr-auto ml-0">
	            <h2 class="align-left mr-4">Kennummer</h2>
	            <div class="outlab w-50 text-center" style="min-width:400px;">
	                <h3 class="inlabel text-center"><%=kennnummer %></h3>
	            </div>
	        </div>
	    </div>
	
	    <div class="p-5 container-fluid h-30 m-auto">
	        <div class="row mb-4">
	            <div class="table-wrapper-scroll-y m-auto" style="max-height:500px; width:95% ">
	
	                <table class="table table-striped table-hover " id="myTable">
	                    <thead>
	                        <tr>
	                            <th class="sortable" scope="col">Name</th>
	                            <th class="sortable" scope="col">Vorname</th>
	                            <th class="sortable" scope="col">Vorsitz</th>
	                            <th class="sortable" scope="col">E-Mail</th>
	                            <th class="sortable" scope="col">Matrikelnummer</th>
	                            <th class="sortable" scope="col">Studiengang</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<%
	                    		ArrayList<Integer> list;
	                    		ArrayList<Database.User> users = new ArrayList<Database.User>();
	                    		ArrayList<Database.Student> studenten = new ArrayList<Database.Student>();
	                    		try {
		                    		list = db.getStudentenFromTeam(teamID);
		                    		for(int i = 0; i < list.size();i++) {
		                    			int userID = list.get(i).intValue();
		                    			Database.User user = db.getUser(userID);
		                    			Database.Student student = db.getStudent(userID);
		                    			
		                    			out.println("<tr>");
		                    			out.println("<th class=\"sortable\" id=\"name_" + userID + "\">" + student.getNachname() + "</th>");
		                    			out.println("<td id=\"vorname_" + userID + "\">" + student.getVorname() + "</td>");
		                    			out.println("<td>" + (student.isVorsitz() ? "Ja" : "Nein") + "</td>");
		                    			out.println("<td id=\"email_" + userID + "\">" + user.getEmail() + "</td>");
		                    			out.println("<td>" + student.getMatrikelnummer() + "</td>");
		                    			out.println("<td id=\"studiengang_" + userID + "\">" + student.getStudiengang() + "</td>");
		                    			out.println("</tr>");
		                    			
		                    			users.add(user);
		                    			studenten.add(student);
		                    		}
	                    		} catch(Exception e) {
	                    			out.print(":O");
	                    			list = new ArrayList<Integer>();
	                    		}
	                    		
	                    		
	                    	%>
	
	                    </tbody>
	                </table>
	
	            </div>
	        </div>
	    </div>
	    
	    	    
	    <script>
	    	function updateForm() {
	    		var selected = document.getElementById("matrik").value;
	    		
	    		document.getElementById("vorname").value = document.getElementById("vorname_" + selected).innerHTML;
	    		document.getElementById("name").value = document.getElementById("name_" + selected).innerHTML
	    		document.getElementById("studiengang").value = document.getElementById("studiengang_" + selected).innerHTML;
	    		document.getElementById("email").value = document.getElementById("email_" + selected).innerHTML;
	    	}
	    	
	    </script>
    <div class="container-fluid myrow botbox mt-4 mb-0">

            <form id="student" method="post" action="AdminTeamDetails" class="col-12 row">
                <div class="col-4 mt-2">
    
                    <div class="row mt-1">
                        <div class="col-4 p-1">
                            <h4 class="inlabel text-left">Matrikel-Nr.</h4>
                        </div>
                        <div class="col-7 pr-4">
                        		<input type="hidden" name="team" value="<% out.print(teamID); %>">
                                <select id="matrik" name="matrikelnummer" class="custom-select mw-200 w-100 border border-dark" onchange="updateForm();">
                                  <%
                                  try {
	                                  for(int i = 0; i < list.size();i++) {
			                    			int userID = list.get(i).intValue();
			                    			out.println("<option value=\"" + userID +"\">" + studenten.get(i).getMatrikelnummer() + "</option>");
	                                  }
                                  } catch(Exception e) {
                                	  
                                  }
                                  %>
                                </select>
                        </div>
    
                    </div>
    
                    <div class="row mt-1">
                        <div class="col-4 p-1">
                            <h4 class="inlabel text-left">Name</h4>
                        </div>
                        <div class="col-7 pr-4">
                            <input id="name" name="name" type="text" class="mw-200 w-100 border border-dark  p-1 ">
                        </div>
                    </div>
                    
                    
                    <div class="row mt-1">
                        <div class="col-4 p-1">
                            <h4 class="inlabel text-left">Vorname</h4>
                        </div>
                        <div class="col-7 pr-4">
                                <input id="vorname" name="vorname" type="text" class="mw-200 w-100 border border-dark  p-1 ">
                        </div>
                    </div>
                </div>
    
    
               
           
            
           
                <div class="col-4 ">
    
                    <div class="myrow mt-2">
                        <div class="col-4">
                            <h4 class="inlabel p-1 text-left">Studiengang</h4>
                        </div>
                        <div class="col-7">
                            <input id="studiengang" name="studiengang" type="text" class=" mw-200 w-100 border border-dark p-1 mt-1">
                        </div>
    
                    </div>
                    <div class="myrow mt-2">
                            <div class="col-4">
                                <h4 class="inlabel p-1 text-left">E-Mail</h4>
                            </div>
                            <div class="col-7">
                                <input id="email" name="email" type="text" class=" mw-200 w-100 border border-dark p-1 mt-1">
                            </div>
        
                        </div>
    
                </div>
                <div class="col-2"></div>
                <div class="col-2">
                        <div class="row mt-2">
        
                            <input type="submit" formid="lehrstuhl" class="addi sub1 ml-auto p-1 mt-1 border border-dark" value="Ändern">
                        </div>
                        <div class="row mt-2">
        
                            <input type="submit" class="dele sub1 ml-auto p-1 mt-1 border border-secondary" value="Löschen">
        
                        </div>
                    </div>
            <div class=" col-2">

            </div>
        </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
	</body>
</html>