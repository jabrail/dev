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

public class Thumbus extends Sprite{

    private var camera:Camera3D;
    private var stage3D:Stage3D;
    private var rootContainer:Object3D = new Object3D();
    private var light : AmbientLight;
    public var thumbus : Box;
    private var button_on_Proection : Sprite = new Sprite();
    private var button_of_rotation : Sprite = new Sprite();
    private var clickPoint_x_y : Point = new Point();
    private var clickPoint_z : Point = new Point();

    private var mainSprite : Sprite= new Sprite();
    private var clickBox : Boolean =false;



    public function Thumbus() {
         this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
   }
    private function onContextCreate(e:Event):void {

        var thumbusMaterial_1 : FillMaterial = new FillMaterial(0x000000,1);
        var thumbusMaterial_2 : FillMaterial = new FillMaterial(0x222222,1);
        var thumbusMaterial_3 : FillMaterial = new FillMaterial(0x444444,1);
        var thumbusMaterial_4 : FillMaterial = new FillMaterial(0x666666,1);
        var thumbusMaterial_5 : FillMaterial = new FillMaterial(0x888888,1);
        var thumbusMaterial_6 : FillMaterial = new FillMaterial(0x332434,1);


        thumbus = new Box(600,600,600);

        thumbus.addSurface(thumbusMaterial_1, 0, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_2, 6, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_3, 12, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_4, 18, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_5, 24, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_6, 30, 2); //на каждую накладываем свою текстуру



        thumbus.x=0;
        thumbus.y=150;
        thumbus.z=100;
        rootContainer.addChild(thumbus);

        thumbus.addEventListener(MouseEvent3D.MOUSE_DOWN, thumbus_mouseDownHandler);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);


        for each (var resource:Resource in rootContainer.getResources(true)) {
            resource.upload(stage3D.context3D);
        }
        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

    }





    private function onEnterFrame(event:Event):void {
        camera.render(stage3D);
    }

    private function addedToStageHandler(event:Event):void {

        camera = new Camera3D(0.1, 10000);
        camera.view = new View(100, 100,false,0xcccccc);
//        camera.view.backgroundAlpha = 0.5;
        camera.rotationX = -120 * Math.PI / 180;
        camera.y = -800;
        camera.z = 800;
        mainSprite.addChild(camera.view);
        mainSprite.addChild(camera.diagram);
        mainSprite.x=350;
        mainSprite.y=450;
        addChild(mainSprite);
        rootContainer.addChild(camera);
        light = new AmbientLight(0xFFFFFF);
        light.z = 100;
        rootContainer.addChild(light);
        stage3D = stage.stage3Ds[1];
        stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
        stage3D.requestContext3D();
        camera.view.hideLogo();

    }

    private function thumbus_mouseDownHandler(event:MouseEvent3D):void {
        clickPoint_x_y.x = event.localX;
        clickPoint_x_y.y = event.localY;
        clickPoint_z.x = event.localZ;
        thumbus.addEventListener(MouseEvent3D.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.addEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
    }

    private function thumbus_mouseMoveHandler(event:MouseEvent3D):void {
        thumbus.rotationX+=(event.localX-clickPoint_x_y.x)/1000;
        thumbus.rotationY+=(event.localY-clickPoint_x_y.y)/1000;
        thumbus.rotationZ+=(event.localZ-clickPoint_z.x)/1000;
        clickPoint_x_y.x=event.localX;
        clickPoint_x_y.y=event.localY;
        clickPoint_z.x=event.localZ;
    }

    private function thumbus_mouseUp3DHandler(event:MouseEvent):void {
        thumbus.removeEventListener(MouseEvent3D.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.removeEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
        clickBox=false;
    }

    private function stage_mouseDownHandler(event:MouseEvent):void {
        if (clickBox)
        {
  /*          clickPoint.x=event.stageX;
            clickPoint.y=event.stageY;
            stage.addEventListener(MouseEvent3D.MOUSE_MOVE, thumbus_mouseMoveHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);*/
        }
    }
}
}
