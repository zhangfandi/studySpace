package event
{
	public class Student
	{
		
		private var _name:String;
		
		public function Student()
		{
		}
		
		public function callOverEventHandler(e:CallOverEvent):void{
			if(e.name == this.name){
				trace(this.name + ' 到');
			}
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