<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList, java.util.HashMap" %>
<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>Gewinnerteams</title>
</head>
<body onload="window.print();">

<%
	Database db = new Database();
	db.connect();


	for(int gruppe = 1;gruppe <= 2;gruppe++) {
	    ArrayList<String> teams = db.getOrderedTeams(gruppe);
	    
	    out.println("<h1>Gewinnerteams aus Gruppe " + gruppe + "</h1>");
		
	    out.print("<table class=\"table table-bordered\"><thead><tr><th scope=\"col\">Platz</th><th scope=\"col\">Kennnummer</th><th scope=\"col\">Titel</th><th scope=\"col\">Punkte</th></tr></thead>");
	    out.print("<tbody>");
		for(int i = 0;i < teams.size() && i < 3;i++) {
			String [] currTeam = teams.get(i).split("#");
			int teamID = Integer.parseInt(currTeam[1]);
			Database.Team team = db.getTeam(teamID);
			ArrayList<Integer> studenten = db.getStudentenFromTeam(teamID);
			
			out.print("<tr>");
			out.print("<th scope=\"row\">" + (i + 1) + "</th>");
			out.print("<td>" + team.getKennnummer() + "</td>");
			out.print("<td>"+ team.getTitel() +"</td>");
			out.print("<td>"+ currTeam[2] +"</td>");
			out.print("</tr>");
			
			out.print("<tr>");
			out.print("<th scope=\"row\">Studenten</th>");
			out.print("<th scope=\"col\">Matrikelnummer</th>");
			out.print("<th scope=\"col\">Vorname</th>");
			out.print("<th scope=\"col\">Nachname</th>");
			out.print("</tr>");
			
			for(int n = 0;n < studenten.size();n++) {
				Database.Student student = db.getStudent(studenten.get(n).intValue());
				
				out.print("<tr>");
				out.print("<th scope=\"row\"></th>");
				out.print("<th scope=\"row\"> " + student.getMatrikelnummer() + "</th>");
				out.print("<td>" + student.getVorname() + "</td>");
				out.print("<td>" + student.getNachname() + "</td>");
				out.print("</tr>");
			}
			
			
		}
		out.print("</tbody></table>");
	}
		
	

%>

</body>
</html>