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
	private static final String filePath2 = "C:\\Users\\lucah\\Desktop\\Testfiles\\abschluss\\";
	private Database db;
	
    public AdminSiegerehrung() {
        super();
        db = new Database();
        db.connect();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	AccountControl.Result res = AccountControl.ensureRank(AccountControl.UserRank.ADMIN, db, request, response);
    	
    	String order = request.getParameter("order");
		request.setAttribute("order", order);
		
		    	
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
 	  
 	   /* DRUCKE PRÄSENTATION */
 	   else if (request.getParameter("createPr").equals("Erstelle Präsentation")) {
 		  
 		  String order = request.getParameter("order");
 		  int ord = Integer.parseInt(order);
 		  ArrayList<String> teamsg1 = new ArrayList<String>();
 		  ArrayList<String> teamsg2 = new ArrayList<String>();
 		  
 		  try {
 				  teamsg1=db.getOrderedTeams(1); 
 				  teamsg2=db.getOrderedTeams(2);
 				  
 				  String idg1;
 				  String idg2;
 				
 				  if(ord==1) {
 					List<InputStream> inputPdfList = new ArrayList<InputStream>();
 			        inputPdfList.add(new FileInputStream(filePath+"Startfolie.pdf"));
 			        
 			       idg1=teamsg1.get(2).split("#")[1]+"_kurzbeschreibung.pdf";
 			       idg2=teamsg2.get(2).split("#")[1]+"_kurzbeschreibung.pdf";
 			       inputPdfList.add(new FileInputStream(filePath2+idg1));
 			       inputPdfList.add(new FileInputStream(filePath2+idg2));
 			        
 			       inputPdfList.add(new FileInputStream(filePath+"zwischen1.pdf"));
 			        
 			       idg1=teamsg1.get(1).split("#")[1]+"_kurzbeschreibung.pdf";
 			       idg2=teamsg2.get(1).split("#")[1]+"_kurzbeschreibung.pdf";
 			       inputPdfList.add(new FileInputStream(filePath2+idg1));
 			       inputPdfList.add(new FileInputStream(filePath2+idg2));
 			        
 			        inputPdfList.add(new FileInputStream(filePath+"zwischen2.pdf"));
 			        
 			       idg1=teamsg1.get(0).split("#")[1]+"_kurzbeschreibung.pdf";
 			       idg2=teamsg2.get(0).split("#")[1]+"_kurzbeschreibung.pdf";
 			       inputPdfList.add(new FileInputStream(filePath2+idg1));
 			       inputPdfList.add(new FileInputStream(filePath2+idg2));
 			        
 			        inputPdfList.add(new FileInputStream(filePath+"orga.pdf"));
 			        
 			        OutputStream outputStream = new FileOutputStream(filePath+"merged23.pdf");
 			        //Output Stream zum Speichern
 			     
 			        mergePDF(inputPdfList, outputStream);
 					
 			  }
 				  
 				  else if(ord==2) {
  					List<InputStream> inputPdfList = new ArrayList<InputStream>();
  			        inputPdfList.add(new FileInputStream(filePath+"Startfolie.pdf"));
  			        
  			       idg1=teamsg1.get(0).split("#")[1]+"_kurzbeschreibung.pdf";
  			       idg2=teamsg2.get(0).split("#")[1]+"_kurzbeschreibung.pdf";
  			       inputPdfList.add(new FileInputStream(filePath2+idg1));
  			       inputPdfList.add(new FileInputStream(filePath2+idg2));
  			        
  			       inputPdfList.add(new FileInputStream(filePath+"zwischen1.pdf"));
  			        
  			       idg1=teamsg1.get(1).split("#")[1]+"_kurzbeschreibung.pdf";
  			       idg2=teamsg2.get(1).split("#")[1]+"_kurzbeschreibung.pdf";
  			       inputPdfList.add(new FileInputStream(filePath2+idg1));
  			       inputPdfList.add(new FileInputStream(filePath2+idg2));
  			        
  			        inputPdfList.add(new FileInputStream(filePath+"zwischen2.pdf"));
  			        
  			       idg1=teamsg1.get(2).split("#")[1]+"_kurzbeschreibung.pdf";
  			       idg2=teamsg2.get(2).split("#")[1]+"_kurzbeschreibung.pdf";
  			       inputPdfList.add(new FileInputStream(filePath2+idg1));
  			       inputPdfList.add(new FileInputStream(filePath2+idg2));
  			        
  			        inputPdfList.add(new FileInputStream(filePath+"orga.pdf"));
  			        
  			        OutputStream outputStream = new FileOutputStream(filePath+"merged23.pdf");
  			        //Output Stream zum Speichern
  			     
  			        mergePDF(inputPdfList, outputStream);
  					
  			  }
 		 
 		  }catch (SQLException e) {
				e.printStackTrace();
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



    

    