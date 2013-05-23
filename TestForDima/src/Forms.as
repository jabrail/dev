/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 14.04.13
 * Time: 10:14
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.core.TweenCore;
import com.greensock.easing.Bounce;
import com.greensock.easing.Elastic;
import com.greensock.plugins.GlowFilterPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
[SWF(width="800", height="600",frameRate="60")]
public class Forms extends Sprite{
    public var arrayReg : Array = new Array();
    public var arrayForTextIN : Array = new Array();
    [Embed(source = '/images/background_button.png')]
    private var Background:Class;
    [Embed(source = '/images/background_button_reg.png')]
    private var Background_reg:Class;

    private var timeLine : TimelineLite = new TimelineLite();
    private var logInSprite : Sprite = new Sprite();
    public var addTestContainer : Sprite = new Sprite();
    public var logInContainer : Sprite = new Sprite();
    public var registrationContainer : Sprite = new Sprite();
    public var testAddArray : Array = new Array();
    public function Forms() {
        TweenPlugin.activate([GlowFilterPlugin]);
    }
    public function registration() : void      // окно регистрации
    {

        registrationContainer.removeChildren();
        TextFormats.init_Formats();
        for (var i: int =0;i<5;i++)
      {
          arrayReg[i] = new TextField();
          (arrayReg[i] as TextField).background = true;
          (arrayReg[i] as TextField).backgroundColor = 0xDDDDDD;
          (arrayReg[i] as TextField).border = true;
          (arrayReg[i] as TextField).borderColor=0x000000;
          (arrayReg[i] as TextField).type = TextFieldType.INPUT;
          (arrayReg[i] as TextField).defaultTextFormat = TextFormats.textFormat_1;
          (arrayReg[i] as TextField).width = 200;
          (arrayReg[i] as TextField).height = 30;
          (arrayReg[i] as TextField).x = 300;
          (arrayReg[i] as TextField).y = 150+i*40;
          (arrayReg[i] as TextField).addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
          (arrayReg[i] as TextField).addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);

          if (i==0)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Login';
              tf.x=30;
              tf.y=155+i*40;
              registrationContainer.addChild(tf);
          }
          if (i==1)
          {
              (arrayReg[i] as TextField).displayAsPassword = true;
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Пароль';
              tf.x=30;
              tf.y=155+i*40;
              registrationContainer.addChild(tf);
          }
          if (i==2)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Имя';
              tf.x=30;
              tf.y=155+i*40;
              registrationContainer.addChild(tf);
          }
          if (i==3)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Фамилия';
              tf.x=30;
              tf.y=155+i*40;
              registrationContainer.addChild(tf);
          }
          if (i==4)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Группа';
              tf.x=30;
              tf.y=155+i*40;
              registrationContainer.addChild(tf);
          }
          registrationContainer.addChild((arrayReg[i] as TextField));
      }
        var button : Sprite = createButton('Зарегистрироваться');
        button.addEventListener(MouseEvent.CLICK, registration_clickHandle);
        button.y=155+i*40;
        button.x=303;
        registrationContainer.addChild(button);
        addChild(registrationContainer);
        var arrow : Bitmap = new Asset.ArrowBack();
        var sp_arrow : Sprite = new Sprite();
        arrow.height=80;
        arrow.width =80;
        arrow.x=-40;
        arrow.y=-40;
        sp_arrow.x=40;
        sp_arrow.y=560;
        sp_arrow.addChild(arrow);
        registrationContainer.addChild(sp_arrow);
        sp_arrow.addEventListener(MouseEvent.MOUSE_MOVE, arrow_mouseMoveHandler);
        sp_arrow.addEventListener(MouseEvent.MOUSE_OUT, arrow_mouseOutHandler);
        sp_arrow.addEventListener(MouseEvent.CLICK, arrow_clickHandler);


    }
    private function createButton(text : String) : Sprite {        // создание кнопки
        var button : Sprite  = new Sprite();
        var button_fon : Sprite  = new Sprite();
        var hover: Sprite = new Sprite();
        var tf: TextField = new TextField();
        tf.defaultTextFormat = TextFormats.textFormat_1;
        tf.y=10;
        tf.height=30;
        tf.width =200;
        tf.text = text;
    var btm : Bitmap = new Background();
        btm.width =200;
        btm.height=50;
        hover.graphics.beginFill(0x000000,0.01);
        hover.graphics.drawRect(0,0,btm.width,btm.height);
        button.addChild(btm);
        button_fon.addChild(tf);
        button.addChild(button_fon);
        button.addChild(hover);
         return button;
    }
    private function createButtonReg(text : String) : Sprite {   // создание кнопки регистрации
        var button : Sprite  = new Sprite();
        var button_fon : Sprite  = new Sprite();
        var hover: Sprite = new Sprite();
        var tf: TextField = new TextField();
        tf.defaultTextFormat = TextFormats.textFormat_1;
        tf.y=10;
        tf.height=30;
        tf.width =200;
        tf.text = text;
        var btm : Bitmap = new Background_reg();
        btm.width =200;
        btm.height=50;
        hover.graphics.beginFill(0x000000,0.01);
        hover.graphics.drawRect(0,0,btm.width,btm.height);
        button.addChild(btm);
        button_fon.addChild(tf);
        button.addChild(button_fon);
        button.addChild(hover);
        return button;
    }
    public function singlIn() : void    // окно ввода при входе
    {
        TextFormats.init_Formats();
        logInSprite.removeChildren();
        addChild(logInSprite);
        for (var i: int =0;i<2;i++)
        {
            arrayForTextIN[i] = new TextField();
            (arrayForTextIN[i] as TextField).background = true;
            (arrayForTextIN[i] as TextField).backgroundColor = 0xDDDDDD;
            (arrayForTextIN[i] as TextField).border = true;
            (arrayForTextIN[i] as TextField).borderColor=0x000000;
            (arrayForTextIN[i] as TextField).type = TextFieldType.INPUT;
            (arrayForTextIN[i] as TextField).defaultTextFormat = TextFormats.textFormat_1;
            (arrayForTextIN[i] as TextField).width = 200;
            (arrayForTextIN[i] as TextField).addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
            (arrayForTextIN[i] as TextField).addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
            (arrayForTextIN[i] as TextField).height = 30;
            (arrayForTextIN[i] as TextField).x = 300;
            (arrayForTextIN[i] as TextField).y = 150+i*80;

            if (i==0)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Login';
                tf.x=380;
                tf.y=115;
                logInContainer.addChild(tf);
            }
            if (i==1)
            {
                (arrayForTextIN[i] as TextField).displayAsPassword = true;
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Password';
                tf.x=370;
                tf.y=155+i*40;
                logInContainer.addChild(tf);
            }
            logInSprite.addChild((arrayForTextIN[i] as TextField));
        }
        logInContainer.addChild(logInSprite);
        var button : Sprite = createButton('Войти');
        button.y=155+i*80;
        button.x=303;
        logInContainer.addChild(button);
        button.addEventListener(MouseEvent.MOUSE_DOWN, button_mouseDownHandler);

        var button_reg : Sprite = createButtonReg('Регистрация');
        button_reg.addEventListener(MouseEvent.MOUSE_UP, button_reg_mouseUpHandler);
        button_reg.y=155+(i+1)*72;
        button_reg.x=303;
        logInContainer.addChild(button_reg);
        addChild(logInContainer);

    }


    private function focusOutHandler(event:FocusEvent):void {
        timeLine.append(new TweenLite((event.target as TextField),0.4,{glowFilter:{color:0x3366ff, alpha:0, blurX:30, blurY:30}}));
    }
    public function notTrueUser() : void   // ошибочный ввод данных при входе
    {
                timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
         timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
         timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
         timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
         timeLine.append(new TweenLite(logInSprite,0.1,{x:0}));
    }

    private function focusInHandler(event:FocusEvent):void {

        timeLine.append(new TweenLite((event.target as TextField),0.4,{glowFilter:{color:0x3366ff, alpha:1, blurX:30, blurY:30}}));

    }

    private function button_mouseDownHandler(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.LOG_IN));
/*        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:0}));*/
    }


    private function button_reg_mouseUpHandler(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.REGISTRATION));

    }
    public function addTestForm(): void {      // форма добавления тестов
        TextFormats.init_Formats();
         addTestContainer.removeChildren();
        for (var i: int =0;i<8;i++)
        {
            testAddArray[i] = new TextField();
            (testAddArray[i] as TextField).background = true;
            (testAddArray[i] as TextField).backgroundColor = 0xDDDDDD;
            (testAddArray[i] as TextField).border = true;
            (testAddArray[i] as TextField).borderColor=0x000000;
            (testAddArray[i] as TextField).type = TextFieldType.INPUT;
            (testAddArray[i] as TextField).defaultTextFormat = TextFormats.textFormat_1;
            (testAddArray[i] as TextField).width = 200;
            (testAddArray[i] as TextField).height = 30;
            (testAddArray[i] as TextField).x = 300;
            (testAddArray[i] as TextField).y = 150+i*40;
            (testAddArray[i] as TextField).addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
            (testAddArray[i] as TextField).addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);

            if (i==0)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Вопрос';
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==1)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Вариант A';
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==2)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Вариант B';
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==3)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Вариант C';
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==4)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Вариант D';
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==5)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Правильный вариант';
                tf.width=300;
                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            if (i==6)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Название теста';
                tf.x=30;
                tf.y=155+i*40;
                tf.width=300;
                addTestContainer.addChild(tf);
            }
            if (i==7)
            {
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Название предмета';
                tf.width=300;

                tf.x=30;
                tf.y=155+i*40;
                addTestContainer.addChild(tf);
            }
            addTestContainer.addChild((testAddArray[i] as TextField));
        }
        var button : Sprite = createButton('Добавить');
        button.addEventListener(MouseEvent.CLICK, addTest_clickHandler);
        button.y=155+i*40;
        button.x=303;
        addTestContainer.addChild(button);
        addChild(addTestContainer);

    }

    private function addTest_clickHandler(event:MouseEvent):void {    // событие нажатия кнопку добавить тест
          dispatchEvent(new Event(MyEvents.ADDTEST));
    }

    private function registration_clickHandle(event:MouseEvent):void {   // нажатие на кнопку регистрация
        dispatchEvent(new Event(MyEvents.REGISTRATIONCLICK))
    }
    private function arrow_mouseMoveHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30}}));
    }

    private function arrow_mouseOutHandler(event:MouseEvent):void {
        new TimelineLite().append(new TweenLite(event.target, 0.3, {glowFilter:{color:0xffff00, alpha:0, blurX:30, blurY:30}}));
    }

    private function arrow_clickHandler(event:MouseEvent):void {     // нажатие на кнопку назад
        new TimelineLite().append(new TweenLite(event.target, 0.5, {scaleX: 0.9,scaleY:0.9, ease:Bounce.easeOut}));
        dispatchEvent(new Event(MyEvents.BACKREG));
    }
}
}
