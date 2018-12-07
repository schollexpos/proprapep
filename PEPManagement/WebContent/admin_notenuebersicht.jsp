<%@ page import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if(request.getAttribute("hasAccess") == null) {
	response.sendRedirect("AdminNotenuebersicht");
}
    %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="theme.css" type="text/css">
  <title>Main PEP</title>
</head>

<body class="flex-grow-1">

        <<div class="py-2 px-2 mb-0">
            <div class="container-fluid logo border border-dark">
              <nav class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
                <a class="navbar-brand mr-auto" href="https://www.uni-siegen.de/start/">
                  <img class="log" src="logo_u_s.png" width="180">
                </a>
                <h1 class="nav-item m-auto "><b>Planungs- und Entwicklungsprojekt</b></h1>
        
                <div class="dropdown show ml-auto mr-3">
                    <a style="text-decoration:none;" class="menu-dt" href="#" role="button" id="dropdownMenuLink"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <img class="menu-pic" src="Bilder/Menü.png" width="60">
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
            

    <div class="container-fluid mt-2 p-3">
     <div class="myrow">
         <div class="col-sm">
              <h4 class="inlabel text-center">Notenvergabe</h4>
            </div>
         <div class="col-sm">
                 <h4 class="inlabel text-center">Gewinner</h4>
         </div>
     </div>
    </div>

    <div class="container-fluid mt-0 p-0">
            <div class="myrow">
                <div class="col-sm m-auto">
                    <div class="relem2 m-auto">
                        <select class="custom-select mt-1 p-1 border border-dark"><span>Dropdown</span>
                            <option>Gruppe1</option>
                            <option>Gruppe2</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm m-auto">
                    <div class="relem2 m-auto">
                        <select class="custom-select mt-1 p-1 border border-dark"><span>Dropdown</span>
                            <option>Gruppe1</option>
                            <option>Gruppe2</option>
                        </select>
                    </div>
                </div>
            </div>
    </div>
    <div class="myrow p-3">
      <div class="col-sm m-auto">
        <div class="table-wrapper-scroll-y m-auto" style="max-height:500px; width:95% ">
        <table class="table table-hover " id="myTable">
          <thead>
              <tr>
                  <th class="sortable" scope="col">Kennummer</th>
                  <th class="sortable" scope="col">Note</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>010118</td>
                  <td>1.7</td>
              </tr>
              <tr>
                  <td>010218</td>
                  <td>3.0</td>
              </tr>
              <tr>
                  <td>010318</td>
                  <td>4.0</td>
              </tr>
              <tr>
                  <td>010118</td>
                  <td>1.7</td>
              </tr>
              <tr>
                  <td>010218</td>
                  <td>3.0</td>
              </tr>
              <tr>
                  <td>010318</td>
                  <td>4.0</td>
              </tr>
              <tr>
                  <td>010118</td>
                  <td>1.7</td>
              </tr>
              <tr>
                  <td>010218</td>
                  <td>3.0</td>
              </tr>
              <tr>
                  <td>010318</td>
                  <td>4.0</td>
              </tr>
          </tbody>
        </table>
      </div>
      </div>
      <div class="col-sm mb-auto">
          <table class="table table-hover " id="myTable">
              <thead>
                  <tr>
                      <th class="sortable" scope="col">Kennummer</th>
                      <th class="sortable" scope="col">Platz</th>
                  </tr>
              </thead>
              <tbody>
                  <tr>
                      <td>010118</td>
                      <td>1</td>
                  </tr>
                  <tr>
                      <td>010218</td>
                      <td>2</td>
                  </tr>
                  <tr>
                      <td>010318</td>
                      <td>3</td>
                  </tr>
              </tbody>
            </table>
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