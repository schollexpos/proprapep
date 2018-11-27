

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

@WebServlet("/BerwertungServlet")
public class BerwertungServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
	
    public BerwertungServlet() {
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
			System.out.println("SQLError in BewertungsServlet.java: " + e.getMessage());		
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
