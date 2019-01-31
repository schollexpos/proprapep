<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Registrierung PEP</title>
</head>

<body class="flex-grow-1">
  <div class="py-2 px-2 mb-0">
			<div class="container-fluid logo border border-dark">
				<nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">

					<div class="col-sm-3 navbar-brand mr-0">
						<a class="mr-auto" href="https://www.uni-siegen.de/start/"> <img
							class="log" src="logo_u_s.png" width="180">
						</a>
					</div>
					<div class="col-sm-6 col-12 nav-item pt-1">
						<div class="row">
							<h1 class="col-12 text-center mb-0">
								<b>PEP</b>
							</h1>
						</div>
						<div class="row">
							<h5 class="text-center col-12 mt-0">
								<b>Planungs- und Entwicklungsprojekt</b>
							</h5>
						</div>
					</div>
					<div class="col-sm-3 col-0"></div>
					</nav>
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
		if(str.equals("1")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if(str.equals("2")) {

			errorMessage = "Datenbankfehler!";
		} else if(str.equals("3")) {
			errorMessage = "Ihre E-Mail Adresse muss von der Universit&auml;t Siegen sein!";
		} else if(str.equals("4")) {
			errorMessage = "Diese E-Mail Adresse existiert bereits";
		} else if(str.equals("5")) {
			errorMessage = "Ihr Passwort muss mindestens 8 Zeichen haben.";
		} else if(str.equals("6")) {
			errorMessage = "Falscher Zugangscode!";
		}else if(str.equals("7")) {
			errorMessage = "Die Passwörter stimmen nicht überein!";
		}
		 
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>

		    
    	
    	<form action="AdminRegister" method="post">
		    
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
		            Registrierung muss über die Mail-Adresse der Universität erfolgen!</p>
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
  
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</body>

</html>