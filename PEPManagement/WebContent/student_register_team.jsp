<%@ page import="pepmanagement.Database, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("StudentRegisterTeam");
}
%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Vorsitz PEP</title>
</head>

<body class="flex-grow-1">
  <div class="py-2 px-2 mb-0" >
    <div class="container-fluid logo my-0 border border-dark" >
    <div class="row text-center pl-2  w-100">
        <a class="navbar-brand" href="https://www.uni-siegen.de/start/">
            <img src="logo_u_s.svg" width="180">
        </a>
        <div class="relem2 pt-1" style="">
        <h1 class="w-100 ml-4" style:="margin:auto; position: fixed;" ><b>Planungs- und Entwicklungsprojekt</b></h1>
      </div>
      </div>
    </div>
  </div>

<div class="py-1 mt-3" >
    <div class="container-fluid">
    	<div class="myrow">
    		<%
    		if(request.getParameter("error") != null || request.getAttribute("error") != null) {
    			String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Datenbankfehler!";
				} else if(str.equals("3")) {
					errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
				} else if(str.equals("4")) {
					errorMessage = "Die Registrierung ist geschlossen!";
				}
				
				out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
			}
		%>
    	</div>
    
        <div class="myrow">
            <div class="srow" style="width:700px;">
                <p class=" impmsg">Da Sie Vorsitzender sind, müssen Sie folgende Informationen zusätzlich angeben und das Anmeldeformular ausdrucken. 
                    <br>Alle Teammitglieder müssen Unterschreiben!</p>
            </div>
        </div>
        
         <form action="StudentRegisterTeam" method="post">

        <div class="myrow mt-3">
                <div class="srow">
                  <div  class="relem1">
                    <h5 class="inlabel" style="font-size:18px;">Erster Betreuer</h5>
                  </div>
                  <div class="relem2">
	                    <select class="custom-select mt-1 p-1 border border-dark" name="betreuer1">
	                    <%
	                    	pepmanagement.Database db = new pepmanagement.Database();
	                       	db.connect();
	                       	ArrayList<Database.Betreuer> list = db.getBetreuer();
	                       	for(int i = 0;i < list.size();i++) {
	                       		Database.Betreuer b =  list.get(i);
	                       		
	                       		out.print("<option value=\"" + b.getID() + "\">" + b.getName() + " " + b.getLehrstuhl() + "</option>");
	                 
	                       	}
	                    %>
	                    </select>
                  </div>
                </div>
              </div>

        <div class="myrow">
             <div class="srow">
                <div  class="relem1">
                    <h5 class="inlabel" style="font-size:18px;">Zweiter Betreuer</h5>
                </div>
                <div class="relem2">
                    <input id="betreuer2h" name="betreuer2" type="text" class="inputl border border-dark p-1 mt-1" >
                </div>
                </div>
            </div>
            
        <div class="myrow">
         <div class="srow">
            <div  class="relem1">
                <h4 class="inlabel">Teamname</h4>
            </div>
            <div class="relem2">
                <input id="teamnameh" name="teamname" type="text" class="inputl border border-dark p-1 mt-1" >
            </div>
        </div>
        </div>

        <div class="myrow">
                <div class="srow" >
                    <div class="relem3">
                    <p class="mt-2 border border-secondary impmsg">Wichtig: Bitte geben Sie den korrekten Betreuer ein. Hiernach werden Lehrstuhl und Gruppe eingeteilt. 
                        <br>Der erste Betreuer ist der jeweilige Lehrstuhlinhaber, alle weiteren gehören dem zweiten Betreuer an</p>
                </div>
            </div>
            </div>

        <div class="myrow mt-3">
            <div class="srow">
                <div  class="relem1">
                    <h4 class="inlabel">Download</h4>
                </div>
                 <div class="relem2">
                    <a class="standard border border-dark" style="width:98%; margin:0;" href="">Formular Herunterladen</a>
                </div>
            </div>
            </div>

            <div class="myrow">
                <div class="srow">
                  <div class="relem3">
        				<input class ="wichtig border border-dark" type="submit" value="Team Registrieren">
                  </div>
                </div>
              </div>
              </form>
    </div>
</div>
  </body></html>