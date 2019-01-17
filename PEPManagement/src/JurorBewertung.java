

import pepmanagement.AccountControl;
import pepmanagement.Bewertungskriterium;
import pepmanagement.Database;
import pepmanagement.Database.Team;
import pepmanagement.Pair;
import pepmanagement.Session;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/JurorBewertung")
public class JurorBewertung extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db; 
	
    public JurorBewertung() {
        super();
        
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.JUROR, db, request, response);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}
		
		if(res == AccountControl.Result.SUCCESS) {
			try {
				Session session = new Session(db, request);
				session.restore(request);
				request.setAttribute("teamtitel",(request.getParameter("projekttitel")));
				request.setAttribute("jurorID", db.getUserID(session.getEmail()));
				request.setAttribute("kriterien", db.getKriterien());
				
				if(!db.bewertungOpen()) {
					request.setAttribute("error", "10");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		AccountControl.processResult(res, request, response, "JurorBewertung", "juror_bewertung.jsp");
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = new Session(db, request);
		
		String page = "";
		if(!session.restore(request)) {
			page = "login.jsp?returnto=AdminTeamDetails";
		} else if (request.getParameter("bewerten") != null) {
			try {
				if(!db.bewertungOpen()) {
					page = "JurorBewertung?error=10";
				}
				else {
					page = addBewertung(session, request,response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (request.getParameter("auswaehlen") != null) {
			try {				
				page = selectTeam(request,response);
			} catch (SQLException e) {
				request.setAttribute("error", "2");
				e.printStackTrace();
			}
		} else if(request.getParameter("team")==null) {
			page = "JurorBewertung?error=2";
		}
		response.sendRedirect(page);

	}
	
	
	private String selectTeam(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
		String page = "";	
		
		page = "JurorBewertung?team=" + request.getParameter("teamid");
		return page;
	}

	private String addBewertung(Session session, HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int team = Integer.parseInt(request.getParameter("tt"));
		String page = "JurorBewertung?team=" + team;
		ArrayList<Bewertungskriterium> kriterien = db.getKriterien();

		int length = kriterien.size();
		
		for (int i=0; i<length; i++) {
			if(request.getParameter("punktzahl"+ i).equals("")) {
				continue;
			}
			int punktzahl = Integer.parseInt(request.getParameter("punktzahl" + i));
			int bewertungid = Integer.parseInt(request.getParameter("bewertungid" + i));
			int jurorid = db.getUserID(session.getEmail());
			int teamid = team;
			
			db.setBewertung(teamid, bewertungid, punktzahl, jurorid);
			
		}
		return page;
		
	}
	

	
	
}