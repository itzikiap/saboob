/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import assets.Selectable;
	import com.asinmotion.easing.Elastic;
	import com.asinmotion.easing.*;
	import com.asinmotion.effects.Parallel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import stucture.Modes;

	public class Dude extends Sprite{
		private var _layers:Array;
		private var _time:Timer;
		
		private var _data:Object;
		
		private var _mode:String;
		private var _twns:Array;
		
		private var _viewAnim:Parallel;
		private var _editAnim:Parallel;
		
		//public var mcHat, mcHair, mcMouth, mcTatoo, mcBeard, mcEyes, mcHand:MovieClip;
		
		function Dude() {
			_layers = [mcHat, mcHair, mcMouth, mcTatoo, mcBeard, mcEyes];
			resetPicture();
			
			_data = new Object();
			_data.mcHat = mcHat.currentFrame;
			_data.mcHair = mcHair.currentFrame;
			_data.mcMouth = mcMouth.currentFrame;
			_data.mcTatoo = mcTatoo.currentFrame;
			_data.mcBeard = mcBeard.currentFrame;
			_data.mcEyes = mcEyes.currentFrame;
			
			openMode(Modes.EDIT);
			
		}
		
		function openMode(mode:String) {
			if (mode == Modes.VIEW) {
				scaleX = scaleY = 1.1;
				this.getChildByName("slogenMc").rotation = 0;
				this.getChildByName("slogenMc").alpha = 1;
			} else {
				scaleX = scaleY = 0.9;
				this.getChildByName("slogenMc").rotation = -90;
				this.getChildByName("slogenMc").alpha = 0;
			}
			_mode = mode;
		}
		
		function switchToMode(mode:String) {
			_viewAnim = new Parallel();
			_viewAnim.addEffect({target:this, scaleX:1.1, ease:Elastic.easeOut, time: 1000});
			_viewAnim.addEffect({target:this, scaleY:1.1, ease:Elastic.easeOut, time: 1000});
			_viewAnim.addEffect({target:this.getChildByName("slogenMc"), rotation:0, ease:Bounce.easeOut, time: 1200});
			_viewAnim.addEffect({target:this.getChildByName("slogenMc"), alpha:1, ease:Bounce.easeOut, time: 1200});
			
			_editAnim = new Parallel();
			_editAnim.addEffect({target:this, scaleX:0.9, ease:Bounce.easeOut, time: 1000});
			_editAnim.addEffect({target:this, scaleY:0.9, ease:Bounce.easeOut, time: 1000});
			_editAnim.addEffect({target:this.getChildByName("slogenMc"), rotation:-90, ease:Sine.easeOut, time: 1000});
			_editAnim.addEffect({target:this.getChildByName("slogenMc"), alpha:0, ease:Sine.easeOut, time: 1000});
			if (mode == Modes.VIEW) {
				_editAnim.stop();
				_viewAnim.start();
			} else {
				_viewAnim.stop();
				_editAnim.start();
			}
		}
		
		function changeElement(name:String, val:Number) {
			mcHand.play();
			var ctl:Selectable = getChildByName(name);
			ctl.switchImage(val, _mode == Modes.VIEW);
			_data[name] = val;
		}
		
		public function serialize():String {
			var st:String = "";
			for (var name:String in _data) {
				var ctl:Selectable = getChildByName(name);
				var d:int = _data[name];
				var c:int = ctl.code;
				st += String.fromCharCode(c+64) + String.fromCharCode( d+64 );
			}
			return st;
		}
		
		public function construct(st:String) {
			var names:Object = { 1:"mcMouth", 5:"mcHair", 0:"mcTatoo", 2:"mcHat", 4:"mcBeard", 3:"mcEyes" };
			
			for (var i = 0; i < 6; i++ ) {
				var itemSt:String = st.substring(i * 2, i * 2 + 2);
				
				var itemArr:Array = [itemSt.charCodeAt(0) - 64, itemSt.charCodeAt(1) - 64];
				
				changeElement(names[itemArr[0]], itemArr[1]);
			}
		}
	
		public function resetPicture() {
			for each (var layer:MovieClip in _layers) {
				layer.stop();
			}
		}
		
		public function showDude(evt:Event) {
			dispatchEvent(EventControlChange("showDude"));
		}
	}
	
}
