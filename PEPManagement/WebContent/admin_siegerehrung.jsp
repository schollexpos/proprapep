<%@ page
	import="pepmanagement.Database, pepmanagement.Pair, java.util.ArrayList, java.util.HashMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (request.getAttribute("hasAccess") == null) {
		response.sendRedirect("AdminSiegerehrung");
	}

	Database db = new Database();
	db.connect();

	int order = 1;
	int[] teamIDg1 = new int[3];
	int[] teamIDg2 = new int[3];
	try {
		if (request.getAttribute("order") != null) {
			order = Integer.parseInt((String) request.getAttribute("order"));
			if (order < 1 || order > 2)
				order = 1;
		}
	} catch (Exception e) {

	}

	System.out.println("Req: " + request.getAttribute("Order") + " Order: " + order);
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="theme.css" type="text/css">
<title>Siegerehrung PEP</title>
</head>

<body class="flex-grow-1">
	<%
		if (request.getParameter("error") != null || request.getAttribute("error") != null) {
			String str = (request.getParameter("error") != null
					? request.getParameter("error")
					: (String) request.getAttribute("error"));
			String errorMessage = "???";
			if (str.equals("1")) {
				errorMessage = "Datenbankfehler";
			} else if (str.equals("2")) {
				errorMessage = "Es gab einen Fehler!";
			} else {
				errorMessage = "Unbekannter Fehler!";
			}

			out.println(pepmanagement.Menu.getErrorMessage(errorMessage));
		}
	%>


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
		<div class="row mt-2">

			<div class="col-12">
				<h2 class="text-center m-auto">Übersicht Siegerehrung</h2>
			</div>


		</div>
		<div class="row">
			<div class="col-lg-6 col-md-12 mt-4 px-3 pb-3"
				style="box-shadow: 15px 0 8px -10px rgb(82, 82, 82)">

				<div class="myrow">
					<div class="table-wrapper-scroll-y w-100">

						<table class="table table-hover " id="myTable">
							<thead class="thead-dark">
								<tr>
									<th class="sortable" scope="col">Gruppe 1</th>
									<th class="sortable" scope="col">Projekttitel</th>
									<th class="sortable" scope="col">Kennnummer</th>
									<th class="sortable" scope="col">Punkte</th>
								</tr>
							</thead>
							<tbody>
								<%
									ArrayList<String> teamListe = db.getOrderedTeams(1);

									for (int i = 0; i < teamListe.size() && i < 3; i++) {
										String[] currTeam = teamListe.get(i).split("#");
										teamIDg1[i] = Integer.parseInt(currTeam[1]);
										Database.Team team = db.getTeam(teamIDg1[i]);

										out.print("<tr>");
										out.print("<th scope=\"row\"> Platz " + (i + 1) + "</th>");
										out.print("<td>" + currTeam[0] + "</td>");
										out.print("<td>" + team.getKennnummer() + "</td>");
										out.print("<td>" + currTeam[2] + "</td>");

										out.print("</tr>");
									}
								%>
							</tbody>
						</table>

					</div>
				</div>
				<div class="row mt-0">
					<div class="col-3"></div>
				</div>

				<div class="myrow mt-4">
					<div class="table-wrapper-scroll-y w-100">

						<table class="table table-hover " id="myTable">
							<thead class="thead-dark">
								<tr>
									<th class="sortable" scope="col">Gruppe 2</th>
									<th class="sortable" scope="col">Projekttitel</th>
									<th class="sortable" scope="col">Kennnummer</th>
									<th class="sortable" scope="col">Punkte</th>
								</tr>
							</thead>
							<tbody>
								<%
									ArrayList<String> teamListe2 = db.getOrderedTeams(2);

									for (int i = 0; i < teamListe2.size() && i < 3; i++) {
										String[] currTeam = teamListe2.get(i).split("#");
										teamIDg2[i] = Integer.parseInt(currTeam[1]);

										out.print("<tr>");
										out.print("<th scope=\"row\"> Platz " + (i + 1) + "</th>");
										out.print("<td>" + currTeam[0] + "</td>");
										out.print("<td>" + currTeam[1] + "</td>");
										out.print("<td>" + currTeam[2] + "</td>");

										out.print("</tr>");
									}
								%>

							</tbody>
						</table>

					</div>
				</div>
				<div class="row mt-1">
					<div class="col-lg-3 col-md-6">
						<input type="button" class=" w-100 senden border border-dark"
							onclick="javascript:location.href='admin_sieger_printview.jsp';"
							value="Drucken">
					</div>
				</div>
			</div>

			<div class="col-lg-6 col-md-12 mt-4 px-3">
				<div class="row">
					<div class="col-6">
						<select class="suchen custom-select m-auto p-1 border border-dark"
							id="Order" onchange="updatediv();"><span>Reihenfolge</span>
							<%
								out.print("<option value=\"1\" " + (order == 1 ? "selected" : "") + ">Absteigend</option>");
								out.print("<option value=\"2\" " + (order == 2 ? "selected" : "") + ">Aufsteigend</option>");
							%>
						</select>
					</div>
					<form class="col-6" action="AdminSiegerehrung" method="post">

						<%
							if (order == 1) {
								out.print("<input type=\"hidden\" name=\"order\" value=\"1\" >");
								out.print(
										"<input type=\"submit\" class=\"uploadbtn suchen standard addi border border-dark\"  name=\"createPr\" value=\"Erstelle Präsentation\" >");
							}

							else if (order == 2) {
								//out.print ("<a class=\"blank\" href=\"C:\\Users\\lucah\\Desktop\\Testfiles\\-1.dokumentation.pdf\">");
								out.print("<input type=\"hidden\" name=\"order\" value=\"2\" >");
								out.print(
										"<input type=\"submit\" class=\"uploadbtn suchen standard addi border border-dark\"  name=\"createPr\" value=\"Erstelle Präsentation\" > ");
							}
						%>
					</form>
				</div>

				<form action="AdminSiegerehrung" method="post"
					enctype="multipart/form-data">
					<div class="row mt-2">
						<div class="col-sm-4 col-12">
							<h4 class="inlabel text-center">Startfolie</h4>
						</div>
						<input type="hidden" name="filename" value="startfolie">
						<div class="col-sm-5 col-12">
							<div class="input-group">
								<label class="input-group-btn"> <span
									class="btn btn-default wichtigUp"> Browse... <input
										type="file" name="file" size="50" style="display: none;"
										multiple>
								</span>
								</label> <input type="text"
									class="form-control uplout border border-dark" readonly>
							</div>
						</div>
						<div class="col-sm-3 col-12">
							<input type="submit"
								class="btn btn-default wichtigUp uploadbtn border border-dark"
								value="Upload" style="display: block;">
						</div>
					</div>
				</form>



				<div class="row mt-3">
				<div class="col-lg-1 col-0"></div>
					<div class="col-lg-3 pt-1">
						<h3 class="text-left mb-0"><b>
							<%
								if (order == 1) {
									out.print("Platz 3");
								} else if (order == 2) {
									out.print("Platz 1");
								}
							%>
						</b></h3>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-1 col-0"></div>
					<div class="col-lg-11 pt-0" style="z-index: -1;">
						<div class="v-spacer"></div>
					</div>
				</div>


				<div class="row ">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 1</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								if (order == 1) {
									String prjkt = db.getTeamTitel(teamIDg1[2]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}

								else if (order == 2) {
									String prjkt = db.getTeamTitel(teamIDg1[0]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>
				<div class="row mt-1">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 2</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								if (order == 1) {
									String prjkt = db.getTeamTitel(teamIDg2[2]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}

								else if (order == 2) {
									String prjkt = db.getTeamTitel(teamIDg2[0]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>

				<form class="row mt-3" action="AdminSiegerehrung" method="post"
					enctype="multipart/form-data">
					<div class="col-sm-4">
						<h4 class="inlabel text-center">Zwischenfolie</h4>
					</div>
					<input type="hidden" name="filename" value="zwischen1">
					<div class="col-sm-5">
						<div class="input-group">
							<label class="input-group-btn"> <span
								class="btn btn-default wichtigUp"> Browse... <input
									type="file" name="file" style="display: none;" multiple>
							</span>
							</label> <input type="text"
								class="form-control uplout border border-dark" readonly>
						</div>
					</div>
					<div class="col-sm-3">
						<input type="submit"
							class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark"
							value="Upload" style="display: block;">
					</div>
				</form>

				<div class="row mt-3">
				<div class="col-lg-1 col-0"></div>
					<div class="col-lg-3 pt-1">
						<h3 class="text-left mb-0 mr-2"><b>Platz 2</b></h3>
					</div>
					</div>
					<div class="row">
					<div class="col-lg-1 col-0"></div>
					<div class="col-lg-11 col-12 pt-0" style="z-index: -1;">
						<div class="v-spacer"></div>
					</div>
				</div>


				<div class="row ">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 1</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								{
									String prjkt = db.getTeamTitel(teamIDg1[1]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>
				<div class="row mt-1">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 2</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								{
									String prjkt = db.getTeamTitel(teamIDg2[1]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>

				<form class="row mt-3" action="AdminSiegerehrung" method="post"
					enctype="multipart/form-data">
					<div class="col-sm-4">
						<h4 class="inlabel text-center">Zwischenfolie</h4>
					</div>
					<input type="hidden" name="filename" value="zwischen2">
					<div class="col-sm-5">
						<div class="input-group">
							<label class="input-group-btn"> <span
								class="btn btn-default wichtigUp"> Browse... <input
									type="file" name="file" style="display: none;" multiple>
							</span>
							</label> <input type="text"
								class="form-control uplout border border-dark" readonly>
						</div>
					</div>
					<div class="col-sm-3">
						<input type="submit"
							class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark"
							value="Upload" style="display: block;">
					</div>
				</form>

				<div class="row mt-3">
				<div class="col-lg-1 col-0"></div>
					<div class="col-lg-3 pt-1">
						<h3 class="text-left mb-0 mr-2"><b>
							<%
								if (order == 1) {
									out.print("Platz 1");
								} else if (order == 2) {
									out.print("Platz 3");
								}
							%>
						</b></h3>
					</div>
					</div>
					<div class="row">
					<div class="col-lg-1 col-0"></div>
					<div class="col-lg-11 pt-0" style="z-index: -1;">
						<div class="v-spacer"></div>
					</div>

				</div>

				<div class="row ">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 1</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								if (order == 1) {
									String prjkt = db.getTeamTitel(teamIDg1[0]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}

								else if (order == 2) {
									String prjkt = db.getTeamTitel(teamIDg1[2]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>
				<div class="row mt-1">
				<div class="col-lg-1 col-0"></div>
					<div class="col-sm-3 col-12 mb-1">
						<h4 class="inlabel text-left">Gruppe 2</h4>
					</div>
					<div class="col-lg-5 col-sm-6 col-12">
						<div class="uplout text-left border border-dark p-1 w-100">
							<%
								if (order == 1) {
									String prjkt = db.getTeamTitel(teamIDg2[0]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}

								else if (order == 2) {
									String prjkt = db.getTeamTitel(teamIDg2[2]);
									if (prjkt == "") {
										out.print("Projekttitel");
									} else {
										out.print(prjkt);
									}
								}
							%>
						</div>
					</div>
				</div>


				<form class="row mt-3" action="AdminSiegerehrung" method="post"
					enctype="multipart/form-data">
					<div class="col-sm-4 mb-1">
						<h5 class="inlabel text-center">Organisation / Sponsoren</h5>
					</div>
					<input type="hidden" name="filename" value="orga">
					<div class="col-sm-5">
						<div class="input-group">
							<label class="input-group-btn"> <span
								class="btn btn-default wichtigUp"> Browse... <input
									type="file" name="file" style="display: none;" multiple>
							</span>
							</label> <input type="text"
								class="form-control uplout border border-dark" readonly>
						</div>
					</div>
					<div class="col-sm-3">
						<input type="submit"
							class="btn btn-default wichtigUp mr-auto ml-0 uploadbtn border border-dark"
							value="Upload" style="display: block;">
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
		function updatediv() {
			e = document.getElementById("Order");
			var strUser = e.options[e.selectedIndex].value;
			document.location.href = "AdminSiegerehrung?order=" + strUser;
		}

		$(function() {

			$(document)
					.on(
							'change',
							':file',
							function() {
								var input = $(this), numFiles = input.get(0).files ? input
										.get(0).files.length
										: 1, label = input.val().replace(/\\/g,
										'/').replace(/.*\//, '');
								input
										.trigger('fileselect', [ numFiles,
												label ]);
							});

			$(document)
					.ready(
							function() {
								$(':file')
										.on(
												'fileselect',
												function(event, numFiles, label) {

													var input = $(this)
															.parents(
																	'.input-group')
															.find(':text'), log = numFiles > 1 ? numFiles
															+ ' files selected'
															: label;

													if (input.length) {
														input.val(log);
													} else {
														if (log)
															alert(log);
													}

												});
							});

		});
	</script>

</body>