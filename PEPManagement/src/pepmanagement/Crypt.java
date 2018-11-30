package pepmanagement;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class Crypt {

	private static byte[] hashPassword(String password, byte[] salt) {		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.update(salt);
			
			byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
			
			return hashedPassword;
		} catch(Exception e) {
			return null;
		}
	}
	
	public static byte[] hashPassword(String password, String email) {
		/*TODO: Currently, the email is used as the salt
		 * Upon making this project production-ready, a random
		 * salt should be generated and stored alongside the password in
		 * the database.
		 */
		byte[] salt = new byte[16];
		
		for(int i = 0;i < salt.length;i++) {
			salt[i] = (byte) email.charAt(i);
		}
		
		return hashPassword(password, salt);
	}
	
	public static boolean validatePassword(String hashedPassword, String email, String enteredPassword) {
		/* TODO: See public hashPassword */
		byte[] password = hashPassword(enteredPassword, email);
		
		String pw = "";
		for(int i = 0;i < password.length;i++) {
			pw += password[i];
		}
		
		return hashedPassword.equals(pw);
	}
}
