<%@ page import="pepmanagement.Database, java.sql.Date, java.text.SimpleDateFormat, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminConfig");
}

Database db = new Database();
db.connect();

Date deadlineReg = db.getDeadlineRegistrierung();
Date deadlineUp = db.getDeadlineUpload();
String zcS = db.getStudentZugangscode();
String zcJ = db.getJurorZugangscode();
String zcA = db.getAdminZugangscode();
boolean frei = db.bewertungOpen();
    %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Konfiguration PEP</title>
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

    <div class="py-2 px-2 mb-0">
            <div class="container-fluid logo border border-dark">
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

 
  <div class="container-fluid mt-3 p-3">
    <form action="AdminConfig" method="post" class="myrow">
	        <div class="col-sm ml-auto">
	            <h4 class="inlabel text-center">Registrierungsfrist</h4>
	        </div>
	        <div class="col-sm">
	            <input type="date" value="<%=deadlineReg %>" name="register-frist" class="iputl p-1 w-100">
	        </div>
	        <div class="col-sm">
	            <input type="submit" class="wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark" value="ƒndern">
	        </div>
    </form>
</div>

<div class="container-fluid mt-0 p-3">
    <form action="AdminConfig" method="post" class="myrow">
      <div class="col-sm ml-auto">
          <h4 class="inlabel text-center">Abgabefrist</h4>
      </div>
      <div class="col-sm">
          <input type="date" value="<%=deadlineUp %>" name="upload-frist" class ="iputl p-1 w-100">
      </div>
      <div class="col-sm">
          <input type ="submit" class="wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark" value ="ƒndern">
      </div>
  </form>
</div>

<div class="container-fluid mt-0 p-3">
    <form action="AdminConfig" method="post" class="myrow">
        <div class="col-sm ml-auto">
            <h4 class="inlabel text-center">Zugangscode Studenten</h4>
        </div>
        <div class="col-sm">
            <input type ="text" name="zc-student" value="<%=zcS %>" class ="iputl p-1 w-100">
        </div>
        <div class="col-sm">
            <input type ="submit" class="wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark" value ="ƒndern" >
        </div>
    </form>
  </div>

  <div class="container-fluid mt-0 p-3">
    <form action="AdminConfig" method="post" class="myrow">
        <div class="col-sm ml-auto">
            <h4 class="inlabel text-center">Zugangscode Juroren</h4>
        </div>
        <div class="col-sm">
            <input type ="text" name="zc-juror" value="<%=zcJ %>" class ="iputl p-1 w-100">
        </div>
        <div class="col-sm">
            <input type ="submit" class="wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark" value ="ƒndern" >
        </div>
    </form>
  </div>

  <div class="container-fluid mt-0 p-3">
    <form action="AdminConfig" method="post" class="myrow">
        <div class="col-sm ml-auto">
            <h4 class="inlabel text-center">Zugangscode Administratoren</h4>
        </div>
        <div class="col-sm">
            <input type ="text" name="zc-admin" value="<%=zcA %>" class ="iputl p-1 w-100">
        </div>
        <div class="col-sm">
            <input type ="submit" class="wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark" value ="ƒndern" >
        </div>
    </form>
  </div>

  <div class="container-fluid p-3">
    <div class="myrow">
    	<div class="col-sm ml-auto">
            <h4 class="inlabel text-center">Freigabe Bewertung:</h4>
        </div>
        <form action="AdminConfig" method="post" class="col-sm">
        	<input type="hidden" name="freigabe" value="jabitte">
            <input type="submit" class="wichtigUp w-100 mr-auto ml-0 uploadbtn border border-dark" value ="<% out.print((frei ? "Schliessen" : "Freigeben")); %>" >
        </form>
        <div class="col-sm">
        </div>
    </div>
    <div class="myrow mt-6">
        <div class="col-sm ml-auto">
        </div>
        <div class="col-sm mt-3">
            <h3 class="inlabel text-center">Semester Abschlieﬂen?</h3>
            <input type ="button" class="wichtigUp w-100 mr-auto mt-1 wichtigUpbtn border border-dark" value ="Semster Abschlieﬂen!" >
        </div>
        <div class="col-sm">
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