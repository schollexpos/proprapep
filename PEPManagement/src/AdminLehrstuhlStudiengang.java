import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;
import pepmanagement.Session;

//Hello

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
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}

		AccountControl.processResult(res, request, response, "AdminLehrstuhlStudiengang", "admin_ls_sg.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lehrstuhl = request.getParameter("lehrstuhl");
		String inhaber = request.getParameter("inhaber");
		String gruppe = request.getParameter("gruppe");
		String studiengang = request.getParameter("studiengang");
		String kuerzel  = request.getParameter("kuerzel");
		String cgruppe = request.getParameter("cgruppe");
		String betreuerId = request.getParameter("ID");
		String page = "";
		
		try {
			if(lehrstuhl != null && kuerzel != null && inhaber != null && gruppe != null) {
				int g = Integer.parseInt(gruppe);
				
				db.addBetreuer(inhaber, kuerzel, lehrstuhl, g);
				
				page = "AdminLehrstuhlStudiengang";
			} else if(studiengang != null) {
				db.addStudiengang(studiengang);   
				page = "admin_ls_sg.jsp";
			} else if(cgruppe != null) {
			
				db.changeBetreuerGruppe(Integer.parseInt(betreuerId), Integer.parseInt(cgruppe));
				page="admin_ls_sg.jsp";
			}
			
			else {
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
