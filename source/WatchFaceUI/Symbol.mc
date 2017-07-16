using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Symbol {
	hidden var bluetooth, vibration, alarm, notifications, invertedBluetooth, invertedNotifications, invertedAlarm, invertedVibration;

	function initialize() {
		bluetooth = Ui.loadResource(Rez.Drawables.bluetooth_ID);
    	notifications = Ui.loadResource(Rez.Drawables.notifications_ID);
		vibration = Ui.loadResource(Rez.Drawables.vibration_ID);
		alarm = Ui.loadResource(Rez.Drawables.alarm_ID);
		
		invertedBluetooth = Ui.loadResource(Rez.Drawables.invertedBluetooth_ID);
		invertedNotifications = Ui.loadResource(Rez.Drawables.invertedNotifications_ID);
		invertedVibration = Ui.loadResource(Rez.Drawables.invertedVibration_ID);
		invertedAlarm = Ui.loadResource(Rez.Drawables.invertedAlarm_ID);
	}
	
	function drawSymbols(dc) {
		var invert = App.getApp().getProperty("id_invert");
		if (!invert) {
			symbols(dc); 
		}
		else {
			symbolsInverted(dc);
		}
	}
	
	hidden function symbols(dc) {
		var count = 0; 
		if (Sys.getDeviceSettings().phoneConnected && App.getApp().getProperty("bluetooth_prop")) {
			drawSymbol(dc, bluetooth, count, 0, 0);
			count++; 
		} 
		if (Sys.getDeviceSettings().vibrateOn && App.getApp().getProperty("vibration_prop")) {
			drawSymbol(dc, vibration, count, 0, 0);
			count++; 
		}
		if (Sys.getDeviceSettings().alarmCount > 0 && App.getApp().getProperty("alarm_prop")) {
			drawSymbol(dc, alarm, count, 1, 3);
			count++; 
		}
		if (Sys.getDeviceSettings().notificationCount > 0 && App.getApp().getProperty("notification_prop")) {
			drawSymbol(dc, notifications, count, 0, -2);
			count++; 
		}
    }
    
    hidden function symbolsInverted(dc) {
		var vibrateX = 0; 
		var alarmY = -2;
		var count = 0; 
		if (Sys.getDeviceSettings().phoneConnected && App.getApp().getProperty("bluetooth_prop")) {
			drawSymbol(dc, invertedBluetooth, count, 3, 1);
			vibrateX = -3; 
			alarmY = -4;
			count++; 
		} 
		if (Sys.getDeviceSettings().vibrateOn && App.getApp().getProperty("vibration_prop")) {
			drawSymbol(dc, invertedVibration, count, vibrateX, -2);
			alarmY = -4;
			count++; 
		}
		if (Sys.getDeviceSettings().alarmCount > 0 && App.getApp().getProperty("alarm_prop")) {
			drawSymbol(dc, invertedAlarm, count, alarmY, -3);
			count++; 
		}
		if (Sys.getDeviceSettings().notificationCount > 0 && App.getApp().getProperty("notification_prop")) {
			drawSymbol(dc, invertedNotifications, count, 3, 1);
			count++; 
		}
    }
    
    hidden function drawSymbol(dc, symbol, number, xOffSet, y) {
    	if (number == 0) {
    		dc.drawBitmap(-2 + xOffSet, y, symbol);
    	} else if (number == 1) {
    		dc.drawBitmap(11 + xOffSet, y, symbol);
    	} else if (number == 2) {
    		dc.drawBitmap(22 + xOffSet, y, symbol);
    	} else if (number == 3) {
    		dc.drawBitmap(31 + xOffSet, y,  symbol);
    	}
    }

}