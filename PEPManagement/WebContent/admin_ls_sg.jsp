<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminLehrstuhlStudiengang");
}
    %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Lehrstuhl/Studiengangübersicht PEP</title>
</head>

<body class="flex-grow-1">

<%
if(request.getParameter("error") != null || request.getAttribute("error") != null) {
	String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		}
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>

<%
	Database db = new Database();
	db.connect();
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

    <div class="p-3 mb-5 container-fluid h-50">
        <div class="row mb-5">
            <div class="table-wrapper-scroll-y mr-2" style="width:55%">

                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">#</th>
                            <th class="sortable" scope="col">Kürzel</th>
                            <th class="sortable" scope="col">Lehrstuhl</th>    
                            <th class="sortable" scope="col">Lehrstuhlinhaber</th>
                            <th class="sortable" scope="col">Gruppe</th>
                        </tr>
                    </thead>
                      <tbody>
                    
                    	<%
                    		ArrayList<Database.Betreuer> betreuerList = db.getBetreuer();
                    		for(int i = 0;i < betreuerList.size();i++) {
                    			out.print("<tr>");
                    			out.print("<th scope=\"row\">" + (i+1) + "</th>");
                    			out.print("<td>" + betreuerList.get(i).getKuerzel() + "</td>");
                    			out.print("<td>" + betreuerList.get(i).getLehrstuhl() + "</td>");
                    			out.print("<td>" + betreuerList.get(i).getName() + "</td>");
                    			out.print("<td>Gruppe " + betreuerList.get(i).getGruppe() + "</td>");
                    			out.print("</tr>");
                    		}
                    	
                    	%>
                      
                    </tbody>
                </table>

            </div>

            <div class="table-wrapper-scroll-y ml-auto" style="width:40%;">

                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">#</th>
                            <th class="sortable" scope="col">Studiengang</th>

                        </tr>
                    </thead>
                    <tbody>
                    	<%
                    		ArrayList<String> studiengangliste = db.getStudiengaenge();
                    		for(int i = 0;i < studiengangliste.size();i++) {
                    			out.print("<tr>");
                    			out.print("<th scope=\"row\">" + (i+1) + "</th>");
                    			out.print("<td>" + studiengangliste.get(i) + "</td>");
                    			out.print("</tr>");
                    		}
                    	%>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
    
        <div class="container-fluid myrow botbox mt-4 mb-0">
     
           
        	<form action="AdminLehrstuhlStudiengang" method="post" id="lehrstuhl" class="col-6 row">
	            <div class="col-8 mt-2">
	                    <div class="row mt-1">
	                        <div class="col-4 p-1">
	                            <h4 class="inlabel text-left">Lehrstuhl</h4>
	                        </div>
	                        <div class="col-7 pr-4">
	                            <input id="lehrstuhlh" name="lehrstuhl" type="text" class="w-100 mw-200 border border-dark  p-1 ">
	                        </div>
	
	                    </div>
	
	                    <div class="row mt-1">
	                        <div class="col-4 p-1">
	                            <h5 class="inlabel text-left ">Lehrstuhlinhaber</h5>
	                        </div>
	                        <div class="col-7 pr-4">
	                            <input id="lehrstuhlh" name="inhaber" type="text" class="mw-200 w-100 border border-dark  p-1 ">
	                        </div>
	                    </div>
	                    
	                    <div class="row mt-1">
		                    <div class="col-4 p-1">
		                        <h5 class="inlabel text-left ">Lehrstuhlkürzel</h5>
		                    </div>
		                    <div class="col-7 pr-4">
		                        <input id="lehrstuhlh" name="kuerzel" type="text" class="w-100 border border-dark  p-1 " maxlength="2">
		                    </div>
		                </div>
	                    
	                    
	                    <div class="row mt-1">
	                        <div class="col-4 p-1">
	                            <h4 class="inlabel text-left" text-center>Gruppe</h4>
	                        </div>
	                        <div class="col-7 pr-4">
	                            <select name="gruppe" class="custom-select mw-200 w-100 border border-dark"><span>Gruppe</span>
	                                <option value="1">Gruppe 1</option>
	                                <option value="2">Gruppe 2</option>
	
	                            </select>
	                        </div>
	                    </div>
	                    
	            </div>
            

	            <div class="col-4">
	                <div class="row mt-2">
	                    
	                        <input type="submit" formid="lehrstuhl" class="addi p-1 mt-1 border border-dark" value="Lehrstuhl Hinzufügen">
	                                    </div>
	                <div class="row mt-2">
	                    
	                        <input type="submit" class="dele p-1 mt-1 border border-secondary" value="Lehrstuhl Löschen">
	                    
	                </div>
	            </div>
			</form>

			
	        <form id="studiengange" action="AdminLehrstuhlStudiengang" method="post" class="col-6 row">
	            <div class="col-8 ">
	                    <div class="myrow mt-2">
	                        <div class="col-5">
	                        	<h4 class="inlabel p-1 text-right">Studiengang</h4>
	                        </div>
	                        <div class="col-7">
	                            <input id="studiengangh" name="studiengang" type="text" class=" mw-200 w-100 border border-dark p-1 mt-1">
	                        </div>
	
	                    </div>
	            </div>
	            
	
	            <div class=" col-4" >
	                <div class="row mt-2">
	                        <input type="submit" formid="studiengang" class="addi p-1 mt-1 border border-dark" value="Studiengang Hinzufügen">
	                </div>
	                <div class="row mt-2">
	                        <input type="submit" formid="studiengang" class="dele p-1 mt-1 border border-secondary" value="Studiengang Löschen">
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