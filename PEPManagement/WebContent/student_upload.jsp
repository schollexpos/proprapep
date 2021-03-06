 <%
 ArrayList<Boolean> deadlineReached = null;
 	if(request.getAttribute("list") == null || request.getAttribute("teamid") == null || request.getAttribute("deadlinereached") == null) {
 		response.sendRedirect("StudentUpload");
 	} else {
 		int teamID = -1;
 		try {
 			teamID = ((Integer) request.getAttribute("teamid")).intValue();
 		} catch(Exception e) {}
 		
 		if(teamID == -1) response.sendRedirect("StudentSelectTeam");
 		
 		deadlineReached = ( ( ArrayList<Boolean>) request.getAttribute("deadlinereached"));
 	}
 %>
<%@ page import="pepmanagement.Database, pepmanagement.Menu, pepmanagement.AccountControl, pepmanagement.Pair, java.util.ArrayList" %>
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
				<nav
					class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">

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
					<div class="col-sm-2 col-0"></div>

	                
				<%
					String str = Menu.getMenu(AccountControl.UserRank.VORSITZ);
					out.println(str);
				%>
						
            </nav>
        </div>
    </div>
  <div class="mt-5"></div>
  
  <%
 	ArrayList<Pair<String,String>> list =  (ArrayList<Pair<String,String>>) request.getAttribute("list");
  	Boolean vorsitz = new Boolean(true);
  	
  for(int i = 0;list != null && i < list.size();i++) {
	  
	  out.println("<div class=\"container-fluid mt-1 p-3\"><form class=\"myrow\" action = \"StudentUpload\" method=\"post\" enctype = \"multipart/form-data\">");
	  out.println("<div class=\"col-lg-4 col-sm-3 col-12\"><h4 class=\"inlabel text-center\">" +  pepmanagement.FileManager.getFileDescriptor(i) + "</h4></div>");
	  out.println("<input type=\"hidden\" name=\"filename\" value=\"" + list.get(i).x + "\" />");
	  if(vorsitz.booleanValue() && !deadlineReached.get(i).booleanValue()) {
		  out.println("<div class=\"col-lg-4 col-sm-5 col-12 input-group\"><label class=\"input-group-btn\"><span class=\"btn btn-default wichtigUp\">Browse...<input type = \"file\" name = \"file\" size = \"50\" style=\"display: none;\" multiple></span></label><input type=\"text\" class=\"form-control uplout border border-dark\" readonly></div>"); 
	  } else {
		  out.println("<div class=\"col-lg-4 col-sm-3 col-12 input-group\"><input type=\"text\" class=\"form-control uplout border border-dark\" readonly></div>");
		  
	  } out.println("<div class=\"col-lg-2 col-sm-3 col-12\">");
	  if(vorsitz.booleanValue() && !deadlineReached.get(i).booleanValue())
		  out.println("<input type=\"submit\" class=\"btn btn-default wichtigUp w-100 mr-auto ml-0 uploadbtn border border-dark\" value=\"Upload\" style=\"display:block;\">");
  	  
	  out.println("<div class=\"col-lg-2 col-sm-1 col-0\"></div> </div></form><div class=\"myrow\">");
  	  out.println("<p class=\"text-center m-auto\" style=\"height:16px; ; padding-left: 1px;\">Letzter Upload: " + list.get(i).y + "</p></div>"); 
	  out.println("</div>\n");
	  
  }
  
  %>
  
  
  
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
  
<script>
    $(function() {
    
   
    $(document).on('change', ':file', function() {
      var input = $(this),
          numFiles = input.get(0).files ? input.get(0).files.length : 1,
          label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
      input.trigger('fileselect', [numFiles, label]);
    });
    
   
    $(document).ready( function() {
        $(':file').on('fileselect', function(event, numFiles, label) {
    
            var input = $(this).parents('.input-group').find(':text'),
                log = numFiles > 1 ? numFiles + ' files selected' : label;
    
            if( input.length ) {
                input.val(log);
            } else {
                if( log ) alert(log);
            }
    
        });
    });
    
    });
    </script>
    
    
  </body>
  </html>
  

				