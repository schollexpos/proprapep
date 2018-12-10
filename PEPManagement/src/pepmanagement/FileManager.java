package pepmanagement;

import java.io.File;

//Hello

public class FileManager {
	
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
	
	public static String getFilename(int teamID, String filename) {
		return teamID + "_" + filename + ".pdf";
	}

}
