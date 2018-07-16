/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Sprite;

	public class ControlsHolder extends Sprite{
		private var controls:Array;
		
		function ControlsHolder() {
			scanControls();
		}
		
		private function scanControls() {
			controls = new Array();
			for (var i:Number = 0; i< this.numChildren; i++) {
				var ctl:*= this.getChildAt(i);
				if (ctl.name.indexOf("Control") > -1) {
					ctl.addEventListener(EventControlChange.CONTROL_CHANGE, controlChange);
					controls.push(ctl);
				}
			}
		}
		
		private function controlChange(evt:EventControlChange):void {
			var name:String = evt.name;
			name = name.substring(0,name.indexOf("Control"));
		}
	}
}
