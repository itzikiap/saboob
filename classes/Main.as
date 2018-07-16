/**
* This class is deprecated for now...
* @author Default
* @version 0.1
*/

package  {
import flash.display.MovieClip;
import org.flashdevelop.utils.FlashConnect;

	public class Main extends MovieClip{
		[Embed (source="../all_stuff.swf")]
		private var GfClass:Class;
			
		function Main() {
			FlashConnect.trace("this is a test");
			this.graphics.lineStyle(10);
			this.graphics.drawRect(0,0,100,100);

			var gf:MovieClip = new GfClass();
			this.addChild(gf);
		}
		
		static public function main():void {
			var mn:Main = new Main();
		}
	}
}
