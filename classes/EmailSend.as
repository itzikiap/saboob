package  {
	import com.asinmotion.easing.Bounce;
	import com.asinmotion.easing.Quad;
	import com.asinmotion.easing.Sine;
	import com.asinmotion.effects.Parallel;
	import events.EventSendEmail;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	* ...
	* @author I.A.P Itzik Arzoni
	*/
	public class EmailSend extends Sprite{
		
		private var saveX:Number;
		
		public function EmailSend() {
			var names:Array = ["חלש", "רוגס"];
			
			for (var i:int = 0; i < names.length; i++) {
				var btn:MovieClip = this.getChildByName("btn" + i);
				btn.titleTxt.text = names[i];
				btn.useHandCursor = true;
				btn.buttonMode = true;
				btn.addEventListener(MouseEvent.CLICK, buttonSelected);
			}
			
			saveX = this.x;
			
			this.visible = false;
			this.x = 810;
		}
		
		function showMenu() {
			this.visible = true;
			
			_anim = new Parallel();
			_anim.addEffect( { target:this, x:saveX, ease:Bounce.easeOut, time: 800 } );
			_anim.start();
		}
		
		function hideMenu() {
			_anim = new Parallel();
			_anim.addEffect( { target:this, x:810, ease:Sine.easeOut, time: 400 } );
			//_anim.addEventListener(TweenEvent.MOTION_STOP, motionStopped);
			_anim.start();
		}
		
		
		private function buttonSelected(evt:MouseEvent) {
			var num:int = evt.currentTarget.name.substr( -1, 1);

			switch (num) {
				case 0:
					dispatchEvent(new EventSendEmail(EventSendEmail.SEND, this.mail_txt.text));
					break;
				case 1:
					dispatchEvent(new EventSendEmail(EventSendEmail.CLOSE, ""));
					break;
			}
		}
		
	}
	
}
