import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			
			ResultSet result = database.executeQuery("SELECT vorname, nachname FROM student LIMIT 10;");
			String message = "";
			while (result.next())  { 
				message = result.getString(1) + " " + result.getString(2);
	    	}
			
			if(session.restore(request)) {
				message += "<br />You're logged in as " + session.getEmail();
				request.setAttribute("loggedin", new Boolean(true));
			} else {
				message += "<br />You're not logged in!";
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
