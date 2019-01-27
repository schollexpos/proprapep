<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminPersoenlich");
}

Database.User u = (Database.User) request.getAttribute("user");

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Persönliches Teilnehmer PEP</title>
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
        	pepmanagement.AccountControl.UserRank rank;
        		if(u.isAdmin()) rank = pepmanagement.AccountControl.UserRank.ADMIN; 
        		else rank =  pepmanagement.AccountControl.UserRank.JUROR;
					String str = pepmanagement.Menu.getMenu(rank);
					out.println(str);
				%>
      </nav>
    </div>
  </div>
  <div class="container-fluid p-1">
    	<div class="row mt-5">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">E-Mail</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="mailh" value="<%=u.getEmail() %>" type="email" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
          
      
     <div class="row mt-4">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-4 col-sm-8 col-12 ">
        <h4 class="inlabel text-left">Passwort ändern</h4>
      </div>
      </div>
      	
      	
      	<form action="AdminPersoenlich" method="post">
            
            <div class="row mt-2">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h5 class="inlabel pt-2">ALtes Passwort</h5>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                    <input id="passworth" name="oldpw" type="password" class="w-100 border border-dark p-1 mt-1">
                </div>
                
            </div>
            <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h5 class="inlabel pt-2">Neues Passwort</h5>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="passworth" name="newpw1" type="password" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
           
            <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h5 class="inlabel pt-1">Neues Passwort Wdh.</h5>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                  <input id="passworthw" name="newpw2" type="password" class="w-100 border border-dark p-1 mt-1">
                </div>
              </div>
              
         <div class="row mt-1">
		        <div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
		          <div  class="col-xl-4 col-sm-8 col-12 ">
          <input type ="submit" class="fstil wichtigUp w-100 m-auto uploadbtn border border-dark" value ="Passwort ändern" >
        </div>
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