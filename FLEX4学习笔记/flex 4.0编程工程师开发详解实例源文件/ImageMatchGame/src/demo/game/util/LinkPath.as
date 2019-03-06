package demo.game.util
{
	
	import flash.geom.Point;
	
	public class LinkPath
	{
		private var _pathVector : Array;
		private var _width : int;
		private var _height: int;
		
		/**
		 * 在向量数组中查找两个节点之间通路的路径
		 * 
		 * @param startPoint:Point 起始节点
		 * @param endPoint:Point 结束节点
		 * @return 包含结果的点的数组，没找找到返回null;
		 */
		public function find(startPoint:Point, endPoint:Point) : Array{
			//能否直连
			if(
				(startPoint.x == endPoint.x && Math.abs(startPoint.y - endPoint.y) == 1) ||
				(startPoint.y == endPoint.y && Math.abs(startPoint.x - endPoint.x) == 1)
			)
				return [startPoint, endPoint];
			
			var line1 : Object, line2 : Object;
			var lines:Array = [];
			
			//使得这两点变为可通过点
			pathVector[startPoint.x][startPoint.y] = pathVector[endPoint.x][endPoint.y] = 0;
			
			//水平查找
			line1 = getNormalLine(startPoint, -1, width);
			line2 = getNormalLine(endPoint, -1, width);
			lines = lines.concat(findLinkLines(line1, line2));
			
			//垂直查找
			line1 = getNormalLine(startPoint, -1, height, false);
			line2 = getNormalLine(endPoint, -1, height, false);
			lines = lines.concat(findLinkLines(line1, line2, false));
			
			//恢复这两点
			pathVector[startPoint.x][startPoint.y] = pathVector[endPoint.x][endPoint.y] = 1;
			
			if(lines.length == 0)
				return lines;
			
			var result:Array, tmpArray:Array;
			var length:int = int.MAX_VALUE, tmp:int;
			for(var i:int = 0, point:Point, line : Object; i < lines.length; i++){
				line = lines[i];
				
				if(
					!((startPoint.x == line.start.x || startPoint.y == line.start.y) && 
						(endPoint.x == line.end.x || endPoint.y == line.end.y))
				){
					point = line.start;
					line.start = line.end;
					line.end = point;
				}
				
				tmpArray = [startPoint, line.start, line.end, endPoint];
				tmp = pathLength(tmpArray);
				
				if(tmp < length){
					length = tmp;
					result = tmpArray;
				}
			}
			
			return result;
		}
		/**
		 * 测试给定点是否为可通过点
		 * @param point:Point 要测试的点;
		 * @return boolean
		 */
		private function canThrough(point:Point):Boolean{
			return(!pathVector[point.x] || !pathVector[point.x][point.y])
		}
		
		/**
		 * 取得经过point点在direction轴向上最长的一条线段
		 * @param point:Point 经过点
		 * @param start:int 沿轴向的开始坐标值
		 * @param end:int 沿轴向的结束坐标值
		 * @param transverse:Boolean 轴向, true:横周，false:纵轴
		 */
		private function getNormalLine(point:Point, start:int, end:int, transverse:Boolean = true):Object{
			var startPoint : Point = new Point();
			var endPoint : Point = new Point();
			var tmp : Point = new Point();
			var axisX:String = 'x', axisY:String = 'y';
			
			if(!transverse){//横向还是纵向
				axisX = 'y';
				axisY = 'x';
			}
			var ambit:int = point[axisX];
			
			tmp[axisY] = point[axisY];
			for(var i:int = start; i <= end; i++){
				tmp[axisX] = i;
				if(i == ambit || canThrough(tmp))
					continue;
				else if(i < ambit)
					start = i + 1;
				else if(i > ambit)
					end = i - 1;
			}
			
			startPoint[axisY] = endPoint[axisY] = point[axisY];
			startPoint[axisX] = start;
			endPoint[axisX] = end;
			
			return {start:startPoint, end:endPoint};
		}
		
		/**
		 * 查找两条线之间是否存在连通线
		 * @return Array 所有可以连通的线段
		 */
		private function findLinkLines(line1:Object, line2:Object, transverse:Boolean = true):Array{
			var s1:int, s2:int, e1:int, e2:int, s:int, e:int;
			var axisX:String = 'x', axisY:String = 'y';
			var point:Point = new Point();
			var lines:Array = [];
			var tmp : Object;
			
			if(!transverse){//横向还是纵向
				axisX = 'y';
				axisY = 'x';
			}
			
			if(line1.start[axisX] > line2.start[axisX]){//按照线段开始点再在线段方向上排序
				tmp = line1;
				line1 = line2;
				line2 = tmp;
			}
			
			s1 = line1.start[axisX];//两条线段的起止端点
			e1 = line1.end[axisX];
			s2 = line2.start[axisX];
			e2 = line2.end[axisX];
			
			s = line1.start[axisY];//连线的起止端点
			e = line2.start[axisY];
			
			if(s > e){
				s = s + e;
				e = s - e;
				s = s - e;
			}
			
			if(s2 <= e1){//找两条线段轴向投影的交集
				var end : int = e1 < e2 ? e1 : e2;//交集的截止点
				
				point[axisY] = s;
				//查找连接线
				for(var i:int = s2; i <= end; i++){
					point[axisX] = i;
					tmp = getNormalLine(point, s, e, !transverse);
					if(tmp.end[axisY] == e)
						lines.push(tmp);
				}
			}
			
			return lines;
		}
		
		private function pathLength(path:Array):int{
			var length:int = 0;
			for(var i:int = 1, point:Point = path[0]; i < path.length; i++){
				if(point.x == path[i].x)
					length += Math.abs(point.y -  path[i].y);
				else
					length += Math.abs(point.x -  path[i].x);
				point = path[i];
			}
			return length;
		}
		
		public function get pathVector():Array{
			return _pathVector;
		}
		
		public function set pathVector(value:Array):void{
			_pathVector = value;
			_width = value.length;
			_height = value[0].length;
		}
		
		public function get width():int{
			return _width;
		}
		
		public function get height():int{
			return _height;
		}
	}
}