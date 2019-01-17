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
            <a class="col-md-2 col-12 navbar-brand" href="https://www.uni-siegen.de/start/">
                <img  src="logo_u_s.svg" width="180">
            </a>
            <div class="col-md-8 col-12 pt-1">
            <h1 class="w-100 mx-2" data-toggle="collapse" style:="margin:auto; position: fixed;" ><b>Planungs- und Entwicklungsprojekt</b></h1>
          </div>
          <div class="col-md-2 col-0"></div>
          </div>
        </div>
    </div>
  <div class="py-3 w-100 mt-5" >
    <div class="container-fluid text-center">
      <div class="row">
        <h3 class="m-auto col-12">Herzlich willkommen beim Planungs- und Entwicklungsprojekt.<br><b>PEP</b><br></h3>
      </div>
    </div>
  </div>
  
  

  <div class="py-1 mt-2">
    <div class="container-fluid">
      <form action="LoginServlet" method="post">
	      
	      <div class="row">
	      <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">E-Mail</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
	              <input id="emailfield" placeholder="mail@uni-siegen.de" name="email" type="email" class="w-100 border border-dark p-1 mt-1" >
	            </div>
	            <div class="col-xl-4 col-sm-2 col-0"></div>
	          
	        </div>
	        
	      <div class="row">
	       <div class="col-xl-4 col-sm-2 col-0"></div>
		          <div  class="col-xl-1 col-sm-3 col-12 mr-2">
		            <h4 class="inlabel pt-1">Passwort</h4>
		          </div>
		          <div class="col-xl-3 col-sm-5 col-12">
	            <input id="passwordfield" type="password" name="password" class="w-100 border border-dark p-1 mt-1" >
	           </div>
	            <div class="col-xl-4 col-sm-2 col-0"></div>
	          
	        </div>
	    
	       <div class="row mt-2">
	        <div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
	           <div class ="col-xl-2 col-sm-4 col-6">
	           		<%
	           			if(request.getParameter("returnto") != null) {
	           				out.println("<input type=\"hidden\" name=\"returnto\" value=\"" + request.getParameter("returnto") + "\" />");
	           			}
	           		%>
	           		<input class ="standard border border-dark" type="submit" value="Anmelden">
	           </div>
	            <div class ="col-xl-2 col-sm-4 col-6">
	              <a class ="standard border border-dark" href="https://www.uni-siegen.de/start/">Abbrechen</a>
	            </div>
	            <div class="col-xl-4 col-sm-2 col-0"></div>
	         
	        </div>
         </form>
      
        <div class="row">
          	<div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
          	<div class="col-xl-4 col-sm-8 col-12">
              <p class="" style="height:16px; text-align: left; padding-top:10px;">
                Noch keinen Account?
              </p>
            </div>
          </div>
        <div class="row">
          <div class="col-xl-4 col-sm-2 col-0 mr-1"></div>
            <div class="col-xl-4 col-sm-8 col-12">
            <a class ="wichtig w-100 m-0 border border-dark" href="student_register.jsp">Registrieren</a>
            </div>
         
        </div>
      </div>
</div>
</body>
</html>