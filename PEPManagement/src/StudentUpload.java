
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
	private Database db;
       
   
    public StudentUpload() {
        super();
        db = new Database();
        db.connect();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.STUDENT, db, request, response);

		
		if(res == AccountControl.Result.SUCCESS) {
			
			long deadline = -1;
			
			// List of all the existing files
			ArrayList<pepmanagement.Pair<String,String>> list = new ArrayList<pepmanagement.Pair<String,String>>();
			
			Session session = new Session(db, request);
			session.restore(request);
			
			boolean vorsitz = false;
			ArrayList<Boolean> deadlineReached = new ArrayList<Boolean>();
			
			int teamID = -1;
			try {
				Database.Student s = db.getStudent(db.getUserID(session.getEmail()));
				vorsitz = s.isVorsitz();
				teamID = s.getTeamID();
				
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlineDokumentation())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlineKurzbeschreibung())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlinePoster())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlinePraesentation())));
				
				
				for(int i = 0;i < FileManager.getFileCount();i++) {
					String date = "";
					
					if(FileManager.fileExists(FileManager.getBasePath(), teamID, FileManager.getFileIdentifier(i))) {
						SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
						long lastMod = FileManager.fileDate(FileManager.getBasePath(), teamID, FileManager.getFileIdentifier(i));
	    				
	    				date = sdf.format(lastMod);
					} else {
						date = "-";
					}
					
					
					list.add(new pepmanagement.Pair<String, String>(FileManager.getFileIdentifier(i), date));
				}
			} catch (SQLException e) {
				res = AccountControl.Result.ERROR;
			}
			
			
			request.setAttribute("list", list);
			request.setAttribute("vorsitz", new Boolean(vorsitz));
			request.setAttribute("deadlinereached", deadlineReached);
			request.setAttribute("teamid", new Integer(teamID));
		}
		
		AccountControl.processResult(res, request, response, "StudentUpload", "student_upload.jsp", true);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		File file ;
	   int fsize = 5000;
		try {
			fsize = db.getMaxfilesize();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   int maxFileSize = fsize * 1000 * 1024;
	   int maxMemSize = fsize * 1000 * 1024;
	   
	   // Verify the content type
	   String contentType = request.getContentType();
	   String page = "";
	   
	   boolean vorsitz = false;
	   ArrayList<Boolean> deadlineReached = new ArrayList<Boolean>();
		int teamID = -1;
	   if ((contentType.indexOf("multipart/form-data") >= 0)) {
	      DiskFileItemFactory factory = new DiskFileItemFactory();
	      factory.setSizeThreshold(maxMemSize);
	      
	      // Location to save data that is larger than maxMemSize.
	      factory.setRepository(new File("c:\\temp"));

	      
	      ServletFileUpload upload = new ServletFileUpload(factory);
	      upload.setSizeMax(maxFileSize);
	      
	      try { 
	    		deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlineDokumentation())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlineKurzbeschreibung())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlinePoster())));
				deadlineReached.add(new Boolean(Database.dateReached(db.getDeadlinePraesentation())));
	    	
	    	  
	    	 Session session = new Session(db, request);
	    	 
	    	 if(session.restore(request) /*&& !Database.dateReached(db.getDeadlineUpload())*/) {
	    		  Database.Student s = db.getStudent(db.getUserID(session.getEmail()));
					vorsitz = s.isVorsitz();
	    		 
	    		 String filename = request.getParameter("filename");
		    	 
		    	 Enumeration<String> espeter = request.getParameterNames();
		    	 while(espeter.hasMoreElements()) System.out.println(">" + espeter.nextElement());
		    	 
		    	 
		    	 teamID = db.getTeamID(session.getEmail());
		    	 
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
		               String allowedExtensions[] = { ".pdf", ".PDF", ".PPT", ".ppt", ".PPTX", ".pptx" };
		               
		               boolean extensionOkay = false;
		               for(int n = 0;n < allowedExtensions.length;n++) {
		            	   if(fileName.endsWith(allowedExtensions[n])) extensionOkay = true;
		               }
		
		               if(extensionOkay && (!filename.equals("kurzbeschreibung") || filename.endsWith(".pdf") || filename.endsWith(".PDF")) ) {
		            	   file = new File(FileManager.getBasePath() + FileManager.getFilename(teamID, filename)) ;
			               fi.write(file) ;
		               } else {
		            	   page = "team_upload.jsp?error=99";
		               }
		               
		          
		            } else if(fi.getFieldName().equals("filename")) {
		            	filename = fi.getString();
		            }
		         }
		         
		         if(page.equals("")) page = "student_upload.jsp";
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
	   
	   request.setAttribute("vorsitz", new Boolean(true));
		request.setAttribute("deadlinereached", deadlineReached);
		request.setAttribute("teamid", new Integer(teamID));
	   

		response.sendRedirect(page);
	}

}
