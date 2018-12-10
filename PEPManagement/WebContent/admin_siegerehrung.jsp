<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminSiegerehrung");
}

Database db = new Database();
db.connect();

%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Siegerehrung PEP</title>
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

    <div class="container-fluid">
        <div class="row mt-2">
            <div class="col-4"></div>
            <div class="col-4">
            <h2 class="text-center m-auto">Übersicht Siegerehrung</h2>
        </div>
        
        <div class="col-2">
                <select class="custom-select inputl w-50 m-auto p-1 border border-dark"><span>Reihenfolge</span>
                    <option>Aufsteigend</option>
                    <option>Absteigend</option>
                </select>
        </div>
        <form class="col-2" action="AdminSiegerehrung" method="post">
        <input type="submit" class="uploadbtn standard addi border border-dark" name="createPr"  value="Erstelle Präsentation" >
        </form>
        </div>
        <div class="row">
            <div class="col-6 mt-4 px-3 pb-3" style="box-shadow: 15px 0 8px -10px rgb(82, 82, 82)">

                <div class="myrow">
                    <div class="table-wrapper-scroll-y w-100">

                        <table class="table table-hover " id="myTable">
                            <thead>
                                <tr>
                                    <th class="sortable" scope="col">Gruppe 1</th>
                                    <th class="sortable" scope="col">Projekttitel</th>
                                    <th class="sortable" scope="col">Kennnummer</th>
                                    <th class="sortable" scope="col">Punkte</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">Platz 1</th>
                                    <td>Spanverfahren</td>
                                    <td>012412</td>
                                    <td>169</td>
                                </tr>
                                <tr>
                                    <th scope="row">Platz 2</th>
                                    <td>Fahrradfanatik</td>
                                    <td>235346</td>
                                    <td>150</td>
                                </tr>
                                <tr>
                                    <th scope="row">Platz 3</th>
                                    <td>Spahnnungs-entwicklung</td>
                                    <td>0151252</td>
                                    <td>130</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
                <div class="row mt-0">
                    <div class="col-3">
                        <input type="button" class=" w-100 senden border border-dark" value="Drucken">
                    </div>
                </div>

                <div class="myrow mt-4">
                    <div class="table-wrapper-scroll-y w-100">

                        <table class="table table-hover " id="myTable">
                            <thead>
                                <tr>
                                    <th class="sortable" scope="col">Gruppe 2</th>
                                    <th class="sortable" scope="col">Projekttitel</th>
                                    <th class="sortable" scope="col">Kennnummer</th>
                                    <th class="sortable" scope="col">Punkte</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">Platz 1</th>
                                    <td>Spanverfahren</td>
                                    <td>012412</td>
                                    <td>169</td>
                                </tr>
                                <tr>
                                    <th scope="row">Platz 2</th>
                                    <td>Fahrradfanatik</td>
                                    <td>235346</td>
                                    <td>150</td>
                                </tr>
                                <tr>
                                    <th scope="row">Platz 3</th>
                                    <td>Spahnnungs-entwicklung</td>
                                    <td>0151252</td>
                                    <td>130</td>
                                </tr>


                            </tbody>
                        </table>

                    </div>
                </div>
                <div class="row mt-0">
                    <div class="col-3">
                        <input type="button" class=" w-100 senden border border-dark" value="Drucken">
                    </div>
                </div>
            </div>

            <div class="col-6 mt-4 px-3">
                <form class="row" action="AdminSiegerehrung" method="post" enctype="multipart/form-data">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Startfolie</h4>
                    </div>
                      <input type="hidden" name="filename" value="startfolie">
                    <div class="col-5">
                        <div class="input-group">
                            <label class="input-group-btn">
                                <span class="btn btn-default wichtigUp">
                                    Browse... <input type="file" name="file" size="50" style="display: none;" multiple>
                                </span>
                            </label>
                            <input type="text" class="form-control uplout border border-dark" readonly>
                        </div>
                    </div>
                    <div class="col-3">
                        <input type="submit" class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark" value="Upload" style="display:block;">
                    </div>
                </form>
                <div class="row mt-3">
                    <div class="col-3 pt-1">
                        <h5 class="text-right mb-0 mr-2">Platz 3</h5>
                    </div>
                    <div class="col-7 pt-1" style="z-index:-1;">
                        <div class="v-spacer"></div>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 1</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 2</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>

                <form class="row mt-3" action="AdminSiegerehrung" method="post" enctype="multipart/form-data">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Zwischenfolie</h4>
                    </div>
                     <input type="hidden" name="filename" value="zwischen1">
                    <div class="col-5">
                        <div class="input-group">
                            <label class="input-group-btn">
                                <span class="btn btn-default wichtigUp">
                                    Browse... <input type="file" name="file" style="display: none;" multiple>
                                </span>
                            </label>
                            <input type="text" class="form-control uplout border border-dark" readonly>
                        </div>
                    </div>
                    <div class="col-3">
                        <input type="submit" class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark" value="Upload" style="display:block;">
                    </div>
                </form>

                <div class="row mt-3">
                    <div class="col-3 pt-1">
                        <h5 class="text-right mb-0 mr-2">Platz 2</h5>
                    </div>
                    <div class="col-7 pt-1" style="z-index:-1;">
                        <div class="v-spacer"></div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 1</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 2</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>

                <form class="row mt-3" action="AdminSiegerehrung" method="post" enctype="multipart/form-data">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Zwischenfolie</h4>
                    </div>
                     <input type="hidden" name="filename" value="zwischen2">
                    <div class="col-5">
                        <div class="input-group">
                            <label class="input-group-btn">
                                <span class="btn btn-default wichtigUp">
                                    Browse... <input type="file"  name="file" style="display: none;" multiple>
                                </span>
                            </label>
                            <input type="text" class="form-control uplout border border-dark" readonly>
                        </div>
                    </div>
                    <div class="col-3">
                        <input type="submit" class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark" value="Upload" style="display:block;">
                    </div>
                </form>

                <div class="row mt-3">
                    <div class="col-3 pt-1">
                        <h5 class="text-right mb-0 mr-2">Platz 1</h5>
                    </div>
                    <div class="col-7 pt-1" style="z-index:-1;">
                        <div class="v-spacer"></div>
                    </div>

                </div>

                <div class="row ">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 1</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-4">
                        <h4 class="inlabel text-center">Gruppe 2</h4>
                    </div>
                    <div class="col-5">
                        <div class="uplout text-left border border-dark p-1 w-100">Projektitel</div>
                    </div>
                </div>


                <form class="row mt-3" action="AdminSiegerehrung" method="post" enctype="multipart/form-data">
                    <div class="col-4">
                        <h5 class="inlabel text-center">Organisation / Sponsoren</h5>
                    </div>
                     <input type="hidden" name="filename" value="orga">
                    <div class="col-5">
                        <div class="input-group">
                            <label class="input-group-btn">
                                <span class="btn btn-default wichtigUp">
                                    Browse... <input type="file" name="file" style="display: none;" multiple>
                                </span>
                            </label>
                            <input type="text" class="form-control uplout border border-dark" readonly>
                        </div>
                    </div>
                    <div class="col-3">
                        <input type="submit" class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark" value="Upload" style="display:block;">
                    </div>
                </form>
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