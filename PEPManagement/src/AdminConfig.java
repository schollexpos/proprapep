
//Hello


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
import pepmanagement.FileManager;
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
		
		//TODO: Semester abschließen
		String maxfilesize = request.getParameter("filesize");
		String deadlinereg = request.getParameter("register-frist");
		
		String deadlinedok  = request.getParameter("dokumentation-frist");
		String deadlinekube = request.getParameter("kurzbeschreibung-frist");
		String deadlinepo = request.getParameter("poster-frist");
		String deadlineprae = request.getParameter("praesentation-frist");
		
		String zcStudenten = request.getParameter("zc-student");
		String zcAdmin = request.getParameter("zc-admin");
		String zcJuror = request.getParameter("zc-juror");
		String changeFreigabe = request.getParameter("freigabe");
		String ende = request.getParameter("Ende");
		
		boolean download = false;
		
		try {
			if(deadlinereg != null) {
				System.out.println(deadlinereg);
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlinereg).getTime());
				
				db.setDeadlineRegistrierung(d);
			} else if(deadlinedok != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlinedok).getTime());
				
				db.setDeadlineDokumentation(d);
			} else if(deadlinekube != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlinekube).getTime());
				
				db.setDeadlineKurzbeschreibung(d);
			} else if(deadlinepo != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlinepo).getTime());
				
				db.setDeadlineKurzbeschreibung(d);
			} else if(deadlineprae != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				
				d = new Date(format.parse(deadlineprae).getTime());
				
				db.setDeadlinePraesentation(d);
			} else if(zcStudenten != null) {
				db.setStudentZugangscode(zcStudenten);
			} else if(zcAdmin != null) {
				db.setAdminZugangscode(zcAdmin);
			} else if(zcJuror != null) {
				db.setJurorZugangscode(zcJuror);
			} else if(changeFreigabe != null) {
				db.setBewertungOpen(!db.bewertungOpen());				
			} else if(maxfilesize != null) {
				db.setMaxfilesize(Integer.parseInt(maxfilesize));
			} else if (ende != null) {
				if(FileManager.zipAllTeams()){
					System.out.println("Packen abgeschlossen!");
					download = true;
					db.deleteSemester();
				} else {
					System.out.println("Fehler beim Zippen");
				}
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
		
		if(download == false) {
			AccountControl.processResult(res, request, response, "AdminConfig", "admin_config.jsp", true);
		} else {
			performTask(FileManager.getBasePath(), "alles.zip", request, response);
		}
		
		
		
		
	}
	
	private void performTask(String path, String filename, HttpServletRequest request, HttpServletResponse response) throws ServletException,
	IOException {
		String contextPath = getServletContext().getRealPath(File.separator);
		File pdfFile = new File(path + filename);
		
		response.setContentType("application/zip");
		response.addHeader("Content-Disposition", "attachment; filename=" + filename);
		response.setContentLength((int) pdfFile.length());
		
		FileInputStream fileInputStream = new FileInputStream(pdfFile);
		OutputStream responseOutputStream = response.getOutputStream();
		int bytes;
		while ((bytes = fileInputStream.read()) != -1) {
			responseOutputStream.write(bytes);
		}
		
	}

}
