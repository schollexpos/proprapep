

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;

@WebServlet("/Aktivierung")
public class Aktivierung extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
       
 
    public Aktivierung() {
        super();
        db = new Database();
        db.connect();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String key = request.getParameter("key");
		
		if(email == null) email = "???";
		if(key == null) key = "???";
		String page = "index";
		try {
			if(db.validateEmail(email, key)) {
				page = "index?plzactivate=yay&email=" + email;
			} else {
				page = "index?plzactivate=no";
			}
		} catch (SQLException e) {
			page = "index?activationsuccess=-1";
		}
		
		response.sendRedirect(page);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
