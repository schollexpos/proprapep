<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Anmeldung PEP</title>
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
			errorMessage = "E-Mail/Passwort falsch!";
		}
		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>


    <div class="py-2 px-2 mt-0" >
      <div class="container-fluid logo my-0 border border-dark" >
        <div class="row text-center pl-2  w-100">
            <a class="navbar-brand" href="https://www.uni-siegen.de/start/">
                <img  src="logo_u_s.svg" width="180">
            </a>
            <div class="relem2 pt-1" style="">
            <h1 class="w-100 ml-4" style:="margin:auto; position: fixed;" ><b>Planungs- und Entwicklungsprojekt</b></h1>
          </div>
          </div>
        </div>
    </div>
  <div class="py-3 w-100 mt-5" >
    <div class="container-fluid text-center">
      <div class="myrow">
        <h3 class="" style="margin:auto; text-align: center;">Herzlich willkommen beim Planungs- und Entwicklungsprojekt.<br><b>PEP</b><br></h3>
      </div>
    </div>
  </div>
  
  

  <div class="py-1 mt-2">
    <div class="container-fluid">
      <form action="LoginServlet" method="post">
	      <div class="myrow">
	          <div class="srow">
	            <div  class="relem1">
	              <h4 class="inlabel">E-mail</h4>
	            </div>
	            <div class="relem2">
	              <input id="emailfield" placeholder="mail@uni-siegen.de" name="email" type="email" class="inputl border border-dark p-1 mt-1" >
	            </div>
	          </div>
	        </div>
	        
	      <div class="myrow">
	        <div class="srow">
	          <div  class="relem1">
	            <h4 class="inlabel">Passwort</h4>
	          </div>
	          <div class="relem2">
	            <input id="passwordfield" type="password" name="password" class="inputl border border-dark p-1 mt-1" >
	           </div>
	        </div>
	       </div>
	    
	       <div class="myrow">
	         <div class="srow">
	           <div class = "relem1" style="width:60%">
	           		<%
	           			if(request.getParameter("returnto") != null) {
	           				out.println("<input type=\"hidden\" name=\"returnto\" value=\"" + request.getParameter("returnto") + "\" />");
	           			}
	           		%>
	           		<input class ="standard border border-dark" type="submit" value="Anmelden">
	           </div>
	           <div class = "relem1" style="width:35%">
	              <a class ="standard border border-dark" href="https://www.uni-siegen.de/start/">Abbrechen</a>
	            </div>
	         </div>
	        </div>
         </form>
      
        <div class="myrow">
            <div class="srow" >
              <p class="" style="height:16px; text-align: left; padding-top:10px; padding-left: 10px;">
                Noch keinen Account?
              </p>
            </div>
          </div>
        <div class="myrow">
          <div class="srow">
            <div class="relem3">
            <a class ="wichtig border border-dark" href="register.html">Registrieren</a>
            </div>
          </div>
        </div>
      </div>
</div>
</body>
</html>