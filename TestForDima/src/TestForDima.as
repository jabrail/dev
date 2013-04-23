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

[SWF(width="800", height="600",frameRate="60")]
public class TestForDima extends Sprite {
    [Embed(source = '/images/red.jpg')]
    private var Background:Class;
    private var array:Array = new Array();
    private var timeline : TimelineLite = new TimelineLite();
    private var test : TestView;
    private var twinlite : TweenLite;
    private var timer : Timer = new Timer(1300);
    private var lastPoint: Point = new Point();
    private var currentSost : String = 'notScale';
    private var navigation : int=0;
    public function TestForDima() {
        TweenPlugin.activate([ScrollRectPlugin]);
        var background : Bitmap = new Background();
        background.width=800;
        background.height=600;
        addChild(background);
        ServerRelation.getTest();
        ServerRelation.eventdisp.addEventListener(Event.COMPLETE, server_completeHandler);
        /* test.scaleX=0.5;    */

        addChild(ModalContainer.rootContainer);
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function test_mouseWheelHandler(event:MouseEvent):void {
        stage.removeEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);1
        stage.removeEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);

        if (currentSost=='Scale')
        {
            if (event.delta>0)
            {
                timeline.append(new TweenLite(test, 0.75, {x:test.x-400,ease:Bounce.easeOut}));
                navigation--;
            }
            else
            {
                timeline.append(new TweenLite(test, 0.75, {x:test.x+400,ease:Bounce.easeOut}));
                navigation++;
            }
        }
        else if (currentSost=='notScale')
        if (event.delta>0)
        {
            timeline.append(new TweenLite(test, 0.75, {x:test.x-800,ease:Bounce.easeOut}));
            navigation--;
        }
        else
        {
            timeline.append(new TweenLite(test, 0.75, {x:test.x+800,ease:Bounce.easeOut}));
            navigation++;
        }

        trace(test.x)
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start()
    }

    private function addedToStageHandler(event:Event):void {
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);

    }

    private function stage_keyUpHandler(event:KeyboardEvent):void {
        stage.removeEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);1
        stage.removeEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
        if (event.charCode==43)
        if (currentSost=='Scale')
        {
            var currentPos : Number = test.x*2;
            timeline.append(new TweenLite(test, 0.75, {scaleY:1,scaleX:1,y:0,x:currentPos,ease:Bounce.easeOut}));
            currentSost='notScale';
        }
        if (event.charCode==45)
            if (currentSost=='notScale')
        {
            var currentPos : Number = test.x/2;
            timeline.append(new TweenLite(test, 0.75, {scaleY:0.5,scaleX:0.5,y:130,x:currentPos,ease:Bounce.easeOut}));
            currentSost='Scale';
        }

        trace(test.x);
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start()
    }

    private function timer_timerHandler(event:TimerEvent):void {
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, test_mouseWheelHandler);1
        stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
        timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
        if (currentSost=='Scale')
        {
            test.x=navigation*400;
        }
        else if (currentSost=='notScale')
            test.x=navigation*800;

    }

    private function server_completeHandler(event:Event):void {
        ServerRelation.eventdisp.addEventListener(Event.COMPLETE, server_completeHandler);
        array=ServerRelation.outputArray;
        test  = new TestView(array);
        addChild(test);

    }
}
}
