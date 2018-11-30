import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;

@WebServlet("/AdminLehrstuhlStudiengang")
public class AdminLehrstuhlStudiengang extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
    
    public AdminLehrstuhlStudiengang() {
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
				page = "login.jsp?returnto=AdminZuordnung";
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
			request.getRequestDispatcher("/admin_ls_sg.jsp").forward(request, response);
		} else {
			if(page.length() != 0) response.sendRedirect(page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lehrstuhl = request.getParameter("lehrstuhl");
		String inhaber = request.getParameter("inhaber");
		String gruppe = request.getParameter("gruppe");
		String studiengang = request.getParameter("studiengang");
		String page = "";
		
		try {
			if(lehrstuhl != null && inhaber != null && gruppe != null) {
				int g = Integer.parseInt(gruppe);
				
				db.addBetreuer(inhaber, lehrstuhl, g);
				
				page = "AdminLehrstuhlStudiengang";
			} else if(studiengang != null) {
				db.addStudiengang(studiengang);
				page = "admin_ls_sg.jsp";
			} else {
				page = "admin_ls_sg.jsp?error=1";
			}
		} catch(SQLException e) {
			page = "admin_ls_sg.jsp?error=2";
		} catch(NumberFormatException e) {
			page = "admin_ls_sg.jsp?error=3";
		}
		
		response.sendRedirect(page);
	}

}
