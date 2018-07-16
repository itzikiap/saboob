/**
* ...
* @author Default
* @version 0.1
*/

package {
	import assets.Selectable;
	import com.asinmotion.easing.Sine;
	import com.asinmotion.effects.Parallel;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ImageSlide extends MovieClip {
		private var _image:Selectable;
		private var _circle:Sprite;
		private var _num:Number;
		
		private var _hideAnim:Parallel;
		
		private var _atween:Tween;
		private var _ptween:Tween;
		private var _delay:Number;
		private var _time:Timer;
		
		public function ImageSlide () {
		}
		
		public function createImage (type:Selectable, frame:Number) {
			var circle:Sprite = new Selectable();
			circle.graphics.lineStyle (1,0,1);
			circle.graphics.beginFill (0xffffff,1);
			circle.graphics.drawCircle (0,0,30);
			_image = type;
			_image.gotoAndStop (frame);
			circle.alpha = 0;
			_image.width = _image.height= 50;
			circle.createButton ();

			circle.buttonMode = true;
			circle.addEventListener (MouseEvent.ROLL_OVER, imageSelected);
			_circle = circle;
			circle.addChild (_image);
			this.addChild (circle);
			_image.rotation = -this.rotation;

			_atween = new Tween(_circle, "alpha", Regular.easeOut, 0, 0.8, 25);
			_atween.stop ();
			_ptween = new Tween(_circle, "x", Elastic.easeInOut, 120, 220, 35);
			_ptween.stop ();
			_circle.visible = false;

			_num = frame;
			
			_time = new Timer(500, 1);
			_time.stop();
			_time.addEventListener(TimerEvent.TIMER, openSelected);
		}
		
		private function imageSelected (evt:MouseEvent) {
			if(evt.currentTarget == _circle) {
				_time.start();
			}
		}
		
		private function openSelected(evt:TimerEvent) {
			dispatchEvent (new Event("imageSelected"));
		}
		
		public function show (delay:Number) {
			this.addEventListener (Event.ENTER_FRAME, doShowing);
			_delay = delay;
		}
		
		private function doShowing (evt:Event) {
			if (_hideAnim != null) {
				_hideAnim.stop();
			}
			if (_delay == 0) {
				_circle.visible = true;
				_atween.start ();
				_ptween.start ();
				this.removeEventListener (Event.ENTER_FRAME, doShowing);
			}
			_delay--;
		}
		
		public function hide () {
			this.removeEventListener (Event.ENTER_FRAME, doShowing);
			_delay = 0;
			//_circle.visible = false;
			_atween.stop ();
			_ptween.stop ();
			_hideAnim = new Parallel();
			_hideAnim.addEffect( { target:_circle, alpha:0, ease:Sine.easeOut, time: 400 } );
			_hideAnim.addEffect( { target:_circle, x:300, ease:Sine.easeOut, time: 400 } );
			_hideAnim.addEventListener("complete", hideCircle);
			_hideAnim.start();
		}
		
		private function hideCircle(evt:Event) {
			_circle.visible = false;
		}
		
		public function get num ():Number {
			return _num;
		}
	}
}
