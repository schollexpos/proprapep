

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;

/**
 * TODO: in jsp: checken ob Team schon existiert -> umleiten
 * TODO: in index: checken ob Team nicht existiert (zB durch schliessen des browsers)
 * 	-> umleiten
 */
@WebServlet("/StudentRegisterTeam")
public class StudentRegisterTeam extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Database db;
    
    public StudentRegisterTeam() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = "";
		boolean success = false;
		
		try {
			Session session = new Session(db, request);
			
			if(!session.restore(request)) {
				page = "login.jsp?returnto=StudentRegisterTeam";
			} else {
				request.setAttribute("hasAccess", new Boolean(true));
				success = true;
			}
        } catch(Exception e) {
        	response.getWriter().append("Encountered an error while serving your request.").append(request.getContextPath());
        }
		
		if(success) {
			request.getRequestDispatcher("/student_register_team.jsp").forward(request, response);
		} else {
			if(page.length() != 0) response.sendRedirect(page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String betreuer1ID = request.getParameter("betreuer1");
		String betreuer2 = request.getParameter("betreuer2");
		String teamname = request.getParameter("teamname");
		
		String page = "";
		Session session = new Session(db, request);
		//TODO: Clean up inputs
		
		
		if(!session.restore(request)) {
			page = "login.jsp?returnto=StudentRegisterTeam";
		} else if(betreuer1ID == null || betreuer2 == null) {
			page = "student_register_team.jsp?error=1";
		} else {
			try {
				int betreuer1 = Integer.parseInt(betreuer1ID);
				
				db.createTeam(session.getEmail(), betreuer1, betreuer2, teamname);
				db.addStudentToTeam(db.getUserID(session.getEmail()), db.getTeamID(session.getEmail()));
				
				page = "index";
			} catch(SQLException e) {
				page = "student_register_team.jsp?error=2";
				System.out.println(e.getMessage());
			} catch(NumberFormatException e) {
				page = "student_register_team.jsp?error=3";
			}
		}
		

		response.sendRedirect(page);
	}

}
