
//Hello


import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.Database;
import pepmanagement.Session;


@WebServlet("/AdminConfig")
public class AdminConfig extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Database db;
	
    public AdminConfig() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}

		
		AccountControl.processResult(res, request, response, "AdminConfig", "admin_config.jsp");
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		//TODO: Semester abschlieﬂen
		
		String deadlinereg = request.getParameter("register-frist");
		String deadlineup  = request.getParameter("upload-frist");
		String zcStudenten = request.getParameter("zc-student");
		String zcAdmin = request.getParameter("zc-admin");
		String zcJuror = request.getParameter("zc-juror");
		String changeFreigabe = request.getParameter("freigabe");
		
		try {
			if(deadlinereg != null) {
				System.out.println(deadlinereg);
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlinereg).getTime());
				
				db.setDeadlineRegistrierung(d);
			} else if(deadlineup != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlineup).getTime());
				
				db.setDeadlineUpload(d);
			} else if(zcStudenten != null) {
				db.setStudentZugangscode(zcStudenten);
			} else if(zcAdmin != null) {
				db.setAdminZugangscode(zcAdmin);
			} else if(zcJuror != null) {
				db.setJurorZugangscode(zcJuror);
			} else if(changeFreigabe != null) {
				db.setBewertungOpen(!db.bewertungOpen());
			}
		} catch (ParseException e) {
			res = AccountControl.Result.ERROR;

			System.out.println(e);
		} catch (SQLException e) {
			res = AccountControl.Result.DBERROR;
			System.out.println(e);
		} catch (Exception e) {
			res = AccountControl.Result.ERROR;

			System.out.println(e);
		}
		
		AccountControl.processResult(res, request, response, "AdminConfig", "admin_config.jsp", true);
	}

}
