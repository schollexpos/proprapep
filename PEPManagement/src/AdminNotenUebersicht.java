
//Hello


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;

@WebServlet("/AdminNotenUebersicht")
public class AdminNotenUebersicht extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Database db;
   
    public AdminNotenUebersicht() {
        super();
        db = new Database();
        db.connect();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);

		
		
		AccountControl.processResult(res, request, response, "AdminNotenuebersicht", "admin_notenuebersicht.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
