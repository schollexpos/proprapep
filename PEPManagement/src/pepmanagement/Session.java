package pepmanagement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.catalina.connector.Request;


//Hello


public class Session {
	HttpSession session;
	Database db;
	String email;
	
	public Session(Database database, HttpServletRequest request) {
		session = request.getSession();
		session.setMaxInactiveInterval(30*60);
		email = "null";
		db = database;
	}
	
	public Session(Database database, HttpSession tsession) {
		session = tsession;
		session.setMaxInactiveInterval(30*60);
		email = "null";
		db = database;
	}
	
	public void create(String temail) throws SQLException {
		/*
		 * Creates a new session and registers it in the database
		 */
		email = temail;
		session.setAttribute("email", email);
		db.addSession(email, session.getId());
		/*Cookie emailCookie = new Cookie("email", email);
		emailCookie.setMaxAge(30*60);
		response.addCookie(emailCookie);*/
	}
	
	public boolean restore(HttpServletRequest request) {
		/* 
		 * Restores a session. Returns true only if the cookie is
		 * set and the session is registered in the database.
		 */
		
		System.out.println(session.getAttribute("email"));
		if(session.getAttribute("email") == null) return false;
		
		email = (String) session.getAttribute("email");
		String sessionID = session.getId();
		System.out.println(sessionID);
		/*
		Cookie[] cookies = request.getCookies();
		if(cookies !=null){
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
			}
		}*/	
		boolean valid = false;
		try { 
			valid = db.verifySession(email,sessionID);
		} catch(SQLException e) {
			
		}
		return valid;
	}
		
	public void invalidate()  {
		/* Invalidates the session, deleting it from the database */

		email = (String) session.getAttribute("email");
		session.invalidate();
		
		try {
			db.deleteSession(email);
		} catch (Exception e) {
		}
	}
	
	public String getID() {
		return session.getId();
	}
	
	public String getEmail() {
		return email;
	}
}
