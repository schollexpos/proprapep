import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;
import pepmanagement.Session;


//Hello


@WebServlet("/AdminTeamDetails")
public class AdminTeamDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
       
    
    public AdminTeamDetails() {
        super();
        db = new Database();
        db.connect();
    } 
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		String add = "";
		if(res == AccountControl.Result.SUCCESS) {
			if(request.getParameter("teamid") != null) {
				add = "?teamid=" + request.getParameter("teamid");
			}
			   
		}
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}

		AccountControl.processResult(res, request, response, "AdminTeamDetails", "admin_teamdetails.jsp" + add);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID = request.getParameter("matrikelnummer");
		String name = request.getParameter("name");
		String vorname = request.getParameter("vorname");
		String studiengang = request.getParameter("studiengang");
		String email = request.getParameter("email");
		String teamID = request.getParameter("team");
		
		String page = "";
		
		if(userID == null || name == null || vorname == null || studiengang == null || email == null) {
			page = "AdminTeamDetails?error=1&teamid=" + teamID;
		} else if(!email.endsWith("@student.uni-siegen.de")){
			page = "AdminTeamDetails?error=4&teamid=" + teamID;
		} else {
			try {
				int uID = Integer.parseInt(userID);
				
				db.updateStudent(uID, vorname, name, email, studiengang);
				page = "AdminTeamDetails?teamid=" + teamID;
			} catch(NumberFormatException e) {
				page = "AdminTeamDetails?error=3&teamid=" + teamID;
			} catch (SQLException e) {
				page = "AdminTeamDetails?error=2&teamid=" + teamID;
				System.out.println(e.getMessage());
			}
		}
		
		response.sendRedirect(page);
	}

}
