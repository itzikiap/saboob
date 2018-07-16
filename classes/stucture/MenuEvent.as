
package stucture {

	import flash.events.Event;
	

	public class MenuEvent extends Event {
		static public var MENU_EVENT:String = "menu_event";
		
		private var _val:int;
		
		public function MenuEvent(val:int) {
			super(MENU_EVENT);
			_val = val;
		}
		
		public function get value():int {
			return _val;
		}
	}
	
}
