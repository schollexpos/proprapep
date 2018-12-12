import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;


//Hello


@WebServlet("/StudentSelectTeam")
public class StudentSelectTeam extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
       
    
    public StudentSelectTeam() {
        super();
        db = new Database();
        db.connect();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = new Session(db, request);
		
		String page = "";
		if(!session.restore(request)) {
			page = "login.jsp?returnto=StudentSelectTeam";
		} else {
			try {
				int userID = db.getUserID(session.getEmail());
				
				if(db.getStudentTeam(userID) != -1) {
					page = "index";
				} else {
					page = "student_select_team.jsp";
				}
				
			} catch(SQLException e) {
				page = "student_select_team.jsp?error=2";
			} catch(NumberFormatException e) {
				page = "student_select_team.jsp?error=3";
			}
		}
		
		response.sendRedirect(page);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = new Session(db, request);
		
		String teamID = request.getParameter("teamid");
		
		String page = "";
		if(!session.restore(request)) {
			page = "login.jsp?returnto=StudentSelectTeam";
		} else if(teamID == null) {
			page = "student_select_team.jsp?error=1";
		} else {
			try {
				int teamIDint = Integer.parseInt(teamID);
				int userID = db.getUserID(session.getEmail());
				
				if(!db.teamIDExists(teamIDint)) {
					page = "student_select_team.jsp?error=4";
				} else if(db.getStudentTeam(userID) != -1) {
					page = "index";
				} else if(db.getStudentenFromTeam(teamIDint).size() >= db.getMaxTeamSize()) {
					page = "student_select_team.jsp?error=5";
				} else {
					db.addStudentToTeam(userID, teamIDint);
					page = "_erfolg.html";
				}
				
			} catch(SQLException e) {
				page = "student_select_team.jsp?error=2";
			} catch(NumberFormatException e) {
				page = "student_select_team.jsp?error=3";
			}
		}
		

		response.sendRedirect(page);
	}

}
