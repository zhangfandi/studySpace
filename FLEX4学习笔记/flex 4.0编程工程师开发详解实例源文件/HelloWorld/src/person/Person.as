package person
{
	public class Person
	{
		private var _age : int;
		public var name : String;
		var _gender : String  =  '男';
		
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
	}
}