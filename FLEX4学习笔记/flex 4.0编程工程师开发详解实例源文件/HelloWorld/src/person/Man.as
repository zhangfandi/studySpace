package person
{
	public class Man extends Person implements Husband
	{
		public function Man()
		{
			super();
		}
		
		override public function get gender():String{
			return '男';
		}
		
		override public function set gender(value:String):void{
			super.gender = '男';
		}
		
		public function drink(wine:String):void{
			trace ( wine + '好喝');
		}
		
		public function sayLoveToWife(name: String):void{
			trace ('i love you' + name);
		}
	}
}