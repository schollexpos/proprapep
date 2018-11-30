 <%
 	if(request.getAttribute("list") == null) {
 		response.sendRedirect("StudentUpload");
 	}
 %>
<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Main PEP</title>
</head>

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
            <li class="nav-item mx-2">
              <a class="nav-link" href="#">Planungs- und Entwicklungsprojekt</a>
            </li>
            <li class="nav-item mx-2">
              <a class="nav-link" href="team.html">Team</a>
            </li>
            <li class="nav-item active mx-2">
              <a class="nav-link" href="upload.html">Upload<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item mx-2">
              <a class="nav-link" href="zuordnung.html">Zuordnung Gruppen</a>
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
  
  
  <%
 	ArrayList<Pair<String,String>> list =  (ArrayList<Pair<String,String>>) request.getAttribute("list");
  	
  for(int i = 0;list != null && i < list.size();i++) {
	  
	  out.println("<div class=\"container-fluid mt-5 p-3\"><form action = \"StudentUpload\" method=\"post\" enctype = \"multipart/form-data\"> <div class=\"myrow\">");
	  out.println("<div class=\"col-sm ml-auto\"><h4 class=\"inlabel text-center\">" +  list.get(i).x + "</h4></div>");
	  out.println("<input type=\"hidden\" name=\"filename\" value=\"" + list.get(i).x + "\" />");
	  out.println("<div class=\"col-sm\"><input type = \"file\" name = \"file\" size = \"50\" class=\"iputl p-1 w-100\"></div>");
	  out.println("<div class=\"col-sm\"><input type=\"submit\" class=\"wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark\" value=\"Upload\"></div></div>");
  	  out.println("</form>)<div class=\"myrow\">");
  	  out.println("<p class=\"text-center m-auto\" style=\"height:16px; ; padding-left: 1px;\">Letzter Upload:" + list.get(i).y + "</p></div>"); 
	  out.println("</div>\n");
	  
  }
  
  %>

  </body>
  

