/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 02.05.13
 * Time: 22:41
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

public class SellectSubject extends Sprite {
    public function SellectSubject() {
    }
    public function init() :void {
        ServerRelation.getSubgect();
        ServerRelation.eventdisp.addEventListener(Event.COMPLETE, completeHandler);
    }

    private function completeHandler(event:Event):void {

        for (var i : int =0; i<ServerRelation.subjectArray.length;i++)
        {
            var tf : TextField = new TextField();
            tf.defaultTextFormat = TextFormats.textFormat_2;
            tf.text=ServerRelation.subjectArray[i][1];
            tf.x=350;
            tf.y=200+i*50;
            addChild(tf);
        }
    }
}
}
