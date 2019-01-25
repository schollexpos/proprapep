<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="pepmanagement.Bewertungskriterium,pepmanagement.Database.Team,pepmanagement.Database,java.util.*"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="theme.css" type="text/css">
<title>Bewertung Admin</title>
</head>
<%
	if (request.getParameter("error") != null || request.getAttribute("error") != null) {
		String str = (request.getParameter("error") != null
				? request.getParameter("error")
				: (String) request.getAttribute("error"));
		String errorMessage = "???";
		if (str.equals("1") || str.equals("7")) {
			errorMessage = "Bitte f&uuml;llen Sie alle Felder aus!";
		} else if (str.equals("2")) {
			errorMessage = "Geben sie eine Zahl als Punktzahl ein!";
		} else if (str.equals("3")) {
			errorMessage = "Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben auf Korrektheit!";
		}

		out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
	}
%>
<body class="flex-grow-1">

	<div class="py-2 px-2 mb-0">
		<div class="container-fluid logo border border-dark">
			<nav
				class="row pl-2 navbar navbar-expand-lg navbar-light bg-light w-100">
				<a class="navbar-brand mr-auto"
					href="https://www.uni-siegen.de/start/"> <img class="log"
					src="logo_u_s.png" width="180">
				</a>
				<h1 class="nav-item m-auto ">
					<b>Planungs- und Entwicklungsprojekt</b>
				</h1>

				<%
					String str = pepmanagement.Menu.getMenu(pepmanagement.AccountControl.UserRank.ADMIN);
					out.println(str);
				%>
			</nav>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div
				class="col-xl-3 col-md-4 col-sm-5 mt-3 p-3 border-right border-dark"
				style="box-shadow: 15px 0 8px -10px rgb(82, 82, 82);">

				<h2 class="mt-1 text-center">Juror / Gruppe</h2>

				<form action="AdminBewertungskriterien" method=post>
					<%
						Database db = new Database();
						db.connect();
						ArrayList<String> juroren = db.getJuroren();
						ArrayList<Integer> jurorenIDs = db.getJurorenIDs();

						for (int i = 0; i < juroren.size(); i++) {
							int jurorid = jurorenIDs.get(i);
							int gruppe = db.getJurorGruppe(jurorid);
							out.println("<div class=\"row mt-2\">");
							out.println("<h4 class=" + "\"col-md-7 col-sm-12 text-left\">" + juroren.get(i) + "</h4>");
							out.println(
									"<div class=\"col-md-5 col-sm-12\"> <select class=\"custom-select border border-dark\" name=\"gruppe"
											+ i + "\" ><span>Gruppe</span>");
							out.println("<option " + (gruppe == 0 ? "selected" : "") + ">0</option>");
							out.println("<option " + (gruppe == 1 ? "selected" : "") + ">1</option>");
							out.println("<option " + (gruppe == 2 ? "selected" : "") + ">2</option> ");
							out.println("<input type=\"hidden\" name=\"jurorid" + i + "\" value=\"" + jurorid + "\"" + ">");
							out.println("</select> </div></div>");
						}
					%>

					<div class="row">
						<div class="col-sm-1 col-0"></div>
						<div class="col-sm-10 col-12">
							<input type="submit"
								class="standard addi uploadbtn border border-dark mt-2"
								value="Juroren zuweisen" name="zuweisung">
						</div>
					</div>
				</form>






				<div class="row">
					<div class="col-sm-1 col-0"></div>
					<div class="col-sm-10 col-12">
						<p class="impmsg border border-secondary mt-2"
							style="font-size: 18px;">Bitte erst nach Ablauf der
							Abgabefrist zuteilen!</p>
					</div>
				</div>
			</div>

			<div class="col-xl-9 col-md-8 col-sm-7 mt-3 px-3">

				<div class="row">
					<div class="table-wrapper-scroll-y myrow">
						<table class="table table-hover w-100 ">
							<thead class="thead-dark">
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
										<td id="kriterium_${kriterium.bewertungID}"><a
											class="dele p-1 border border-secondary"
											href="javascript:deleteKriterium(${kriterium.bewertungID});">Löschen</a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				<form action="AdminBewertungskriterien" method="post">
					<div class="row mt-5 p-2 botbox">
						<div class="col-xl-6 col-md-8 col-sm-12 mt-1">

							<div class="row">
								<div class="col-sm-5">
									<h4 class="inlabel">Hauptkriterium</h4>
								</div>
								<div class="col-sm-7">
									<input id="hauptkriterium" type="text"
										class="w-100 p-1 border border-dark" name="hauptkriterium">
								</div>
							</div>

							<div class="row mt-1">
								<div class="col-sm-5">
									<h4 class="inlabel">Teilkriterium</h4>
								</div>
								<div class="col-sm-7">
									<input id="teilkriterium" type="text"
										class="border border-dark w-100 p-1" name="teilkriterium">
								</div>
							</div>
						</div>

						<div class="col-xl-3 col-md-4 col-sm-12 mt-1">
							<div class="row">
								<div class="col-sm-7  pt-1">
									<h6 class="inlabel">Minimale Punktzahl</h6>
								</div>
								<div class="col-sm-5">
									<input id="minpunkte" type="text"
										class="border border-dark w-100 p-1" name="minpunkte">
								</div>
							</div>



							<div class="row mt-1">
								<div class="col-sm-7 pt-1">
									<h6 class="inlabel">Maximale Punktzahl</h6>
								</div>
								<div class="col-sm-5">
									<input id="maxpunkte" type="text"
										class="border border-dark w-100 p-1" name="maxpunkte">
								</div>
							</div>
						</div>






						<div class="col-xl-3 col-sm-12 mt-1">
							<div class="row">
								<div class="col-xl-12 col-md-6 col-sm-12">
									<input type="submit" class="border border-dark addi w-100 "
										value="Kriterium hinzufügen" style="height: 82px;"
										name="addKriterium">
								</div>
							</div>
						</div>

					</div>
				</form>
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

		function deleteKriterium(id) {
			if (!allow)
				return;

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