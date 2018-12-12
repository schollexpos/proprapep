

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;

@WebServlet("/DeleteLSSG")
public class DeleteLSSG extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Database db;
   
    public DeleteLSSG() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		System.out.print("PEPTER\n");
		
		if(res == AccountControl.Result.SUCCESS) {
			if(request.getParameter("betreuer") != null) {
				try {
					int betreuerID = Integer.parseInt(request.getParameter("betreuer"));
					db.deleteBetreuer(betreuerID);
				} catch(Exception e) {}
			} else if(request.getParameter("studiengang") != null) {
				System.out.print("PEPTER "+ request.getParameter("studiengang") + "\n");
				
				try {
					ArrayList<String> stuList = db.getStudiengaenge();
					int studiengangID = Integer.parseInt(request.getParameter("studiengang"));
					db.deleteStudiengang(stuList.get(studiengangID));
				} catch(Exception e) {
					System.out.println("DeleteLSSG: " + e.getMessage());
				}
				
			} if(request.getParameter("kriterium") != null) {
				try {
					int kritID = Integer.parseInt(request.getParameter("kriterium"));
					db.deleteKriterium(kritID);
				} catch(Exception e) {}
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
