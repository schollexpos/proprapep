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
		
	}

}
