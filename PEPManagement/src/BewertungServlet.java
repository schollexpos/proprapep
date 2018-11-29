

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BewertungServlet")
public class BewertungServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
	
    public BewertungServlet() {
        super();
        
        db = new Database();
        db.connect();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		

		response.getWriter().append("Served at: ").append(request.getContextPath());
        List<Bewertungskriterium> kriterien = new ArrayList<Bewertungskriterium>();

        try {          
            ResultSet resultSet = db.listKriterien();         
            while (resultSet.next()) {
            	Bewertungskriterium bewertungskriterium = new Bewertungskriterium();
            	bewertungskriterium.setHauptkriterium(resultSet.getString("hauptkriterium"));
            	bewertungskriterium.setTeilkriterium(resultSet.getString("teilkriterium"));
            	bewertungskriterium.setMaxpunkte(resultSet.getInt("maxpunkte"));
            	kriterien.add(bewertungskriterium);
            }
            
            request.setAttribute("kriterien", kriterien); // Will be available as ${kriterien} in JSP
            request.getRequestDispatcher("bewertung.jsp").forward(request, response);
            
        } catch (SQLException e) {
			System.out.println("SQLError in BewertungServlet.java: " + e.getMessage());		
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String hauptkriterium = request.getParameter("hauptkriterium");
		String teilkriterium = request.getParameter("teilkriterium");
		String maxpunkte =request.getParameter("maxpunkte");
		String page = "";		
		System.out.println(hauptkriterium + " " + teilkriterium + " " + maxpunkte );
		
//		TODO: Fehlerbehandlung in der JSP 
		if(hauptkriterium == null || teilkriterium == null || maxpunkte == null) {
			System.out.println("Error null");
			page = "bewertung.jsp?error=1";			
		} else {			
			try {
				db.addKriterium(hauptkriterium, teilkriterium, Integer.parseInt(maxpunkte));
				page = "BewertungServlet";
				System.out.println("geschafft");
				
			} catch (SQLException e) {
				System.out.println("SQLError in BewertungskriteriumServlet.java: " + e.getMessage());
				page = "bewertung.jsp?error=1";
			}
		}
		doGet(request, response);
	}

}
