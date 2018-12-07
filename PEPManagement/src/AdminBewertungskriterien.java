import pepmanagement.Bewertungskriterium;
import pepmanagement.Database;

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


//Hello


@WebServlet("/AdminBewertungskriterien")
public class AdminBewertungskriterien extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
	
    public AdminBewertungskriterien() {
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
            request.getRequestDispatcher("admin_bewertungskriterien.jsp").forward(request, response);
            
        } catch (SQLException e) {
			System.out.println("SQLError in AdminBewertung.java: " + e.getMessage());		
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("addKriterium") != null) {
			try {
				addKriterium(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (request.getParameter("deleteKriterium") != null) {
			try {
				deleteKriterium(request,response);
			} catch (SQLException e) {
				request.setAttribute("datenbankfehler", "datenbankfehler");
				e.printStackTrace();
			}
		}
		
		
	}
	
	
	protected void addKriterium(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		String hauptkriterium = request.getParameter("hauptkriterium");
		String teilkriterium = request.getParameter("teilkriterium");
		String maxpunkte =request.getParameter("maxpunkte");
		String page = "";		
		System.out.println(hauptkriterium + " " + teilkriterium + " " + maxpunkte );
		
//		TODO: Fehlerbehandlung in der JSP 
		if(hauptkriterium == null || teilkriterium == null || maxpunkte == null) {
			System.out.println("Keine Angaben!");
		} else {			
			db.addKriterium(hauptkriterium, teilkriterium, Integer.parseInt(maxpunkte));
			page = "AdminBewertungskriterien";
			System.out.println("geschafft");
		}
		doGet(request, response);
	}
	
	
	protected void deleteKriterium(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		String deleteTeilkriterium = request.getParameter("teilkriterium");
		String deleteHauptkriterium = request.getParameter("hauptkriterium");
		System.out.println(deleteTeilkriterium + " " + deleteHauptkriterium);
		if (deleteHauptkriterium == null && deleteTeilkriterium == null) {
			System.out.println("Felder leer");
		} else if (deleteHauptkriterium != null && deleteTeilkriterium != null) {			
			db.deleteTeilkriterium(deleteTeilkriterium);			
		} else if (deleteHauptkriterium != null && deleteTeilkriterium == null) {
			db.deleteHauptkriterium(deleteHauptkriterium);
		}
		doGet(request,response);
		
	}
	
	
	
	
	
}
