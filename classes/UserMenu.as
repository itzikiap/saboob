
package  {
	import com.asinmotion.easing.Elastic;
	import com.asinmotion.easing.Expo;
	import com.asinmotion.effects.Parallel;
	import fl.motion.easing.Exponential;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import stucture.MenuEvent;
	
	public class UserMenu extends MovieClip{
		private var _buttons:Array;
		private var _shown:Boolean
		private var _anim:Parallel;
		
		private var _savedX:Number;
		
		public function UserMenu() {
			var names:Array = ["-----", "ספא", "חלש", "ספדה"];
			
			for (var i:int = 0; i < names.length; i++) {
				var btn:MovieClip = this.getChildByName("btn" + i);
				btn.titleTxt.text = names[i];
				btn.addEventListener(MouseEvent.CLICK, buttonSelected);
				btn.useHandCursor = true;
				btn.buttonMode = true;
			}
			

			x=810
			//this.visible = false;
		}
		
		function showMenu() {
			//this.visible = true;
			
			_anim = new Parallel();
			_anim.addEffect( { target:this, x:680, ease:Elastic.easeOut, time: 1500 } );
			//_anim.addEffect( { target:this, alpha:1, ease:Elastic.easeOut, time: 1000 } );
			_anim.start();
		}
		
		function hideMenu() {
			_anim = new Parallel();
			_anim.addEffect( { target:this, x:850, ease:Expo.easeOut, time: 1500 } );
			//_anim.addEffect( { target:this, alpha:1, ease:Elastic.easeOut, time: 1000 } );
			_anim.addEventListener(TweenEvent.MOTION_STOP, motionStopped);
			_anim.start();
		}
		
		function motionStopped(evt:TweenEvent) {
			this.visible = false;
		}
		
		function buttonSelected(evt:MouseEvent) {
			var num:int = evt.currentTarget.name.substr( -1, 1);
			dispatchEvent(new MenuEvent(num));
		}
	}
	
}
