package pepmanagement;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AccountControl {
	
	/* TODO: nicht mehr statisch, session undso mit dem servlet teilen,
	 * am besten den user immer als objekt an die request dranklatschen um es dem jsp
	 * einfach zu machen
	 */
	
	public enum UserRank {
		ADMIN,
		JUROR,
		STUDENT,
		VORSITZ
	}
	
	public enum Result {
		SUCCESS,
		NEEDSLOGIN,
		NEEDSRIGHTS,
		DBERROR,
		ERROR
		//Neu: Custom (-error) mit möglichkeit error code zu setzen
	}
	
	private static boolean hasRank(Database db, Database.User user, UserRank rank) {
		switch(rank) {
		case ADMIN:
			return user.isAdmin();
		case JUROR:
			return user.isJuror();
		case STUDENT:
			return user.isStudent();
		case VORSITZ:
			try {
				System.out.println(">>" + user.getID());
				return user.isStudent() && db.getStudent(user.getID()).isVorsitz();
			} catch (SQLException e) {
				System.out.println(":( " + e.getMessage());
				return false;
			}
		default:
				return false;	
		}
	}
	
	public static Result ensureRank(UserRank rank, Database db, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		 * */
		try {
			Session session = new Session(db, request);
			
			if(!session.restore(request)) {
				return Result.NEEDSLOGIN;
			} else {
				int userID = db.getUserID(session.getEmail());
				Database.User user = db.getUser(userID);
				
				if(!hasRank(db, user, rank)) {
					return Result.NEEDSRIGHTS;
				} else {
					request.setAttribute("hasAccess", new Boolean(true));
					return Result.SUCCESS;
				}
			}
	    } catch (SQLException e) {
	    	System.out.println("[ERROR] Database: " + e.getMessage());
	    	return Result.DBERROR;
	    } catch(Exception e) {
	    	return Result.ERROR;
	    }
	}
	
	public static void processResult(Result result, HttpServletRequest request, HttpServletResponse response, String servlet, String jsp) throws ServletException, IOException {
		processResult(result, request, response, servlet, jsp, false);
	}
	public static void processResult(Result result, HttpServletRequest request, HttpServletResponse response, String servlet, String jsp, boolean jspError) throws ServletException, IOException {
		/* Takes a result and displays the necessary information.
		 * In case of success, it forwards the user to the jsp,
		 * In case of lack of login/rights it redirects him to an appropriate page,
		 * in case of error, it displays an error message (jspError = false) or returns
		 * an error code (1 for DB, 2 for everything else) to the jsp
		 * 
		 * You should call this function after you have added all the parameters to your request.
		 */
		
		String page = "";
		switch(result) {
		case NEEDSLOGIN:
			page = "login.jsp?returnto=" + servlet;
			break;
		case NEEDSRIGHTS:
			page = "401.html";
			break;
		case DBERROR:
			if(jspError) {
				page = addParameter(jsp, "error", "1");
			} else {
				response.getWriter().append("[Encountered an database-error while serving your request.").append(request.getContextPath());
			}
		case ERROR:
	    	if(jspError) {
				page = addParameter(jsp, "error", "2");
			} else {
		    	response.getWriter().append("Encountered an error while serving your request.").append(request.getContextPath());
			}
		default:
			break;
		}
		
		System.out.println("Page: " + page + " JSP: " + jsp);
		
		if(result == Result.SUCCESS) {
			request.getRequestDispatcher(jsp).forward(request, response);
		} else {
			if(page.length() != 0) response.sendRedirect(page);
		}
	}
	
	private static String addParameter(String page, String parameter, String value) {
		String sep = (page.contains("?") ? "&" : "?");
		return page + sep + parameter + "=" + value;
	}
}
