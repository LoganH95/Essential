using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

class Layout {
	hidden var width, height;
	
	enum { 
		steps_type,
		calories_type,
		goal_type,
		stepsGoal_type,
		distance_type
	}

	function initialize() {
    }
    
    function displayInfo(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
    	var moveBarSwitch = App.getApp().getProperty("move_prop");
		var leftSwitch = App.getApp().getProperty("left_prop");
		var rightSwitch = App.getApp().getProperty("right_prop");
    	
		dc.setColor(Color.getSecondaryColor(), Gfx.COLOR_TRANSPARENT);
		showBattery(dc); 
		showDate(dc); 
			
		if (leftSwitch != 99) {
			bottomCorner(dc, true, leftSwitch);
		}
		if (rightSwitch != 99) {
			bottomCorner(dc, false, rightSwitch);
		}
			
		if (moveBarSwitch) {
			moveBar(dc, ActivityMonitor.getInfo().moveBarLevel); 
		}
		
		var symbol = new Symbol(); 
		symbol.drawSymbols(dc);
    }
    
    hidden function showBattery(dc) {
		if (Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
			StatsDisplay.drawBattery(dc, width - 1, 0, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT);
 		} else {
 			StatsDisplay.drawBattery(dc, width - 1, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT);
		}
    }
    
    hidden function showDate(dc) {
    	if (Sys.getDeviceSettings().partNumber.equals("006-B1765-00")) {
    		StatsDisplay.drawDate(dc, width/2, 0, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
 		} else {
 			StatsDisplay.drawDate(dc, width/2, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		}
    }
    
    hidden function bottomCorner(dc, left, cornerSwitch) {
    	var justification, x; 
    	if (left) {
    		x = 0; 
    		justification = Gfx.TEXT_JUSTIFY_LEFT; 
		}
		else {
			x = width - 1; 
			justification = Gfx.TEXT_JUSTIFY_RIGHT; 
		}
    	if (cornerSwitch == steps_type) {
    		StatsDisplay.drawSteps(dc, x, 125, Gfx.FONT_MEDIUM, justification);
		} else if (cornerSwitch == calories_type) {
			StatsDisplay.drawCalories(dc, x, 125, Gfx.FONT_MEDIUM, justification);
		} else if (cornerSwitch == goal_type) {
			StatsDisplay.drawGoal(dc, x, 125, Gfx.FONT_MEDIUM, justification);
		} else if (cornerSwitch == stepsGoal_type) {
			StatsDisplay.drawStepsGoal(dc, x, 125, Gfx.FONT_MEDIUM, justification);
		} else if (cornerSwitch == distance_type) {
			StatsDisplay.drawDistance(dc, x, 125, Gfx.FONT_MEDIUM, justification);
		}
    }
    
    hidden function moveBar(dc,level) {
		if (level >= 1) {
			dc.fillRectangle(0, 46, 8, 8);
			if (level >= 2) {
				dc.fillRectangle(0, 58, 8, 8);
				if (level >= 3) {
					dc.fillRectangle(0, 70, 8, 8);
					if (level >= 4) {
						dc.fillRectangle(0, 82, 8, 8);
						if (level == 5) {
							dc.fillRectangle(0, 94, 8, 8);
						}
					}
				}
			}
		}
	}
}