package silin.starling.display
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.errors.AbstractMethodError;
	import starling.errors.MissingContextError;
	import starling.events.Event;
	import starling.utils.getNextPowerOfTwo;
	import starling.utils.VertexData;
    
    
    
    
	/**
	 * DisplayObject из bitmapData с сеткой искажения размерностью divX-divY клеток
	 * @author silin
	 */
    public class TextureObject extends DisplayObject
    {
        private static var PROGRAM_NAME:String = "TextureObject";
        
        // vertex data 
        protected var mVertexData:VertexData;
        protected var mVertexBuffer:VertexBuffer3D;
        
        // index data
        protected var mIndexData:Vector.<uint>;
        protected var mIndexBuffer:IndexBuffer3D;
        
        // helper objects (to avoid temporary objects)
        private static var sHelperMatrix:Matrix = new Matrix();
		private static var sRenderAlpha:Vector.<Number> = new <Number>[1.0, 1.0, 1.0, 1.0];
		
		protected var mTexture:Texture;
		protected var bmdWidth:int;
		protected var bmdHeight:int;
		
		
		
        public function TextureObject(bitmapData:BitmapData = null)
        {
			if (!bitmapData)
			{
				var d:int = 8;
				bitmapData = new BitmapData(2 * d, 2 * d, false, 0xE0E0E0);
				bitmapData.fillRect(new Rectangle(0, 0, d, d), 0xD0D0D0);
				bitmapData.fillRect(new Rectangle(d, d, d, d), 0xD0D0D0 );
			}
			
			setBitmapData(bitmapData);
			createVertexData();
            createBuffers();
            registerPrograms();
           
		
            // handle lost context
            Starling.current.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
        }
		
		
		public function setBitmapData(bitmapData:BitmapData):void
		{
			bmdWidth = bitmapData.width;
			bmdHeight = bitmapData.height;
			
			
			var legalW:int = getNextPowerOfTwo(bmdWidth);
			var legalH:int = getNextPowerOfTwo(bmdHeight);
			
			
		
			if (mTexture)
			{
				mTexture.dispose();
			}
			mTexture = Starling.context.createTexture(legalW, legalH, Context3DTextureFormat.BGRA, false);
			
			var sX:Number = legalW / bmdWidth;
			var sY:Number = legalH / bmdHeight;
			
			var legalBitmapData:BitmapData = new BitmapData(legalW, legalH, true, 0x0);
			legalBitmapData.draw(bitmapData, new Matrix(sX, 0, 0, sY), null, null, null, true);
			mTexture.uploadFromBitmapData(legalBitmapData);
			
			legalBitmapData.dispose();
		}
		
		public function update():void
		{
			createVertexData();
			createBuffers();
		
		}
		
		protected function createVertexData():void
        {
			
			throw new AbstractMethodError("Method needs to be implemented in subclass");
			
        }
		
		
        /** Disposes all resources of the display object. */
        public override function dispose():void
        {
            Starling.current.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
            if (mTexture) mTexture.dispose();
            if (mVertexBuffer) mVertexBuffer.dispose();
            if (mIndexBuffer)  mIndexBuffer.dispose();
            
            super.dispose();
        }
        
        private function onContextCreated(event:Event):void
        {
            // the old context was lost, so we create new buffers and shaders.
            createBuffers();
            registerPrograms();
        }
        
        /** Returns a rectangle that completely encloses the object as it appears in another 
         * coordinate system. */
        public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
        {
            if (resultRect == null) resultRect = new Rectangle();
            
            var transformationMatrix:Matrix = targetSpace == this ? 
                null : getTransformationMatrix(targetSpace, sHelperMatrix);
            
            return mVertexData.getBounds(transformationMatrix, 0, -1, resultRect);
        }
        
		
        /** Creates new vertex- and index-buffers and uploads our vertex- and index-data to those
         *  buffers. */ 
        protected function createBuffers():void
        {
            var context:Context3D = Starling.context;
            if (context == null) throw new MissingContextError();
            
            if (mVertexBuffer) mVertexBuffer.dispose();
            if (mIndexBuffer)  mIndexBuffer.dispose();
            
            mVertexBuffer = context.createVertexBuffer(mVertexData.numVertices, VertexData.ELEMENTS_PER_VERTEX);
            mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, mVertexData.numVertices);
            
            mIndexBuffer = context.createIndexBuffer(mIndexData.length);
            mIndexBuffer.uploadFromVector(mIndexData, 0, mIndexData.length);
        }
        
        /** Renders the object with the help of a 'support' object and with the accumulated alpha
         * of its parent object. */
        public override function render(support:RenderSupport, alpha:Number):void
        {
            // always call this method when you write custom rendering code!
            // it causes all previously batched quads/images to render.
            support.finishQuadBatch();
			
            
			
            sRenderAlpha[0] = sRenderAlpha[1] = sRenderAlpha[2] = 1.0;
            sRenderAlpha[3] = alpha * this.alpha;
            
            var context:Context3D = Starling.context;
            if (context == null) throw new MissingContextError();
            
            // apply the current blendmode
            support.applyBlendMode(false);
            
            // activate program (shader) and set the required buffers / constants 
            context.setProgram(Starling.current.getProgram(PROGRAM_NAME));
			
            context.setVertexBufferAt(0, mVertexBuffer, VertexData.POSITION_OFFSET, Context3DVertexBufferFormat.FLOAT_2); 
			context.setVertexBufferAt(1, mVertexBuffer, VertexData.TEXCOORD_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
			
            context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, support.mvpMatrix3D, true);            
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, sRenderAlpha, 1);
			
			context.setTextureAt(0, mTexture);
			
            context.drawTriangles(mIndexBuffer, 0, mIndexData.length / 3);
            
            // reset buffers
            context.setVertexBufferAt(0, null);
            context.setVertexBufferAt(1, null);
			context.setTextureAt(0, null);
        }
        
        /** Creates vertex and fragment programs from assembly. */
        private static function registerPrograms():void
        {
            var target:Starling = Starling.current;
            if (target.hasProgram(PROGRAM_NAME)) return; // already registered
				
				
			var vertexProgramCode:String =
                "m44 op, va0, vc0 \n" + // 4x4 matrix transform to output space
				"mov v0, va1 \n"+		// UV координаты
				"mov v1, vc4 \n";		// alpha
				
            var fragmentProgramCode:String =
				"tex ft0, v0, fs0 <2d,linear,repeat>\n"+// текстура
				"mul oc ft0, v1 \n";			// alpha
			
            var vertexProgramAssembler:AGALMiniAssembler = new AGALMiniAssembler();
            vertexProgramAssembler.assemble(Context3DProgramType.VERTEX, vertexProgramCode);
            
            var fragmentProgramAssembler:AGALMiniAssembler = new AGALMiniAssembler();
            fragmentProgramAssembler.assemble(Context3DProgramType.FRAGMENT, fragmentProgramCode);
            
            target.registerProgram(PROGRAM_NAME, vertexProgramAssembler.agalcode, fragmentProgramAssembler.agalcode);
        }
        
		
      
    }
	
}