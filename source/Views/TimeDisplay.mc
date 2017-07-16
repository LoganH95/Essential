using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class TimeDisplay {
	var seconds; 
	var width; 
	var height; 

	function initialize() {
		seconds = false; 
    }

	//Puts the time on the screen as text
    function displayTime(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
        drawTime(dc, Sys.getDeviceSettings().is24Hour, Sys.getClockTime()); 
        var secondsSwitch = App.getApp().getProperty("seconds_prop");
    	if (seconds && secondsSwitch) {	
	    	displaySeconds(dc);     	
	    }
	    
	    if (!Sys.getDeviceSettings().is24Hour) {
	    	cycle(dc); 
	    }
    }
    
    hidden function drawTime(dc, mode, time) {
    	var timeString = clockTime(mode, time); 
        dc.drawText(width/2, 40, Gfx.FONT_NUMBER_THAI_HOT, timeString, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
	hidden function clockTime(mode, time) {
		var timeString; 
	    if (!mode && time.hour > 12) {
	       timeString = Lang.format("$1$:$2$", [time.hour - 12, time.min.format("%02d")]);
	    }
	   	else {
	        if(!mode && time.hour == 0) {
	        	timeString = Lang.format("$1$:$2$", [time.hour + 12, time.min.format("%02d")]);
	        }
	        else {
	       	 	timeString = Lang.format("$1$:$2$", [time.hour, time.min.format("%02d")]);
	       	}
	    }
	    return timeString; 
	}
	
	function displaySeconds(dc) {
		var secString = Lang.format("$1$", [Sys.getClockTime().sec.format("%02d")]);
    	if ((Sys.getDeviceSettings().is24Hour && Sys.getClockTime().hour >= 12) || (Sys.getClockTime().hour >= 10 && Sys.getClockTime().hour <= 12) || (Sys.getClockTime().hour >= 22 && Sys.getClockTime().hour <= 23) || Sys.getClockTime().hour == 0) {
    		if (Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
				dc.drawText(width, 40, Gfx.FONT_LARGE, secString, Gfx.TEXT_JUSTIFY_RIGHT);
			}
			else {
    			dc.drawText(width - 23, 40, Gfx.FONT_LARGE, secString, Gfx.TEXT_JUSTIFY_CENTER);
    		}
    	}
    	else {
    		if (Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
				dc.drawText(width - 15, 40, Gfx.FONT_LARGE, secString, Gfx.TEXT_JUSTIFY_RIGHT);
			}
			else {
    			dc.drawText(width - 35, 40, Gfx.FONT_LARGE, secString, Gfx.TEXT_JUSTIFY_CENTER);
    		}
    	}
	}
	
	function cycle(dc) {
		var cycle; 
		if(Sys.getClockTime().hour < 12) {
			cycle = "AM";
		}
		else {
			cycle = "PM"; 
		}
    	if ((Sys.getClockTime().hour >= 10 && Sys.getClockTime().hour <= 12) || (Sys.getClockTime().hour >= 22 && Sys.getClockTime().hour <= 23) || Sys.getClockTime().hour == 0) {
			if(Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
				dc.drawText(3 * width / 4 + 30, 2 * height / 3 - 10, Gfx.FONT_SMALL, cycle, Gfx.TEXT_JUSTIFY_LEFT);
			}
			else {
				dc.drawText(170, 88, Gfx.FONT_SMALL, cycle, Gfx.TEXT_JUSTIFY_LEFT);
			}
    	}
    	else {
			if(Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
 				dc.drawText(3 * width / 4 + 12, 2 * height / 3 - 10, Gfx.FONT_SMALL, cycle, Gfx.TEXT_JUSTIFY_LEFT);
 			}
 			else {
 				dc.drawText(155, 88, Gfx.FONT_SMALL, cycle, Gfx.TEXT_JUSTIFY_LEFT);
 			}
    	}
	}
}