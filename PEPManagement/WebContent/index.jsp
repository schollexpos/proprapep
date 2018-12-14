<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">  
<title>PEP Management </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body style="background-color: #5580ae;">
	<div class="container" style="background-color: white;">
		<header>
			<div class="row">
				<div class="col">
					<nav class="navbar navbar-expand-lg navbar-light bg-light">
					  <a class="navbar-brand" href="#">PEP</a>
					  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					    <span class="navbar-toggler-icon"></span>
					  </button>
					
					  <div class="collapse navbar-collapse" id="navbarSupportedContent">
					    <ul class="navbar-nav mr-auto">
					      <li class="nav-item active">
					        <a class="nav-link" href="#">Index <span class="sr-only">(current)</span></a>
					      </li>
					      
					      
					      <%	
							if(request.getAttribute("loggedin") != null) {
								boolean loggedIn = ((Boolean) request.getAttribute("loggedin")).booleanValue();
								if(loggedIn) {
									out.println("<li class=\"nav-item dropdown\">");
									out.println("<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownAdmin\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Admin</a>");
									out.println("<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownAdmin\">");
									out.println("<a class=\"dropdown-item\" href=\"AdminLehrstuhlStudiengang\">Admin: Lehrstuhl/Studiengangliste</a>");
									out.println("<a class=\"dropdown-item\" href=\"AdminTeamUebersicht\">Admin: Team�bersicht</a>");
									out.println("<a class=\"dropdown-item\" href=\"AdminBewertungskriterien\">Admin: Bewertungskriterien</a>");
									out.println("<a class=\"dropdown-item\" href=\"AdminSiegerehrung\">Admin: Siegerehrung</a>");
									out.println("<a class=\"dropdown-item\" href=\"AdminConfig\">Fristen/Zugangscodes</a>");
									out.println("</li>");
							        
							        out.println("<li class=\"nav-item dropdown\">");
									out.println("<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownJuror\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Juror</a>");
									out.println("<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownJuror\">");
									out.println("<a class=\"dropdown-item\" href=\"JurorBewertung\">Juror: Bewertung</a>");
									out.println("</li>");
							        
							        out.println("<li class=\"nav-item dropdown\">");
									out.println("<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownStudent\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Student</a>");
									out.println("<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownStudent\">");
									out.println("<a class=\"dropdown-item\" href=\"StudentUpload\">Student: Upload</a>");
									out.println("<a class=\"dropdown-item\" href=\"StudentSelectTeam\">Student: Select Team</a>");
							        out.println("</li>");
									
									out.println("<li class=\"nav-item\"> <a class=\"nav-link\" href=\"Logout\">Logout</a></li>");
								} else {
									out.println("<li class=\"nav-item\"> <a class=\"nav-link\" href=\"login.jsp\">Login</a></li>");
									out.println("<li class=\"nav-item\"> <a class=\"nav-link\" href=\"student_register.jsp\">Registrieren (Student)</a></li>");
									out.println("<li class=\"nav-item\"> <a class=\"nav-link\" href=\"admin_register.jsp\">Registrieren (Admin/Juror)</a></li>");
								}
							}
						%>
					    </ul>
					    <span class="navbar-text">
     						<c:out value='${requestScope.message}'/>
    					</span>
					  
					  </div>
					</nav>
				
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="text-center">
						<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logo_Uni_Siegen.svg/2000px-Logo_Uni_Siegen.svg.png" style="width: 60%;"/>
					</div>
				</div>
			</div>
		</header>
		<main>
			<div class="row">
				<div class="col">
					<h1>Debug-�bersicht:</h1>
					
					<p>Kleinere Infos zum Gebrauch der Seiten:</p>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-md-6">
					<h2>Zugangscodes</h2>
				</div>
				<div class="col-12 col-md-6">
					<table class="table table-dark">
					  <thead>
					    <tr>
					      <th scope="col">Typ</th>
					      <th scope="col">Code</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">Student</th>
					      <td>pep2018</td>
					    </tr>
					    <tr>
					      <th scope="row">Juror</th>
					      <td>jp18_usi</td>
					    </tr>
					    <tr>
					      <th scope="row">3</th>
					      <td>acpepmb</td>
					    </tr>
					  </tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col">
						
					<h2>Info: Dateinamen</h2>
					<p>
						Jetzt als bleibendes Schema: Das Servlet sollte so hei�en wie die JSP (nur mit CamelCase statt_mit_strichen),
						wobei die JSP-Datei mit der Nutzerrolle beginnt (zB. student_upload.jsp). 
					</p>
					
					<h2>Test der Datenbank:</h2>
					<p><%
						try {
							Database db = new Database();
							db.connect();
							
							db.getStudentZugangscode();
							
							out.println("&#10004; Datenbank auf dem aktuellen Stand");
						} catch(Exception e) {
							out.println("&#10060; Datenbank nicht aktuell!");
							System.out.println(e.getMessage());
						}
					%>
					</p>
				</div>
			</div>
		</main>
	
	</div>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>