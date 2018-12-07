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
    <title>Persönliches Teilnehmer PEP</title>
</head>

<body class="flex-grow-1">
  <div class="py-2 px-2 mb-0">
    <div class="container-fluid logo border border-dark">
      <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
        <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
          <img class="log" src="logo_u_s.png" width="180">
        </a>
        <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

        <div class="dropdown show ml-auto mr-3">
          <a style="text-decoration:none;" class="menu-dt" href="#" role="button" id="dropdownMenuLink"
            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <img class="menu-pic" src="Bilder/menu.png" width="60">
          </a>

          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
            <a class="dropdown-item" href="index.html">Planungs- und Entwicklungsprojekt</a>
            <a class="dropdown-item" href="upload.html">Upload Vorsitz</a>
            <a class="dropdown-item" href="upload_übersicht.html">Upload</a>
            <a class="dropdown-item" href="notenübersicht_freigabeErteilt.html">PEP Details</a>
            <a class="dropdown-item" href="persöhnliches.html">Persöhnliches</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Logout</a>
          </div>

        </div>
      </nav>
    </div>
  </div>
    <div class="m-5">
        <div class="container-fluid">
          <div class="myrow">
            <div class="srow">
              <div class="relem1">
                <h4 class="inlabel">Vorname</h4>
              </div>
              <div class="relem2">
                <input id="vornameh" value="<%=s.getVorname() %>" type="text" class="inputl border border-dark p-1 mt-1">
              </div>
            </div>
          </div>
          <div class="myrow">
            <div class="srow">
              <div class="relem1">
                <h4 class="inlabel">Nachname</h4>
              </div>
              <div class="relem2">
                <input id="nachnameh" value="<%=s.getNachname() %>" type="text" class="inputl border border-dark p-1 mt-1">
              </div>
            </div>
          </div>
          <div class="myrow">
            <div class="srow">
              <div class="relem1">
                <h4 class="inlabel">E-Mail</h4>
              </div>
              <div class="relem2">
                <input id="mailh" value="<%=u.getEmail() %>" type="email" class="inputl border border-dark p-1 mt-1">
              </div>
            </div>
          </div>
          </div>
          <div class="myrow">
            <div class="srow">
              <div class="relem1">
                <h4 class="inlabel">Matrikel-Nr.</h4>
              </div>
              <div class="relem2">
                <input id="matrikh" value="<%=s.getMatrikelnummer() %>" type="text" class="inputl border border-dark p-1 mt-1">
              </div>
            </div>
          </div>
      </div>
      <div class="col-sm m-1">
        <h4 class="inlabel text-center">Passwort ändern</h4>
      </div>
      	<form action="StudentPersoenlich" method="post">
            <div class="myrow">
                <div class="srow">
                <div class="relem1">
                    <h5 class="inlabel">Altes Passwort</h5>
                </div>
                <div class="relem2">
                    <input id="passworth" name="oldpw" type="password" class="inputl border border-dark p-1 mt-1">
                </div>
                </div>
            </div>
            <div class="myrow">
            <div class="srow">
              <div class="relem1">
                <h5 class="inlabel">Neues Passwort</h5>
              </div>
              <div class="relem2">
                <input id="passworth" name="newpw1" type="password" class="inputl border border-dark p-1 mt-1">
              </div>
            </div>
            </div>
            <div class="myrow">
              <div class="srow">
                <div class="relem1">
                  <h5 class="inlabel">Neues Passwort Wdh.</h5>
                </div>
                <div class="relem2">
                  <input id="passworthw" name="newpw2" type="password" class="inputl border border-dark p-1 mt-1">
                </div>
              </div>
            </div>
        <div class="col-sm">
          <input type ="submit" class="wichtigUp w-25 m-auto uploadbtn border border-dark" value ="Passwort ändern" >
        </div>
        </form>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
    crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
    crossorigin="anonymous"></script>
</body>