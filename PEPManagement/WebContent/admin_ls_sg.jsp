<%@ page
	import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (request.getAttribute("hasAccess") == null) {
		response.sendRedirect("AdminLehrstuhlStudiengang");
	}
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="theme.css" type="text/css">
<title>Lehrstuhl/Studiengangübersicht PEP</title>
</head>

<body class="flex-grow-1">

	<%
		if (request.getParameter("error") != null || request.getAttribute("error") != null) {
			String str = (request.getParameter("error") != null
					? request.getParameter("error")
					: (String) request.getAttribute("error"));
			String errorMessage = "???";
			if (str.equals("1")) {
				errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
			} else if (str.equals("2")) {
				errorMessage = "Datenbankfehler!";
			} else if (str.equals("3")) {
				errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
			}
			out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
		}
	%>

	<%
		Database db = new Database();
		db.connect();
	%>


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
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.ADMIN);
					out.println(str);
				%>
			</nav>
		</div>
	</div>

	<div class="p-3 mb-5 container-fluid">
		<div class="row mb-5">
			<div class="col-lg-7 col-12">
				<div class="table-wrapper-scroll-y mr-2">
					<table class="table table-hover " id="myTable">
						<thead class="thead-dark">
							<tr>
								<th class="sortable" scope="col">#</th>
								<th class="sortable" scope="col">Kürzel</th>
								<th class="sortable" scope="col">Lehrstuhl</th>
								<th class="sortable" scope="col">Lehrstuhlinhaber</th>
								<th class="sortable" scope="col">Gruppe</th>
								<th class="sortable" scope="col"></th>
							</tr>
						</thead>
						<tbody>

							<%
								ArrayList<Database.Betreuer> betreuerList = db.getBetreuer();
								for (int i = 0; i < betreuerList.size(); i++) {
									out.print("<form action=\"AdminLehrstuhlStudiengang\" method=\"post\">");
									out.print("<input type=\"hidden\" name=\"ID\" value=\"" + betreuerList.get(i).getID() + "\">");
									out.print("<tr id=\"betreuer_" + betreuerList.get(i).getID() + "\">");
									out.print("<th scope=\"row\">" + (i + 1) + "</th>");
									out.print("<td>" + betreuerList.get(i).getKuerzel() + "</td>");
									out.print("<td>" + betreuerList.get(i).getLehrstuhl() + "</td>");
									out.print("<td>" + betreuerList.get(i).getName() + "</td>");
									out.print(
											"<td><select onchange=\"this.form.submit()\" class=\"custom-select border border-dark\" name=\"cgruppe\" ><span>Gruppe</span>");
									out.println("<option value=\"1\"" + (betreuerList.get(i).getGruppe() == 1 ? "selected" : "")
											+ ">1</option>");
									out.println("<option value=\"2\"" + (betreuerList.get(i).getGruppe() == 2 ? "selected" : "")
											+ ">2</option></td>");
									out.print("<td><button type=\"button\" onclick=\"deleteBetreuer(" + betreuerList.get(i).getID()
											+ ");\" class=\"dele p-1 border border-secondary\">Löschen</button></td>");
									out.print("</tr></form>");
								}
							%>

						</tbody>
					</table>
				</div>
			</div>
			<div class="col-lg-1 col-0"></div>
			<div class="col-lg-4 col-12">
				<div class="table-wrapper-scroll-y ml-auto">

					<table class="table table-hover" id="myTable">
						<thead class="thead-dark">
							<tr>
								<th class="sortable" scope="col">#</th>
								<th class="sortable" scope="col">Studiengang</th>
								<th class="sortable" scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList<String> studiengangliste = db.getStudiengaenge();
								for (int i = 0; i < studiengangliste.size(); i++) {
									out.print("<tr id=\"stuga_" + i + "\">");
									out.print("<th scope=\"row\">" + (i + 1) + "</th>");

									out.print("<td>" + studiengangliste.get(i) + "</td>");
									out.print("<td><button type=\"button\" onclick=\"deleteStudiengang(" + i
											+ ");\" class=\"dele p-1 mt-1 border border-secondary\">Löschen</button></td>");
									out.print("</tr>");
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid botbox mt-4 mb-0">

		<div class="row">


			<div class="col-lg-7 col-sm-12 mt-2">

				<form action="AdminLehrstuhlStudiengang" method="post"
					id="lehrstuhl">

					<div class="row mt-1">

						<div class="col-sm-2 col-12 ">
							<h4 class="inlabel text-left">Lehrstuhl</h4>
						</div>
						<div class="col-sm-4 col-12">
							<input id="lehrstuhlh" name="lehrstuhl" type="text"
								class="w-100 border border-dark  p-1 ">
						</div>

						<div class="col-sm-2 col-12 pt-1">
							<h5 class="inlabel text-left ">Lehrstuhlkürzel</h5>
						</div>
						<div class="col-sm-4 col-12">
							<input id="lehrstuhlh" name="kuerzel" type="text"
								class="w-100 border border-dark p-1" maxlength="2">
						</div>




					</div>

					<div class="row mt-1">



						<div class="col-sm-2 col-12 pt-1">
							<h5 class="inlabel text-left ">Lehrstuhlinhaber</h5>
						</div>
						<div class="col-sm-4 col-12">
							<input id="lehrstuhlh" name="inhaber" type="text"
								class=" w-100 border border-dark p-1">
						</div>


						<div class="col-sm-2 col-12">
							<h4 class="inlabel text-left" text-center>Gruppe</h4>
						</div>
						<div class="col-sm-4 col-12">
							<select name="gruppe"
								class="custom-select w-100 border border-dark"><span>Gruppe</span>
								<option value="1">Gruppe 1</option>
								<option value="2">Gruppe 2</option>

							</select>
						</div>
					</div>



				</form>

				<div class="row mt-2">



					<div class="col-sm-6 col-12">
						<input type="submit" formid="lehrstuhl"
							class="sub1 addi mt-1 border border-dark"
							value="Lehrstuhl Hinzufügen">
					</div>

				</div>

			</div>



			<div class="col-sm-2 col-0"></div>

			<div class="col-lg-3 col-sm-12">
				
				<form id="studiengange" action="AdminLehrstuhlStudiengang"
					method="post">
					
					<div class="row mt-2">
						<div class="col-sm-4">
							<h4 class="inlabel text-left">Studiengang</h4>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<input id="studiengangh" name="studiengang" type="text"
								class="w-100 border border-dark p-1 mt-1">
						</div>
					</div>

				
				<div class="row mt-1">
						
						<div class=" col-sm-12 col-12">
							<input type="submit" formid="studiengang"
								class="sub1 addi w-100 p-1 mt-1 border border-dark"
								value="Studiengang Hinzufügen">
						</div>

					</div>
				</form>
			</div>
		</div>

	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
	<script>
		var allow = true;

		function deleteBetreuer(id) {
			if (!allow)
				return;

			document.getElementById("betreuer_" + id).style.display = "none";

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					location.reload();
				}
			};
			xhttp.open("GET", "DeleteLSSG?betreuer=" + id, true);
			xhttp.send();

			allow = false;
		}

		function deleteStudiengang(id) {
			if (!allow)
				return;

			document.getElementById("stuga_" + id).style.display = "none";

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					location.reload();
				}
			};
			xhttp.open("GET", "DeleteLSSG?studiengang=" + id, true);
			xhttp.send();

			allow = false;
		}
	</script>
</body>

</html>