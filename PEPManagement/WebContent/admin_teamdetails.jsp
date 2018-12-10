<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminTeamDetails");
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
			errorMessage = "Datenbankfehler";
		} else if(str.equals("2")) {
			errorMessage = "Es gab einen Fehler!";
		} else {
			errorMessage = "Unbekannter Fehler!";
		}
		
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>
	
	    <div class="py-2 px-2 mt-0">
	        <    <div class="container-fluid logo border border-dark">
      <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
        <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
          <img class="log" src="logo_u_s.png" width="180">
        </a>
        <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

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
	
	    <div class="p-5 container-fluid h-75 m-auto">
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
	                    		
	                    		try {
	                    			

		                    		ArrayList<Integer> list = db.getStudentenFromTeam(teamID);
		                    		for(int i = 0; i < list.size();i++) {
		                    			int userID = list.get(i).intValue();
		                    			Database.User user = db.getUser(userID);
		                    			Database.Student student = db.getStudent(userID);
		                    			out.println("<tr>");
		                    			out.println("<th class=\"sortable\">" + student.getNachname() + "</th>");
		                    			out.println("<td>" + student.getVorname() + "</td>");
		                    			out.println("<td>" + (student.isVorsitz() ? "Ja" : "Nein") + "</td>");
		                    			out.println("<td>" + user.getEmail() + "</td>");
		                    			out.println("<td>" + student.getMatrikelnummer() + "</td>");
		                    			out.println("<td>" + student.getStudiengang() + "</td>");
		                    			out.println("</tr>");
		                    		}
	                    		} catch(Exception e) {
	                    			out.print(":O");
	                    		}
	                    		
	                    		
	                    	%>
	
	                    </tbody>
	                </table>
	
	            </div>
	        </div>
	    </div>
	    
	    
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
	</body>
</html>