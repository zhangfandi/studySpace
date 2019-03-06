package
{
	import flash.events.Event;
	
	public class MydataChangeEvent extends Event
	{
		
		public function MydataChangeEvent()
		{
			super('myDataChangeEvent', false, false);
		}
	}
}