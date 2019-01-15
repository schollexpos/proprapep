package pepmanagement;

import javax.servlet.http.HttpServlet;

import pepmanagement.form.Form;

public abstract class AuthenticatedServlet extends HttpServlet {
	private static final long serialVersionUID = -5605389610279132407L;
	protected Database db;
	String servletFilename;
	String jspFilename;
	
	public AuthenticatedServlet(String servletFilename, String jspFilename) {
		super();
		db = new Database();
		db.connect();
		this.servletFilename = servletFilename;
		this.jspFilename = jspFilename;
	}
	
	public Database getDatabase() {
		return db;
	}
	
	public String getServletFilename() {
		return servletFilename;
	}
	
	public String getJSPFilename() {
		return jspFilename;
	}
	
	protected boolean checkForm(AccountValidator validator, Form form) {
		/* Checks if all the form fields contain information (else sets the
		 * error code to "1" and the information is valid
		 * (sets the error code to "invalid" and the "element" parameter
		 * to the name of the invalid element) */
		if(!form.isNotNull()) {
			validator.setErrorCode("1");
			return false;
		} else {
			for(int i = 0;i < form.getFieldCount();i++) {
				if(!form.getField(i).isValid()) {
					validator.setErrorCode("invalid");
					validator.addParameter("element", form.getField(i).getName());
					return false;
				}
			}
		}
		
		return true;
	}
}
