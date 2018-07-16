/**
* ...
* @author Default
* @version 0.1
*/

package events {
	import flash.events.Event;
	

	public class EventControlChange extends Event{
		static public const CONTROL_CHANGE:String = "controlChange";
		public var name:String;
		public var val:Number;
		
		function EventControlChange(stype:String, nval:Number, sname:String) {
			super(stype);
			this.name = sname;
			this.val = nval;
		}
	}
	
}
