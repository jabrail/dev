package silin.starling.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.utils.VertexData;
	
	/**
	 * линия по массиву точек 
	 * @author silin
	 */
	public class BitmapLine extends TextureObject 
	{
		
		
		private var _points:Vector.<Point> = new Vector.<Point>();
		private var _thickness:Number = 2;
		private var _repeat:Boolean = true;
		
		
		public function BitmapLine(bitmapData:BitmapData=null)
		{
			super(bitmapData);
		}
		
		override protected function createVertexData():void
		{
			
			if (_points.length < 2)
			{
				mVertexData = new VertexData(1);
				mIndexData = Vector.<uint>([0, 0, 0]);
				
			}else
			{
				
				var len:int = _points.length;
				
				mVertexData = new VertexData(2 * len);
				mIndexData = new Vector.<uint>();
				var pathLen:Number = 0;
				var kLen:Number = bmdHeight / bmdWidth / _thickness;
				for (var i:int = 0; i < len; i++)
				{
					var pA:Point = _points[i];
					var pB:Point = i ? _points[i - 1] : _points[i + 1];
					var dirP:Point = pA.subtract(pB);
					var norm:Number = Math.atan2(dirP.y, dirP.x) + (i ? 0.5 * Math.PI : -0.5 * Math.PI);
					var d:Number = 0.5 * _thickness;
					var normP:Point = new Point(d * Math.cos(norm), d * Math.sin(norm));
					var p1:Point = pA.add(normP);
					var p2:Point = pA.subtract(normP);
					
					var k:int = 2 * i;
					var u:Number = _repeat ? pathLen * kLen : i / (len - 1);
					mVertexData.setPosition(k, p1.x, p1.y);
					mVertexData.setTexCoords(k, u, 0);
					mVertexData.setPosition(k + 1, p2.x, p2.y);
					mVertexData.setTexCoords(k + 1, u, 1);
					
					if (i < len - 1)
					{
						mIndexData.push(k, k + 1, k + 2, k + 3, k + 2, k + 1);
						pathLen += Point.distance(_points[i], points[ i + 1]);
					}
					
				}
			}
		
		}
		
		
		public function get lastPoint():Point
		{
			return _points.length ? _points[_points.length - 1] : null;
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
		
		public function get thickness():Number
		{
			return _thickness;
		}
		
		public function set thickness(value:Number):void
		{
			if (_thickness != value)
			{
				_thickness = value;
				update();
			}
		}
		
		public function get repeat():Boolean 
		{
			return _repeat;
		}
		
		public function set repeat(value:Boolean):void 
		{
			if (_repeat != value)
			{
				_repeat = value;
				update();
			}
		}
		
		
		
	}

}