package pepmanagement;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class MailConnection {
	final static String host = "HOST";
	final static String user = "ADRESS";
	final static String pwd = "PW";
	final static int port = 465;

	//Richtige Mail-Methode: 
	public static void sendMail(String to, String from, String subject, String message) {
		System.out.println("\n\n\n===== E-MAIL BEGINN ==== \n");
		System.out.println("VON: " + from + " AN: " + to + "\n");
		System.out.println(message);
		System.out.println("\n===== E-MAIL ENDE ==== \n\n\n");
		
		
	      Properties properties = System.getProperties();
	      properties.setProperty("mail.smtp.host", host);
	      properties.put("mail.smtp.auth", "true");
	      properties.put("mail.smtp.port", port);
	      properties.put("mail.smtp.starttls.enable", "true");
	      properties.put("mail.smtp.ssl.enable", "true");
	      javax.mail.Session session = javax.mail.Session.getInstance(properties,  new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(user, pwd);
	 	   }
	          });
	      
	      
	 
	 
	      try {
	         MimeMessage mail = new MimeMessage(session);
	         mail.setFrom(new InternetAddress(from));
	         mail.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	         mail.setSubject(subject);
	         mail.setContent(message, "text/html");
	         Transport.send(mail);
	      } catch (MessagingException mex) {
	    	 System.out.println("Failed to send mail \"" + subject + "\" from " + from + " to " + to);
	    	 System.out.println(message);
	         mex.printStackTrace();
	      }
	}
	
	
}
