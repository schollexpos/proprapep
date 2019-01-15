import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pepmanagement.AccountControl;
import pepmanagement.AccountValidator;
import pepmanagement.AuthenticatedServlet;
import pepmanagement.Database;
import pepmanagement.Session;
import pepmanagement.form.*;

@WebServlet("/AdminTeamDetails")
public class AdminTeamDetails extends AuthenticatedServlet {
	private static final long serialVersionUID = 1L;
    public AdminTeamDetails() {
        super("AdminTeamDetails", "admin_teamdetails.jsp");
        db = new Database();
        db.connect();
    } 
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountValidator validator = new AccountValidator(this, request, response);
		
		AccountValidator.Result res = validator.ensureRank(AccountValidator.UserRank.ADMIN);
		
		if(res == AccountValidator.Result.SUCCESS && request.getParameter("teamid") != null) {
			validator.addParameter("teamid", request.getParameter("teamid"));
		}
		
		validator.processResult();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountValidator validator = new AccountValidator(this, request, response);
		validator.ensureRank(AccountValidator.UserRank.ADMIN);

		try {
			FormField[] fields = {
					new FieldInt("matrikelnummer", 0, 9999999), //enthält in wirklichkeit die userID
					new FieldString("name", FieldString.Category.ALPHABETPLUS, 0, 50),
					new FieldString("vorname", FieldString.Category.ALPHABETPLUS, 0, 50),
					new FieldString("studiengang", FieldString.Category.ALPHABETPLUS, 0, 50),
					new FieldEmail("email","student.uni-siegen.de"),
					new FieldInt("team", 0, 9999999),
			};
			
			Form form = new Form(new ArrayList<FormField>(Arrays.asList(fields)));
			
			form.fillContents(request);
			
			validator.addParameter("teamid", form.getField("team").getContent());
			
			if(this.checkForm(validator, form)) {
				int uID = ((FieldInt) form.getField("matrikelnummer")).getIntValue();
				
				db.updateStudent(uID, form.getField(2).getContent(), form.getField(1).getContent(), form.getField(4).getContent(), form.getField(3).getContent());
			}
		} catch (Exception e1) {
			validator.setErrorCode("6");
		}
		
		validator.processResult();
	}

}
