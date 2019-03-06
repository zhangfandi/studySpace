package event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Teacher extends EventDispatcher
	{
		public function Teacher(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function callOver(studentName:String):void{
			
			var e : CallOverEvent = new CallOverEvent(CallOverEvent.CALL_NAME_EVENT);
			e.name = studentName;
			
			dispatchEvent(e);
		}
	}
}