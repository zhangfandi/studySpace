package demo.game.util
{
	import spark.components.SkinnableContainer;

	public class Random {
		
		/**
		* 打乱容器内的组件索引顺序
		* @param container:SkinnableContainer 装有组件的容器
		*/
		public static function randomElements(container:SkinnableContainer):void{
			
			var num : int = container.numElements;
			var array : Array = [];
			var temp:Object;
			
			for(var i : int = 0; i < num; i++){
				temp = container.getElementAt(i);
				if(temp.width != 0)
					array.push(temp);
			}
			
			for(i = 0, num = array.length; i < num; i++){
				container.swapElements(array[i], array[getRandomNum(i, num -1)]);
			}
			
		}
		
		/**
		 * 返回一个介于 start 到 end 之间的整数
		 * @param start:int 起始整数
		 * @param end:int 结束整数
		 */
		public static function getRandomNum(start:int, end:int):int{
			return Math.round(Math.random() * (end - start)) + start;
		}
	}
}