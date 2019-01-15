package pepmanagement.form;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FieldString extends FormField {
	int minlen, maxlen;
	Category category;
	
	public final static String forbiddenChars = ".*[<>&].*";
	
	public enum Category {
		EVERYTHING,
		ALPHANUMERICAL,
		ALPHABET,
		ALPHABETPLUS,
		ANPLUS
	}
	
	public FieldString(String name,  Category category, int minlen, int maxlen) {
		super(Form.Type.STRING, name);
		this.category = category;
		this.minlen = minlen;
		this.maxlen = maxlen;
	}
	
	private boolean satisfiesCategory() {
		//TODO: implement it
		// should check if the string only contains allowed characters
		return !content.contains(forbiddenChars);
	}
	
	public boolean isValid() {
        return content.length() >= minlen && content.length() <= maxlen && satisfiesCategory();
	}
	
	public boolean isNotEmpty() {
		return content != null && !content.equals("");
	}
}
