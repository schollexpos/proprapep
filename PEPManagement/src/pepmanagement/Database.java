package pepmanagement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
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
        	System.out.println("Can't connect to Database: " + e.getMessage());
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
	
	boolean isConnected() {
		try {
			return connection != null && !connection.isClosed();
		} catch(Exception e) {
			return false;
		}
	}
	
	public static String cleanString(String str) {
		str.replace("'", "");
		str.replace("\"", "");
		str.replace(";", "");
		return str;
	}
	
	public int getUserID(String email) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM nutzer WHERE email = ?");
		statement.setString(1, email);
		ResultSet result = statement.executeQuery();
		
		int id = -1;
		while (result.next())  { 
			id = result.getInt(1);
    	}
		return id;
	}
	
	public class User {
		int userID;
		String email, passwort;
		int berechtigungen;
		
		User(int tUserID, String temail, String tpasswort, int tberechtigungen) {
			userID = tUserID;
			email = temail;
			passwort = tpasswort;
			berechtigungen = tberechtigungen;
		}
		
		int getID() { return userID; }
		String getEmail() { return email; }
		String getPasswort() { return passwort; }
		int getBerechtigungen() { return berechtigungen; }
		boolean isAdmin() { return berechtigungen >= 2; }
		boolean isJuror() { return berechtigungen >= 1; }
		boolean isStudent() { return berechtigungen == 0; }
	}
	
	public User getUser(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM nutzer WHERE id = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		User user = null;
		
		while (result.next())  { 
			user = new User(result.getInt(1), result.getString(2), result.getString(3), result.getInt(4));
    	}
		
		return user;
	}
	
	
	
	public class Student {
		int matrikelnummer, nutzerID;
		String vorname, nachname, studiengang;
		int teamID;
		boolean vorsitz;
		
		Student(int mNo, int userID, String tvorname, String tnachname, String tstudiengang, int tteamID, boolean tvorsitz) {
			matrikelnummer = mNo;
			nutzerID = userID;
			vorname = tvorname;
			nachname = tnachname;
			studiengang = tstudiengang;
			teamID  = tteamID;
			vorsitz = tvorsitz;
		}
		
		public int getMatrikelnummer() {
			return matrikelnummer;
		}

		public int getNutzerID() {
			return nutzerID;
		}

		public String getVorname() {
			return vorname;
		}

		public String getNachname() {
			return nachname;
		}

		public String getStudiengang() {
			return studiengang;
		}

		public int getTeamID() {
			return teamID;
		}

		public boolean isVorsitz() {
			return vorsitz;
		}
	}
	
	public Student getStudent(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM nutzer WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		Student studi = null;
		
		while (result.next())  { 
			studi = new Student(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4), result.getString(5), result.getInt(6), result.getBoolean(7));
    	}
		
		return studi;
	}
	
	
	public class Team {
		int id;
		String vorsitzmail;
		int betreuer1;
		String betreuer2, titel;
		int kennnummer;
		int note;
		
		Team(int tid, String tvorsitzmail, int bet1, String bet2, String tit, int kennno, int tnote) {
			id = tid;
			vorsitzmail = tvorsitzmail;
			betreuer1 = bet1;
			betreuer2 = bet2;
			titel = tit;
			kennnummer = kennno;
			note = tnote;
		}
		
		public int getID() {
			return id;
		}
		public String getVorsitzmail() {
			return vorsitzmail;
		}
		public int getBetreuer1() {
			return betreuer1;
		}
		public String getBetreuer2() {
			return betreuer2;
		}
		public String getTitel() {
			return titel;
		}
		public int getKennnummer() {
			return kennnummer;
		}
		public int getNote() {
			return note;
		}
	}
	
	public Team getTeam(int teamID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM team WHERE id = ?");
		statement.setInt(1, teamID);
		ResultSet result = statement.executeQuery();
		
		Team team = null;
		
		while (result.next())  { 
			team = new Team(result.getInt(1), result.getString(2), result.getInt(3), result.getString(4), result.getString(5), result.getInt(6), result.getInt(7));
    	}
		
		return team;
	}
	
	public ArrayList<Team> getTeams(int group) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM team WHERE betreuer1 IN (SELECT id FROM betreuer WHERE gruppe = ?)");
		statement.setInt(1, group);
		ResultSet result = statement.executeQuery();
		
		ArrayList<Team> teams = new ArrayList<Team>();
		
		while (result.next())  { 
			Team team = new Team(result.getInt(1), result.getString(2), result.getInt(3), result.getString(4), result.getString(5), result.getInt(6), result.getInt(7));
			teams.add(team);
		}
		
		return teams;
	}
	
	
	
	public int getUserID(int matrikelno) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM nutzer WHERE matrikelno = ?");
		statement.setInt(1, matrikelno);
		ResultSet result = statement.executeQuery();
		
		int id = -1;
		while (result.next())  { 
			id = result.getInt(1);
    	}
		return id;
	}
	
	private int getUserRights(int userID) throws SQLException{
		PreparedStatement statement = connection.prepareStatement("SELECT berechtigungen FROM nutzer WHERE id = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		int id = -1;
		while (result.next())  { 
			id = result.getInt(1);
    	}
		return id;
	}
	
	public boolean userIsAdmin(int userID) throws SQLException {
		return getUserRights(userID) == 2;
	}
	
	public boolean userIsJuror(int userID) throws SQLException {
		return getUserRights(userID) > 0;
	}
	
	
	
	public void registerUser(String email, String password, int berechtigung) throws SQLException {
		byte[] hashedPassword = Crypt.hashPassword(password, email);
		password = "";
		for(int i = 0;i < hashedPassword.length;i++) {
			password += hashedPassword[i];
		}
		
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `nutzer` (`id`, `email`, `passwort`, `berechtigungen`) VALUES (NULL, ?, ?, ?);");
		statement.setString(1, email);
		statement.setString(2, password);
		statement.setInt(3, berechtigung);
		statement.executeUpdate();
	}
	
	public void  registerUser(String email, String password) throws SQLException {
		registerUser(email, password, 0);
	}
	
	public void registerStudent(int matrikelnummer, int userID, String vorname, String nachname, String studiengang, int teamID, boolean vorsitz) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `student` (`matrikelno`, `nutzerid`, `vorname`, `nachname`, `studiengang`, `teamid`, `vorsitz`) VALUES (?, ?, ?, ?, ?, ?, ?)");
		statement.setInt(1, matrikelnummer);
		statement.setInt(2, userID);
		statement.setString(3,  vorname);
		statement.setString(4, nachname);
		statement.setString(5, studiengang);
		statement.setInt(6,  teamID);
		statement.setBoolean(7, vorsitz);
		
		statement.executeUpdate();
	}
	
	public int getStudentTeam(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT teamid FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		int res = -1;
		while(result.next()) {
			res = result.getInt(1);
		}
		
		return res;
	}
	
	public int getStudentMatrikelnummer(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT matrikelno FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		int res = -1;
		while(result.next()) {
			res = result.getInt(1);
		}
		
		return res;
	}
	
	public String getStudentVorname(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT vorname FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		String res = "";
		while(result.next()) {
			res = result.getString(1);
		}
		
		return res;
	}
	
	public String getStudentNachname(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT nachname FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		String res = "";
		while(result.next()) {
			res = result.getString(1);
		}
		
		return res;
	}
	
	public String getStudentStudiengang(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT studiengang FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		String res = "";
		while(result.next()) {
			res = result.getString(1);
		}
		
		return res;
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
	
	public void createTeam(String email, int betreuer1ID, String betreuer2, String teamname) throws SQLException {
		executeUpdate("INSERT INTO `team` (`vorsitzmail`, `betreuer1`, `betreuer2`, `projekttitel`, `kennnummer`, `note`) VALUES ( '" + email + "', " + betreuer1ID + ", '" + betreuer2 +  "', '" +  teamname + "', -1, 0.0);");
	}
	
	public int getTeamID(String vorsitzmail) throws SQLException {
		ResultSet result = executeQuery("SELECT id FROM team WHERE vorsitzmail = '" + vorsitzmail + "'");
		
		int id = -1;
		while (result.next())  id = result.getInt(1);
		return id;
	}
	
	public void addStudentToTeam(int userID, int teamID)  throws SQLException {
		executeUpdate("UPDATE student SET teamid = " + teamID + " WHERE nutzerid = '" +  userID + "'");
	}
	
	public ArrayList<Integer> getStudentenFromTeam(int teamID) throws SQLException {
		ArrayList<Integer> aList = new ArrayList<Integer>();
		
		ResultSet result = executeQuery("SELECT nutzerid FROM student WHERE teamid = " + teamID + " ORDER BY vorsitz DESC");
		
		while (result.next())  {
			int id = result.getInt(1);
			
			aList.add(new Integer(id));
		}
		
		return aList;
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
		//TODO: update der Bewertung
		executeUpdate("INSERT INTO `bewertung` (`teamID`, `jurorID`, `punkte`) VALUES ( '" + teamID + "', '" + jurorID + "', '" + punkte  + "');");		
	}
	
	public ResultSet listTeams() throws SQLException {		
		ResultSet teams = executeQuery("SELECT * FROM team");		
		return teams;
	}

	public ResultSet listKriterien() throws SQLException {
		ResultSet kriterien = executeQuery("SELECT * FROM bewertungskriterium");		
		return kriterien;
	}
	
	
	public ArrayList<String> getStudiengaenge() throws SQLException {
		ArrayList<String> aList = new ArrayList<String>();
		ResultSet result = executeQuery("SELECT * FROM studiengangliste");
		
		while (result.next()) aList.add(result.getString(1));
		return aList;
	}
	
	public String getTeamVorsitzenderName(int teamID) throws SQLException {
		ResultSet result = executeQuery("SELECT vorname,nachname FROM student WHERE teamid = " + teamID + " AND vorsitz = 1");
	
		String name = "";
		while(result.next()) {
			name = result.getString(1) + " " + result.getString(2);
		}
		
		return name;
	}
	
	public boolean studentIsVorsitzender(int userID) throws SQLException {
		ResultSet result = executeQuery("SELECT vorsitz FROM student WHERE nutzerid = " + userID);
		
		boolean res = false;
		while(result.next()) {
			res = result.getBoolean(1);
		}
		
		return res;
	}
	
	public int getTeamKennnummer(int teamID) throws SQLException {
		ResultSet result = executeQuery("SELECT kennnummer FROM team WHERE id = " + teamID);
		
		int kennnummer = -1;
		while(result.next()) {
			kennnummer = result.getInt(1);
		}
		
		return kennnummer;
	}
	
	public String getTeamTitel(int teamID) throws SQLException {
		ResultSet result = executeQuery("SELECT projekttitel FROM team WHERE id = " + teamID);
		
		String kennnummer = "";
		while(result.next()) {
			kennnummer = result.getString(1);
		}
		
		return kennnummer;
	}
	
	public boolean teamIDExists(int teamID) throws SQLException {
		ResultSet result = executeQuery("SELECT id FROM team WHERE id = " + teamID);
		
		boolean hasResults = false;
		while(result.next()) {
			hasResults = true;
		}
		
		return hasResults;
	}
	
	public void addBetreuer(String name, String lehrstuhl, int gruppe) throws SQLException {
		executeUpdate("INSERT INTO `betreuer` (`id`, `name`, `lehrstuhl`, `gruppe`) VALUES (NULL, '" + name + "', '" + lehrstuhl +  "', " + gruppe + ");");
	}
	
	public void addStudiengang(String name) throws SQLException {
		executeUpdate("INSERT INTO `studiengangliste` (`name`) VALUES ('" + name + "');");
	}
	
	public ArrayList<Pair<Integer, String>> getBetreuer() throws SQLException {
		ArrayList<Pair<Integer, String>> aList = new ArrayList<Pair<Integer, String>>();
		
		ResultSet result = executeQuery("SELECT id,name FROM betreuer");
		
		while (result.next())  {
			int id = result.getInt(1);
			String name = result.getString(2);
			
			Pair<Integer, String> npair = new Pair<Integer, String>(new Integer(id), name);
			aList.add(npair);
		}
		
		return aList;
	}
	
	public String getBetreuerLehrstuhl(int id) throws SQLException {
		ResultSet result = executeQuery("SELECT lehrstuhl FROM betreuer WHERE id = " + id);
		
		String res = "";
		while (result.next())  {
			res = result.getString(1);
		}
		return res;
	}
	
	public int getBetreuerGruppe(int id) throws SQLException {
		ResultSet result = executeQuery("SELECT gruppe FROM betreuer WHERE id = " + id);
		
		int res = -1;
		while (result.next())  {
			res = result.getInt(1);
		}
		return res;
	}
	
	public String getBetreuerName(int id) throws SQLException {
		ResultSet result = executeQuery("SELECT name FROM betreuer WHERE id = " + id);
		
		String res ="";
		while (result.next())  {
			res = result.getString(1);
		}
		return res;
	}  
	
	public void setMinMaxTeamSize(int min, int max) throws SQLException {
		executeUpdate("UPDATE config SET minmitglieder = " + min + " maxmitglieder = " + max + " WHERE id = 1");
	}
	
	public int getMinTeamSize() throws SQLException {
		ResultSet result = executeQuery("SELECT minmitglieder FROM config WHERE id = 1");
		
		int res = -1;
		while (result.next())  {
			res = result.getInt(1);
		}
		return res;
	}
	
	public int getMaxTeamSize() throws SQLException {
		ResultSet result = executeQuery("SELECT maxmitglieder FROM config WHERE id = 1");
		
		int res = -1;
		while (result.next())  {
			res = result.getInt(1);
		}
		return res;
	}
	
	
	public String getAdminZugangscode() throws SQLException {
		ResultSet result = executeQuery("SELECT `zugangscode-admin` FROM config WHERE id = 1");
		
		String res = "";
		while (result.next())  {
			res = result.getString(1);
		}
		return res;
	}
	
	public String getJurorZugangscode() throws SQLException {
		ResultSet result = executeQuery("SELECT `zugangscode-juror` FROM config WHERE id = 1");
		
		String res = "";
		while (result.next())  {
			res = result.getString(1);
		}
		return res;
	}
	
	public String getStudentZugangscode() {
		try {
			ResultSet result = executeQuery("SELECT `zugangscode-student` FROM config WHERE id = 1");
			
			String res = "";
			while (result.next())  {
				res = result.getString(1);
			}
			return res;
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			return "";
		}
		
	}
}
