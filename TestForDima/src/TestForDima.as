package {

import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.core.TweenCore;
import com.greensock.easing.Back;
import com.greensock.easing.Bounce;
import com.greensock.easing.Elastic;
import com.greensock.plugins.ScrollRectPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.Timer;

public class TestForDima extends Sprite {

    private var array:Array = new Array();
    private var timeline : TimelineLite = new TimelineLite();
    private var test : TestView;
    private var twinlite : TweenLite;
    private var timer : Timer = new Timer(1300);
    private var lastPoint: Point = new Point();
    private var currentSost : String = 'notScale';
    private var navigation : int=0;
    private var completeTest : CompleteTestView;
    public function TestForDima() {

    }
    public function init() : void {    // отправка запроса на сервер для получения теста
        TweenPlugin.activate([ScrollRectPlugin]);
        ServerRelation.getTest();
        ServerRelation.eventdisp.addEventListener(Event.COMPLETE, server_completeHandler);
        /* test.scaleX=0.5;    */

        addChild(ModalContainer.rootContainer);
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function test_mouseWheelHandler(event:MouseEvent):void {        // событие прокрутки мыши
        stage.removeEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);1
        stage.removeEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);

        if (currentSost=='Scale')
        {
            if (event.delta>0)
            {
                timeline.append(new TweenLite(test, 0.75, {x:test.x-400}));
                navigation--;
            }
            else
            {
                timeline.append(new TweenLite(test, 0.75, {x:test.x+400}));
                navigation++;
            }
        }
        else if (currentSost=='notScale')
        if (event.delta>0)
        {
            timeline.append(new TweenLite(test, 0.75, {x:test.x-800}));
            navigation--;
        }
        else
        {
            timeline.append(new TweenLite(test, 0.75, {x:test.x+800}));
            navigation++;
        }

        trace(test.x)
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start()
    }

    private function addedToStageHandler(event:Event):void {    // добавление на страницу объекта
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);

    }

    private function stage_keyUpHandler(event:KeyboardEvent):void {    // нажатие кнопки
        stage.removeEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);1
        stage.removeEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
        if (event.charCode==43)
        if (currentSost=='Scale')
        {
            var currentPos : Number = test.x*2;
            timeline.append(new TweenLite(test, 0.75, {scaleY:1,scaleX:1,y:0,x:currentPos}));
            currentSost='notScale';
        }
        if (event.charCode==45)
            if (currentSost=='notScale')
        {
            var currentPos : Number = test.x/2;
            timeline.append(new TweenLite(test, 0.75, {scaleY:0.5,scaleX:0.5,y:130,x:currentPos}));
            currentSost='Scale';
        }

        trace(test.x);
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start()
    }

    private function timer_timerHandler(event:TimerEvent):void {    // событие таймера
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
        timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
        if (currentSost=='Scale')
        {
            test.x=navigation*400;
        }
        else if (currentSost=='notScale')
            test.x=navigation*800;

    }

    private function server_completeHandler(event:Event):void {    // окончание загрузки  тестов
        removeChildren();
        test =null;
        ServerRelation.eventdisp.removeEventListener(Event.COMPLETE, server_completeHandler);
        array=ServerRelation.outputArray;
        test  = new TestView(array);
        addChild(test);
        test.addEventListener(Event.COMPLETE, test_completeHandler);
        test.addEventListener(MyEvents.CLICKTOTEST, test_fsdfgrHandler);
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

    private function test_completeHandler(event:Event):void {    //обновление списка тестов
       removeChild(test);
        completeTest = new CompleteTestView(ModalContainer.responses,array);
        completeTest.countRespons();
        completeTest.outputResult();
        addChild(completeTest);
    }
    private function arrow_mouseMoveHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30}}));

    }

    private function arrow_mouseOutHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:0, blurX:30, blurY:30}}));
    }

    private function arrow_clickHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.5, {scaleX: 0.9,scaleY:0.9, ease:Bounce.easeOut}));
        dispatchEvent(new Event(MyEvents.BACKTESTING));
    }

    private function test_fsdfgrHandler(event:Event):void {
        if (currentSost=='Scale')
        {
                timeline.append(new TweenLite(test, 0.75, {x:test.x-400}));
                navigation--;

        }
        else if (currentSost=='notScale')
        {     timeline.append(new TweenLite(test, 0.75, {x:test.x-800}));
                navigation--;
        }
        trace(test.x)
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start()

    }
}
}
