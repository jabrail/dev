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
import com.greensock.easing.Bounce;
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
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.Timer;

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

    private function completeHandler(event:Event):void {      // окончание загрузки предметов и вывод списка предметов на экран
        removeChildren();
         var j : int=1;
         var k : int=0;
        for (var i : int =0; i<ServerRelation.subjectArray.length;i++)
        {
            k++;
            var  table :TableElement = new TableElement();
            table.index = i;
            table.init(ServerRelation.subjectArray[i][1]);
            table.y=130*j;
            table.x=130*k;
            if (k>3)
            {
                j++;
                k=0;
            }
            arratElem.push(table);
            table.addEventListener(MouseEvent.CLICK, table_clickHandler);
            table.addEventListener(MouseEvent.MOUSE_OVER, table_mouseOverHandler);
            table.addEventListener(MouseEvent.MOUSE_OUT, table_mouseOutHandler);
            addChild(table);
        }
        var arrow : Bitmap = new Asset.ArrowBack();
        var sp_arrow : Sprite = new Sprite();
        arrow.height=80;
        arrow.width =80;
        arrow.x=-40;
        arrow.y=-40;
        sp_arrow.x=40;
        sp_arrow.y=560;
        sp_arrow.addChild(arrow);
        addChild(sp_arrow);
        sp_arrow.addEventListener(MouseEvent.MOUSE_MOVE, arrow_mouseMoveHandler);
        sp_arrow.addEventListener(MouseEvent.MOUSE_OUT, arrow_mouseOutHandler);
        sp_arrow.addEventListener(MouseEvent.CLICK, arrow_clickHandler);
    }



    private function table_clickHandler(event:MouseEvent):void {     // событие выбора теста
        ModalContainer.currentSubject=(event.target as Hover).index;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function table_mouseOverHandler(event:MouseEvent):void {    // событие входа указателя мыши в область предмета
        if (event.target is Hover)
        new TimelineLite().append(new TweenLite(arratElem[(event.target as Hover).index], 0.3, {glowFilter:{color:0x0033ff, alpha:1, blurX:30, blurY:30}}));
    }

    private function table_mouseOutHandler(event:MouseEvent):void {   // событие выхода мыши из области объекта
        if (event.target is Hover)
            new TimelineLite().append(new TweenLite(arratElem[(event.target as Hover).index], 0.3, {glowFilter:{color:0x0033ff, alpha:0, blurX:30, blurY:30}}));
    }
    private function arrow_mouseMoveHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30}}));
    }

    private function arrow_mouseOutHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:0, blurX:30, blurY:30}}));
    }

    private function arrow_clickHandler(event:MouseEvent):void {   // нажатие на кнопку назад
        new TimelineLite().append(new TweenLite(event.target, 0.5, {scaleX: 0.9,scaleY:0.9, ease:Bounce.easeOut}));
        dispatchEvent(new Event(MyEvents.BACKSUBJECT));
    }

}
}
