package pepmanagement.form;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FieldEmail extends FormField {
	String domain;
	public static final Pattern VALID_EMAIL_ADDRESS_REGEX = 
			Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
	
	public FieldEmail(String name,  String domain) {
		super(Form.Type.EMAIL, name);
		this.domain = domain;
	}
	
	public boolean isValid() {
		Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(content);
        return matcher.find() && content.endsWith(domain);
	}
	
	public boolean isNotEmpty() {
		return content != null && !content.equals("");
	}
	
	
}