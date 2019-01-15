package pepmanagement.form;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FieldPassword extends FormField {
	int minlen, maxlen, requirements;
	
	public static final int REQ_CHARS = 0x01;
	public static final int REQ_NUMBERS = 0x02;
	public static final int REQ_SYMBOLS = 0x04;
	public static final int REQ_CHARSMIXED = 0x08;
	
	public FieldPassword(String name, int minlen, int maxlen, int requirements) {
		/*
		 * requirements is a bitsets aka to require chars and numbers you write
		 * (REQ_CHARS | REQ_NUMBERS)
		 */
		super(Form.Type.PASSWORD, name);
		this.minlen = minlen;
		this.maxlen = maxlen;
		this.requirements = requirements;
	}
	
	private boolean satisfiesRequirements() {
		if((requirements & REQ_CHARS) != 0 && !content.matches(".*[A-Za-z].*")) return false;
		if((requirements & REQ_NUMBERS) != 0 && !content.matches(".*[0-9].*")) return false;
		if((requirements & REQ_SYMBOLS) != 0 && !content.matches(".*[?!;,:\\.\\-_#'+*+\"\\\\/$%&()=].*")) return false;
		if((requirements & REQ_CHARSMIXED) != 0 && (!content.matches(".*[a-z].*") || !content.matches(".*[A-Z].*"))) return false;
		if(content.matches(FieldString.forbiddenChars)) return false;
		return true;
	}
	
	public boolean isValid() {
        return content.length() >= minlen && content.length() <= maxlen && satisfiesRequirements();
	}
	
	public boolean isNotEmpty() {
		return content != null && !content.equals("");
	}
}
