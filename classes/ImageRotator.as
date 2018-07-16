/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import assets.*;
	import events.EventControlChange;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ImageRotator extends MovieClip{
		private var images:Array;
		private var _selectedImage:Number;
		private var _type:String;
		
		static public const TYPES:Object = {Hair:Hair, Hat:Hat, Eyes:Eyes, Tatoo:Tatoo, Mouth:Mouth, Beard:Beard};
		
		public function ImageRotator(type:String) {
			_type = type;
			var imageType:Class = TYPES[type];
			var test:MovieClip = new imageType();
			var num:Number = test.totalFrames;
			var angle:Number = 17;
			var spacing:Number = num * angle / 2;
			images = new Array();
			for (var i:Number = 0; i < num; i++) {
				var hair:MovieClip = new imageType();
				var image:ImageSlide = new ImageSlide();
				this.addChild(image);
				//image.x = -i * spacing - 150;
				image.rotation = i * angle - spacing;
				image.createImage(hair, i+1);
				image.addEventListener("imageSelected", imageSelected);
				images.push(image);
			}
			//this.mouseChildren = false;
		}
		
		public function imageSelected(evt:Event) {
			var target:ImageSlide = evt.target;
			_selectedImage = target.num;
			dispatchEvent(new EventControlChange(EventControlChange.CONTROL_CHANGE, _selectedImage, this.name));
		}
		
		public function show() {
			var index:Number = 0;
			for (var name:String in images) {
				var i:ImageSlide = images[name];
				i.show(index);
				index+= 1;
			}
		}
		
		public function hide() {
			for (var name:String in images) {
				var i:ImageSlide = images[name];
				i.hide();
			}
		}
		
		public function get selectedImage():Number {
			return _selectedImage
		}
	}
}
