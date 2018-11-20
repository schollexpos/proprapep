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
	
	public ResultSet executeQuery(String query) throws SQLException {
    	Statement select = connection.createStatement();
    	ResultSet result = select.executeQuery(query);
    	return result;
	}
}
