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
			res = result.getDate(1);
		}
		return res;
	}
	
	private Date getDate(String query)  throws SQLException {
		ResultSet result = executeQuery(query);
		return getDate(result);
	}  
	
	private Date getDate(PreparedStatement statement)  throws SQLException {
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
		executeUpdate("UPDATE nutzer WHERE id = " + id + " SET passwort = '" + password + "'");
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
		public boolean isAdmin() { return berechtigungen >= 2; }
		public boolean isJuror() { return berechtigungen >= 1; }
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
		executeUpdate("INSERT INTO `sessions` (`email`, `session`) VALUES ( '" + email + "', '" + sessionID +  "');");
	}
	
	public boolean verifySession(String email, String sessionID) throws SQLException {
		ResultSet result = executeQuery("SELECT * FROM sessions WHERE email='" + email + "' AND session='" + sessionID + "'");
	
		int rows = 0;
		while (result.next())  rows++;
		return rows > 0;
	}
	
	public void deleteSession(String email) throws SQLException {
		/*
		 * Deletes all the session with e-mail email from the database.
		 */
		executeUpdate("DELETE FROM sessions WHERE email='" + email);
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
		executeUpdate("INSERT INTO `team` (`vorsitzmail`, `betreuer1`, `betreuer2`, `projekttitel`, `kennnummer`, `note`) VALUES ( '" + email + "', " + betreuer1ID + ", '" + betreuer2 +  "', '" +  teamname + "', '-1', 0.0);");
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
		return getInt("SELECT id FROM team WHERE vorsitzmail = '" + vorsitzmail + "'");
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
		executeUpdate("INSERT INTO `betreuer` (`id`, `name`, `lehrstuhl`, `kennung`, `gruppe`) VALUES (NULL, '" + name + "', '" + lehrstuhl +  "', '" +  kuerzel + "', " + gruppe + ");");
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
	
	public void setKriterium(String hauptkriterium, String teilkriterium, int maxpunkte) throws SQLException {
		int id = -1;
		if (kriteriumExists(teilkriterium)) {
			PreparedStatement statement = connection.prepareStatement("UPDATE `bewertungskriterium` SET hauptkriterium = ?, teilkriterium = ?, maxpunkte = ? WHERE teilkriterium = ?;");
			statement.setString(1,hauptkriterium);
			statement.setString(2,teilkriterium);
			statement.setInt(3,maxpunkte);
			statement.setString(4,teilkriterium);
			statement.executeUpdate();
			
		} else {
			executeUpdate("INSERT INTO `bewertungskriterium` (`hauptkriterium`, `teilkriterium`, `maxpunkte`) VALUES ( '" + hauptkriterium + "', '" + teilkriterium + "', '" + maxpunkte  + "');");	
		}
	}
	
	public void deleteTeilkriterium(String teilkriterium) throws SQLException {		
		executeUpdate("DELETE FROM bewertungskriterium WHERE teilkriterium='" + teilkriterium + "'");
	}
	
	public void deleteHauptkriterium(String hauptkriterium) throws SQLException {		
		executeUpdate("DELETE FROM bewertungskriterium WHERE hauptkriterium='" + hauptkriterium + "'");
	}
	
	public boolean kriteriumExists(String teilkriterium) throws SQLException {
		ResultSet result = executeQuery("SELECT id FROM bewertungskriterium WHERE teilkriterium = '" + teilkriterium + "'");
		boolean hasResults = false;
		while(result.next()) {
			hasResults = true;
		}
		
		return hasResults;
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
		int id = -1;
		ResultSet result = executeQuery("SELECT * FROM team WHERE projekttitel = '" + titel + "'");
		while(result.next()) {
			id = result.getInt("id");
		}
		return id;
	}
	
	
	/* 		Studiengaenge		 */
	
	public ArrayList<String> getStudiengaenge() throws SQLException {
		ArrayList<String> aList = new ArrayList<String>();
		ResultSet result = executeQuery("SELECT * FROM studiengangliste");
		
		while (result.next()) aList.add(result.getString(1));
		return aList;
	}
	
	public void addStudiengang(String name) throws SQLException {
		executeUpdate("INSERT INTO `studiengangliste` (`name`) VALUES ('" + name + "');");
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
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `deadline-registrierung` = ? WHERE id = 1");
		statement.setDate(1, date);
		statement.executeUpdate();
	}
	
	public Date getDeadlineUpload() throws SQLException {
		return getDate("SELECT `deadline-uploaden` FROM config WHERE id = 1");
	}
	
	public void setDeadlineUpload(Date date) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("UPDATE config SET `deadline-uploaden` = ? WHERE id = 1");
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
