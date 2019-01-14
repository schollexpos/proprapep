<%@ page import="pepmanagement.Database, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="theme.css" type="text/css">
	    <title>Team PEP</title>
	</head>
<body class="flex-grow-1">

    <div class="py-2 px-2 mb-0">
         <div class="container-fluid logo border border-dark">
      <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
        <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
          <img class="log" src="logo_u_s.png" width="180">
        </a>
        <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

        	<%
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.STUDENT);
					out.println(str);
				%>
      </nav>
    </div>
    </div>
    <div class="py-1 mt-5">
        <div class="container-fluid">
        	<div class="myrow">
    		<%
    		if(request.getParameter("error") != null || request.getAttribute("error") != null) {
    			str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Datenbankfehler!";
				} else if(str.equals("3")) {
					errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
				}  else if(str.equals("4")) {
					errorMessage = "Das gew&auml;hlte Team existiert nicht!";
				}  else if(str.equals("5")) {
					errorMessage = "Das gew&auml;hlte Team ist voll!";
				} 
				
				out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
			}
		%>
    	</div>
    
        
        
            <div class="row mt-2">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-4 col-sm-8 col-12 ">
                    <p class="text-center border border-secondary impmsg">Sie haben sich noch keinem Team zu geordnet!<br>
                        Wählen Sie dringend das von Ihrem Vorsitzendem erstellte Projekt aus!
                    </p>
                </div>
            </div>

			<form action="StudentSelectTeam" method="post">

	           <div class="row mt-2">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12">
		            <h4 class="inlabel pt-2">Projekttitel</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
	                        <select name="teamid" class="custom-select w-100 mt-1 p-1 border border-dark"><span>Projekttitel</span>
	                            <option value="-1">Projekt auswählen</option>
	                              <%
			                    	pepmanagement.Database db = new pepmanagement.Database();
			                       	db.connect();
			                       	ArrayList<Database.Team> list = db.getTeams();
			                       	for(int i = 0;i < list.size();i++) {
			                       		Database.Team t =  list.get(i);
			                       		String name = db.getTeamVorsitzenderName(t.getID());
			                       		
			                       		out.print("<option value=\"" + t.getID()+ "\">\"" + t.getTitel() + "\" Vorsitzender: " + name + "</option>");
			                 
			                       	}
			                    %>
	
	                        </select>
	                    </div>
	                </div>
	            
	
	             <div class="row mt-2">
		        <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-4 col-sm-8 col-12 ">
	                        <input type="submit" value="Bestätigen" class="wichtig border border-dark" href="">
	
	                    </div>
	                </div>
	            
            
            </form>

        </div>
    </div>

</body>