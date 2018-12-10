
//Hello


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

@WebServlet("/AdminPersoenlich")
public class AdminPersoenlich extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Database db;
    
    public AdminPersoenlich() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.JUROR, db, request, response);
		
		if(res == AccountControl.Result.SUCCESS) {
			try {
				Session session = new Session(db, request);
				session.restore(request);
				
				int uID = db.getUserID(session.getEmail());
				Database.User u = db.getUser(uID);
				
				request.setAttribute("user", u);
			} catch (SQLException e) {
				res = AccountControl.Result.DBERROR;
			}
		}
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}
		
		AccountControl.processResult(res, request, response, "StudentPersoenlich", "student_persoenlich.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.JUROR, db, request, response);
		
		String oldPW = request.getParameter("oldpw");
		String newPW1 = request.getParameter("newpw1");
		String newPW2 = request.getParameter("newpw2");
		
		if(res == AccountControl.Result.SUCCESS) {
			try {
				Session session = new Session(db, request);
				session.restore(request);
				
				int uID = db.getUserID(session.getEmail());
				Database.User u = db.getUser(uID);
				
				request.setAttribute("user", u);
				
				if(oldPW != null && newPW1 != null && newPW2 != null) {
					if(newPW1.equals(newPW2)) {
						if(db.loginUser(session.getEmail(), oldPW)) {
							db.setPasswort(u.getID(), newPW1, session.getEmail());
						}
					} else {
						
					}
				}
			} catch (SQLException e) {
				res = AccountControl.Result.DBERROR;
			}
		}
		
		AccountControl.processResult(res, request, response, "AdminPersoenlich", "admin_persoenlich.jsp");
	}

}
