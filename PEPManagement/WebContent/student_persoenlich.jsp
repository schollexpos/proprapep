<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("StudentPersoenlich");
}

Database.User u = (Database.User) request.getAttribute("user");
Database.Student s = (Database.Student) request.getAttribute("student");

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Pers�nliches Teilnehmer PEP</title>
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
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.STUDENT);
					out.println(str);
				%>
      </nav>
    </div>
  </div>
   
        <div class="container-fluid mt-5">
          
           <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">Vorname</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="vornameh" value="<%=s.getVorname() %>" type="text" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
        
          
           <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">Nachname</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="nachnameh" value="<%=s.getNachname() %>" type="text" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
        
           <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">E-Mail</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="mailh" value="<%=u.getEmail() %>" type="email" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
          
          
           <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">Zugang</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                <input id="matrikh" value="<%=s.getMatrikelnummer() %>" type="text" class="w-100 border border-dark p-1 mt-1">
              </div>
            </div>
          
      
      <div class="col-sm mt-3">
        <h4 class="inlabel text-center">Passwort �ndern</h4>
      </div>
      	<form action="StudentPersoenlich" method="post">
            
            <div class="row">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h5 class="inlabel pt-2">Altes Passwort</h5>
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
		            <h5 class="inlabel pt-1">Neues Passowrt wdh.</h5>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
                  <input id="passworthw" name="newpw2" type="password" class="w-100 border border-dark p-1 mt-1">
                </div>
               </div>
         <div class="row mt-2">
		        <div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
		          <div  class="col-xl-4 col-sm-8 col-12 ">
          <input type ="submit" class="fstil wichtigUp uploadbtn border border-dark" style="width:95%;" value ="Passwort �ndern" >
        </div>
        </div>
        </form>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
    crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
    crossorigin="anonymous"></script>
</body>

</html>