package demo.game.event
{
	import flash.events.Event;
	
	import mx.controls.Image;
	
	public class MatchingEvent extends Event {
		public static const PIC_MATCHING_FOUND:String = 'matchingFound';
		
		private var _matchImages : Array;
		
		public function MatchingEvent(type:String, images:Array) {
			super(type, false, false);
			_matchImages = images;
		}
		
		public function get matchImages():Array{
			return _matchImages;
		}
	}
}