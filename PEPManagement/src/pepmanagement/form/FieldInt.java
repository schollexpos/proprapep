package pepmanagement.form;

public class FieldInt extends FormField {
	int lowerRange,  upperRange;

	
	public FieldInt(String name, int lowerRange, int upperRange) {
		super(Form.Type.INT, name);
		this.lowerRange = lowerRange;
		this.upperRange = upperRange;
	}
	
	public boolean isValid() {
		try {
			int c = Integer.parseInt(content);
			return c >= lowerRange && c <= upperRange;
		} catch(Exception e) {
			return false;
		}
	}
	
	public boolean isNotEmpty() {
		return content != null && !content.equals("");
	}
	
	public int getIntValue() {
		try {
			return Integer.parseInt(content);
		} catch(Exception e) {
			return -1;
		}
	}
}
