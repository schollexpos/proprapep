

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.FileManager;

/**
 * Servlet implementation class PDFServe
 */
@WebServlet("/PDFServe")
public class PDFServe extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public PDFServe() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String teamID = request.getParameter("team");
			String fileID = request.getParameter("fileid");
			String special = request.getParameter("special");
			
			if(special != null && special.equals("1")) {
				
				performTask(FileManager.getBasePath(), "merged23.pdf",request,response);
			} else {
				performTask(FileManager.getBasePath(), teamID + "_" + fileID + ".pdf",request,response);
			}
			
			performTask(FileManager.getBasePath(), teamID + "_" + fileID + ".pdf",request,response);
		} catch(Exception e) {
			
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}
	
	private void performTask(String path, String pdfFileName, HttpServletRequest request, HttpServletResponse response) throws ServletException,
	IOException {
		String contextPath = getServletContext().getRealPath(File.separator);
		File pdfFile = new File(path + pdfFileName);
		
		response.setContentType("application/pdf");
		response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
		response.setContentLength((int) pdfFile.length());
		
		FileInputStream fileInputStream = new FileInputStream(pdfFile);
		OutputStream responseOutputStream = response.getOutputStream();
		int bytes;
		while ((bytes = fileInputStream.read()) != -1) {
			responseOutputStream.write(bytes);
		}
		
		}
}
