
package  {
	import fl.motion.easing.Linear;
	import fl.motion.Tweenables;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import stucture.Modes;
	public class SwitchModeBtn extends MovieClip{
		
		private var _twn:Tween;
		private var _target:Number;
		private var _mode:String;
		
		public function SwitchModeBtn() {
			stop();
			
			this.addEventListener(MouseEvent.MOUSE_OVER, show);
			this.addEventListener(MouseEvent.MOUSE_OUT, hide);
			this.addEventListener(MouseEvent.CLICK, changeMode);
			_twn = new Tween(this, "alpha", Linear.easeOut, 0.4, 1, 1.4, true)
			_twn.stop();
			alpha = 0.4;
			
			useHandCursor = true;
			buttonMode = true;
			
			_mode = "edit";
			gotoAndStop("view");
		}
		
		function show(evt:MouseEvent) {
			_twn.stop();
			_twn.position = 0.4;
			_twn.continueTo(1, 1.4);
		}
		function hide(evt:MouseEvent) {
			_twn.stop();
			_twn.position = 1;
			_twn.continueTo(0.4, 1.4);
		}
		
		function switchingLoop(evt:Event) {
			if (_target > this.currentFrame) {
				this.nextFrame();
			} else if (_target < this.currentFrame) {
				this.prevFrame();
			} else {
				this.removeEventListener(Event.ENTER_FRAME, switchingLoop);
				if (this.currentFrame == this.totalFrames) {
					this.gotoAndStop(1);
				}
			}
		}
		
		function changeMode(evt:MouseEvent) {
			if (_mode == Modes.VIEW) {
				_target = 26;
				addEventListener(Event.ENTER_FRAME, switchingLoop);
				_mode = Modes.EDIT;
				dispatchEvent(new Event("switchMode"));
			} else {
				_target = this.totalFrames;
				addEventListener(Event.ENTER_FRAME, switchingLoop);
				_mode = Modes.VIEW;
				dispatchEvent(new Event("switchMode"));
			}
			
		}

		public function get mode():String {
			return _mode;
		}
		
		public function set mode(value:String):void {
			if (value == Modes.VIEW) {
				_target = this.totalFrames;
				this.gotoAndStop(this.totalFrames);
			} else {
				_target = 26;
				this.gotoAndStop(26);
			}
			_mode = value;
		}
	}
}
