//Hallo hilfe

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;
import pepmanagement.Session;

@WebServlet("/AdminTeamUebersicht")
public class AdminTeamUebersicht extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
     
    public AdminTeamUebersicht() {
        super();
        db = new Database();
        db.connect();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		String team = request.getParameter("team");
		
		System.out.println(team);
		try {
			if(team != null) {
				int teamID = Integer.parseInt(team);

				db.teamSetKennnummer(teamID);
			}
		} catch(SQLException e) {
			res = AccountControl.Result.DBERROR;
			System.out.println(e.getMessage());
		} catch(NumberFormatException e) {
			res = AccountControl.Result.ERROR;

			System.out.println(e.getMessage());
		}
		
		String group = request.getParameter("group");
		request.setAttribute("group", group);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}
		
		AccountControl.processResult(res, request, response, "AdminTeamUebersicht", "admin_teamuebersicht.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		   
		String min = request.getParameter("min");
		String max = request.getParameter("max");
		
		try {
			if(min != null && max != null) {
				int minInt = Integer.parseInt(min);
				int maxInt = Integer.parseInt(max);

				db.setMinMaxTeamSize(minInt, maxInt);
			}
		} catch(SQLException e) {
			res = AccountControl.Result.DBERROR;
		} catch(NumberFormatException e) {
			res = AccountControl.Result.ERROR;
		}
		
		AccountControl.processResult(res, request, response, "AdminTeamUebersicht", "admin_teamuebersicht.jsp", true);
	}

}
