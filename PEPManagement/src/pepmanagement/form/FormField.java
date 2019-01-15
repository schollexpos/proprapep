package pepmanagement.form;

public abstract class FormField {
	protected String name, content;
	protected Form.Type type;
	
	public FormField(Form.Type type, String name) {
		this.name = name;
		this.type = type;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getContent() {
		return this.content;
	}
	
	public String getName() {
		return name;
	}
	
	public abstract boolean isValid(); 
	public abstract boolean isNotEmpty();
	public boolean isOkay() { return isValid() && isNotEmpty(); }
	
	public Form.Type getType() {
		return type;
	}
}