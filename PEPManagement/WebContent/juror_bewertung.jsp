<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="pepmanagement.Bewertungskriterium,pepmanagement.Database.Team,java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Juror Bewertung</title>
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
    <form action="JurorBewertung" method="post">
    
    <div class="container-fluid myrow mt-2 p-2">
        <div class="col-sm ml-auto">
        </div>
        <div class="col-sm m-auto">
            <div class="myrow ">
                <h1 class="m-auto">Bewertung Übersicht</h1>
            </div>
            <div class="myrow m-auto p-2">
            <%
            int j = 0;
            List<Team> teamList = (List<Team>) request.getAttribute("teams");
            %>
            
            
                <select class="custom-select inputl w-50 m-auto p-1 border border-dark" id = "projekttitel" name="projekttitel">
                	<c:forEach items = "${teams}" var = "team">
	                    <option ><%=teamList.get(j).getTitel()%></option>
	                    <%j++; %>	                   
                    </c:forEach>
                </select>
               
            </div>
        </div>
        
        
        <div class="col-sm mr-auto">
        </div>
    </div>

    <div class="p-5 container-fluid h-50 m-auto">
        <div class="row mb-4">
            <div class="table-wrapper-scroll-y m-auto" style="max-height:500px; width:95% ">

                <table class="table table-hover " id="myTable">
                    <thead>
                        <tr>
                            <th class="sortable" scope="col">Hauptkriterium</th>
                            <th class="sortable" scope="col">Teilkriterium</th>
                            <th class="sortable" scope="col">Bewerten</th>
                            <th class="sortable" scope="col">Maximale Punktzahl</th>
                        </tr>
                            
                    <tbody>
                    		<%
                    		int i = 0;
                    		List<Bewertungskriterium> kriterienList = (List<Bewertungskriterium>) request.getAttribute("kriterien");
                    		%>
						    <c:forEach items="${kriterien}" var="kriterium">
						    	
	       						<tr>
	            					<th scope="row" id = "hauptkriterium<%=i%>>"> <%=kriterienList.get(i).getHauptkriterium()%></th>	            					
	            					<td><%=kriterienList.get(i).getTeilkriterium()%></td>
									<td><input type="number" name="punktzahl<%=i%>" min="0" max="<%=kriterienList.get(i).getMaxpunkte()%>"></td>
									<td><%=kriterienList.get(i).getMaxpunkte()%></td>
        						</tr>
        						     				
        						  <input type="hidden" name="hauptkriterium<%=i%>" value="<%=kriterienList.get(i).getHauptkriterium()%>" />
        						  <input type="hidden" name="teilkriterium<%=i%>" value="<%=kriterienList.get(i).getTeilkriterium()%>" />

        						<%i++; %>    
   							</c:forEach>
   							
                        
                    </tbody>
                </table>
            </div>
            
            <input type="submit" class="btn btn-primary m-2" value="Bewertung hinzufügen" style="width: 200px; min-width:100px; height:40px" name = "bewerten">
            
            
            
        </div>
        
    </div>
    </form>
</body>
