<%@ page import="pepmanagement.Database, pepmanagement.Menu, pepmanagement.AccountControl, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="utf-8"%>
    <%
    	Database db = new Database();
    	db.connect();
    %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Registrierung PEP</title>
</head>

<body class="flex-grow-1">
  <div class="py-2 px-2 mt-0" >
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
  
  <div class="pt-3">
    
      <div class="myrow" >
        <div class="srow">
          <div class="relem3">
            <h3 class="inlabel">Registrierung</h3>
          </div>
        </div>
      </div>
    
  </div>
  <div class="py-1" >
    <div class="container-fluid">
    	<%
    	if(request.getParameter("error") != null || request.getAttribute("error") != null) {
    		String str = (request.getParameter("error") != null ? request.getParameter("error") : (String) request.getAttribute("error"));
				String errorMessage = "???";
				if(str.equals("1") || str.equals("7")) {
					errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
				} else if(str.equals("2")) {
					errorMessage = "Datenbankfehler!";
				} else if(str.equals("3")) {
					errorMessage = "Ihre E-Mail Adresse muss eine studentische E-Mail Adresse der Universit&auml;t Siegen sein!";
				} else if(str.equals("4")) {
					errorMessage = "Diese E-Mail Adresse existiert bereits";
				} else if(str.equals("5")) {
					errorMessage = "Ihr Passwort muss mindestens 8 Zeichen haben.";
				} else if(str.equals("6")) {
					errorMessage = "Die Passw&ouml;rter stimmen nicht &uuml;berein!";
				} else if(str.equals("8")) {
					errorMessage = "Falscher Code!";
				} else if(str.equals("9")) {
					errorMessage = "Bitte kontrollieren sie Ihre Eingaben auf Korrektheit.";
				}
				
				out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
			}
		%>
		    
    	
    	<form action="StudentRegister" method="post">
		    	
		      <div class="myrow">
		        <div class="srow">
		          <div  class="relem1">
		            <h4 class="inlabel">Vorname</h4>
		          </div>
		          <div class="relem2">
		            <input id="vornameh" name="vorname" type="text" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow">
		        <div class="srow" >
		          <div  class="relem1">
		            <h4 class="inlabel">Nachname</h4>
		          </div>
		          <div class="relem2" >
		            <input id="nachnameh" name="nachname" type="text" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow">
		        <div class="srow">
		          <div class="relem1">
		            <h4 class="inlabel">E-Mail</h4>
		          </div>
		          <div class="relem2" >
		            <input id="mailh" name="email" type="email" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow">
		        <div class="srow" >
		          <p class="" style="height:16px; text-align: left; padding-left: 10px;">
		            Registrierung muss �ber die Mail-Adresse der Universit�t erfolgen!</p>
		        </div>
		      </div>
		      <div class="myrow" >
		        <div class="srow">
		          <div class="relem1">
		            <h4 class="inlabel">Matrikel-Nr.</h4>
		          </div>
		          <div class="relem2" >
		            <input id="matrikh" name="matrikelno" type="text" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		       <div class="myrow">
		        <div class="srow">
		          <div class="relem1">
		            <h4 class="inlabel">Studiengang</h4>
		          </div>
		          <div class="relem2" >
		          	<select name="studiengang" id="studiengang" class="inputl border border-dark p-1 mt-1">
		          		<%
		          			ArrayList<String> sList = db.getStudiengaenge();
		          		
		          			for(int i = 0;i < sList.size();i++) {
		          				out.println("<option>" + sList.get(i) + "</option>");
		          			}
		          		%>
		          	</select>
		          
		            <input id="studiengang" name="studiengang" type="text" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow">
		        <div class="srow">
		          <div class="relem1">
		            <h4 class="inlabel">Zugang</h4>
		          </div>
		          <div class="relem2" >
		            <input id="zugangh" name="zugangscode" type="text" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow">
		        <div class="srow">
		          <div class="relem1">
		            <h5 class="inlabel">Passwort</h5>
		          </div>
		          <div class="relem2" >
		            <input id="passworth" name="password" type="password" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		      <div class="myrow" >
		        <div class="srow">
		          <div class="relem1">
		            <h5 class="inlabel">Passwort Wdh.</h5>
		          </div>
		          <div class="relem2" >
		            <input id="passworthw" name="password2" type="password" class="inputl border border-dark p-1 mt-1" >
		          </div>
		        </div>
		      </div>
		    
		  
		 
		  
		    
		      <div class="myrow" >
		        <div class="srow" >
		          <div class="relem3">
		            <p class="impmsg border-secondary border">Wichtig: Bitte sprechen Sie sich vor Abgabe dieser Informationen mit Ihren Teammitgliedern ab!
		              <br>Es darf pro Team nur einen Vorsitzenden geben!</p>
		          </div>
		        </div>
		      </div>
		    
		  
		  
		    <div class="myrow" >
		      <div class="srow">
		        <div  class="relem1" style="width:35%">
		          <p class="" style="	display: block;	margin: auto;	text-align: left;	min-width: 200px;	width: 100%;">Haben Sie den Vorsitz Ihres Teams inne?</p>
		        </div>
		        <input type="hidden" value="0" name="vorsitz" id="vorsitzfeld">
		        <div class="relem1" style="	width: 30%;">
		          <input type="button" value="Ja" class="vorsitz border border-dark" onclick="document.getElementById('vorsitzfeld').value = '1';">
		        </div>
		        <div class="relem1" style="	width: 30%;">
		          <input type="button" value="Nein" class="vorsitz border border-dark" value="Nein" onclick="document.getElementById('vorsitzfeld').value = '0';" >
		        </div>
		      </div>
		    </div>
		  
		  
		      <div class="myrow">
		        <div class="srow">
		          <div class="relem3">
						<input class ="wichtig border border-dark" type="submit" value="Registrieren">
		          </div>
		        </div>
		      </div>
      </form>
    </div>
  </div>
</body>

</html>