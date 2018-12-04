import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;

@WebServlet("/AdminTeamDetails")
public class AdminTeamDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
       
    
    public AdminTeamDetails() {
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
				page = "login.jsp?returnto=AdminTeamDetails";
			} else {
				int userID = db.getUserID(session.getEmail());
				
				if(!db.userIsAdmin(userID)) {
					page = "401.html";
				} else {
					request.setAttribute("hasAccess", new Boolean(true));
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
			request.getRequestDispatcher("/admin_team_details.jsp").forward(request, response);
		} else {
			if(page.length() != 0) response.sendRedirect(page);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
