

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
	
    public LoginServlet() {
        super();
        db = new Database();
        db.connect();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * LOGIN Order:
		 * 1) Check if both email and password were filled out correctly
		 * 2) Check if the password correct (ask the database)
		 * 3) Create the session
		 * 4) Add the session in the database, so it can be validated
		 */
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String page = "";
		Session session = new Session(db, request);
		
		//TODO: Clean up inputs
		
		//TODO: login.jsp can recieve a "returnto" parameter via get!
		
		if(email == null || password == null) {
			page = "login.jsp?error=1";
		} else {
			try {
				if(db.loginUser(email, password)) {
					session.create(email);
					page = "index";
				} else {
					page = "login.jsp?error=3";
				}
			} catch(SQLException e) {
				System.out.println("SQL Error in LoginServlet: " + e.getMessage());
				page = "login.jsp?error=2";
			}
		}
		
		response.sendRedirect(page);
	}

}
