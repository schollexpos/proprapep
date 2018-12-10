
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.eclipse.jdt.internal.compiler.ast.Literal;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;

import pepmanagement.AccountControl;
import pepmanagement.ContextGlue;
import pepmanagement.Database;
import pepmanagement.FileManager;
import pepmanagement.Session;


//Hello


@WebServlet("/StudentUpload")
public class StudentUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String filePath = "C:\\Users\\lucat\\git\\proprapep\\PEPManagement\\WebContent\\data\\";
	private Database db;
       
   
    public StudentUpload() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.VORSITZ, db, request, response);

		
		if(res == AccountControl.Result.SUCCESS) {
			long deadline = -1;
			
			// List of all the existing files
			ArrayList<pepmanagement.Pair<String,String>> list = new ArrayList<pepmanagement.Pair<String,String>>();
			
			Session session = new Session(db, request);
			session.restore(request);
			
			int teamID = -1;
			try {
				teamID = db.getTeamID(session.getEmail());
	    			
				for(int i = 0;i < FileManager.getFileCount();i++) {
					String date = "";
					
					if(FileManager.fileExists(filePath, teamID, FileManager.getFileIdentifier(i))) {
						SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
						long lastMod = FileManager.fileDate(filePath, teamID, FileManager.getFileIdentifier(i));
	    				
	    				date = sdf.format(lastMod);
					} else {
						date = "-";
					}
					
					deadline = db.getDeadlineUpload().getTime();
					list.add(new pepmanagement.Pair<String, String>(FileManager.getFileIdentifier(i), date));
				}
			} catch (SQLException e) {
				res = AccountControl.Result.ERROR;
			}
			
			
			request.setAttribute("list", list);
			request.setAttribute("deadline", new Long(deadline));
		}
		
		AccountControl.processResult(res, request, response, "StudentUpload", "student_upload.jsp", true);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		File file ;
	   int maxFileSize = 5000 * 1024;
	   int maxMemSize = 5000 * 1024;
	   
	   // Verify the content type
	   String contentType = request.getContentType();
	   String page = "";
	   
	   if ((contentType.indexOf("multipart/form-data") >= 0)) {
	      DiskFileItemFactory factory = new DiskFileItemFactory();
	      factory.setSizeThreshold(maxMemSize);
	      
	      // Location to save data that is larger than maxMemSize.
	      factory.setRepository(new File("c:\\temp"));

	      
	      ServletFileUpload upload = new ServletFileUpload(factory);
	      upload.setSizeMax(maxFileSize);
	      
	      try { 
	    	 Session session = new Session(db, request);
	    	 
	    	 if(session.restore(request) && db.studentIsVorsitzender(db.getUserID(session.getEmail()))) {
		    	 String filename = request.getParameter("filename");
		    	 
		    	 Enumeration<String> espeter = request.getParameterNames();
		    	 while(espeter.hasMoreElements()) System.out.println(">" + espeter.nextElement());
		    	 
		    	 
		    	 int teamID = db.getTeamID(session.getEmail());
		    	 
		         List<FileItem> fileItems = upload.parseRequest((RequestContext) new ContextGlue(request));
	
		         Iterator<FileItem> i = fileItems.iterator();
	
		         while (i.hasNext ()) {
		            FileItem fi = i.next();
		            if (!fi.isFormField ()) {
		               // Get the uploaded file parameters
		               String fieldName = fi.getFieldName();
		               String fileName = fi.getName();
		               boolean isInMemory = fi.isInMemory();
		               long sizeInBytes = fi.getSize();
		            
		               // Write the file
		
		               file = new File(filePath + FileManager.getFilename(teamID, filename)) ;
		               fi.write(file) ;
		          
		            } else if(fi.getFieldName().equals("filename")) {
		            	filename = fi.getString();
		            }
		         }
		         
		         page = "student_upload.jsp";
	    	 } else {
	    		 page = "team_upload.jsp?error=3";
	    	 }
	      } catch(Exception ex) {
	         System.out.println(ex);
	         page = "team_upload.jsp?error=1";
	      }
	   } else {
		   page = "team_upload.jsp?error=2";
	     //No file selected
	   }
	   

		response.sendRedirect(page);
	}

}
