package pepmanagement;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//Hello


public class AccountValidator {
	/* Makes sure a user who accesses the Servlet has the necessary rights.
	 * There are two ways to accomplish this:
	 * 
	 *		1) making an object and calling ensureRank() at the beginning
	 *			and processResult() at the end of your doX method in the Servlet,
	 *			which gives detailed information on how the verification went
	 *			(maybe the user lacks rights, or needs to login..) and automatically
	 *			forwards the user to the appropriate page
	 *				Probably the right thing in a GET-request, as error messages are shown
	 *				and other user friendly stuff
	 *
	 *		2) Calling the static method hasRank(), which just gives true if
	 *			everything is okay (or false in case of any error etc.)
	 *				Probably the right thing in a POST-request, when you just want to
	 *				put the FORM-contents in the database
	 */
	
	
	ArrayList<Pair<String,String>> parameter;
	AuthenticatedServlet servlet;
	HttpServletRequest request;
	HttpServletResponse response;
	Session session;
	Database db;
	Database.User user = null;
	boolean authenticated = false;
	Result result = Result.SUCCESS;
	String customErrorCode = "";
	
	public enum UserRank {
		ADMIN,
		JUROR,
		STUDENT,
		VORSITZ,
		NONE
	}
	
	public enum Result {
		SUCCESS,
		NEEDSLOGIN,
		NEEDSRIGHTS,
		DBERROR,
		ERROR,
		ALREADYLOGGEDIN,
		CUSTOMERROR
	}
	
	public AccountValidator(AuthenticatedServlet servlet, HttpServletRequest request, HttpServletResponse response) {
		/* Creates the AccountValidator, the Session and the User.
		 * 
		 * The user can be null, if either the session can't be
		 * restored (not logged in) or he doesn't exist in the
		 * DB. 
		 */
		this.parameter = new ArrayList<Pair<String,String>>();
		this.servlet = servlet;
		this.db = servlet.getDatabase();
		this.request = request;
		this.response = response;
		this.session = new Session(db, request);
		
		if(session.restore(request)) {
			try {
				user = db.getUser(db.getUserID(session.getEmail()));
				
				if(user == null) {
					System.out.println("[WARN] AccountValidator: User tried to access restricted page with non-existent Account" + session.getEmail());
				}
			} catch(SQLException e) {
				System.out.println("[ERR.] AccountValidator: SQL Exception in Constructor: " + e.getMessage());
				result = Result.DBERROR;
			}
		}
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}
	}
	
	public Result ensureRank(UserRank admin) throws ServletException, IOException {
		/* Checks if the user is logged in and has the rank "rank".
		 * Sets the hasAccess-Attribute in case of success (and only then).
		 *  
		 * Returns SUCCESS only if everything goes right,
		 * NEEDSLOGIN or NEEDSRIGHTS if the user lacks login or rights to perform the action
		 * DBERROR or ERROR in case of error
		 * 
		 * Then you can check for SUCCESS and add the parameters that your JSP needs
		 * or do other stuff you want to do.
		 * 
		 * you should also checkout processResult
		 */
		
		if(admin == UserRank.NONE) {
			result = (user == null ? Result.SUCCESS : Result.ALREADYLOGGEDIN);
		} else {
			try {
				if(user == null)
					result = Result.NEEDSLOGIN;
				else if(!hasRank(db, user, admin))
						result =  Result.NEEDSRIGHTS;
			} catch (SQLException e) {
				System.out.println("[Error] AccountValidator: SQL Exception in Constructor: " + e.getMessage());
				result = Result.DBERROR;
			} catch(Exception e) {
				result = Result.ERROR;
			}
		}
		
		authenticated = (result == Result.SUCCESS);
		
		return result;
	}
	
	public void processResult() throws ServletException, IOException {
		processResult(false);
	}
	
	public void processResult(boolean jspError) throws ServletException, IOException {
		/* Takes a result and displays the necessary information.
		 * In case of success, it forwards the user to the jsp,
		 * In case of lack of login/rights it redirects him to an appropriate page,
		 * in case of error, it displays an error message (jspError = false) or returns
		 * an error code (1 for DB, 2 for everything else) to the jsp
		 * 
		 * You should call this function after you have added all the parameters to your request.
		 */
		
		
		
		//TODO if validated: show page
		
		String page = "";
		switch(result) {
		case SUCCESS:
			if(result == Result.SUCCESS) request.setAttribute("hasAccess", new Boolean(true));
			break;
		case ALREADYLOGGEDIN:
			page = "index";
			break;
		case NEEDSLOGIN:
			page = "login.jsp?returnto=" + servlet.getServletFilename();
			break;
		case NEEDSRIGHTS:
			page = "401.html";
			break;
		case DBERROR:
			if(authenticated || jspError) {
				page = servlet.getJSPFilename();
				this.addParameter("error", "3");
			} else {
				response.getWriter().append("Encountered an database-error while serving your request.\n").append(request.getContextPath());
			}
		case ERROR:
	    	if(authenticated || jspError) {
	    		page = servlet.getJSPFilename();
	    		this.addParameter("error", "2");
			} else {
		    	response.getWriter().append("Encountered an error while serving your request.").append(request.getContextPath());
			}
		case CUSTOMERROR:
			if(authenticated || jspError) {
				page = servlet.getJSPFilename();
				this.addParameter("error", customErrorCode);
			} else {
		    	response.getWriter().append("Encountered an special error while serving your request. Error Code #" + customErrorCode + " ").append(request.getContextPath());
			}
		default:
			break;
		}
		
		System.out.println("== AccountValidator ===");
		System.out.println("Page: " + page + " JSP: " + servlet.getJSPFilename());
		System.out.println("Autheticated: " + (authenticated ? "true" : false) + " User: " + (user == null ? "null" : user.getEmail()));
		System.out.println("Result: " + result);
		for(Pair<String,String> p : parameter ) {
			System.out.println("\tParam[" + p.x + "] = " + p.y);
		}
		
		if(result == Result.SUCCESS) {
			page = servlet.getJSPFilename();
			
		}
		
		if(page.length() != 0) {
			String parameterStr = this.compileParameters();
			
			page += parameterStr;
			System.out.println("Parameter Stringo " + page);
			request.getRequestDispatcher(page).forward(request, response);
		}
		
	}
	
	public void setErrorCode(String ec) {
		customErrorCode = ec;
		result = Result.CUSTOMERROR;
	}
	
	public Database.User getUser() {
		return user;
	}
	
	public void addParameter(String parameter, String value) {
		this.parameter.add(new Pair<String,String>(parameter, value));
	}
	
	private String compileParameters() {
		String str = "";
		for(int i = 0;i < parameter.size();i++) {
			str += (i == 0 ? "?" : "&");
			str += parameter.get(i).x + "=" + parameter.get(i).y;
			request.setAttribute(parameter.get(i).x, parameter.get(i).y);
		}
		
		return str;
	}
	
	public static boolean hasRank(Database db, Database.User user, UserRank rank) throws SQLException {
		switch(rank) {
		case ADMIN:
			return user.isAdmin();
		case JUROR:
			return user.isJuror();
		case STUDENT:
			return user.isStudent();
		case VORSITZ:
			return hasRank(db, user, UserRank.STUDENT) && db.getStudent(user.getID()).isVorsitz();
		default:
			return false;	
		}
	}
	
	public static boolean hasRank(HttpServletRequest request, Database db, UserRank rank) {
		/*
		 * A small & fast method to ensure the user has the required Rank, if you don't
		 * want to bother with an AccountValidator Object and all the necessary functions.
		 */
		
		Session session = new Session(db, request);
		if(!session.restore(request)) {
			try {
				Database.User user = db.getUser(db.getUserID(session.getEmail()));
				return hasRank(db, user, rank);
			} catch(Exception e) {
				return false;
			}
		} else {
			return rank == UserRank.NONE;
		}
	}
}
