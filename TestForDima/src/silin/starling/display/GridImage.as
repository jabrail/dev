package silin.starling.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.utils.VertexData;
    
    
    
    
	/**
	 * DisplayObject из bitmapData с сеткой искажения размерностью divX-divY клеток
	 * @author silin
	 */
    public class GridImage extends TextureObject
    { 
        
		protected var divX:int
		protected var divY:int
		
		
        public function GridImage(bitmapData:BitmapData, divX:int = 28, divY:int = 28)
        {
			this.divX = divX;
			this.divY = divY;
			super(bitmapData);
			
        }
		
		
		override protected function createVertexData():void
        {
			
			mVertexData = new VertexData((divX + 1) * (divY + 1));
			mIndexData = new <uint>[];
			
		
			for (var i:int = 0,  pos:int = 0; i <= divY; i++) //Y
			{
				
				for (var j:int = 0; j <= divX; j++) //X
				{
					var u:Number = j / divX;
					var v:Number = i / divY;
					var tX:Number = u * bmdWidth;
					var tY:Number = v * bmdHeight;
					
					mVertexData.setPosition(pos, tX, tY);
					mVertexData.setTexCoords(pos, u, v);
					
					if (i < divY && j < divX)
					{
						mIndexData.push(pos, pos + 1, pos + divX + 2, pos, pos + divX + 1, pos + divX + 2);
					}
					pos++;
				}
				
			}
			
        }
		
		public function resetGrid():void
		{
			
			for (var i:int = 0, k:int = 0; i <= divY; i++) //Y
			{
				
				for (var j:int = 0; j <= divX; j++) //X
				{
					var u:Number = j / divX;
					var v:Number = i / divY;
					var tX:Number = u * bmdWidth;
					var tY:Number = v * bmdHeight;
					
					mVertexData.setPosition(k++, tX, tY);
					
				}
				
			}
			mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, mVertexData.numVertices);
		}
		
		public function zoomGrid(p0:Point, radius:Number, force:Number = 0.25):void
		{
			var w:Number = width;
			var h:Number = height;
			
			for (var i:int = 1; i < divY; i++)//Y
			{
				for (var j:int = 1; j < divX; j++)//X
				{
					var k:int = i * (divX + 1) + j;
				
					var node:Point = new Point(j / divX * bmdWidth, i / divY * bmdHeight);
					
					var dirP:Point = node.subtract(p0);
					var dir:Number = Math.atan2(dirP.y, dirP.x);
					var dist:Number = Point.distance(node, p0);
					var t:Number = Math.min(dist / radius, 1);
					
					
					t = 1 - t * t * t;
					//t = 1 - Math.sin(0.5 * Math.PI * t);
					//t = Math.cos(0.5 * Math.PI * t);
					
					
					var d:Number = radius * force * t;
					
					node.x += Math.cos(dir) * d;
					node.y += Math.sin(dir) * d;
					node.x = Math.min(Math.max(0, node.x), bmdWidth);
					node.y = Math.min(Math.max(0, node.y), bmdHeight);
					mVertexData.setPosition(k, node.x, node.y);
					
				}
			}
			
			mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, mVertexData.numVertices);
		}
		
		public function shiftGrid(p0:Point, p1:Point, pow:int=2):void
		{
			var w:Number = width;
			var h:Number = height;
			
			
			for (var i:int = 1; i < divY; i++)//Y
			{
				for (var j:int = 1; j < divX; j++)//X
				{
					var k:int = i * (divX + 1) + j;
				
					var node:Point = new Point();
					mVertexData.getPosition(k, node);
					
					var fX:Number = (p0.x - node.x < 0) ? ((w - node.x) / (w - p0.x)) : (node.x / p0.x);
					var fY:Number = (p0.y - node.y < 0) ? ((h - node.y) / (h - p0.y)) : (node.y / p0.y);
					var f:Number = fX * fY;
					while (pow-->1) f *= f;
					
					
					node.x += (p1.x - p0.x) * f;
					node.y += (p1.y - p0.y) * f;
				
					mVertexData.setPosition(k, node.x, node.y);
					
				}
			}
			
			mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, mVertexData.numVertices);
		}
      
    }
	
}