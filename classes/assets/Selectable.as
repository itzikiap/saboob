/**
* ...
* @author Default
* @version 0.1
*/

package assets {
	import fl.motion.easing.Elastic;
	import fl.motion.Tweenables;
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Selectable extends MovieClip{
		
		private var _alpha:Number;
		private var _twn:Tween;
		private var _time:Timer;
		
		public var _code:String;
		
		public function Selectable() {
			
		}
		
		public function createButton() {
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, true);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseOut, true);
//			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_twn = new Tween(this, "x", null, 0,0,0);
			_twn.stop();
			
			_time = new Timer(500, 1);
			_time.stop();
			_time.addEventListener(TimerEvent.TIMER_COMPLETE, openSelected);
			
		}
		
		function mouseOver(evt:MouseEvent) {
			if (isNaN(_alpha)) {
				_alpha = 0.8;
			}
			_time.start();
			//openSelected();
		}
		
		function mouseOut(evt:MouseEvent) {
			_twn.stop();
			_twn = new Tween(this, "alpha", Regular.easeOut, alpha, _alpha, 13);
			_time.stop();
		}
		
		private function openSelected(evt:TimerEvent) {
			dispatchEvent(new Event("imageSelected"));
			_twn.stop();
			_twn = new Tween(this, "alpha", Regular.easeOut, alpha, 1, 23);

		}
		
		public function switchImage(num:Number, direct:Boolean = false ) {
			this.gotoAndStop(num);
			if (!direct) {
				var twn:Tween = new Tween(this, "scaleX", Elastic.easeOut,  0.5, 1, 32);
				var twn2:Tween = new Tween(this, "scaleY", Elastic.easeOut,  0.5, 1, 32);
				var twn3:Tween = new Tween(this, "alpha", Regular.easeOut, 0, 1, 13);
			} else {
				alpha = 1;
			}
		}
		
		public function get code():String { return _code; }
		
		
	}
	
}
