import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import java.sql.Date;
public class Database {
	private Connection connection;
	final String dbserver = "localhost";
	final int dbport = 3306;
	final String dbname = "pepdb";
	final String dbuser = "root";
	final String dbpassword = "";
	
	public void connect() {
		connection = null;
        
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	connection = DriverManager.getConnection("jdbc:mysql://" + dbserver + ":" + dbport + "/" + dbname +  "?useJDBCCompliantTimezoneShift=true&serverTimezone=UTC", dbuser, dbpassword);
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}
	
	public void disconnect() {
        if(connection != null) {
        	try {
        		connection.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        }
	}
	
	public void registerUser(String email, String password) throws SQLException {
		//TODO: Make sure each email can only be registered once
		
		byte[] hashedPassword = Crypt.hashPassword(password, email);
		password = "";
		for(int i = 0;i < hashedPassword.length;i++) {
			password += hashedPassword[i];
		}
		
		executeUpdate("INSERT INTO `nutzer` (`id`, `email`, `passwort`) VALUES (NULL, '" + email + "', '" + password +  "');");
	}
	
	public boolean loginUser(String email, String password) throws SQLException {
		/* Checks if the password is is correct */
		ResultSet result = executeQuery("SELECT passwort FROM nutzer WHERE email = '" + email + "'");
		String hashedPassword = "";
		while (result.next())  { 
			hashedPassword = result.getString(1);
    	}
		
		return Crypt.validatePassword(hashedPassword, email, password);
	}
	
	public boolean emailExists(String email) throws SQLException {
		ResultSet result = executeQuery("SELECT passwort FROM nutzer WHERE email = '" + email + "'");
		int rows = 0;
		while (result.next())  { 
			rows++;
    	}
		return rows > 0;
	}
	
	public void addSession(String email, String sessionID) throws SQLException {
		executeUpdate("INSERT INTO `sessions` (`email`, `session`) VALUES ( '" + email + "', '" + sessionID +  "');");
	}
	
	public boolean verifySession(String email, String sessionID) throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM sessions WHERE email='" + email + "' AND session='" + sessionID + "'");
	
		int rows = 0;
		while (result.next())  rows++;
		return rows > 0;
	}
	
	public ResultSet executeQuery(String query) throws SQLException {
    	Statement select = connection.createStatement();
    	ResultSet result = select.executeQuery(query);
    	return result;
	}
	
	public void executeUpdate(String query) throws SQLException {
		System.out.println(">>" + query + "<<");
		Statement select = connection.createStatement();
		select.executeUpdate(query);
	}

	public void deleteSession(String email) throws SQLException {
		/*
		 * Deletes all the session with e-mail email from the database.
		 */
		executeUpdate("DELETE FROM sessions WHERE email='" + email);
	}
	
	public void addKriterium(String hauptkriterium, String teilkriterium, int maxpunkte) throws SQLException {
		executeUpdate("INSERT INTO `bewertungskriterium` (`hauptkriterium`, `teilkriterium`, `maxpunkte`) VALUES ( '" + hauptkriterium + "', '" + teilkriterium + "', '" + maxpunkte  + "');");		
	}
	
	public void deleteTeilkriterium(String teilkriterium) throws SQLException {		
		executeUpdate("DELETE FROM bewertungskriterium WHERE teilkriterium='" + teilkriterium);
	}
	
	public void deleteHauptkriterium(String hauptkriterium) throws SQLException {		
		executeUpdate("DELETE FROM bewertungskriterium WHERE hauptkriterium='" + hauptkriterium);
	}
	
	public boolean kriteriumExists(String teilkriterium) throws SQLException {
		ResultSet result = executeQuery("SELECT id FROM bewertungskriterium WHERE teilkriterium = '" + teilkriterium + "'");
		int rows = 0;
		while (result.next())  { 
			rows++;
    	}
		return rows > 0;
	}
	
	public void createBewertung(int teamID, int jurorID, int punkte) throws SQLException {		
		executeUpdate("INSERT INTO `bewertung` (`teamID`, `jurorID`, `punkte`) VALUES ( '" + teamID + "', '" + jurorID + "', '" + punkte  + "');");		
	}	
	
}
