<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null && false) {
	response.sendRedirect("AdminTeamDetails");
}
    %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="theme.css" type="text/css">
	    <title>Projektdetails</title>
	</head>
	<body class="flex-grow-1">
	    <div class="py-2 px-2 mt-0">
	        <div class="container-fluid logo my-0 border border-dark">
	            <div class="row text-center pl-2  w-100">
	                <a class="navbar-brand" href="https://www.uni-siegen.de/start/">
	                    <img src="logo_u_s.png" width="180">
	                </a>
	                <div class="relem2 pt-1" style="">
	                    <h1 class="w-100 ml-4" style:="margin:auto; position: fixed;"><b>Planungs- und Entwicklungsprojekt</b></h1>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	    <%
	    Database db = new Database();
		db.connect();
		
		String titel = "";
		int kennnummer = -1;
		int teamID = -1;
		
		try {
			teamID = Integer.parseInt(request.getParameter("teamid"));
			
			titel = db.getTeamTitel(teamID);
			kennnummer = db.getTeamKennnummer(teamID);
			
		} catch(Exception e) {
			
		}
	    	
	    %>
	
	    <div class="container-fluid myrow mt-3 p-4">
	        <div class="myrow w-50 mr-auto ml-0">
	            <h2 class="align-left mr-4 ">Projekttitel</h2>
	            <div class="outlab w-50 text-center" style="min-width:400px;">
	                <h3 class="inlabel text-center">Titel</h3>
	            </div>
	        </div>
	        <div class="w-50 myrow mr-auto ml-0">
	            <h2 class="align-left mr-4">Kennummer</h2>
	            <div class="outlab w-50 text-center" style="min-width:400px;">
	                <h3 class="inlabel text-center">Kennummer</h3>
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
		                    			out.println("<tr>");
		                    			out.println("<th class=\"sortable\">" + db.getStudentNachname(userID) + "</th>");
		                    			out.println("<td>" + db.getStudentVorname(userID) + "</td>");
		                    			out.println("<td>" + (db.studentIsVorsitzender(userID) ? "Ja" : "Nein") + "</td>");
		                    			out.println("<td>" + "jemand@example.com" + "</td>");
		                    			out.println("<td>" + db.getStudentMatrikelnummer(userID) + "</td>");
		                    			out.println("<td>" + db.getStudentStudiengang(userID) + "</td>");
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
	</body>
</html>