package pepmanagement;

public class Bewertungskriterium {
	private String hauptkriterium;
	private String teilkriterium;
	private int maxpunkte;
	private int minpunkte;
	private int bewertungID;
	
	public String getHauptkriterium() {
		return hauptkriterium;
	}
	public void setHauptkriterium(String hauptkriterium) {
		this.hauptkriterium = hauptkriterium;
	}
	public String getTeilkriterium() {
		return teilkriterium;
	}
	public void setTeilkriterium(String teilkriterium) {
		this.teilkriterium = teilkriterium;
	}
	public int getMaxpunkte() {
		return maxpunkte;
	}
	public void setMaxpunkte(int punktzahl) {
		this.maxpunkte = punktzahl;
	}
	public int getBewertungID() {
		return bewertungID;
	}
	public void setBewertungID(int bewertungID) {
		this.bewertungID = bewertungID;
	}
	public int getMinpunkte() {
		return minpunkte;
	}
	public void setMinpunkte(int minpunkte) {
		this.minpunkte = minpunkte;
	}
	
}
