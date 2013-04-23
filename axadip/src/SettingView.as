/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 18.04.13
 * Time: 9:05
 * To change this template use File | Settings | File Templates.
 */
package {
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.core.View;
import alternativa.engine3d.core.events.MouseEvent3D;
import alternativa.engine3d.lights.AmbientLight;
import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.primitives.Box;

import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Stage3D;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

public class SettingView extends Sprite{

    private var camera:Camera3D;
    private var stage3D:Stage3D;
    private var rootContainer:Object3D = new Object3D();
    private var light : AmbientLight;
    public var thumbus : Box;
    private var button_on_Proection : Sprite = new Sprite();
    private var button_of_rotation : Sprite = new Sprite();
    private var button_of_alpha : Sprite = new Sprite();
    private var clickPoint : Point = new Point();
    private var clickDin: Boolean = false;
    private var tf_din : TextField = new TextField();
    private var mainSprite : Sprite= new Sprite();
    private var clickBox : Boolean =false;



    public function SettingView() {
        var shape : Sprite = new Sprite();
        shape.graphics.beginFill(0xcccccc,0.6);
        shape.graphics.drawRect(0,0,100,560);
        addChild(shape);
        var fon : Sprite = new Sprite();
        var tf : TextField = new TextField();
        tf.width=90;
        tf.height=30;
        tf.text ='Проекция'
        tf.border=true;
        tf.borderColor=0x000000;
        fon.graphics.beginFill(0x000000,0.5);
        button_of_rotation.graphics.beginFill(0x000000,0.01);
        fon.graphics.drawRect(0,0,90,30);
        button_of_rotation.graphics.drawRect(0,0,90,30);
        tf.textColor = 0xFFFFFF;
        fon.addChild(tf);
        fon.addChild(button_of_rotation);
        fon.x =5;
        fon.y = 10;
        addChild(fon);
        button_of_rotation.addEventListener(MouseEvent.CLICK, button_of_rotation_clickHandler);



        var fon : Sprite = new Sprite();
        var tf : TextField = new TextField();
        fon.graphics.beginFill(0x000000,0.5);
        button_on_Proection.graphics.beginFill(0x000000,0.01);
        fon.graphics.drawRect(0,0,90,30);
        button_on_Proection.graphics.drawRect(0,0,90,30);
        tf.textColor = 0xFFFFFF;
        tf.width=90;
        tf.height=30;
        tf.text ='Вращение'
        tf.border=true;
        tf.borderColor=0x000000;        fon.addChild(tf);
        fon.addChild(button_on_Proection);
        fon.x =5;
        fon.y = 50;
        addChild(fon);
        button_on_Proection.addEventListener(MouseEvent.CLICK, button_on_Proection_clickHandler);

        var fon : Sprite = new Sprite();
        fon.graphics.beginFill(0x000000,0.5);
        button_of_alpha.graphics.beginFill(0x000000,0.01);
        fon.graphics.drawRect(0,0,90,30);
        button_of_alpha.graphics.drawRect(0,0,90,30);
        tf_din.textColor = 0xFFFFFF;
        tf_din.width=90;
        tf_din.height=30;
        tf_din.text ='Динамики'
        tf_din.border=true;
        tf_din.borderColor=0x000000;
        fon.addChild(tf_din);
        fon.addChild(button_of_alpha);
        fon.x =5;
        fon.y = 90;
        addChild(fon);
        button_of_alpha.addEventListener(MouseEvent.CLICK, button_of_alpha_clickHandler);

        var button_bottom : Button = new Button('Вид верху',1);
        addChild(button_bottom);
        button_bottom.x=5;
        button_bottom.y=130;
        button_bottom.addEventListener(Event.COMPLETE, button_bottom_completeHandler);

        var button_left : Button = new Button('Вид сбоку',1);
        addChild(button_left);
        button_left.x=5;
        button_left.y=170;
        button_left.addEventListener(Event.COMPLETE, button_left_completeHandler);

        var button_all_view : Button = new Button('Общий вид',1);
        addChild(button_all_view);
        button_all_view.x=5;
        button_all_view.y=210;
        button_all_view.addEventListener(Event.COMPLETE, button_all_view_completeHandler);

        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);



    }


    private function button_of_rotation_clickHandler(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.STOP_ROTATE));
    }

    private function button_on_Proection_clickHandler(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.PROECTION))
    }



    private function addedToStageHandler(event:Event):void {


    }

    private function thumbus_mouseDownHandler(event:MouseEvent3D):void {
           clickBox=true;
    }

    private function thumbus_mouseMoveHandler(event:MouseEvent):void {
      thumbus.rotationX+=(event.stageX-clickPoint.x)/100;
      thumbus.rotationY+=(event.stageY-clickPoint.y)/100;
        clickPoint.x=event.stageX;
        clickPoint.y=event.stageY;
    }

    private function thumbus_mouseUp3DHandler(event:MouseEvent):void {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.removeEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
        clickBox=false;
    }

    private function stage_mouseDownHandler(event:MouseEvent):void {
        if (clickBox)
        {
        clickPoint.x=event.stageX;
        clickPoint.y=event.stageY;
        stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.addEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
        }
    }

    private function button_of_alpha_clickHandler(event:MouseEvent):void {
       if (clickDin)
       {
           tf_din.text='Динамика';
       clickDin =false;
       }
        else
       {
           tf_din.text='Статика';
           clickDin =true;
       }
        dispatchEvent(new Event(MyEvents.ONOFDINAMIC));
    }

    private function button_bottom_completeHandler(event:Event):void {
        dispatchEvent(new Event(MyEvents.BOTTOM_VIEW));
    }

    private function button_left_completeHandler(event:Event):void {
        dispatchEvent(new Event(MyEvents.LEFT_VIEW));
    }

    private function button_all_view_completeHandler(event:Event):void {
        dispatchEvent(new Event(MyEvents.ALL_VIEW));
    }
}
}
