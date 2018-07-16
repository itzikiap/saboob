/**
* ...
* @author Default
* @version 0.1
*/

package  {
import assets.Selectable;
import com.asinmotion.easing.Sine;
import com.asinmotion.effects.Parallel;
import events.EventControlChange;
import events.EventSendEmail;
import fl.transitions.Tween;
import flash.display.AVM1Movie;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import org.flashdevelop.utils.FlashConnect;
import stucture.MenuEvent;
import stucture.Modes;
	
	public class GameFlow extends MovieClip{
		private var controls:Array;
		private var face:Dude;
		private var mode:SwitchModeBtn;
		private var menu:UserMenu;
		private var saved:String;
		
		private var sendMail:EmailSend;
		
		function GameFlow() {
			
			var paramObj:LoaderInfo = this.root.loaderInfo;
			
			saved = paramObj.parameters["dude"];
			
			this.mcControls.savedX = this.mcControls.x;
			scanControls();
			face = this.mcDude as Dude;
			mode = this.getChildByName("modeBtn") as SwitchModeBtn;
			mode.addEventListener("switchMode", switchToNewMode);
			
			menu = this.userMenu as UserMenu;
			menu.addEventListener(MenuEvent.MENU_EVENT, executeMenuCommand);
			
			if (saved != null) {
				this.mcControls.x = this.mcControls.savedX;
				this.mcControls.mouseChildren = false;
				this.mcControls.alpha = 0;
				closeAllPanels();
				menu.showMenu();
				mode.mode = Modes.VIEW;
				face.openMode(Modes.VIEW);
				face.construct(saved);
			}
			
			var o:Object = this.mcMail;
			
			sendMail = o;
			sendMail.addEventListener(EventSendEmail.SEND, handleSendMail);
			sendMail.addEventListener(EventSendEmail.CLOSE, handleSendMail);
			
			//face.addEventListener("showDude", );
		}
		
		private function switchToNewMode(evt:Event) {
			face.switchToMode(mode.mode);
			var holder:Sprite = this.mcControls;
			if (hideAnim != null) {
				hideAnim.stop();
			}
			var hideAnim:Parallel = new Parallel();
			
			if (mode.mode == Modes.VIEW) {
				holder.buttonMode = false;
				holder.mouseChildren = false;
				closeAllPanels();
				hideAnim.addEffect( { target:holder, x:holder.savedX - 30, ease:Sine.easeOut, time: 200 } );
				hideAnim.addEffect( { target:holder, alpha:0, ease:Sine.easeOut, time: 200 } );
				hideAnim.start();
				menu.showMenu();
			} else {
				holder.buttonMode = false;
				holder.mouseChildren = true;
				holder.x = holder.savedX;
				hideAnim.addEffect( { target:holder, alpha:1, ease:Sine.easeOut, time: 1300 } );
				hideAnim.start();
				menu.hideMenu();
			}
		}
		
		private function scanControls() {
			controls = new Array();
			var holder:Sprite = this.mcControls;
			for (var i:Number = 0; i< holder.numChildren; i++) {
				var ctl:Controls = holder.getChildAt(i) as Controls;
				if (ctl != null) {
					if (ctl.name.indexOf("Control") > -1) {
						ctl.addEventListener(EventControlChange.CONTROL_CHANGE, controlChange);
						ctl.addEventListener("panelOpened", closePanels);
						controls.push(ctl);
					}
				}
			}
		}

		private function closeAllPanels() {
			for (var o:String in controls) {
				var ctl:Controls = controls[o];
				ctl.hideSelection();
			}
			
		}
		
		private function closePanels(evt:Event) {
			for (var o:String in controls) {
				var ctl:Controls = controls[o];
				if (evt.currentTarget != ctl) {
					ctl.hideSelection();
				}
			}
		}
		
		private function handleSendMail(evt:EventSendEmail) {
			switch (evt.type) {
				case EventSendEmail.SEND:
					saved = face.serialize();

					var to:String = evt.email;
					var subject:String = "החבוב שלי מהכל סבוב חבוב";
					var page:String = "http://iap.babin.co.il/saboob/index.html"
					var body:String = "מה שלומך חבוב? <br>"
						+ "תראה את החבוב שעיצבתי להכל סבוב חבוב: <br>"
						+ "<a href='" + page + "?dude=" + saved + "'> לחץ כאן </a> <br> "
						+ "הכנס לפורום שלנו: <br>"
						+ "<a href=http://forum.saboob.co.il/>http://forum.saboob.co.il/</a>";
					var request:URLRequest = new URLRequest("mailto:"+to+"?subject="+subject+"&body="+body);
					navigateToURL(request); // second argument is targe
					//flash.external.ExternalInterface.call
				case EventSendEmail.CLOSE:
					mode.buttonMode = true;
					menu.mouseChildren = true;
					sendMail.hideMenu();
					break;
					
			}
		}
		
		private function executeMenuCommand(evt:MenuEvent) {
			switch (evt.value) {
				case 0:
					saved = face.serialize();
					trace("saved face: " + saved);
					
					//var request:URLRequest = new URLRequest("all_stuff.swf?dude="+saved);
					//navigateToURL(request, '_blank'); // second argument is targe
					//flash.external.ExternalInterface.call
					break;
				case 1:
					face.construct("DACA@ABAEAAA");
					break;
				case 2:
					mode.buttonMode = false;
					menu.mouseChildren = false;
					sendMail.showMenu();
					break;
					
			}
		}
		
		private function controlChange(evt:EventControlChange):void {
			var name:String = evt.name;
			name = name.substring(0, name.indexOf("Control"));
			
			face.changeElement(name, evt.val);
		}
	}
	
}
