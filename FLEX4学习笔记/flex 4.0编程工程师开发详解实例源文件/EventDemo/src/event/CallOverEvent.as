package event
{
	import flash.events.Event;
	
	public class CallOverEvent extends Event
	{
		public static const CALL_NAME_EVENT : String = 'CallOverEvent_CallName';
		
		private var _name:String;
		
		public function CallOverEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}