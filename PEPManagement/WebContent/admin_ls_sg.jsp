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
    <title>Main PEP</title>
</head>

<body class="flex-grow-1">

<%
	if(request.getParameter("error") != null) {
		String str = request.getParameter("error");
		String errorMessage = "???";
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {
			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		}
		out.println("<div class=\"errormessage\"><p>" + errorMessage + "</p></div>");
	}
%>

<%
	Database db = new Database();
	db.connect();
%>

    <div class="py-2 px-2 mb-0">
        <div class="container-fluid logo border border-dark">
            <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
                <a class="navbar-brand" href="https://www.uni-siegen.de/start/">
                    <img class="log" src="logo_u_s.png" width="180">

                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item  mx-2">
                            <a class="nav-link" href="index.html">Planungs- und Entwicklungsprojekt</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="team.html">Team</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="#">Upload</a>
                        </li>
                        <li class="nav-item active mx-2">
                            <a class="nav-link" href="#">Zuordnung Gruppen<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="teamuebersicht.html">Team Übersicht</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="zuojuror.html">Bewertung</a>
                        </li>
                    </ul>
                    <form class="form-inline">
                        <a class="nav-link mx-2" href="#">Logout</a>
                    </form>

                </div>
            </nav>
        </div>
    </div>

    <div class="p-3 container-fluid h-50">
        <div class="row mb-5">
            <div class="table-wrapper-scroll-y mr-2" style="width:55%">

                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">#</th>
                            <th class="sortable" scope="col">Lehrstuhl</th>
                            <th class="sortable" scope="col">Lehrstuhlinhaber</th>
                            <th class="sortable" scope="col">Gruppe</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<%
                    		ArrayList<Pair<Integer, String>> betreuerList = db.getBetreuer();
                    		for(int i = 0;i < betreuerList.size();i++) {
                    			out.print("<tr>");
                    			out.print("<th scope=\"row\">" + (i+1) + "</th>");
                    			out.print("<td>" + db.getBetreuerLehrstuhl(betreuerList.get(i).x) + "</td>");
                    			out.print("<td>" + betreuerList.get(i).y + "</td>");
                    			out.print("<td>Gruppe " + db.getBetreuerGruppe(betreuerList.get(i).x) + "</td>");
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
    <footer class="footer border border-dark py-1">
        <div class="container-fluid myrow ">
        	<form action="AdminLehrstuhlStudiengang" method="post" id="lehrstuhl">
	            <div style="float:left; width:32%">
	                    <div class="myrow mt-2">
	                        <div class="relem1 mr-2">
	                            <h4 class="inlabel ">Lehrstuhl</h4>
	                        </div>
	                        <div class="relem2 w-50">
	                            <input id="lehrstuhlh" name="lehrstuhl" type="text" class="inputl border border-dark  p-1 mt-1">
	                        </div>
	
	                    </div>
	
	                    <div class="myrow">
	                        <div class="relem1 mr-2">
	                            <h5 class="inlabel">Lehrstuhlinhaber</h5>
	                        </div>
	                        <div class="relem2 w-50">
	                            <input id="inhaberh" name="inhaber" type="text" class="inputl border border-dark  p-1 mt-1">
	                        </div>
	                    </div>
	                    <div class="myrow">
	                        <div class="relem1 mr-2">
	                            <h4 class="inlabel">Gruppe</h4>
	                        </div>
	                        <div class="relem2 w-50">
	                            <select name="gruppe" class="custom-select inputl  mt-2 p-1 border border-dark"><span>Gruppe</span>
	                                <option value="1">Gruppe 1</option>
	                                <option value="2">Gruppe 2</option>
	                            </select>
	                        </div>
	                    </div>      
	            	
	            </div>
	
	            <div class="mr-auto" style="width:18%">
	                <div class="myrow mt-2">
	                    <div class="relem2">
	                        <input type="submit" class="addi p-1 mt-1 border border-dark" value="Lehrstuhl Hinzufügen">
	                    </div>
	                </div>
	                <div class="myrow mt-2">
	                    <div class="relem2">
	                        <input class="dele p-1 mt-1 border border-secondary" value="Lehrstuhl Löschen">
	                    </div>
	                </div>
	            </div>
            </form>
			
			<form action="AdminLehrstuhlStudiengang" method="post">
	            <div class="mr-0 ml-auto" style=" width:26% ">
	                    <div class="myrow mt-2">
	                        <div class="relem1 mr-2">
	                            <h4 class="inlabel ">Studiengang</h4>
	                        </div>
	                        <div class="relem2 w-50">
	                            <input id="studiengangh" name="studiengang" type="text" class="inputl border border-dark w-50 p-1 mt-1">
	                        </div>
	
	                    </div>
	
	            </div>
	            
	
	            <div class="mr-0" style=" width:18%">
	                <div class="myrow mt-2">
	                    <div class="relem2">
	                        <input type="submit" formid="studiengang" class="addi p-1 mt-1 border border-dark" value="Studiengang Hinzufügen">
	                    </div>
	                </div>
	                <div class="myrow mt-2">
	                    <div class="relem2">
	                        <input class="dele p-1 mt-1 border border-secondary" value="Studiengang Löschen">
	                    </div>
	                </div>
	            </div>
            </form>
        </div>
    </footer>
    <script>
        $(document).ready(function () {
            $('myTable').DataTable({
                select: true
            });
        });

        function savedata1() {

            var obj = $('myTable tbody tr').map(function () {
                var $row = $(this);
                var t1 = $row.find(':nth-child(1)').text();
                var t2 = $row.find(':nth-child(2)').text();
                var t3 = $row.find(':nth-child(3)').text();
                return {
                    td_1: $row.find(':nth-child(1)').text(),
                    td_2: $row.find(':nth-child(2)').text(),
                    td_3: $row.find(':nth-child(3)').text()
                };
            }).get();
        }
    </script>
</body>