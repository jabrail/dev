/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 02.03.13
 * Time: 16:53
 * To change this template use File | Settings | File Templates.
 */
package {
import alternativa.engine3d.alternativa3d;
import alternativa.engine3d.controllers.SimpleObjectController;
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.core.View;
import alternativa.engine3d.core.events.MouseEvent3D;
import alternativa.engine3d.lights.AmbientLight;
import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.materials.Material;
import alternativa.engine3d.materials.StandardMaterial;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.materials.VertexLightTextureMaterial;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.objects.SkyBox;
import alternativa.engine3d.objects.Sprite3D;
import alternativa.engine3d.primitives.Box;
import alternativa.engine3d.primitives.GeoSphere;
import alternativa.engine3d.resources.BitmapTextureResource;

import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Back;
import com.greensock.easing.Circ;


import flash.display.Sprite;
import flash.display.Stage3D;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

use namespace alternativa3d;

[SWF(frameRate="100", width="800", height="600", backgroundColor="#FF3838")]

public class MainView extends Sprite{
    private var addPoint : AddPoint = new AddPoint();
    private var getPoint : GetPoint = new GetPoint();
    private var rootContainer:Object3D = new Object3D();
    [Embed(source="images/map.png") ]
    static private const MainTexture:Class;
    [Embed(source="images/deep.png") ]
    static private const DeepTexture:Class;
    [Embed(source="images/sky.jpg") ]
    static private const Sky:Class;
    [Embed(source="images/pol.jpg") ]
    static private const LeftView:Class;
    private var light : AmbientLight;
    private var addBaseBool : Boolean = false;

    private var controller:SimpleObjectController;

    private var camera:Camera3D;
    private var stage3D:Stage3D;
    private var form : FormInpOut = new FormInpOut();
    private var panel : Sprite = new Sprite();
    private var startPanel : Boolean = false;
    private var startPanelpos : Boolean = true;
    private var panelForm : FormInpOut = new FormInpOut();
    private var addPointAction : AddPoint = new AddPoint();
    private var buttonOpenText : TextField = new TextField();
    private var buttonView : Sprite = new Sprite();
    private var allPoints : Array = new Array();
    private var allProection : Array = new Array();
    private var position : Point = new Point();
    private var index :int = 0;
    private var points : Array;
    private var seconds : int = 0;
    private var controllerSost : Boolean = true;
    private var mainMesh : Mesh = new Mesh();
    private var hoverMesh : Mesh = new Mesh();
    private var indexAdd : int =0;
    private var arrayAddPoints : Array;
    private var deg: Number =0;
    private var cache : Cache = new Cache();
    private var settingView : SettingView = new SettingView();
    private var timeLine : TimelineLite = new TimelineLite();
    private var timeLine_y : TimelineLite = new TimelineLite();
    private var timeLine_z : TimelineLite = new TimelineLite();
    private var timeLine_camera_z : TimelineLite = new TimelineLite();
    private var rotationSost : Boolean = true;
    private var thumbusSprite : Sprite = new Sprite();
    private var mainSprite : Sprite3D = new Sprite3D(150,150);
    private var proection_sost : Boolean = true;
    public var thumbus : Box;
    private var clickForbox : Boolean = false;
    private var clickPoint : Point = new Point();
    private var dinamic : Boolean = true;
    var button_base : Button = new Button('Базу');
    var button_add_one  : Button = new Button('Одно событие');
    private var clickPoint_x_y : Point = new Point();
    private var clickPoint_z : Point = new Point();
    private var showPointProperty : Sprite = new Sprite();
    private var text_show_property_x : TextField = new TextField();
    private var text_show_property_y : TextField = new TextField();
    private var text_show_property_z : TextField = new TextField();
    private var text_show_property_title : TextField = new TextField();
    private var settingVis : Boolean = false;



    private var plane : Box;

    public function MainView() {

        camera = new Camera3D(0.1, 10000);
        camera.view = new View(stage.stageWidth, stage.stageHeight,false,0xFFFFFF);
        camera.rotationX = -120 * Math.PI / 180;
        camera.y = -800;
        camera.z = 800;
        createTextProp()
        showPointProperty.x=850-showPointProperty.width;
        showPointProperty.y=100;
        addChild(showPointProperty);

        addChild(camera.view);
        addChild(camera.diagram);
        settingView.x=0;
        settingView.y=40;
        addChild(settingView);
        settingView.addEventListener(MouseEvent.CLICK, settingView_mouseOverHandler);
        settingView.addEventListener(MyEvents.PROECTION, settingView_stop_rotateHandler);
        settingView.addEventListener(MyEvents.STOP_ROTATE, settingView_proectionHandler);
        settingView.addEventListener(MyEvents.ONOFDINAMIC, settingView_dinamicHandler);
        settingView.addEventListener(MyEvents.BOTTOM_VIEW, settingView_BOTTOM_VIEWHandler);
        settingView.addEventListener(MyEvents.LEFT_VIEW, settingView_LEFT_VIEWHandler);
        settingView.addEventListener(MyEvents.ALL_VIEW, settingView_ALL_VIEWHandler);
        rootContainer.addChild(camera);
        light = new AmbientLight(0xFFFFFF);
        light.z = 100;
        rootContainer.addChild(light);
        stage3D = stage.stage3Ds[0];
        stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
        stage3D.requestContext3D();
        panel.graphics.beginFill(0xcccccc,0.6);
        panel.graphics.drawRect(0,0,800,600);
        panel.y=-560;
        var but : Sprite = new Sprite();
        but.graphics.beginFill(0x880000,0.7);
        but.graphics.drawRect(0,0,80,30);
        but.x = panel.width-but.width;
        but.y = panel.height-but.height;
        but.addChild(buttonOpenText);
        buttonOpenText.text='Открыть'
        buttonOpenText.width=but.width;
        buttonOpenText.x = 15;
        buttonOpenText.y = 4;
        buttonOpenText.textColor = 0xFFFFFF;
        panel.addChild(but);
        panel.addChild(panelForm);
        but.addEventListener(MouseEvent.CLICK, but_clickHandler);
        var textureMain:BitmapTextureResource = new BitmapTextureResource(new Sky().bitmapData);
        var skyBox : SkyBox = new SkyBox(4500,new TextureMaterial(textureMain,textureMain),new TextureMaterial(textureMain,textureMain),new TextureMaterial(textureMain,textureMain),new TextureMaterial(textureMain,textureMain),new TextureMaterial(textureMain,textureMain),new TextureMaterial(textureMain,textureMain));
        rootContainer.addChild(skyBox);
        addChild(panel);
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        addButton();
        camera.view.hideLogo();



    }
    private function onContextCreate(e:Event):void {

        var textureMain:BitmapTextureResource = new BitmapTextureResource(new MainTexture().bitmapData); //создаем BitmapTextureResource и  передаем ему bitmapDat'у нашей текстуры
        var textureDeep:BitmapTextureResource = new BitmapTextureResource(new DeepTexture().bitmapData); //создаем BitmapTextureResource и  передаем ему bitmapDat'у нашей текстуры
        //    textureMain.upload(stage3D.context3D); //добавляем в context3D
        var textureLeft:BitmapTextureResource = new BitmapTextureResource(new LeftView().bitmapData); //создаем BitmapTextureResource и  передаем ему bitmapDat'у нашей текстуры
        //    textureLeft.upload(stage3D.context3D); //добавляем в context3D



        var mainMaterial : VertexLightTextureMaterial = new VertexLightTextureMaterial(textureMain);
        var mainDeep : TextureMaterial = new TextureMaterial(textureDeep,null,0.5);
        mainDeep.alpha = 0.5;
        mainDeep.alphaThreshold = 1;
        mainMaterial.alpha = 0.8;
        mainMaterial.alphaThreshold = 1;
        var leftMaterial : FillMaterial = new FillMaterial(0x246345,0.5);
        var thumbusMaterial : FillMaterial = new FillMaterial(0xcccccc,0.5);
        //      leftMaterial.alpha = 0.4;
        plane  = new Box(539, 515, 600);
        //     plane.rotationX=Math.PI/2;
        plane.x=0-539/2+539/2;
        plane.y = 0-515/2+515/2;
        plane.z = 0-600/2+300;
        for (var i:int = 0; i < 6; i++) { //box'у добавляем 6 поверхностей
            if (i==1) {
                plane.addSurface(mainMaterial, i*6, 2); //на каждую накладываем свою текстуру

            }else if (i==0)
            {
                plane.addSurface(leftMaterial,i*6,2); //на каждую накладываем свою текстуру
            }
            else
            {
                plane.addSurface(mainDeep, i*6, 2); //на каждую накладываем свою текстуру
            }
        }

        thumbus = new Box(100,100,100);
        for (var i:int = 0; i < 6; i++) { //box'у добавляем 6 поверхностей
            if (i==1) {
                thumbus.addSurface(mainMaterial, i*6, 2); //на каждую накладываем свою текстуру

            }else if (i==0)
            {
                thumbus.addSurface(leftMaterial,i*6,2); //на каждую накладываем свою текстуру
            }
            else
            {
                thumbus.addSurface(mainDeep, i*6, 2); //на каждую накладываем свою текстуру
            }
        }

        thumbus.addEventListener(MouseEvent3D.MOUSE_DOWN, thumbus_mouseDownHandler);
        mainSprite.addChild(thumbus)
        mainSprite.x=350;
        mainSprite.y=-550;
        mainSprite.z=200;
        rootContainer.addChild(mainSprite);

//        plane.addEventListener(MouseEvent3D.MOUSE_DOWN, plane_middleMouseDown3DHandler);
//        stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
        mainMesh.x = panel.x/8;
        mainMesh.y = panel.y/8;
        mainMesh.addChild(plane);
        hoverMesh.addChild(mainMesh)
        rootContainer.addChild(hoverMesh);
        getPoint.geAlltPoints();
        getPoint.addEventListener(Event.COMPLETE, getPoint_completeHandler);


//        controller = new SimpleObjectController(stage, camera, 80, 10, 0.4);


        for each (var resource:Resource in rootContainer.getResources(true)) {
            resource.upload(stage3D.context3D);
        }

        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        addEventListener(Event.ENTER_FRAME, rotationCam)

    }

    private function onEnterFrame(e:Event):void {
//        mainMesh.rotationX = settingView.thumbus.rotationX;
        if (controllerSost)
//        controller.update();
            camera.render(stage3D);
        mainMesh.rotationX = thumbus.rotationX;
        mainMesh.rotationY = thumbus.rotationY;
        mainMesh.rotationZ = thumbus.rotationZ;
        camera.lookAt(plane.x,plane.y,plane.z+100);

    }

    private function getPoint_completeHandler(event:Event):void {

        points = getPoint.getArray();
        index = 0;
        if (points.length!=0)
            addPointForStage()

    }

    private function but_clickHandler(event:MouseEvent):void {
        startPanel = true;
        if (startPanelpos) {
            startPanelpos = false;
            timeLine.append(new TweenLite(panel,1,{y:0,ease:Circ.easeOut}));
            timeLine.append(new TweenLite(settingView,1,{x:0-settingView.width,ease:Circ.easeOut}));
            buttonOpenText.text='Закрыть'

        }
        else {
            startPanelpos =true;
            timeLine.append(new TweenLite(panel,1,{y:-561,ease:Circ.easeOut}));
            timeLine.append(new TweenLite(settingView,1,{x:0-settingView.width/2,ease:Circ.easeOut}));
            buttonOpenText.text='Открыть'
        }


    }

    private function enterFrameHandler(event:Event):void {
        /*   if (startPanel) {
         if (!startPanelpos)
         {
         //   panel.y+=13;
         if (panel.y>0) {
         startPanel = false;
         buttonOpenText.text='Закрыть'
         }
         }
         else {
         //   panel.y-=13;
         if (panel.y<-560) {
         startPanel = false;
         buttonOpenText.text='Открыть'
         }
         }
         }*/
    }

    private function panelForm_completeHandler(event:Event):void {
        addPointAction.addPoint(panelForm.monthStringInp.text,panelForm.x_corInp.text,panelForm.y_corInp.text,panelForm.z_corInp.text,panelForm.titleStringInp.text,panelForm.magnitudeInp.text)

    }
    private function addButton() : void {


        panel.addChild(buttonView);
        panelForm.addEventListener(MyEvents.ADD_POINT, panelForm_completeHandler);
        panelForm.addEventListener(MyEvents.ADD_BASE, panelForm_add_baseHandler);
        panelForm.addEventListener(MyEvents.DEPP_SORT, panelForm_1DEPP_SORTHandler);
        panelForm.addEventListener(MyEvents.MAGNITUDE_SORT, panelForm_1MAGNITUDE_SORTHandler);
        panelForm.addEventListener(MyEvents.MONTH_SORT, panelForm_1MONTH_SORTHandler);

        var button_add : Button = new Button('Добавить');
        var button_month : Button = new Button('По дате')
        var button_deep : Button = new Button('По глубине')
        var button_magnit : Button = new Button('По магнитуде')
        var button_all : Button = new Button('Все события')
        button_month.addEventListener(Event.COMPLETE, button_month_completeHandler);
        button_deep.addEventListener(Event.COMPLETE, button_deep_completeHandler);
        button_magnit.addEventListener(Event.COMPLETE, button_magnit_completeHandler);
        button_add.addEventListener(Event.COMPLETE, button_add_completeHandler);
        button_all.addEventListener(Event.COMPLETE, button_all_completeHandler);
        buttonView.addChild(button_add);
        button_month.x =  button_add.x +button_add.width;
        buttonView.addChild(button_month);
        button_deep.x = button_month.x+button_month.width;
        buttonView.addChild(button_deep);
        button_magnit.x =  button_deep.x+button_deep.width;
        buttonView.addChild(button_magnit);
        button_all.x = button_magnit.x+button_magnit.width;
        buttonView.addChild(button_all);

        buttonView.y=570

    }

    private function button_add_completeHandler(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = true;
        button_base.addEventListener(Event.COMPLETE, button_base_completeHandler);
        button_base.y = 500;
        panel.addChild(button_base);
        panelForm.addForm()
    }

    private function button_month_completeHandler(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = false;
        panelForm.sortingForm_month();

    }

    private function button_deep_completeHandler(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = false;
        panelForm.sortingForm_h();

    }

    private function button_magnit_completeHandler(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = false;
        panelForm.sortingForm_mag();
    }

    private function panelForm_1DEPP_SORTHandler(event:Event):void {
        removeChildPoints();
        getPoint.getPointDeep(panelForm.sor_min_h_inp.text,panelForm.sor_max_h_inp.text);

    }

    private function panelForm_1MAGNITUDE_SORTHandler(event:Event):void {
        removeChildPoints();
        getPoint.getPoinMagnitude(panelForm.sor_min_mag_inp.text,panelForm.sor_max_mag_inp.text);

    }

    private function panelForm_1MONTH_SORTHandler(event:Event):void {
        removeChildPoints();
        getPoint.getPointMonth(panelForm.sor_month_inp.text,panelForm.sor_month_inp_2.text);
    }
    private function removeChildPoints() : void {
        for (var i : int =0;i<allPoints.length;i++)
        {
            mainMesh.removeChild(allPoints[i][0]);

        }
        allPoints = null;
        allPoints = new Array();
        for (var i : int =0;i<allProection.length;i++)
        {
            mainMesh.removeChild(allProection[i][0]);
        }
        allProection = null;
        allProection = new Array();
    }

    private function button_all_completeHandler(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = false;
        removeChildPoints();
        getPoint.geAlltPoints();
    }

    private function sphere_mouseOut3DHandler(event:MouseEvent3D):void {

        var x_x : Number = 148.49+(event.target.x/22.84);
        text_show_property_x.text= x_x.toString();
        var x_x : Number = 45.21+(event.target.y/32.36);

        text_show_property_y.text= x_x.toString();
        text_show_property_z.text= allPoints[event.target.userData][1];
        text_show_property_title.text = allPoints[event.target.userData][5];
    }

    private function plane_middleMouseDown3DHandler(event:MouseEvent3D):void {
        clickForbox = true;
    }

    private function plane_mouseMove3DHandler(event:MouseEvent):void {
        camera.x-=event.stageX-clickPoint.x;
        camera.y+=event.stageY-clickPoint.y;
        clickPoint.x = event.stageX;
        clickPoint.y = event.stageY;
    }

    private function plane_mouseUp3DHandler(event:MouseEvent):void {
        plane.removeEventListener(MouseEvent3D.MOUSE_MOVE, plane_mouseMove3DHandler);
        controllerSost = true;
        rotationSost = true;

    }
    private function addPointForStage()  : void {
        enterFrameHandlerPoint();
    }

    private function enterFrameHandlerPoint():void {


        /*     if (seconds>10)
         {*/


        for (var i :int =0;i<points.length;i++)
        {
            seconds=0;
            var color : Number = 0;

            //           if (sphere.y =  points[i][3])

            var sphere : GeoSphere = new  GeoSphere(points[i][4]/1.5,points[i][4]/1.5);


                var material: FillMaterial = new FillMaterial(0xff0000+(points[i][2]*0x001100))

                sphere.setMaterialToAllSurfaces(material);

            sphere.x = points[i][0]-539/2;
            sphere.y =  points[i][1]-515/2;
            var hs :  Number = points[i][2];
            sphere.z = (601-hs)-300;
            mainMesh.addChild(sphere);
            var h : Number =(601-sphere.z);
            var box : Box = new Box(3,3,1,1,1,1,false,material);
            mainMesh.addChild(box);
            box.x = sphere.x;
            box.y = sphere.y;
            box.z = 601;
//                if (proection_sost)
            box.z = sphere.z+(h-300)/2;
            box.scaleZ =h-300;

            allPoints.push(new Array(sphere,sphere.z,points[i][0],points[i][1],points[i][2],points[i][3]));
            if (dinamic)
            {
                allProection.push(new Array(box,false));
                sphere.visible = false;
                box.visible = false;
                addEventListener(Event.ENTER_FRAME, enterFrameHandler1);
            }
            else
            {
                allProection.push(new Array(box,true));
            }
            index=0;
            sphere.addEventListener(MouseEvent3D.MOUSE_OUT, sphere_mouseOut3DHandler);
            sphere.userData = i;
        }
        for each (var resource:Resource in rootContainer.getResources(true)) {
            resource.upload(stage3D.context3D);
        }
        //     }
        seconds++;
    }

    private function button_base_completeHandler(event:Event):void {
        button_add_one.visible = true;
        button_base.visible = false;
        button_add_one.addEventListener(Event.COMPLETE, button_add_completeHandler_base);
        button_add_one.y = 500;
        panel.addChild(button_add_one);
        panelForm.addBase();

    }

    private function button_add_completeHandler_base(event:Event):void {
        button_add_one.visible = false;
        button_base.visible = true;
        button_base.addEventListener(Event.COMPLETE, button_base_completeHandler);
        button_base.y = 500;
        panel.addChild(button_base);
        panelForm.addForm()
    }

    private function panelForm_add_baseHandler(event:Event):void {
        arrayAddPoints = encodeBase('*'+panelForm.sor_max_mag_inp.text+'*');
        trace(arrayAddPoints.length);
        trace(arrayAddPoints);
        addBaseBool=true;
        addBase();


    }
    private function encodeBase(string:String) : Array {
        var i : int = string.search('>');
        i++;
        var id: int = 0;
        var index : int=0;
        var outputArray : Array = new Array();
        var ptr :Array = new Array();
        var retStr : String = '';
        var seach : Boolean = false;
        var seach_pod : Boolean = false;
        outputArray[index] = new Array();
        while (seach!=true) {
            if (string.charAt(i)!='*')
            {
                if (string.charAt(i)!='>')
                {
                    if (string.charAt(i)!='|')
                    {
                        if (string.charAt(i)!=' ')
                        {
                            retStr+=string.charAt(i);
                            i++;
                        }
                        else
                        {
                            i++;
                        }
                    }
                    else{
                        if (id==2) outputArray[index].push(retStr);
                        if (id==4) outputArray[index].push(retStr);
                        if (id==5) outputArray[index].push(retStr);
                        if (id==6) outputArray[index].push(retStr);
                        if (id==7) outputArray[index].push(retStr);
                        if (id==8) outputArray[index].push(retStr);
                        retStr='';
                        i++;
                        id++;

                    }
                }
                else
                {
                    i++;
                    id=0;
                    index++;
                    outputArray[index] = new Array();

                }
            }
            else
            {
                seach = true;
            }


        }

        return outputArray;
    }
    private  function addBase() : void {
        if (addBaseBool) {
            addPointAction.addPoint(arrayAddPoints[indexAdd][0],arrayAddPoints[indexAdd][2],arrayAddPoints[indexAdd][1],arrayAddPoints[indexAdd][3],arrayAddPoints[indexAdd][5],arrayAddPoints[indexAdd][4]);
            addPointAction.addEventListener(Event.COMPLETE, addPointAction_completeHandler);
        }
    }

    private function addPointAction_completeHandler(event:Event):void {
        indexAdd++;
        trace(indexAdd);

        if (indexAdd!=arrayAddPoints.length) {
            addBase();
            trace(arrayAddPoints[indexAdd]);
        }
        else
        {
            indexAdd=0;
            addPointAction.removeEventListener(Event.COMPLETE, addPointAction_completeHandler);
            addBaseBool=false;
        }
    }
    private function rotationCam(e:Event) : void {
        if(rotationSost)
            rotationCamera();
    }

    private function enterFrameHandler1(event:Event):void {
        if (seconds>10)
        {
            allPoints[index][0].visible = true;
            if (proection_sost)
                allProection[index][0].visible = true;
            allProection[index][1] = true;

            index++;
            seconds=0;
        }
        seconds++;
        if (index>=allPoints.length-1)
        {
            seconds=0;
            index=0;
            removeEventListener(Event.ENTER_FRAME,enterFrameHandler1);
        }
    }
    private function rotationCamera() : void  {
        deg+=0.004;
//        plane.rotationZ-=0.01;
   /*     camera.x = plane.x+800*Math.cos(deg);
        camera.y = plane.y+600*Math.sin(deg);*/
       /* thumbus.thumbus.rotationX+=0.01;
        thumbus.thumbus.rotationY+=0.01;*/
        thumbus.rotationZ+=0.01;
        camera.lookAt(plane.x,plane.y,plane.z+100);
    }

    private function settingView_mouseOverHandler(event:MouseEvent):void {
     /*   if (settingVis)
        {
            timeLine.append(new TweenLite(settingView,0.2,{x:0,ease : Circ.easeOut}));
            settingVis = true;
        }
        else
        {
            timeLine.append(new TweenLite(settingView,0.2,{x:0-settingView.width/2,ease : Circ.easeOut}));
            settingVis = false;
        }*/

        timeLine.append(new TweenLite(settingView,0.2,{x:0,ease : Circ.easeOut}));
    }

    private function settingView_mouseOutHandler(event:MouseEvent):void {
        settingView.removeEventListener(MouseEvent.MOUSE_OUT, settingView_mouseOutHandler);
        settingView.addEventListener(MouseEvent.CLICK, settingView_mouseOverHandler);

        timeLine.append(new TweenLite(settingView,0.2,{x:-50,ease : Circ.easeOut}));
    }

    private function settingView_stop_rotateHandler(event:Event):void {
        if (rotationSost)
        {
            rotationSost=false;
        }
        else
        {
            rotationSost = true;
        }
    }

    private function settingView_proectionHandler(event:Event):void {
        if (proection_sost)
        {
            proection_sost = false;
            OfProection();
        }
        else
        {
            proection_sost = true;
            OnProection();
        }
//        addPointForStage();
    }



    private function stage_mouseDownHandler(event:MouseEvent):void {

        if (clickForbox)
        {
            clickPoint.x= event.stageX;
            clickPoint.y= event.stageY;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, plane_mouseMove3DHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
        }
    }

    private function stage_mouseUpHandler(event:MouseEvent):void {
        clickForbox = false;
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, plane_mouseMove3DHandler);
        stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
    }
    private function OfProection() : void {
        for (var i : int =0;i<allProection.length;i++)
        {
            allProection[i][0].visible = false;
        }
        for (var i : int =0;i<allPoints.length;i++)
        {
            var tn : TimelineLite = new TimelineLite();
            tn.append(new TweenLite(allPoints[i][0],0.5,{z:300}));
        }
    }
    private function OnProection() : void {
        for (var i : int =0;i<allProection.length;i++)
        {
            if (allProection[i][1])
                allProection[i][0].visible = true;
        }

        for (var i : int =0;i<allPoints.length;i++)
        {
            var tn : TimelineLite = new TimelineLite();
            tn.append(new TweenLite(allPoints[i][0],0.5,{z:allPoints[i][1]}));
        }

    }

    private function settingView_dinamicHandler(event:Event):void {
        if (dinamic)
        {
            dinamic=false;
        }
        else
        {
            dinamic=true;
        }
    }

    private function stage_keyUpHandler(event:KeyboardEvent):void {

        if (event.charCode==43)
        {
            timeLine.append(new TweenLite(camera,0.4,{x:camera.x-camera.x/10,y:camera.y-camera.y/10,z:camera.z-camera.z/10}))
     /*       camera.x-= camera.x/10;
            camera.y-= camera.y/10;
            camera.z-= camera.z/10;
     */   }
        if (event.charCode==45)
        {
            timeLine.append(new TweenLite(camera,0.4,{x:camera.x+camera.x/10,y:camera.y+camera.y/10,z:camera.z+camera.z/10}))
/*

            camera.x+= camera.x/10;
            camera.y+= camera.y/10;
            camera.z+= camera.z/10;
*/
        }

    }
    private function createRhumbus() {

        var thumbusMaterial_1 : FillMaterial = new FillMaterial(0x000000,1);
        var thumbusMaterial_2 : FillMaterial = new FillMaterial(0x222222,1);
        var thumbusMaterial_3 : FillMaterial = new FillMaterial(0x444444,1);
        var thumbusMaterial_4 : FillMaterial = new FillMaterial(0x666666,1);
        var thumbusMaterial_5 : FillMaterial = new FillMaterial(0x888888,1);
        var thumbusMaterial_6 : FillMaterial = new FillMaterial(0x332434,1);


        thumbus = new Box(100,100,100);

      /*  thumbus.addSurface(thumbusMaterial_1, 0, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_2, 6, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_3, 12, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_4, 18, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_5, 24, 2); //на каждую накладываем свою текстуру
        thumbus.addSurface(thumbusMaterial_6, 30, 2); //на каждую накладываем свою текстуру*/



        thumbus.x=0;
        thumbus.y=150;
        thumbus.z=100;
        rootContainer.addChild(thumbus);

        thumbus.addEventListener(MouseEvent3D.MOUSE_DOWN, thumbus_mouseDownHandler);

    }
    private function thumbus_mouseDownHandler(event:MouseEvent3D):void {
        clickPoint_x_y.x = event.localX;
        clickPoint_x_y.y = event.localY;
        clickPoint_z.x = event.localZ;
        thumbus.addEventListener(MouseEvent3D.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.addEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
    }
    private function thumbus_mouseMoveHandler(event:MouseEvent3D):void {
        thumbus.rotationX-=(event.localX-clickPoint_x_y.x)/100;
        thumbus.rotationY-=(event.localY-clickPoint_x_y.y)/100;
        thumbus.rotationZ-=(event.localZ-clickPoint_z.x)/100;
        clickPoint_x_y.x=event.localX;
        clickPoint_x_y.y=event.localY;
        clickPoint_z.x=event.localZ;
    }
    private function thumbus_mouseUp3DHandler(event:MouseEvent):void {
        thumbus.removeEventListener(MouseEvent3D.MOUSE_MOVE, thumbus_mouseMoveHandler);
        stage.removeEventListener(MouseEvent.MOUSE_UP, thumbus_mouseUp3DHandler);
    }

    private function settingView_BOTTOM_VIEWHandler(event:Event):void {
        rotationSost = false;
        timeLine.append(new TweenLite(thumbus,1,{rotationX : Math.PI/2}))
        timeLine_y.append(new TweenLite(thumbus,1,{rotationY : 0}))
        timeLine_z.append(new TweenLite(thumbus,1,{rotationZ : 0}))
        timeLine_camera_z.append(new TweenLite(camera,1,{z : 0}))
        timeLine_camera_z.append(new TweenLite(camera,1,{y : -800}))
    }

    private function settingView_LEFT_VIEWHandler(event:Event):void {
        timeLine.append(new TweenLite(thumbus,1,{rotationX : 0}))
        timeLine_y.append(new TweenLite(thumbus,1,{rotationY : 0}))
        timeLine_z.append(new TweenLite(thumbus,1,{rotationZ : 0}))
        timeLine_camera_z.append(new TweenLite(camera,1,{z : 0}))
        timeLine_camera_z.append(new TweenLite(camera,1,{y : -1000}))
        rotationSost = false;
    }

    private function settingView_ALL_VIEWHandler(event:Event):void {
        timeLine.append(new TweenLite(thumbus,1,{rotationX : 0}))
        timeLine_y.append(new TweenLite(thumbus,1,{rotationY : 0}))
        timeLine_z.append(new TweenLite(thumbus,1,{rotationZ : 0}))
        timeLine_camera_z.append(new TweenLite(camera,1,{z : 800}))
        timeLine_camera_z.append(new TweenLite(camera,1,{y : -800}))
    }
    private function createTextProp() : void {
        text_show_property_x.multiline = true;
        showPointProperty.addChild(text_show_property_x);
        text_show_property_x.width =50;
        text_show_property_x.text = 'null';
        text_show_property_x.y=20;

        text_show_property_y.multiline = true;
        showPointProperty.addChild(text_show_property_y);
        text_show_property_y.width =50;
        text_show_property_y.text = 'null';
        text_show_property_y.y=40;


        text_show_property_z.multiline = true;
        showPointProperty.addChild(text_show_property_z);
        text_show_property_z.width =50;
        text_show_property_z.text = 'null';
        text_show_property_z.y=60;


        text_show_property_title.multiline = true;
        showPointProperty.addChild(text_show_property_title);
        text_show_property_title.width =150;
        text_show_property_title.text = 'null';
        text_show_property_title.y=80;
    }
}
}
