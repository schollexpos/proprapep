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

//Hello


@WebServlet("/StudentRegister")
public class StudentRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
 
    public StudentRegister() {
        super();
        

        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}
		
		try {
			if(Database.dateReached(db.getDeadlineRegistrierung())) request.setAttribute("error", 10);
		} catch (SQLException e) {}
		
		response.sendRedirect("student_register.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String vorname = request.getParameter("vorname");
		String nachname = request.getParameter("nachname");
		String zugangscode = request.getParameter("zugangscode");
		String matrikelNo = request.getParameter("matrikelno");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String passwordWdh = request.getParameter("password2");
		String vorsitz = request.getParameter("vorsitz");
		String studiengang = request.getParameter("studiengang");
		
		
		String page = "";
		Session session = new Session(db, request);
		
		if(session.restore(request)) {
			page = "index";
		} else if(vorname == null || studiengang == null || nachname == null || zugangscode == null || matrikelNo == null || passwordWdh == null || vorsitz == null || email == null || password == null) {
			page = "student_register.jsp?error=1";
		} else if(password.length() < 8) {
			page = "student_register.jsp?error=5";
		} else if(!email.endsWith("uni-siegen.de")) {
			System.out.println("EAIL: >>" + email + "<<");
			page = "student_register.jsp?error=3";
		} else if(!password.equals(passwordWdh)) {
			page = "student_register.jsp?error=6";
		} else if(vorname.length() < 2 || vorname.length() < 2 || studiengang.length() < 2) {
			page = "student_register.jsp?error=7";
		} else if(!zugangscode.equals("") && !zugangscode.equals(db.getStudentZugangscode())) {
			page = "student_register.jsp?error=8";
		} else {
			try {
				int matNo = Integer.parseInt(matrikelNo);
				int vorsitzender = Integer.parseInt(vorsitz);
				
				if(db.emailExists(email)) {
					page = "student_register.jsp?error=4";
				} else if(Database.dateReached(db.getDeadlineRegistrierung())) {
					page = "student_register.jsp?error=10";
				} else { 
					db.registerUser(email, password);
					int userID = db.getUserID(email);
					db.registerStudent(matNo, userID, vorname, nachname, studiengang, -1, vorsitzender == 1);
					
					String email64 = StringXORer.base64Encode(email);
					String key = db.getValidationKey(email);
					
					String link = "http://localhost:8080/PEPManagement/Aktivierung?email=" + email64 + "&key=" + key;
					
					MailConnection.sendMail(email, "pep@pottproductions.de", "Registrierung beim PEP", "Diese E-Mail Adresse wurde für das Planungs- und Entwicklungsprojekt registriert.\n\n Um die Registrierung abzuschliessen, öffnen Sie bitte folgenden Link in ihrem Internetbrowser: \n"
								+ "<a href=\"" + link + "\" title=\"Bestätigungslink\">" + link + "</a>\n\nWenn Sie sich nicht registriert haben, machen Sie einfach gar nichts.");
					
					
				
					page = "index?plzactivate=1";
					
				}
			} catch (SQLException e) {
				System.out.println("SQLError in RegisterServlet.java: " + e.getMessage());
				page = "student_register.jsp?error=2";
			} catch(NumberFormatException e) {
				page = "student_register.jsp?error=9";
			}
		}
		response.sendRedirect(page);
	}

}
