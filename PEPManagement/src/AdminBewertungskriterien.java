import pepmanagement.AccountControl;
import pepmanagement.Bewertungskriterium;
import pepmanagement.Database;
import pepmanagement.Database.Betreuer;
import pepmanagement.Database.Team;
import pepmanagement.Session;

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
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		} 

        try {
            ArrayList<Bewertungskriterium> kriterien = db.getKriterien();   			
            request.setAttribute("kriterien", kriterien); // Will be available as ${kriterien} in JSP
            
        } catch (SQLException e) {
			System.out.println("SQLError in AdminBewertung.java: " + e.getMessage());		
        }
		AccountControl.processResult(res, request, response, "AdminBewertungskriterien", "admin_bewertungskriterien.jsp");

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
				request.setAttribute("error", "2");
				e.printStackTrace();
			}
		} else if (request.getParameter("zuweisung") != null) {
			try {
				jurorZuweisen(request,response);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		
	}
	protected void jurorZuweisen(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int jurorid = -1;
		int gruppe = -1;
		ArrayList<String> juroren = db.getJuroren();
		for (int i=0; i<juroren.size(); i++) {
			if(request.getParameter("jurorid" + i).equals("")) {
				continue;
			}
			try {
			jurorid = Integer.parseInt(request.getParameter("jurorid" + i));
			gruppe = Integer.parseInt(request.getParameter("gruppe" + i));
			} catch(NumberFormatException e) {
				
			}

			db.setJurorGruppe(jurorid, gruppe);
		}
		
		doGet(request, response);

	}
	
	protected void addKriterium(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		String hauptkriterium = request.getParameter("hauptkriterium");
		String teilkriterium = request.getParameter("teilkriterium");
		String minpunkte = request.getParameter("minpunkte");
		String maxpunkte =request.getParameter("maxpunkte");
		
		if(hauptkriterium.equals("") || teilkriterium.equals("") || maxpunkte.equals("") || minpunkte.equals("")) {
			request.setAttribute("error", "1");
			System.out.println("Keine Angaben!");
		} else {
			try {
				db.setKriterium(hauptkriterium, teilkriterium, Integer.parseInt(maxpunkte), Integer.parseInt(minpunkte));
			} catch(NumberFormatException e) {
				request.setAttribute("error", "2");
			}
		}
		doGet(request,response);

	}
	
	
	protected void deleteKriterium(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		String deleteTeilkriterium = request.getParameter("teilkriterium");
		String deleteHauptkriterium = request.getParameter("hauptkriterium");
		if (deleteHauptkriterium.equals("") && deleteTeilkriterium.equals("")) {
			request.setAttribute("error", "1");;
		} else if (deleteHauptkriterium.equals("") && !deleteTeilkriterium.equals("")) {			
			db.deleteTeilkriterium(deleteTeilkriterium);			
		} else if (!deleteHauptkriterium.equals("")) {
			db.deleteHauptkriterium(deleteHauptkriterium);
		}
		doGet(request,response);
		
	}	
}
