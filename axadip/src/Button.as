/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 15.03.13
 * Time: 1:03
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class Button extends Sprite{
    private var textField : TextField = new TextField();
    private var shape : Shape = new Shape();
    private var hover : Sprite = new Sprite();
    public function Button(text : String,type : int=0) {
       if (type==0)
       {
        textField.width=120;
        textField.height=30;
        textField.x = 10;
        textField.y = 4;
        textField.text=text;
        textField.textColor=0xFFFFFF;
        shape.graphics.beginFill(0x000000,0.7);
        shape.graphics.drawRoundRectComplex(0,0,120,30,5,25,0,0);
        hover.graphics.beginFill(0x000000,0.01);
        hover.graphics.drawRoundRectComplex(0,0,120,30,0,0,0,0);
        hover.addEventListener(MouseEvent.CLICK, hover_clickHandler);
        addChild(shape);
        addChild(textField);
        addChild(hover);
       }
        else if (type==1)
       {
           textField.width=90;
           textField.height=30;
           textField.x = 0;
           textField.y = 0;
           textField.text=text;
           textField.border=true;
           textField.borderColor=0x000000;
           textField.textColor=0xFFFFFF;
           shape.graphics.beginFill(0x000000,0.5);
           shape.graphics.drawRect(0,0,90,30);
           hover.graphics.beginFill(0x000000,0.01);
           hover.graphics.drawRect(0,0,90,30);
           hover.addEventListener(MouseEvent.CLICK, hover_clickHandler);
           addChild(shape);
           addChild(textField);
           addChild(hover);
       }
    }

    private function hover_clickHandler(event:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
