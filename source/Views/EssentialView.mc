using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class EssentialView extends Ui.WatchFace {
	var time  = new TimeDisplay();
	var layout = new Layout(); 
	
	function initialize() {
        WatchFace.initialize();
    }
	
    function onLayout(dc) { 
    }

    function onShow() {
    }

    function onUpdate(dc) {
    	resetScreen(dc);
    	time.displayTime(dc);
    	layout.displayInfo(dc);
    }
    
    function resetScreen(dc) {
    	dc.setColor(Color.getBackgroundColor(), Color.getBackgroundColor());
		dc.clear();
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    }
    
    function onHide() {
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