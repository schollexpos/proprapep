import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;
import pepmanagement.MailConnection;
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
		//System.out.println("Can you hear me?");
		try {
			
			ArrayList<Database.Message> messages;
			
			Session session = new Session(database, request);
			
			String message = "";
			String page = "/index.jsp";
			int rank = 0;
			if(session.restore(request)) {
				message = "You're logged in as\n" + session.getEmail();
				int uID = database.getUserID(session.getEmail());
				if(database.userIsAdmin(uID)) {
					message += " [A]";
					messages = database.getAllMessages();
					rank = 2;
				} else if(database.userIsJuror(uID)) {
					message += " [J]";
					messages = database.getJurorMessages();
					rank = 1;
				} else {
					Database.Student student = database.getStudent(uID);
					int teamID = student.getTeamID();
					messages = database.getStudentMessage(teamID);
					request.setAttribute("teamID", new Integer(teamID));
					request.setAttribute("vorsitz", new Boolean(student.isVorsitz()));
					
					rank = 0;
				}
				
				request.setAttribute("loggedin", new Boolean(true));
				request.setAttribute("messages", messages);
				request.setAttribute("rank", new Integer(rank));
			} else {
				message += "You're not logged in!";
				request.setAttribute("loggedin", new Boolean(false));
				page = "/login.jsp";
			}
			
			 request.setAttribute("message", message); // This will be available as ${message}
		     request.getRequestDispatcher(page).forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, database, request, response);
		   
		try {
			int userCat = Integer.parseInt(request.getParameter("usercat"));
			int userTeam = Integer.parseInt(request.getParameter("userteam"));
			String textDe = request.getParameter("textde");
			String textEn = request.getParameter("texten");
			
			if(textDe.length() > 0 && textEn.length() > 0 ) {
				Database.Message m = database.getNewMessage();
				m.setRank(userCat);
				m.setTeam(userTeam);
				m.setMessage(textDe, textEn);
				m.setDate(new java.sql.Date(System.currentTimeMillis()));
				database.publishMessage(m);
			}
		} catch(SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} catch(NumberFormatException e) {
			System.out.println("NumberFormatException: " + e.getMessage());
		} catch(Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}
		
		
		doGet(request, response);
	}

}
