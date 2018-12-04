

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String page = "";
		boolean success = false;
		
		try {
			Session session = new Session(db, request);
			
			if(!session.restore(request)) {
				page = "login.jsp?returnto=AdminTeamUebersicht";
			} else {
				int userID = db.getUserID(session.getEmail());
				
				if(!db.userIsAdmin(userID)) {
					page = "401.html";
				} else {
					request.setAttribute("hasAccess", new Boolean(true));
					if(request.getParameter("group") != null) request.setAttribute("group", new String(request.getParameter("group")));
					success = true;
				}
			}
        } catch (SQLException e) {
        	//Can't show him the page since it's access-restricted
        	response.getWriter().append("Encountered an database-error while serving your request.").append(request.getContextPath());
        	System.out.println(e.getMessage());
        } catch(Exception e) {
        	response.getWriter().append("Encountered an error while serving your request.").append(request.getContextPath());
        }
		
		if(success) {
			request.getRequestDispatcher("/admin_teamuebersicht.jsp").forward(request, response);
		} else {
			if(page.length() != 0) response.sendRedirect(page);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String min = request.getParameter("min");
		String max = request.getParameter("max");
		
		String page = "";
		
		if(min == null || max == null) {
			page = "admin_teamuebersicht.jsp?error=1";
		} else {
			try {
				Session session = new Session(db, request);
				if(!session.restore(request)) {
					page = "login.jsp";
				} else {
					int userID = db.getUserID(session.getEmail());
					if(!db.userIsAdmin(userID)) {
						page = "403.html";
					} else {
						int minInt = Integer.parseInt(min);
						int maxInt = Integer.parseInt(max);
						
						db.setMinMaxTeamSize(minInt, maxInt);
						page = "admin_teamuebersicht.jsp";
					}
				}
			} catch(SQLException e) {
				page = "admin_teamuebersicht.jsp?error=2";
			} catch(NumberFormatException e) {
				page = "admin_teamuebersicht.jsp?error=3";
			}
		}
		
		response.sendRedirect(page);
	}

}
