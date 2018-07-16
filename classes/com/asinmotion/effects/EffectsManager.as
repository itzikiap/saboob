package com.asinmotion.effects{
	import com.asinmotion.easing.*;
	
	public class EffectsManager{
		private const startProp:RegExp = /start_.*/;
		public function EffectsManager():void{
			
		}
		public function doEffect(o:Object):void{
			var efkt:Effect = new Effect(o);
			efkt.run();
		}
	}
}