package pepmanagement;

public class Menu {
	
	public static String getErrorMessage(String message) {
		String str = "<div class=\"overlay\">\r\n" + 
				"    <div class=\"error border border-dark\"><h3>Fehler!</h3>\r\n" + 
				"        <span class=\"closebtn\" onclick=\"this.parentElement.style.display='none'; this.parentElement.parentElement.style.display='none';\">&times;</span> \r\n" + 
				"        <strong>" + message + "</strong>\r\n" + 
				"    </div>\r\n" + 
				"    </div>";
		
		return str;
	}
	
	public static String getMenu(AccountControl.UserRank rank) {
		String menu = "   <div class=\"dropdown show ml-auto mr-3\">\r\n" + 
				"                    <a style=\"text-decoration:none;\" class=\"menu-dt\" href=\"#\" role=\"button\" id=\"dropdownMenuLink\"" + 
				"                        data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" + 
				"                        <img class=\"menu-pic\" src=\"Bilder/menu.png\" width=\"60\">\r\n" + 
				"                    </a>"+
				"                    <div class=\"dropdown-menu dropdown-menu-right\" aria-labelledby=\"dropdownMenuLink\">" + 
				"                        <a class=\"dropdown-item\" href=\"index\">Startseite</a>";
		
		switch(rank) {
		case ADMIN:
			menu += "<a class=\"dropdown-item\" href=\"AdminTeamUebersicht\">Teamübersicht</a>";
			menu += "<a class=\"dropdown-item\" href=\"AdminLehrstuhlStudiengang\">Lehstühle/Studiengänge</a>";
			menu += "<a class=\"dropdown-item\" href=\"AdminBewertungskriterien\">Kriterien/Juroren</a>";
			menu += "<a class=\"dropdown-item\" href=\"AdminSiegerehrung\">Siegerehrung</a>";
			menu += "<a class=\"dropdown-item\" href=\"AdminConfig\">Fristen & Freigaben</a>";
			menu += "<a class=\"dropdown-item\" href=\"AdminPersoenlich\">Accountinfos</a>";
			break;
		case JUROR:
			

			menu += "<a class=\"dropdown-item\" href=\"AdminPersoenlich\">Accountinfos</a>";
			break;
		case VORSITZ:
			menu += "<a class=\"dropdown-item\" href=\"StudentUpload\">Projektdaten uploaden</a>";
			menu += "<a class=\"dropdown-item\" href=\"StudentPersoenlich\">Accountinfos</a>";
			break;
		case STUDENT:
			menu += "<a class=\"dropdown-item\" href=\"StudentPersoenlich\">Accountinfos</a>";
			break;
		}
		
		menu +=	"                        <div class=\"dropdown-divider\"></div>" + 
				"                        <a class=\"dropdown-item\" href=\"Logout\">Logout</a>" + 
				"                    </div>" + 
				"                </div>";
		
		return menu;
	}

}
