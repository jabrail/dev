package silin.starling.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.utils.VertexData;
	
	/**
	 * шейп из массива точек
	 * только для непересекаюегося периметра
	 * @author silin
	 */
	public class BitmapShape extends TextureObject
	{
		
		private var _points:Vector.<Point> = new Vector.<Point>();
		
		public function BitmapShape(bitmapData:BitmapData=null)
		{
			super(bitmapData);
		}
		
		override protected function createVertexData():void
		{
			
			if (_points.length < 3)
			{
				mVertexData = new VertexData(1);
				mIndexData = Vector.<uint>([0, 0, 0]);
				
			}
			else
			{
				
				mIndexData = triangulate(_points);
				mVertexData = new VertexData(_points.length);
				
				for (var i:int = 0; i < _points.length; i++)
				{
					mVertexData.setPosition(i, _points[i].x, _points[i].y);
					mVertexData.setTexCoords(i, _points[i].x / bmdWidth, _points[i].y / bmdHeight);
				}
			}
		
		}
		
		private function triangulate(points:Vector.<Point>):Vector.<uint>
		{
			var res:Vector.<uint> = new Vector.<uint>();
			var i:int;
			var j:int;
			
			// indicies
			var indices:Array = [];
			for (i = 0; i < points.length; i++)
			{
				indices.push(i);
			}
			
			// winding
			var angle1:Number = 0;
			var angle2:Number = 0;
			for (j = 0; j < points.length; j++)
			{
				var dp1:Point = points[(j + 1) % points.length].subtract(points[(j + 0) % points.length]);
				var dp2:Point = points[(j + 1) % points.length].subtract(points[(j + 2) % points.length]);
				
				var a1:Number = Math.atan2(dp1.y, dp1.x);
				var a2:Number = Math.atan2(dp2.y, dp2.x);
				
				var da1:Number = a1 - a2;
				var da2:Number = a2 - a1;
				
				if (da1 < 0)
					da1 += Math.PI * 2;
				if (da2 < 0)
					da2 += Math.PI * 2;
				
				angle1 += da1;
				angle2 += da2;
				
			}
			var winding:Boolean = angle2 - angle1 > 0;
			
			i = 0;
			var prevLength:int = indices.length;
			while (indices.length > 2)
			{
				// детекция заклицивания: не изменилась длина на круг 
				if (i > 0 && i % indices.length == 0)
				{
					if (prevLength == indices.length)
					{
						break;
					}
					prevLength = indices.length;
				}
				
				var i0:int = indices[i % indices.length];
				var i1:int = indices[(i + 1) % indices.length];
				var i2:int = indices[(i + 2) % indices.length];
				// выпуклость вершины
				var legal:Boolean = convexVertex(points[i0], points[i1], points[i2], winding);
				// нет ли внутри других вершин
				if (legal)
				{
					for (j = i + 3; j < i + indices.length; j++)
					{
						var it:int = indices[j % indices.length];
						if (innerPoint(points[i0], points[i1], points[i2], points[it], winding))
						{
							legal = false;
							break;
						}
					}
				}
				
				if (legal)
				{
					// забираем треугольник
					res.push(i0, i1, i2);
					// выкидываем ухо
					indices.splice((i + 1) % indices.length, 1);
				}
				else
				{
					// смотрим следующую
					i++;
				}
				
			}
			
			return res;
		}
		
		private function convexVertex(p0:Point, p1:Point, p2:Point, winding:Boolean = true):Boolean
		{
			var dp1:Point = p0.subtract(p1);
			var dp2:Point = p0.subtract(p2);
			return winding ? dp1.x * dp2.y - dp1.y * dp2.x >= 0 : dp1.x * dp2.y - dp1.y * dp2.x < 0;
		}
		
		private function innerPoint(p0:Point, p1:Point, p2:Point, t:Point, winding:Boolean):Boolean
		{
			var f0:Number = t.x * (p1.y - p0.y) + t.y * (p0.x - p1.x) + p0.y * p1.x - p0.x * p1.y;
			var f1:Number = t.x * (p2.y - p1.y) + t.y * (p1.x - p2.x) + p1.y * p2.x - p1.x * p2.y;
			var f2:Number = t.x * (p0.y - p2.y) + t.y * (p2.x - p0.x) + p2.y * p0.x - p2.x * p0.y;
			return winding ? f0 < 0 && f1 < 0 && f2 < 0 : f0 > 0 && f1 > 0 && f2 > 0;
		}
		
		public function get points():Vector.<Point>
		{
			return _points;
		}
		
		public function set points(value:Vector.<Point>):void
		{
			if (_points != value)
			{
				_points = value;
				update();
			}
		}
		
		
	}

}