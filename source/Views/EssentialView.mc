using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class EssentialView extends Ui.WatchFace {
	hidden var time  = new TimeDisplay();
	hidden var layout = new Layout(); 
	
	function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc) {
    	resetScreen(dc);
    	time.displayTime(dc);
    	layout.displayInfo(dc);
    }
    
    hidden function resetScreen(dc) {
    	dc.setColor(Color.getBackgroundColor(), Color.getBackgroundColor());
		dc.clear();
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    }
    
    function onExitSleep() {
    	time.seconds = true; 
    }

    function onEnterSleep() {
    	if(time != null) {
    		time.seconds = false; 
    	}
    }

}