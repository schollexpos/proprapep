

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database database;
   
    public Logout() {
        super();
        
        database = new Database();  
        database.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = new Session(database, request);
		
		if(session.restore(request)) {
			session.invalidate();
		}
		
		 request.getRequestDispatcher("/index").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
