//TODO: Admin & Juror zugangscodes

//Hello

//Hello


import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.MailConnection;
import pepmanagement.Session;
import pepmanagement.StringXORer;

@WebServlet("/AdminRegister")
public class AdminRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db; 
 
    public AdminRegister() {
        super();
        
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}

		
		response.sendRedirect("admin_register.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String passwordw = request.getParameter("password2");
		String zugangscode = request.getParameter("zugangscode");
		String page = "";
		Session session = new Session(db, request);
		
		//TODO: Clean up inputs
		
		if(email == null || password == null || null == zugangscode) {
			page = "admin_register.jsp?error=1";
		} else if(!password.equals(passwordw)) {
			page = "admin_register.jsp?error=7";
		} else if(password.length() < 8) {
			page = "admin_register.jsp?error=5";
		} else if(!email.endsWith("uni-siegen.de") || !email.contains("@")) {
			page = "admin_register.jsp?error=3";
		} else if(session.restore(request)) {
			page = "index";
		} else {
			try {
				String adminCode = db.getAdminZugangscode();
				String jurorCode = db.getJurorZugangscode();
				
				if(db.emailExists(email)) {
					page = "admin_register.jsp?error=4";
				} else if(!zugangscode.equals(adminCode) && !zugangscode.equals(jurorCode)){
					page = "admin_register.jsp?error=6";
				} else {		
					db.registerUser(email, password, (zugangscode.equals(adminCode) ? 12 : 11));
					
					if(zugangscode.equals(jurorCode)) {
						db.setJurorGruppe(db.getUserID(email), 1);
					}
					
					String email64 = StringXORer.base64Encode(email);
					String key = db.getValidationKey(email);
					
					MailConnection.sendMail(email, "pep@pottproductions.de", "Registrierung beim PEP", "Diese E-Mail Adresse wurde für das Planungs- und Entwicklungsprojekt registriert.\n\n Um die Registrierung abzuschliessen, öffnen Sie bitte folgenden Link in ihrem Internetbrowser: \n"
								+ "http://localhost:8080/PEPManagement/Aktivierung?email=" + email64 + "&key=" + key + "\n\nWenn Sie sich nicht registriert haben, machen Sie einfach gar nichts.");
					
					
					page = "index?plzactivate=1";
				}
			} catch (SQLException e) {
				System.out.println("SQLError in RegisterServlet.java: " + e.getMessage());
				page = "admin_register.jsp?error=2";
			}
		}
		response.sendRedirect(page);
	}

}
