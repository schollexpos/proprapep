<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="pepmanagement.Bewertungskriterium,pepmanagement.Database.Team,pepmanagement.Database,java.util.*" %>
    

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="theme.css" type="text/css">
    <title>Bewertung Admin</title>
</head>
    		<%
    		if(request.getParameter("error") != null || request.getAttribute("error") != null) {
    			String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Geben sie eine Zahl als Punktzahl ein!";
				} else if(str.equals("3")) {
					errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
				} 
				
				out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
			}
		%>
<body class="flex-grow-1">

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
    <div class="myrow">
        <div class="container-fluid w-25 h-75 mt-3 ml-0 mr-auto p-4 border-right border-dark" style="box-shadow: 15px 0 8px -10px rgb(82, 82, 82);">

            <h2 class="mt-1 text-center">Juror / Gruppe</h2>
            
             <form action = "AdminBewertungskriterien" method = post>
	        <%
	        Database db = new Database();
	        db.connect();
	        ArrayList<String> juroren = db.getJuroren(); 
	        ArrayList<Integer> jurorenIDs = db.getJurorenIDs();
	        
	        for (int i = 0; i < juroren.size(); i++){
	        	int jurorid = jurorenIDs.get(i);
	        	int gruppe = db.getJurorGruppe(jurorid);
	        	out.println("<div class=\"myrow mt-4\">");
	        	out.println( "<h4 class=" + "\"w-25 mr-auto ml-0 text-center pt-1\">" + juroren.get(i) + "</h4>");
	        	out.println("<select class=\"w-50 ml-2 mr-auto custom-select  border border-dark\" name=\"gruppe" + i + "\" ><span>Gruppe</span>");
	        	out.println("<option " + (gruppe == 0 ? "selected" : "") + ">0</option>");
	        	out.println("<option " + (gruppe == 1 ? "selected" : "") + ">1</option>");
	        	out.println("<option " + (gruppe == 2 ? "selected" : "") + ">2</option>");
	        	out.println("<input type=\"hidden\" name=\"jurorid" + i  + "\" value=\""  + jurorid + "\"" + ">");
	        	out.println("</select> </div>");
	        }
	        
	        
	        %>
           
           
            <input type="submit" class="standard addi w-75 uploadbtn border border-dark mx-auto mt-2" value="Juroren zuweisen" style="min-width:100px; height:40px" name = "zuweisung">
	         </form> 
	               
	
	          
	
	          
	

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
							<th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
						    <c:forEach items="${kriterien}" var="kriterium">
	       						<tr>
	            					<th scope="row">${kriterium.hauptkriterium}</th>
	            					<td>${kriterium.teilkriterium}</td>
	            					<td>${kriterium.minpunkte}-${kriterium.maxpunkte}</td>
	            					<td id="kriterium_${kriterium.bewertungID}"><a href="javascript:deleteKriterium(${kriterium.bewertungID});">Löschen</a></td>
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
					<h5 class="inlabel ml-0 mr-0" style="width:160px">Minimale Punktzahl</h5>
					<input id="minpunkte" type="text" class="inputl border border-dark w-25 p-1 mt-1 ml-1 mr-auto" name = "minpunkte">
                    <input type="submit" class="border border-dark addi w-25 ml-0" value="Kriterium hinzufügen" style=" min-width:200px; height:40px" name = "addKriterium">
               </div>
                

            </div>
            </form>
        </div>
    </div>
    
    
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
        
          <script>
             var allow = true;
             
        function deleteKriterium(id) {
        	if(!allow) return;
        	
	     	  var xhttp = new XMLHttpRequest();
	     	  xhttp.onreadystatechange = function() {
	     	    if (this.readyState == 4 && this.status == 200) {
	     	    	location.reload(); 
	     	    }
	     	  };
	     	  xhttp.open("GET", "DeleteLSSG?kriterium=" + id, true);
	     	  xhttp.send();
	     	
	     	 allow = false;
        }
        </script>
        
</body>
</html>