package events {
	import flash.events.Event;
	
	/**
	* ...
	* @author I.A.P Itzik Arzoni
	*/
	public class EventSendEmail extends Event{
			public static var SEND:String = "send";
			public static var CLOSE:String = "close";
			
			private var _email:String;
		
		public function EventSendEmail(stype:String, mail:String ) {
			super(stype);
			_email = mail;
			
		}
		public function get email():String { return _email; }
		
	}
	
}
