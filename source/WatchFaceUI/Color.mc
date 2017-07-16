using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;


class Color {
    
    static function getPrimaryColor() {
    	var primaryColor = App.getApp().getProperty("color_primary");
    	if (primaryColor == null) {
			primaryColor = Gfx.COLOR_WHITE; 
		}
		primaryColor = checkConflictingColors(primaryColor); 
    	return primaryColor; 
    }
    
    static function checkConflictingColors(color) {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert && color == Gfx.COLOR_BLACK) {
    		return Gfx.COLOR_WHITE; 
    	} else if (invert && color == Gfx.COLOR_WHITE) {
    		return Gfx.COLOR_BLACK; 
    	} else {
    		return color; 
    	}
    }
    
    static function getSecondaryColor() {
    	var secondaryColor = App.getApp().getProperty("color_secondary");
    	if (secondaryColor == null) {
			secondaryColor = 1;  
		}
		if (secondaryColor == 1) {
			secondaryColor = batteryColor(); 
		}
    	return secondaryColor; 
    }
    
    static function batteryColor() {
    	if (Sys.getSystemStats().battery <= 67 && Sys.getSystemStats().battery > 33) {
    		return Gfx.COLOR_YELLOW;
    	}
		else if (Sys.getSystemStats().battery <= 34) {
			return Gfx.COLOR_RED;
		}
		else {
			return Gfx.COLOR_GREEN;
		}
    }
    
    static function getBackgroundColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_BLACK;
		}
    	return Gfx.COLOR_WHITE; 
    }
}