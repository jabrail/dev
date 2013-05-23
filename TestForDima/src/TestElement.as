/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.04.13
 * Time: 13:08
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.plugins.ColorMatrixFilterPlugin;
import com.greensock.plugins.EndArrayPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
public class TestElement extends Sprite{
    private var array: Array;
    private var arrayTextField: Array = new Array();
    private var arrayHovers: Array = new Array();
    public var id : int =0;
    private var mainSprite : Sprite = new Sprite();
    private var timeline : TimelineLite = new TimelineLite();
    public var varian : int =0;

    public var response : int = 0;
    public function TestElement(_array:Array) {
        var fon : Sprite = new Sprite();
        fon.graphics.beginFill(0xFFFFFF,0.2);
        fon.graphics.drawRect(0,0,780,520);
        fon.x=10;
        addChild(fon)
        var fon1 : Sprite = new Sprite();
        fon1.graphics.beginFill(0x432543,0.0001);
        fon1.graphics.drawRect(0,0,800,520);
        addChild(fon1);
        array = _array;
        id = _array[0]
        TextFormats.init_Formats();
        addChild(mainSprite);
        init();
    }
    public function init() : void {    // добавление формы для прохождения тестов

        for (var i:int=0;i<5;i++)
        {
            arrayTextField[i] = new TextField();
            arrayHovers[i] = new MySprite();
            (arrayTextField[i] as TextField).background = true;
            (arrayTextField[i] as TextField).backgroundColor = 0xCCCCCC;
            arrayTextField[i].defaultTextFormat = TextFormats.textFormat_1;
            (arrayTextField[i] as TextField).multiline=true;
            (arrayTextField[i] as TextField).wordWrap=true;
            arrayTextField[i].text = array[i+1];
            arrayTextField[i].height = 80;
            arrayTextField[i].width = 760;
            (arrayHovers[i] as Sprite).graphics.beginFill(0x000000,0.001);
            (arrayHovers[i] as Sprite).graphics.drawRect(0,0,760,80);
            arrayHovers[i].y=arrayTextField[i].y=i*100+20;
            arrayHovers[i].x=arrayTextField[i].x=20;
            (arrayHovers[i] as MySprite).i=i;
            if (i!=0)
            (arrayHovers[i] as Sprite).addEventListener(MouseEvent.CLICK, clickHandler);
            mainSprite.addChild(arrayTextField[i]);
            mainSprite.addChild(arrayHovers[i]);
        }
    }

    private function clickHandler(event:MouseEvent):void {    // выбор теств
        for (var i:int =1;i<arrayHovers.length;i++)
            (arrayHovers[i] as Sprite).removeEventListener(MouseEvent.CLICK, clickHandler);
        TweenPlugin.activate([ColorMatrixFilterPlugin, EndArrayPlugin]);
        timeline.append(new TweenLite(arrayTextField[(event.target as MySprite).i], 1, {colorMatrixFilter:{colorize:0x00cc00, amount:1}}));
//        (event.target as TextField).backgroundColor = 0x00FF00;
        varian = (event.target as MySprite).i;
        dispatchEvent(new Event(Event.COMPLETE));

     }
}
}
