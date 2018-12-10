import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;

import pepmanagement.AccountControl;
import pepmanagement.ContextGlue;
import pepmanagement.Database;
import pepmanagement.FileManager;
import pepmanagement.Session;

@WebServlet("/AdminSiegerehrung")
public class AdminSiegerehrung extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String filePath = "C:\\Users\\lucah\\Desktop\\Testfiles\\abschluss\\";
	private Database db;
	
    public AdminSiegerehrung() {
        super();
        db = new Database();
        db.connect();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
		
		if(request.getParameter("error") != null) {
			request.setAttribute("error", request.getParameter("error"));
		}

		AccountControl.processResult(res, request, response, "AdminSiegerehrung", "admin_siegerehrung.jsp");
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
 	    	 
 	    	if(session.restore(request)) {
 	    	 
 		    	 String filename = request.getParameter("filename");
 		    	 
 		    	 Enumeration<String> espeter = request.getParameterNames();
 		    	 while(espeter.hasMoreElements()) System.out.println(">" + espeter.nextElement());
 		    	 
 		    	 
 		    	 		    	 
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
 		               
 		               file = new File(filePath + filename + ".pdf") ;
 		               fi.write(file) ;
 		               System.out.println(filePath + filename);
 		            } else if(fi.getFieldName().equals("filename")) {
 		            	filename = fi.getString();
 		            }
 		         }
 		         
 		         page = "admin_siegerehrung.jsp";
 	    	} else {
	    		 page = "admin_siegerehrung?error=3";
	    	 }
 	      } catch(Exception ex) {
 	         System.out.println(ex);
 	         page = "admin_siegerehrung.jsp?error=1";
 	      }
 	   } 
 	   else if (request.getParameter("createPr").equals("Erstelle Präsentation")) {
 		  try {
		        
		        List<InputStream> inputPdfList = new ArrayList<InputStream>();
		        inputPdfList.add(new FileInputStream(filePath+"Startfolie.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe1P3.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe2P3.pdf"));
		        inputPdfList.add(new FileInputStream(filePath+"zwischen1.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe1P2.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe2P2.pdf"));
		        inputPdfList.add(new FileInputStream(filePath+"zwischen2.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe1P1.pdf"));
		        //inputPdfList.add(new FileInputStream("Gruppe2P1.pdf"));
		        inputPdfList.add(new FileInputStream(filePath+"orga.pdf"));
		        OutputStream outputStream = new FileOutputStream(filePath+"merged2");
		        //Output Stream zum Speichern
		     
		        mergePDF(inputPdfList, outputStream);     
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
 		   
 		  page = "admin_siegerehrung.jsp";
 	   }
 		   
 		else {
 		   page = "admin_siegerehrung.jsp?error=2";
 	     //No file selected
 	   }
 	   

 		response.sendRedirect(page);
 	}
    
    
    
    
    
    protected void mergePDF (List<InputStream> inputPdfList, OutputStream outputStream) throws Exception {
    	Document doc = new Document();
		List<PdfReader> readers = new ArrayList<PdfReader>();
		int totalPages = 0;

	
		Iterator<InputStream> pdfIterator = inputPdfList.iterator();

		while (pdfIterator.hasNext()) {
			InputStream pdf = pdfIterator.next();
			PdfReader pdfReader = new PdfReader(pdf);
			readers.add(pdfReader);
			totalPages = totalPages + pdfReader.getNumberOfPages();
		}

		// Create writer for the outputStream
		PdfWriter writer = PdfWriter.getInstance(doc, outputStream);

		// Open document.
		doc.open();

		// Contain the pdf data.
		PdfContentByte pageContentByte = writer.getDirectContent();

		PdfImportedPage pdfImportedPage;
		int currentPdfReaderPage = 1;
		Iterator<PdfReader> iteratorPDFReader = readers.iterator();

	
		while (iteratorPDFReader.hasNext()) {
			PdfReader pdfReader = iteratorPDFReader.next();
			
			while (currentPdfReaderPage <= pdfReader.getNumberOfPages()) {
				doc.newPage();
				pdfImportedPage = writer.getImportedPage(pdfReader, currentPdfReaderPage);
				pageContentByte.addTemplate(pdfImportedPage, 0, 0);
				currentPdfReaderPage++;
				//Seite erstellen und Inhalt hinzufügen
			}
			currentPdfReaderPage = 1;
		}

		
		outputStream.flush();
		doc.close();
		outputStream.close();

		System.out.println("Pdf files merged successfully.");
	}

    }



    

    