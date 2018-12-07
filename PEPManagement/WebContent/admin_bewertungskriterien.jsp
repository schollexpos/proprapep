<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Bewertung Admin</title>
</head>
    		<%
			if(request.getParameter("error") != null) {
				String str = request.getParameter("error");
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Datenbankfehler!";
				} else if(str.equals("3")) {
					errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
				} 
				
				out.println("<div class=\"errormessage\"><p>" + errorMessage + "</p></div>");
			}
		%>
<body class="flex-grow-1">

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
                        <li class="nav-item mx-2">
                            <a class="nav-link" href="zuordnung.html">Zuordnung Gruppen</a>
                        </li>
                        <li class="nav-item  mx-2">
                            <a class="nav-link" href="teamuebersicht.html">Team Übersicht<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active mx-2">
                            <a class="nav-link" href="zuojuror.html">Bewertung<span class="sr-only">(current)</span></a>
                        </li>
                    </ul>
                    <form class="form-inline">
                        <a class="nav-link mx-2" href="#">Logout</a>
                    </form>

                </div>
            </nav>
        </div>
    </div>
    <div class="myrow">
        <div class="container-fluid w-25 h-75 mt-3 ml-0 mr-auto p-4 border-right border-dark" style="box-shadow: 15px 0 8px -10px rgb(82, 82, 82);">

            <h2 class="mt-1 text-center">Juror / Gruppe</h2>
            <div class="myrow mt-4">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 1</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <div class="myrow mt-1">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 2</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <div class="myrow mt-1">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 3</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <div class="myrow mt-1">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 4</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <div class="myrow mt-1">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 5</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <div class="myrow mt-1">
                <h4 class="w-25 mr-auto ml-0 text-center pt-1">Juror 6</h4>

                <select class="w-50 ml-2 mr-auto custom-select  border border-dark"><span>Gruppe</span>
                    <option>Gruppe 1</option>
                    <option>Gruppe 2</option>

                </select>

            </div>

            <p class="impmsg border border-secondary w-75 mt-2" style="font-size:18px;">Bitte erst nach Ablauf der
                Abgabefrist zuteilen!</p>
        </div>

        <div class="w-75 p-4 container-fluid">
            <div class="table-wrapper-scroll-y myrow">
                <table class="table table-hover w-100 ">
                    <thead class="thead">
                        <tr>
                            <th scope="col">Hauptkriterium</th>
                            <th scope="col">Teilkriterium</th>
                            <th scope="col">Skala</th>

                        </tr>
                    </thead>
                    <tbody>
						    <c:forEach items="${kriterien}" var="kriterium">
	       						<tr>
	            					<th scope="row">${kriterium.hauptkriterium}</th>
	            					<td>${kriterium.teilkriterium}</td>
	            					<td>0-${kriterium.maxpunkte}</td>
        						</tr>
   							</c:forEach>
                        
                    </tbody>
                </table>
            </div>
			<form action="AdminBewertungskriterien" method="post">
            <div class="myrow mt-5 p-2 w-100 botbox">
                <div class="w-100 myrow ml-0 mr-auto ">
                    <h4 class="inlabel ml-0 mr-0" style="width:160px">Hauptkriterium</h4>
                    <input id="hauptkriterium" type="text" class="inputl border border-dark w-25 p-1 mt-1 ml-1 mr-auto" name = "hauptkriterium">

                    <h4 class="inlabel ml-0 mr-0" style="width:160px">Teilkriterium</h4>
                    <input id="teilkriterium" type="text" class="inputl border border-dark w-25 p-1 mt-1 ml-1 mr-auto" name = "teilkriterium">
                </div>

                <div class="w-100 myrow mt-1 ml-0 mr-auto">
                    <h5 class="inlabel ml-0 mr-0" style="width:160px">Maximale Punktzahl)</h5>
                    <input id="maxpunkte" type="text" class="inputl border border-dark w-25 p-1 mt-1 ml-1 mr-auto" name = "maxpunkte">

                    <input type="submit" class="border border-dark addi w-25 ml-0" value="Kriterium hinzufügen" style=" min-width:200px; height:40px" name = "addKriterium">
                    
               		<input type="submit" class="border border-secondary dele mr-auto ml-1 " value="Löschen" style="width: 10%; min-width:100px; height:40px" name = "deleteKriterium">
                </div>
                

            </div>
            </form>
        </div>
    </div>
</body>
</html>