

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

import pepmanagement.Bewertungskriterium;
import pepmanagement.Database;

@WebServlet("/JurorBewertung")
public class JurorBewertung extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
	
    public JurorBewertung() {
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
            request.getRequestDispatcher("juror_bewertung.jsp").forward(request, response);
            
        } catch (SQLException e) {
			System.out.println("SQLError in JurorBewertung.java: " + e.getMessage());		
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
			page = "juror_bewertung.jsp?error=1";			
		} else {			
			try {
				db.addKriterium(hauptkriterium, teilkriterium, Integer.parseInt(maxpunkte));
				page = "JurorBewertung";
				System.out.println("geschafft");
				
			} catch (SQLException e) {
				System.out.println("SQLError in BewertungskriteriumServlet.java: " + e.getMessage());
				page = "juror_bewertung.jsp?error=1";
			}
		}
		doGet(request, response);
	}

}
