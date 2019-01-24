package pepmanagement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import java.sql.Date;

//Hello

public class Database {
	private Connection connection;
	final String dbserver = "localhost";
	final int dbport = 3306;
	final String dbname = "pepdb";
	final String dbuser = "root";
	final String dbpassword = "";
	
	enum Language {
		PEP_DE,
		PEP_EN
	}
	
	
	/* Connection */
	
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
	
	/*					QUERY				*/
	

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
	
	private String getString(ResultSet result) throws SQLException {
		String res ="";
		while (result.next())  {
			res = result.getString(1);
		}
		return res;
	}
	
	private String getString(String query) throws SQLException {
		ResultSet result = executeQuery(query);
		return getString(result);
	}  
	
	private String getString(PreparedStatement statement) throws SQLException {
		ResultSet result = statement.executeQuery();
		return getString(result);
	}
	
	private int getInt(ResultSet result) throws SQLException {
		int res = -1;
		while (result.next())  {
			res = result.getInt(1);
		}
		return res;
	}
	
	private int getInt(String query)  throws SQLException {
		ResultSet result = executeQuery(query);
		return getInt(result);
	}  
	
	private int getInt(PreparedStatement statement)  throws SQLException {
		ResultSet result = statement.executeQuery();
		return getInt(result);
	}  
	
	private boolean getBoolean(ResultSet result) throws SQLException {
		boolean res = false;
		while (result.next())  {
			res = result.getBoolean(1);
		}
		return res;
	}
	
	private boolean getBoolean(String query)  throws SQLException {
		ResultSet result = executeQuery(query);
		return getBoolean(result);
	}  
	
	private boolean getBoolean(PreparedStatement statement)  throws SQLException {
		ResultSet result = statement.executeQuery();
		return getBoolean(result);
	}  
	
	private Date getDate(ResultSet result) throws SQLException {
		Date res = null;
		while (result.next())  {
			try {
				res = result.getDate(1);
			} catch(Exception e) {
				res = new Date(1);
			}
			
		}
		return res;
	}
	
	
	private Date getDate(String query)  throws SQLException {
		ResultSet result = executeQuery(query);
		return getDate(result);
	}  
	
	private Date getDate(PreparedStatement statement) throws SQLException {
		ResultSet result = statement.executeQuery();
		return getDate(result);
	}  
	
	
	
	/* 						USER 					 */
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
	
	public boolean loginUser(String email, String password) throws SQLException {
		/* Checks if the password is is correct */
		PreparedStatement statement = connection.prepareStatement("SELECT passwort FROM nutzer WHERE email = ?");
		statement.setString(1, email);
		String hashedPassword = getString(statement);
		
		return Crypt.validatePassword(hashedPassword, email, password);
	}
	
	static final long ONE_MINUTE_IN_MILLIS=60000;
	
	public int minutesTillLogin(String email) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT nologinbefore FROM nutzer WHERE email = ?");
		statement.setString(1, email);
		
		java.sql.Date systemDate = new java.sql.Date(System.currentTimeMillis());
		long diff = (getDate(statement).getTime() - systemDate.getTime());
		return (int) (diff < 0 ? 0 : (diff / ONE_MINUTE_IN_MILLIS));
	}
	
	public void failedLoginAttempt(String email) throws SQLException {
		PreparedStatement statement1 = connection.prepareStatement("UPDATE nutzer SET failedlogincount=failedlogincount+1 WHERE email = ?");
		PreparedStatement statement2 = connection.prepareStatement("UPDATE nutzer SET failedlogincount=0 WHERE email = ?");
		PreparedStatement statement3 = connection.prepareStatement("SELECT failedlogincount FROM nutzer WHERE email = ?");
		
		statement1.setString(1, email);
		statement2.setString(1, email);
		statement3.setString(1, email);
		
		statement1.executeUpdate();
		
		int failedAttempts = getInt(statement3);
		
		if(failedAttempts > 10) {
			java.sql.Date systemDate = new java.sql.Date(System.currentTimeMillis());
			//date.setTime(date.getTime() + 24*60*60*1000);
			systemDate.setTime(systemDate.getTime() + 10 * ONE_MINUTE_IN_MILLIS);
			statement2.executeUpdate();
		}
	}
	
	public boolean emailExists(String email) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM nutzer WHERE email = ?");
		statement.setString(1, email);
		return statement.executeQuery().next();
	}
	
	public int getUserID(String email) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM nutzer WHERE email = ?");
		statement.setString(1, email);
		return getInt(statement);
	}
	
	public int getUserID(int matrikelno) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM nutzer WHERE matrikelno = ?");
		statement.setInt(1, matrikelno);
		return getInt(statement);
	}
	
	public void setPasswort(int id, String password, String email) throws SQLException {
		byte[] hashedPassword = Crypt.hashPassword(password, email);
		password = "";
		for(int i = 0;i < hashedPassword.length;i++) {
			password += hashedPassword[i];
		}
		
		PreparedStatement statement = connection.prepareStatement("UPDATE nutzer WHERE id = ? SET passwort = ?");
		statement.setInt(1, id);
		statement.setString(2, password);
		statement.executeUpdate();
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
		
		public int getID() { return userID; }
		public String getEmail() { return email; }
		public String getPasswort() { return passwort; }
		public int getBerechtigungen() { return berechtigungen; }
		public boolean isAdmin() { return berechtigungen == 2; }
		public boolean isJuror() { return berechtigungen == 1; }
		public boolean isStudent() { return berechtigungen == 0; }
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
	
	/* 			Session				*/
	
	public void addSession(String email, String sessionID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `sessions` (`email`, `session`) VALUES (?, ?);");
		statement.setString(1, email);
		statement.setString(2, sessionID);
		statement.executeUpdate();
	}
	
	public boolean verifySession(String email, String sessionID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM sessions WHERE email=? AND session=?");
		statement.setString(1, email);
		statement.setString(2, sessionID);
		return statement.executeQuery().next();
	}
	
	public void deleteSession(String email) throws SQLException {
		/*
		 * Deletes all the session with e-mail email from the database.
		 */
		PreparedStatement statement = connection.prepareStatement("DELETE FROM sessions WHERE email=?");
		statement.setString(1, email);  
		statement.executeUpdate();
	}
	
	
	
	
	/* 			Student 			*/
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
	
	public void updateStudent(int userID, String vorname, String name, String email, String studiengang) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE student SET vorname = ?, nachname = ?, studiengang = ? WHERE nutzerid = ?");
		statement.setString(1, vorname);
		statement.setString(2, name);
		statement.setString(3, studiengang);
		statement.setInt(4, userID);
		statement.executeUpdate();
		 
		statement = connection.prepareStatement("UPDATE nutzer SET email = ? WHERE id = ?");
		statement.setString(1, email);
		statement.setInt(2, userID);
		statement.executeUpdate();
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
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		ResultSet result = statement.executeQuery();
		
		Student studi = null;
		
		while (result.next())  { 
			studi = new Student(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4), result.getString(5), result.getInt(6), result.getBoolean(7));
    	}
		
		return studi;
	}
	
	
	/* 			Team 				*/
	
	public void createTeam(String email, int betreuer1ID, String betreuer2, String teamname) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `team` (`vorsitzmail`, `betreuer1`, `betreuer2`, `projekttitel`, `kennnummer`, `note`) VALUES ( ?, ?, ?, ?, ?, ?);");
		statement.setString(1, email);
		statement.setInt(2, betreuer1ID);
		statement.setString(3, betreuer2);
		statement.setString(4, teamname);
		statement.setString(5, "-1");
		statement.setInt(6, 0);
		statement.executeUpdate();
	}
	
	public class Team {
		int id;
		String vorsitzmail;
		int betreuer1;
		String betreuer2, titel;
		String kennnummer;
		int note;
		
		Team(int tid, String tvorsitzmail, int bet1, String bet2, String tit, String kennno, int tnote) {
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
		public String getKennnummer() {
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
			team = new Team(result.getInt(1), result.getString(2), result.getInt(3), result.getString(4), result.getString(5), result.getString(6), result.getInt(7));
    	}
		
		return team; 
	}
	
	public ArrayList<Team> getTeams() throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM team");
		ResultSet result = statement.executeQuery();
		
		ArrayList<Team> teams = new ArrayList<Team>();
		
		while (result.next())  { 
			Team team = new Team(result.getInt(1), result.getString(2), result.getInt(3), result.getString(4), result.getString(5), result.getString(6), result.getInt(7));
			teams.add(team);
		}
		
		return teams;
	}
	
	public ArrayList<Team> getTeams(int group) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM team WHERE betreuer1 IN (SELECT id FROM betreuer WHERE gruppe = ?)");
		statement.setInt(1, group);
		ResultSet result = statement.executeQuery();
		
		ArrayList<Team> teams = new ArrayList<Team>();
		
		while (result.next())  { 
			Team team = new Team(result.getInt(1), result.getString(2), result.getInt(3), result.getString(4), result.getString(5), result.getString(6), result.getInt(7));
			teams.add(team);
		}
		
		return teams;
	}
	
	public int getTeamID(String vorsitzmail) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM team WHERE vorsitzmail = ?");
		statement.setString(1, vorsitzmail);
		return getInt(statement);
	}
	
	public String getTeamVorsitzenderName(int teamID) throws SQLException {
		return getString("SELECT vorname,nachname FROM student WHERE teamid = " + teamID + " AND vorsitz = 1");
	}
	
	public boolean teamIDExists(int teamID) throws SQLException {
		ResultSet result = executeQuery("SELECT id FROM team WHERE id = " + teamID);
		
		boolean hasResults = false;
		while(result.next()) {
			hasResults = true;
		}
		
		return hasResults;
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
	
	private String generateTeamKennnummer(int id) throws SQLException {
		/* Zur Kennnummerfeststellung wird die Anzahl der Teams aus dem Lehrstuhl ben�tigt,
		 * die bereits eine Kennnummer haben (fortlaufende Nummer) */
		if(id < 0) return "";
		
		Team team = getTeam(id);
		Betreuer betreuer = getBetreuer(team.getBetreuer1());
		
		ResultSet result = executeQuery("SELECT id FROM team WHERE betreuer1 = " + betreuer.getID() + " AND kennnummer != -1");
		
		int count = 0;
		while (result.next()) count++;
		
		DateFormat df = new SimpleDateFormat("yy"); // Just the year, with 2 digits
		
		return betreuer.getKuerzel() + String.format("%02d", count+1) + df.format(Calendar.getInstance().getTime());
	}
	
	public void teamSetKennnummer(int teamID)  throws SQLException {
		executeUpdate("UPDATE team SET kennnummer = '" + generateTeamKennnummer(teamID) + "' WHERE id = " + teamID + " AND kennnummer = '-1'");
	}
	
	/* 			Betreuer 		*/
	
	public void addBetreuer(String name, String kuerzel, String lehrstuhl, int gruppe) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `betreuer` (`id`, `name`, `lehrstuhl`, `kennung`, `gruppe`) VALUES (NULL, ?, ?, ?, ?);");
		statement.setString(1, name);
		statement.setString(2, lehrstuhl);
		statement.setString(3, kuerzel);
		statement.setInt(4, gruppe);
		statement.executeUpdate();
	}
	
	
	
	public class Betreuer {
		int id;
		String name, lehrstuhl, kuerzel;
		int gruppe;
		
		Betreuer(int tid, String tname, String tlehrstuhl, String tkurz, int tgruppe) {
			id = tid;
			name = tname;
			lehrstuhl = tlehrstuhl;
			kuerzel = tkurz;
			gruppe = tgruppe;
		}

		public int getID() {
			return id;
		}

		public String getName() {
			return name;
		}

		public String getLehrstuhl() {
			return lehrstuhl;
		}
		
		public String getKuerzel() {
			return kuerzel;
		}

		public int getGruppe() {
			return gruppe;
		}
		
		public String getKennung() {
			return (id < 10 ? ("0" + id) : Integer.toString(id));
		}
		
	
	}
	public void changeBetreuerGruppe(int betreuer, int neueGruppe) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE betreuer SET gruppe=? WHERE id=?");
		statement.setInt(1, neueGruppe);
		statement.setInt(2, betreuer);
		statement.executeUpdate();
	}

	public ArrayList<Betreuer> getBetreuer() throws SQLException {
		ArrayList<Betreuer> aList = new ArrayList<Betreuer>();
		ResultSet result = executeQuery("SELECT * FROM betreuer");
		
		while (result.next())  {
			Betreuer betreuer = new Betreuer(result.getInt(1), result.getString(2), result.getString(3), result.getString(4), result.getInt(5));
			aList.add(betreuer);
		}
		
		return aList;
	}
	
	public Betreuer getBetreuer(int betreuer) throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM betreuer WHERE id = " + betreuer);
		Betreuer bet = null;
		while (result.next())  {
			bet = new Betreuer(result.getInt(1), result.getString(2), result.getString(3), result.getString(4), result.getInt(5));
		}
		return bet;
	}
	
	public void deleteBetreuer(int betreuer) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("DELETE FROM betreuer WHERE id=?");
		statement.setInt(1, betreuer);
		statement.executeUpdate();
	}
	
	/* BEWERTUNG */
	
	public void setJurorGruppe(int jurorid, int gruppe) throws SQLException {
		if (!jurorGruppeExists(jurorid)){
			PreparedStatement statement = connection.prepareStatement("INSERT INTO juror (nutzerID, gruppe) VALUES (?,?)");
			statement.setInt(1, jurorid);
			statement.setInt(2, gruppe);
			statement.executeUpdate();
		} else {
			PreparedStatement statement = connection.prepareStatement("UPDATE juror SET gruppe = ? WHERE nutzerID = ?");
			statement.setInt(1, gruppe);
			statement.setInt(2, jurorid);
			statement.executeUpdate();
		}
	}
	
	public boolean jurorGruppeExists(int jurorid) throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM juror WHERE nutzerID = '" + jurorid + "'");
		return result.next();
	}
	
	
	public boolean bewertungExists(int teamID, int bewertungID, int jurorID) throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM bewertung WHERE teamID = " + teamID + " AND bewertungID = " + bewertungID + " AND jurorID = " + jurorID);
		return result.next();
	}
	
	public void setKriterium(String hauptkriterium, String teilkriterium, int maxpunkte, int minpunkte) throws SQLException {
		if (kriteriumExists(teilkriterium)) {
			PreparedStatement statement = connection.prepareStatement("UPDATE `bewertungskriterium` SET hauptkriterium = ?, teilkriterium = ?, maxpunkte = ?, minpunkte = ? WHERE teilkriterium = ?;");
			statement.setString(1,hauptkriterium);
			statement.setString(2,teilkriterium);
			statement.setInt(3,maxpunkte);
			statement.setInt(4, minpunkte);
			statement.setString(5,teilkriterium);
			statement.executeUpdate();
		} else {
			PreparedStatement statement = connection.prepareStatement("INSERT INTO `bewertungskriterium` (`hauptkriterium`, `teilkriterium`, `maxpunkte`, `minpunkte`) VALUES ( ?, ?, ?, ?);");
			statement.setString(1, hauptkriterium);
			statement.setString(2, teilkriterium);
			statement.setInt(3, maxpunkte);
			statement.setInt(4,minpunkte);
			statement.executeUpdate();
		}
	}
	
	public void deleteTeilkriterium(String teilkriterium) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("DELETE FROM bewertungskriterium WHERE teilkriterium=?");
		statement.setString(1, teilkriterium);
		statement.executeUpdate();
	}
	
	public void deleteHauptkriterium(String hauptkriterium) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("DELETE FROM bewertungskriterium WHERE hauptkriterium=?");
		statement.setString(1, hauptkriterium);
		statement.executeUpdate();
	}
	
	public void deleteKriterium(int id) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("DELETE FROM bewertungskriterium WHERE id=?");
		statement.setInt(1, id);
		statement.executeUpdate();
	}
	
	public boolean kriteriumExists(String teilkriterium) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM bewertungskriterium WHERE teilkriterium = ?");
		statement.setString(1, teilkriterium);
		return statement.executeQuery().next();
	}
	
	public int getBewertung(int teamID, int bewertungid) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT punkte FROM (SELECT * FROM bewertung WHERE bewertungID = ?) AS X WHERE teamID = ?");
		statement.setInt(1, bewertungid);
		statement.setInt(2, teamID);
		
		ResultSet result = statement.executeQuery();
		while(result.next()) {
			return (result.getInt("punkte"));
		}
        return 0;
	} 
	
	public ArrayList<String> getOrderedTeams(int group) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT projekttitel, ID, SUM(punkte) AS summe FROM team NATURAL JOIN bewertung WHERE betreuer1 IN (SELECT id FROM betreuer WHERE gruppe = ?) AND team.ID = bewertung.teamID GROUP BY team.ID ORDER BY summe DESC");
		statement.setInt(1,group);
		ResultSet result = statement.executeQuery();
		
		ArrayList<String> teams = new ArrayList<String>();
		
		while (result.next())  { 
			String team = result.getString("projekttitel") + "#" + result.getInt("ID") + "#" + result.getInt("summe");
			teams.add(team);
		}
		
		return teams;
	}
	
	
	public void setBewertung(int teamid, int bewertungid, int punktzahl, int jurorid) throws SQLException {
		
		
		if(!bewertungExists(teamid, bewertungid, jurorid)) {
			PreparedStatement statement = connection.prepareStatement("INSERT INTO `bewertung` (`teamID`, `jurorID`, `bewertungID`, `punkte`) VALUES (?,?,?,?);");
			statement.setInt(1, teamid);
			statement.setInt(2, jurorid);
			statement.setInt(3, bewertungid);
			statement.setInt(4, punktzahl);	
			statement.executeUpdate();
		}
		else {
			PreparedStatement statement = connection.prepareStatement("UPDATE `bewertung` SET punkte = ? WHERE teamID = ? AND bewertungID = ?;");
			statement.setInt(1, punktzahl);
			statement.setInt(2, teamid);
			statement.setInt(3, bewertungid);
			statement.executeUpdate();
		}
	}
	
	
	public ResultSet listTeams() throws SQLException {		
		ResultSet teams = executeQuery("SELECT * FROM team");		
		return teams;
	}

	public ArrayList<Bewertungskriterium> getKriterien() throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM bewertungskriterium");
		
	    ArrayList<Bewertungskriterium> kriterien = new ArrayList<Bewertungskriterium>();

        while (result.next()) {
        	Bewertungskriterium bewertungskriterium = new Bewertungskriterium();
        	bewertungskriterium.setHauptkriterium(result.getString("hauptkriterium"));
        	bewertungskriterium.setTeilkriterium(result.getString("teilkriterium"));
        	bewertungskriterium.setMaxpunkte(result.getInt("maxpunkte"));
        	bewertungskriterium.setMinpunkte(result.getInt("minpunkte"));
        	bewertungskriterium.setBewertungID(result.getInt("id"));
        	kriterien.add(bewertungskriterium);
        }
        
        return kriterien;
	}
	
	public ArrayList<Integer> getJurorenIDs() throws SQLException {
		ArrayList<Integer> juroren = new ArrayList<Integer>();
		ResultSet result = executeQuery("SELECT id FROM nutzer WHERE berechtigungen = 1");
		while(result.next()) {
			int id = result.getInt("id");
			juroren.add(id);
		}
		return juroren;
	}
	
	public ArrayList<String> getJuroren() throws SQLException{
		ArrayList<String> juroren = new ArrayList<String>();
		ResultSet result = executeQuery("SELECT email FROM nutzer WHERE berechtigungen = 1");
		while(result.next()) {
			String email = result.getString("email");
			int index = email.indexOf('@');
			email = email.substring(0,index);
			juroren.add(email);
		}
		return juroren;
	}
	
	
	public int getJurorGruppe(int jurorID) throws SQLException {		
		ResultSet result = executeQuery("SELECT gruppe FROM juror WHERE nutzerID = '" + jurorID + "'");
		
		int res =-1;
		while (result.next())  {
			res = result.getInt(1);
		}
		return res;
		
	}
	
	public int getTeamIDByTitel(String titel) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT id FROM team WHERE projekttitel = ?");
		statement.setString(1, titel);
		return getInt(statement);
	}
	
	
	
	/* Nachrichten */
	
	
	public class Message {
		String message_de, message_en;
		int userRank, team;
		Date date;
		
		public void setMessage(String de, String en) {
			this.message_de = de;
			this.message_en = en;
		}
		
		public String getMessageDe() {
			return this.message_de;
		}
		
		public String getMessageEn() {
			return this.message_en;
		}
		
		public void setRank(int userRank) {
			this.userRank = userRank;
		}
		
		public int getRank() {
			return this.userRank;
		}
		
		public void setTeam(int team) {
			this.team = team;
		}
		
		public int getTeam() {
			return this.team;
		}
		
		public void setDate(Date date) {
			this.date = date;
		}
		
		public Date getDate() {
			return this.date;
		}
	}
	
	public Message getNewMessage() {
		return new Message();
	}
	
	private Message extractMessage(ResultSet result) throws SQLException {
		Message m = new Message();
		
		m.setRank(result.getInt(2));
		m.setTeam(result.getInt(3));
		m.setMessage(result.getString(4), result.getString(5));
		m.setDate(result.getDate(6));
		
		return m;
	}
	
	public ArrayList<Message> getAllMessages() throws SQLException {
		ArrayList<Message> arr = new ArrayList<Message>();
		ResultSet result = executeQuery("SELECT * FROM message ORDER BY date DESC");
		
		while(result.next()) {
			arr.add(extractMessage(result));
		}
		
		return arr;
	}
	
	public ArrayList<Message> getJurorMessages() throws SQLException {
		ArrayList<Message> arr = new ArrayList<Message>();
		ResultSet result = executeQuery("SELECT * FROM message WHERE `user-category` = 1 OR `user-category` = -1 ORDER BY date DESC");
		
		while(result.next()) {
			arr.add(extractMessage(result));
		}
		
		return arr;
	}
	
	public ArrayList<Message> getStudentMessage(int team) throws SQLException {
		ArrayList<Message> arr = new ArrayList<Message>();
		ResultSet result = executeQuery("SELECT * FROM message WHERE (`user-category` = 0 OR `user-category` = -1) AND (`user-team` = " + team + " OR `user-team` = -1) ORDER BY date DESC");
		
		while(result.next()) {
			arr.add(extractMessage(result));
		}
		
		return arr;
	}
	
	public void publishMessage(Message m) throws SQLException {
		PreparedStatement s = connection.prepareStatement("INSERT INTO message (`id`, `user-category`, `user-team`, `text-de`, `text-en`, `date`) VALUES (NULL, ?, ?, ?, ?, ?)");
		s.setInt(1, m.getRank());
		s.setInt(2, m.getTeam());
		s.setString(3, m.getMessageDe());
		s.setString(4, m.getMessageEn());
		s.setDate(5, m.getDate());
		s.executeUpdate();
	}
	
	
	/* 		Studiengaenge		 */
	
	public ArrayList<String> getStudiengaenge() throws SQLException {
		ArrayList<String> aList = new ArrayList<String>();
		ResultSet result = executeQuery("SELECT * FROM studiengangliste ORDER BY name");
		
		while (result.next()) aList.add(result.getString(1));
		return aList;
	}
	
	public boolean studiengangExists(String name) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT name FROM studiengangliste WHERE name = ?");
		statement.setString(1, name);
		return statement.executeQuery().next();
	}
	
	public void addStudiengang(String name) throws SQLException {
		if(studiengangExists(name)) return;
		PreparedStatement statement = connection.prepareStatement("INSERT INTO `studiengangliste` (`name`) VALUES (?);");
		statement.setString(1, name);
		statement.executeUpdate();
	}
	
	public void deleteStudiengang(String name) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("DELETE FROM studiengangliste WHERE name = ?");
		statement.setString(1, name);
		statement.executeUpdate();
	}
	
	
							/* CONFIG */
	
	public void setMinMaxTeamSize(int min, int max) throws SQLException {
		if(min > max || min < 0 || max < 1) return;
		
		executeUpdate("UPDATE config SET minmitglieder = " + min + " WHERE id = 1");
		executeUpdate("UPDATE config SET maxmitglieder = " + max + " WHERE id = 1");
	}
	
	public int getMinTeamSize() throws SQLException {
		return this.getInt("SELECT minmitglieder FROM config WHERE id = 1");
	}
	
	public int getMaxTeamSize() throws SQLException {
		return this.getInt("SELECT maxmitglieder FROM config WHERE id = 1");
	}

	public String getAdminZugangscode() throws SQLException {
		return this.getString("SELECT `zugangscode-admin` FROM config WHERE id = 1");
	}
	
	public void setAdminZugangscode(String code) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `zugangscode-admin` = ? WHERE id = 1");
		statement.setString(1, code);
		statement.executeUpdate();
	}
	
	public String getJurorZugangscode() throws SQLException {
		return this.getString("SELECT `zugangscode-juror` FROM config WHERE id = 1");
	}
	
	public void setJurorZugangscode(String code) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `zugangscode-juror` = ? WHERE id = 1");
		statement.setString(1, code);
		statement.executeUpdate();
	}
	
	public String getStudentZugangscode() {
		try {
			return this.getString("SELECT `zugangscode-student` FROM config WHERE id = 1");
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			return "";
		}
	}
	
	public void setStudentZugangscode(String code) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `zugangscode-student` = ? WHERE id = 1");
		statement.setString(1, code);
		statement.executeUpdate();
	}
	
	public Date getDeadlineRegistrierung() throws SQLException {
		return getDate("SELECT `deadline-registrierung` FROM config WHERE id = 1");
	}
	
	public void setDeadlineRegistrierung(Date date) throws SQLException {
		date.setTime(date.getTime() + 24*60*60*1000);
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `deadline-registrierung` = ? WHERE id = 1");
		statement.setDate(1, date);
		statement.executeUpdate();
	}
	
	public Date getDeadlinePoster() throws SQLException {
		return getDate("SELECT `deadline-poster` FROM config WHERE id = 1");
	}
	
	public Date getDeadlineDokumentation() throws SQLException {
		return getDate("SELECT `deadline-dokumentation` FROM config WHERE id = 1");
	}
	
	public Date getDeadlineKurzbeschreibung() throws SQLException {
		return getDate("SELECT `deadline-kurzbeschreibung` FROM config WHERE id = 1");
	}
	
	public Date getDeadlinePraesentation() throws SQLException {
		return getDate("SELECT `deadline-praesentation` FROM config WHERE id = 1");
	}
	
	public void setDeadlineDokumentation(Date date) throws SQLException {
		setDeadline("dokumentation", date);
	}
	public void setDeadlineKurzbeschreibung(Date date) throws SQLException {
		setDeadline("kurzbeschreibung", date);
	}
	public void setDeadlinePoster(Date date)  throws SQLException {
		setDeadline("poster", date);
	}
	public void setDeadlinePraesentation(Date date) throws SQLException {
		setDeadline("praesentation", date);
	}
	
	private void setDeadline(String field, Date date) throws SQLException {
		date.setTime(date.getTime() + 24*60*60*1000);
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `deadline-" + field + "` = ? WHERE id = 1");
		statement.setDate(1, date);
		statement.executeUpdate();
	}
	
	public static boolean dateReached(Date date) {
		java.sql.Date systemDate = new java.sql.Date(System.currentTimeMillis());
		return systemDate.after(date);
	}
	
	public boolean bewertungOpen() {
		try {
			return getBoolean("SELECT `bewertung` FROM config WHERE id = 1");
		} catch(Exception e) {
			return false;
		}
	}
	
	public void setBewertungOpen(boolean should) throws SQLException {
		executeUpdate("UPDATE config SET bewertung = " + (should ? "TRUE" : "FALSE") + " WHERE id = 1");
	}
	
	/* DEPRECATED */
	
	
	@Deprecated
	private int getUserRights(int userID) throws SQLException{
		PreparedStatement statement = connection.prepareStatement("SELECT berechtigungen FROM nutzer WHERE id = ?");
		statement.setInt(1, userID);
		return getInt(statement);
	}
	
	public boolean userIsAdmin(int userID) throws SQLException {
		return getUserRights(userID) == 2;
	}
	
	public boolean userIsJuror(int userID) throws SQLException {
		return getUserRights(userID) > 0;
	}

	@Deprecated
	public int getStudentTeam(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT teamid FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		return getInt(statement);
	}
	
	@Deprecated
	public int getStudentMatrikelnummer(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT matrikelno FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		return getInt(statement);
	}
	
	@Deprecated
	public String getStudentVorname(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT vorname FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		return getString(statement);
	}
	
	@Deprecated
	public String getStudentNachname(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT nachname FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		return getString(statement);
	}
	
	@Deprecated
	public String getStudentStudiengang(int userID) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT studiengang FROM student WHERE nutzerid = ?");
		statement.setInt(1, userID);
		return getString(statement);
	}
	
	
	@Deprecated
	public boolean studentIsVorsitzender(int userID) throws SQLException {
		ResultSet result = executeQuery("SELECT vorsitz FROM student WHERE nutzerid = " + userID);
		
		boolean res = false;
		while(result.next()) {
			res = result.getBoolean(1);
		}
		
		return res;
	}
	
	@Deprecated
	public String getTeamKennnummer(int teamID) throws SQLException {
		return getString("SELECT kennnummer FROM team WHERE id = " + teamID);
	}
	
	@Deprecated
	public String getTeamTitel(int teamID) throws SQLException {
		return getString("SELECT projekttitel FROM team WHERE id = " + teamID);
	}
	
	@Deprecated
	public String getBetreuerLehrstuhl(int id) throws SQLException {return getString("SELECT lehrstuhl FROM betreuer WHERE id = " + id);}
	@Deprecated
	public int getBetreuerGruppe(int id) throws SQLException {return getInt("SELECT gruppe FROM betreuer WHERE id = " + id);}
	@Deprecated
	public String getBetreuerName(int id) throws SQLException {return getString("SELECT name FROM betreuer WHERE id = " + id);}

	
}
