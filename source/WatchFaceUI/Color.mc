using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

class Color {
	const BATTERY_COLOR = 1;
    
    static function getPrimaryColor() {
    	var primaryColor = App.getApp().getProperty("color_primary");
    	return primaryColor ? checkConflictingColors(primaryColor) : checkConflictingColors(Gfx.COLOR_WHITE);
    }
    
    hidden static function checkConflictingColors(color) {
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
			secondaryColor = BATTERY_COLOR;  
		}
		if (secondaryColor == BATTERY_COLOR) {
			secondaryColor = batteryColor(); 
		}
    	return checkConflictingColors(secondaryColor); 
    }
    
    hidden static function batteryColor() {
    	var battery = Sys.getSystemStats().battery;
    	if (battery <= 67 && battery > 33) {
    		return Gfx.COLOR_YELLOW;
    	} else if (battery <= 34) {
			return Gfx.COLOR_RED;
		} else {
			return Gfx.COLOR_GREEN;
		}
    }
    
    static function getBackgroundColor() {
    	return App.getApp().getProperty("id_invert") ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK;
    }
}