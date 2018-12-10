import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.Database;
import pepmanagement.Session;

//Hello

@WebServlet("/index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database database;
       
    public Index() {
        super();
        
        database = new Database();  
        database.connect();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Session session = new Session(database, request);
			
			String message = "";
			if(session.restore(request)) {
				message = "You're logged in as\n" + session.getEmail();
				int uID = database.getUserID(session.getEmail());
				if(database.userIsAdmin(uID)) message += " [A]";
				else if(database.userIsJuror(uID)) message += " [J]";
				
				request.setAttribute("loggedin", new Boolean(true));
			} else {
				message += "You're not logged in!";
				request.setAttribute("loggedin", new Boolean(false));
			}
			
			 request.setAttribute("message", message); // This will be available as ${message}
		     request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
