/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 02.05.13
 * Time: 22:41
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Elastic;
import com.greensock.plugins.ColorTransformPlugin;
import com.greensock.plugins.GlowFilterPlugin;
import com.greensock.plugins.ShortRotationPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

public class SellectSubject extends Sprite {
    private var timeline: TimelineLite = new TimelineLite();
    private var arratElem : Array = new Array();
    public function SellectSubject() {
        TweenPlugin.activate([ColorTransformPlugin, TintPlugin, ShortRotationPlugin]);
    }
    public function init() :void {
        ServerRelation.getSubgect();
        ServerRelation.eventdisp.addEventListener(Event.COMPLETE, completeHandler);
    }

    private function completeHandler(event:Event):void {

        for (var i : int =0; i<ServerRelation.subjectArray.length;i++)
        {
            var  table :TableElement = new TableElement();
            table.index = i;
            table.init(ServerRelation.subjectArray[i][1]);
            table.y=100+i*60;
            arratElem.push(table);
            table.addEventListener(MouseEvent.CLICK, table_clickHandler);
            table.addEventListener(MouseEvent.MOUSE_OVER, table_mouseOverHandler);
            table.addEventListener(MouseEvent.MOUSE_OUT, table_mouseOutHandler);

            addChild(table);
        }
    }



    private function table_clickHandler(event:MouseEvent):void {
        ModalContainer.currentSubject=(event.target as Hover).index;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function table_mouseOverHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(arratElem[(event.target as Hover).index], 0.3, {glowFilter:{color:0x0033ff, alpha:1, blurX:30, blurY:30}}));
    }

    private function table_mouseOutHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(arratElem[(event.target as Hover).index], 0.3, {glowFilter:{color:0x0033ff, alpha:0, blurX:30, blurY:30}}));
    }
}
}
