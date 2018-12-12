 <%
 	if(request.getAttribute("list") == null) {
 		response.sendRedirect("StudentUpload");
 	}
 
 	boolean deadlineReached = ( (Boolean) request.getAttribute("deadlinereached")).booleanValue();
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
            <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
                <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
                    <img class="log" src="logo_u_s.png" width="180">
                </a>
                <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>

	                
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
  	Boolean vorsitz = (Boolean) request.getAttribute("vorsitz");
  	
  for(int i = 0;list != null && i < list.size();i++) {
	  
	  out.println("<div class=\"container-fluid mt-1 p-3\"><form class=\"myrow\" action = \"StudentUpload\" method=\"post\" enctype = \"multipart/form-data\">");
	  out.println("<div class=\"col-sm ml-auto\"><h4 class=\"inlabel text-center\">" +  list.get(i).x + "</h4></div>");
	  out.println("<input type=\"hidden\" name=\"filename\" value=\"" + list.get(i).x + "\" />");
	  if(vorsitz.booleanValue() && !deadlineReached) {
		  out.println("<div class=\"col-sm input-group\"><label class=\"input-group-btn\"><span class=\"btn btn-default wichtigUp\">Browse...<input type = \"file\" name = \"file\" size = \"50\" style=\"display: none;\" multiple></span></label><input type=\"text\" class=\"form-control uplout border border-dark\" readonly></div>"); 
	  } else {
		  out.println("<div class=\"col-sm input-group\"><input type=\"text\" class=\"form-control uplout border border-dark\" readonly></div>");
		  
	  } out.println("<div class=\"col-sm\">");
	  if(vorsitz.booleanValue() && !deadlineReached)
		  out.println("<input type=\"submit\" class=\"btn btn-default wichtigUp w-50 mr-auto ml-0 uploadbtn border border-dark\" value=\"Upload\" style=\"display:block;\">");
  	  
	  out.println("</div></form><div class=\"myrow\">");
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
  

				