package silin.starling.display
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.errors.AbstractMethodError;
	import starling.errors.MissingContextError;
	import starling.events.Event;
	import starling.utils.VertexData;
	
	public class ColorObject extends DisplayObject
	{
		
		private static var PROGRAM_NAME:String = "ColorObject";
		
		// vertex data 
		protected var mVertexData:VertexData;
		protected var mVertexBuffer:VertexBuffer3D;
		
		// index data
		protected var mIndexData:Vector.<uint>;
		protected var mIndexBuffer:IndexBuffer3D;
		
		// helper objects (to avoid temporary objects)
		private static var sHelperMatrix:Matrix = new Matrix();
		private static var sRenderAlpha:Vector.<Number> = new <Number>[1.0, 1.0, 1.0, 1.0];
		
		protected var mColor:uint = 0x0;
		
		public function ColorObject()
		{
			
			createVertexData();
			createBuffers();
			registerPrograms();
			Starling.current.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		
		}
		
		protected function createVertexData():void
		{
			
			throw new AbstractMethodError("Method needs to be implemented in subclass");
		
		}
		
		/** Disposes all resources of the display object. */
		public override function dispose():void
		{
			Starling.current.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			if (mVertexBuffer)
				mVertexBuffer.dispose();
			if (mIndexBuffer)
				mIndexBuffer.dispose();
			
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
		public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle
		{
			if (resultRect == null)
				resultRect = new Rectangle();
			
			var transformationMatrix:Matrix = targetSpace == this ? null : getTransformationMatrix(targetSpace, sHelperMatrix);
			
			return mVertexData.getBounds(transformationMatrix, 0, -1, resultRect);
		}
		
		/** Creates new vertex- and index-buffers and uploads our vertex- and index-data to those
		 *  buffers. */
		protected function createBuffers():void
		{
			
			var context:Context3D = Starling.context;
			if (context == null)
				throw new MissingContextError();
			
			if (mVertexBuffer)
				mVertexBuffer.dispose();
			if (mIndexBuffer)
				mIndexBuffer.dispose();
			
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
			if (context == null)
				throw new MissingContextError();
			
			// apply the current blendmode
			support.applyBlendMode(false);
			
			// activate program (shader) and set the required buffers / constants 
			context.setProgram(Starling.current.getProgram(PROGRAM_NAME));
			
			context.setVertexBufferAt(0, mVertexBuffer, VertexData.POSITION_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
			context.setVertexBufferAt(1, mVertexBuffer, VertexData.COLOR_OFFSET, Context3DVertexBufferFormat.FLOAT_4);
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, support.mvpMatrix3D, true);
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, sRenderAlpha, 1);
			context.drawTriangles(mIndexBuffer, 0, mIndexData.length / 3);
			
			// reset buffers
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);
		}
		
		/** Creates vertex and fragment programs from assembly. */
		private static function registerPrograms():void
		{
			var target:Starling = Starling.current;
			if (target.hasProgram(PROGRAM_NAME))
				return; // already registered
			
			// va0 -> position
			// va1 -> color
			// vc0 -> mvpMatrix (4 vectors, vc0 - vc3)
			// vc4 -> alpha
			
			var vertexProgramCode:String = 
				"m44 op, va0, vc0 \n" + // 4x4 matrix transform to output space
				"mul v0, va1, vc4 \n"; // multiply color with alpha and pass it to fragment shader
			
			var fragmentProgramCode:String = 
				"mov oc, v0"; // just forward incoming color
			
			var vertexProgramAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexProgramAssembler.assemble(Context3DProgramType.VERTEX, vertexProgramCode);
			
			var fragmentProgramAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentProgramAssembler.assemble(Context3DProgramType.FRAGMENT, fragmentProgramCode);
			
			target.registerProgram(PROGRAM_NAME, vertexProgramAssembler.agalcode, fragmentProgramAssembler.agalcode);
		}
		
		public function get color():uint
		{
			return mColor;
		}
		
		public function set color(value:uint):void
		{
			mColor = value;
		}
		
		public function update():void
		{
			createVertexData();
			createBuffers();
		
		}
	}

}