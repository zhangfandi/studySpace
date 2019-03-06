package 
{
	import flash.events.EventDispatcher;

	[Bindable(event='myDataChangeEvent')]
	public class Person extends EventDispatcher
	{
		private var _age : int;
		private var _name : String;
		private var _gender : String  =  '男';
		
		public function Person()
		{
		}
		
		public function get age():int
		{
			return _age;
		}

		public function set age(value:int):void
		{
			_age = value;
			
		}

		public function set gender(value : String):void{
			_gender = value;
		}
		
		public function get gender():String{
			return _gender;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			dispatchEvent(new MydataChangeEvent());
		}

	}
}