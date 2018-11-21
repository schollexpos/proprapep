

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db; 
 
    public RegisterServlet() {
        super();
        
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String page = "";
		Session session = new Session(db, request);
		
		//TODO: Clean up inputs
		
		if(email == null || password == null) {
			page = "register.jsp?error=1";
		} else if(password.length() < 8) {
			page = "register.jsp?error=5";
		} else if(!email.endsWith("uni-siegen.de") || !email.contains("@")) {
			page = "register.jsp?error=3";
		} else {
			//TODO: email verification
			try {
				if(db.emailExists(email)) {
					page = "register.jsp?error=4";
				} else { 
					db.registerUser(email, password);
					session.create(email); 
					page = "index";
				}
			} catch (SQLException e) {
				System.out.println("SQLError in RegisterServlet.java: " + e.getMessage());
				page = "register.jsp?error=2";
			}
		}
		response.sendRedirect(page);
	}

}
