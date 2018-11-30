

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;

@WebServlet("/AdminBewertungskriterien")
public class AdminBewertungskriterien extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db; 
 
    public AdminBewertungskriterien() {
        super();
        
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("admin_bewertungskriterien.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hauptkriterium = request.getParameter("hauptkriterium");
		String teilkriterium = request.getParameter("teilkriterium");
		String maxpunkte =request.getParameter("maxpunkte");
		String page = "";		
		
		
		if(hauptkriterium == null || teilkriterium == null || maxpunkte == null) {
			page = "admin_bewertungskriterien.jsp?error=1";			
		} else {			
			try {				
				db.addKriterium(hauptkriterium, teilkriterium, Integer.parseInt(maxpunkte));
				page = "admin_bewertungskriterien.jsp";
			
			} catch (SQLException e) {
				System.out.println("SQLError in BewertungskriteriumServlet.java: " + e.getMessage());
				page = "admin_bewertungskriterien.jsp?error=1";
			}
		}
		response.sendRedirect(page);	
	}

}