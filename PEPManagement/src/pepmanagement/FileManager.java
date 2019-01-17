package pepmanagement;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import pepmanagement.Database.Team;

//Hello

public class FileManager {
	
	public static String getBasePath() {
		return "C:\\Users\\lucah\\Desktop\\ProPra Projekt 1\\";
	}
	
	public static boolean fileExists(String path, int teamID, String filename) {
		File tmpDir = new File(path + getFilename(teamID, filename));
		return tmpDir.exists();
	}
	
	public static long fileDate(String path, int teamID, String filename) {
		File tmpDir = new File(path + getFilename(teamID, filename));
		return tmpDir.lastModified();
	}
	
	public static int getFileCount() {
		return 4;
	}
	
	public static String getFileIdentifier(int i) {
		switch(i) {
		case 0:
			return "dokumentation";
		case 1:
			return "poster";
		case 2:
			return "kurzbeschreibung";
		case 3:
			return "praesentation";
		default:
			return ":(";
		}
	}
	
	public static String getFileDescriptor(int i) {
		switch(i) {
		case 0:
			return "Dokumentation";
		case 1:
			return "Poster";
		case 2:
			return "Kurzbeschreibung";
		case 3:
			return "Präsentation";
		default:
			return ":(";
		}
	}
	
	public static boolean createTeamFolder(String team) {
		System.out.println(team);
		File dir = new File(getBasePath() + "Teams\\" + team);
		if (dir.mkdir()) {
			return true;
		}
		else return false;
		}
	
	public static String getFilename(int teamID, String filename) {
		return teamID + "_" + filename + ".pdf";
	}
	
	public static String getPDFServe(int teamID, String filename) {
		return "PDFServe?team=" + teamID + "&fileid=" + filename;
	}
	public static boolean zipTeam(Team team) {
		{
			String teamKenn = team.getID() + "_" + team.getKennnummer();
			String zipFile = getBasePath() + "Abschluss\\"+ teamKenn + ".zip";
			String inFileName= getBasePath() +"Teams\\"+ teamKenn;
			
			ZipOutputStream zos = null;
	        FileInputStream fis = null;
	        
	        File inFile = new File(inFileName);
	        if (inFile.exists() && inFile.isDirectory()) {
	        File [] fileArr = inFile.listFiles();
	        try {
	        	
	        	for (File f : fileArr) {
	        		 
	        		zos = new ZipOutputStream(new FileOutputStream(zipFile)); 
	                fis = new FileInputStream(f);
	        
	                String path = f.getCanonicalPath(); 
	                String name = path.substring(inFileName.length(), path.length()); 
	                System.out.println("Packe");
	                zos.putNextEntry(new ZipEntry(name));
	                int len;
	                byte[] buffer = new byte[2048];
	                while ((len = fis.read(buffer, 0, buffer.length)) > 0) {
	                    zos.write(buffer, 0, len);
	                }
	            } 
	        } catch (FileNotFoundException e) {
	        	System.out.println("Team " + teamKenn + " besitzt keinen Ordner!");
	        } catch (IOException e) {
	            e.printStackTrace();
	        }finally{
	            if(fis != null){
	                try {
	                    fis.close();
	                } catch (IOException e) {}
	            }
	            if(zos != null){
	                try {
	                    zos.closeEntry();
	                    zos.close();
	                } catch (IOException e) {}
	            }
	        }
	    } 
		}
		return true;
	}
	
	public static boolean zipAllTeams() throws SQLException {
		Database db = new Database();
		db.connect();
		ArrayList <Team> teams = new ArrayList<>();
		teams = db.getTeams();
		File f = new File(getBasePath()+"Abschluss");
		if (f.exists() && f.isDirectory()) {
			for (Team t : teams) {
				zipTeam(t);
			}
		}else {
			f.mkdir();
			for (Team t : teams) {
				zipTeam(t);
			}
		}
		return true;
	}

}
