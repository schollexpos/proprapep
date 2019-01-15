package pepmanagement.form;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class Form {
	public enum Type {
		EMAIL,
		PASSWORD,
		STRING,
		INT,
		DATE,
		UNKNOWN
	}
	
	public static Type str2type(String str) {
		switch(str) {
		case "email":
			return Type.EMAIL;
		case "password":
			return Type.PASSWORD;
		case "string":
			return Type.STRING;
		case "int":
			return Type.INT;
		case "date":
			return Type.DATE;
		default:
			return Type.UNKNOWN;
		}
	}
	private ArrayList<FormField> fields;
	
	public Form() throws Exception {
		fields = new ArrayList<FormField>();
	}
	
	public Form(ArrayList<FormField> list) throws Exception {
		fields = list;
	}
	
	public Form(FormField[] list) {
		fields = new ArrayList<FormField>(Arrays.asList(list));
	}
	
	public void addField(FormField field) {
		fields.add(field);
	}
	
	public void fillContents(HttpServletRequest request) {
		for(int i = 0;i < fields.size();i++) {
			String fName = fields.get(i).getName();
			String content = request.getParameter(fName);
			
			System.out.println("fillContents " + fName + "->" + content);
			fields.get(i).setContent(content);
		}
	}
	
	public boolean isValid() {
		for(int i = 0;i < fields.size();i++) {
			if(fields.get(i).isValid()) return false;
		}
		return true;
	}
	
	public boolean isNotNull() {
		for(int i = 0;i < fields.size();i++) {
			if(!fields.get(i).isNotEmpty()) return false;
		}
		return true;
	}
	
	public FormField getField(String name) {
		for(int i = 0;i < fields.size();i++) {
			FormField f = fields.get(i);
			if(f.getName().equals(name)) return f;
		}
		return null;
	}
	
	public FormField getField(int i) {
		return fields.get(i);
	}
	
	public int getFieldCount() {
		return fields.size();
	}
	
	

}
