/**
* ...
* @author Default
* @version 0.1
*/

package  {
import assets.Selectable;
import events.EventControlChange;
import fl.data.SimpleCollectionItem;
import fl.motion.MotionEvent;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import org.flashdevelop.utils.FlashConnect;


	public class Controls extends Sprite{
		private var _images:ImageRotator;
		private var _selected:Selectable;
		private var _select:MovieClip;
		
		function Controls(){
			var type:String = this.name.substring(2,this.name.indexOf("Control"));
			_select = this.btnSelect;
			_select.alpha -= 0.1;
			_select.stop();
			_select.buttonMode = true;
			_select.addEventListener(MouseEvent.ROLL_OVER, showSelection);
			_images = new ImageRotator(type);
			_images.addEventListener(EventControlChange.CONTROL_CHANGE, buttonSelected);
			this.parent.parent.OptionsHolder.addChild(_images);
			_selected = new ImageRotator.TYPES[type];
			var holder:Sprite  = new Sprite()
			this.addChild(holder);
			holder.addChild(_selected);
			_selected.gotoAndStop(3);
			_selected.parent.width = _selected.parent.height = 60;
		}
		
		private function showSelection(evt:MouseEvent):void {
			dispatchEvent(new Event("panelOpened"));
			_selected.parent.width = _selected.parent.height = 90;
			_images.show();
			_select.buttonMode = false;
		}

		public function hideSelection():void {
			_select.buttonMode = true;
			_select.gotoAndStop("_up");
			//trace("hide selection: "+this);
			_selected.visible = true;
			_selected.parent.width = _selected.parent.height = 60;
			_images.hide();
		}
		
		private function buttonSelected(evt:EventControlChange):void {
			var val:Number = evt.val;
			//trace("button click: "+val);
			dispatchEvent(new EventControlChange(EventControlChange.CONTROL_CHANGE, val, this.name));
		}
	}
	
}
