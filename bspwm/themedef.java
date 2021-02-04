import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class themedef {
  public static void main(String[] args) {
    ProcessBuilder launch = new ProcessBuilder();
	String def = "elysium";
	Process p;

	switch (def) {
	case "elysium":	
	p = Runtime.getRuntime().exec("bash /home/marco/.config/polybar/Elysium/launch.sh");
System.out.println("Elysium");
	break;
}  
}
}

