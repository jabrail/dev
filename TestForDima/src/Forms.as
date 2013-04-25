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
    private var arrayForText : Array = new Array();
    private var arrayForTextIN : Array = new Array();
    [Embed(source = '/images/background_button.png')]
    private var Background:Class;
    [Embed(source = '/images/background_button_reg.png')]
    private var Background_reg:Class;

    private var timeLine : TimelineLite = new TimelineLite();
    private var logInSprite : Sprite = new Sprite();

    public function Forms() {
        TweenPlugin.activate([GlowFilterPlugin]);
    }
    public function registration() : void
    {
      for (var i: int =0;i<5;i++)
      {
          TextFormats.init_Formats();
          arrayForText[i] = new TextField();
          (arrayForText[i] as TextField).border = true;
          (arrayForText[i] as TextField).borderColor=0x000000;
          (arrayForText[i] as TextField).type = TextFieldType.INPUT;
          (arrayForText[i] as TextField).defaultTextFormat = TextFormats.textFormat_1;
          (arrayForText[i] as TextField).width = 200;
          (arrayForText[i] as TextField).height = 30;
          (arrayForText[i] as TextField).x = 300;
          (arrayForText[i] as TextField).y = 150+i*40;

          if (i==0)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Login';
              tf.x=30;
              tf.y=155+i*40;
              addChild(tf);
          }
          if (i==1)
          {
              (arrayForText[i] as TextField).displayAsPassword = true;
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Пароль';
              tf.x=30;
              tf.y=155+i*40;
              addChild(tf);
          }
          if (i==2)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Имя';
              tf.x=30;
              tf.y=155+i*40;
              addChild(tf);
          }
          if (i==3)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Фамилия';
              tf.x=30;
              tf.y=155+i*40;
              addChild(tf);
          }
          if (i==4)
          {
              var tf : TextField = new TextField();
              tf.defaultTextFormat = TextFormats.textFormat_2;
              tf.text = 'Группа';
              tf.x=30;
              tf.y=155+i*40;
              addChild(tf);
          }
          addChild((arrayForText[i] as TextField));
      }
        var button : Sprite = createButton('Зарегистрироваться');
        button.y=155+i*40;
        button.x=350;
        addChild(button);

    }
    private function createButton(text : String) : Sprite {
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
    private function createButtonReg(text : String) : Sprite {
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
    public function singlIn() : void
    {

        addChild(logInSprite);
        for (var i: int =0;i<2;i++)
        {
            TextFormats.init_Formats();
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
                addChild(tf);
            }
            if (i==1)
            {
                (arrayForTextIN[i] as TextField).displayAsPassword = true;
                var tf : TextField = new TextField();
                tf.defaultTextFormat = TextFormats.textFormat_2;
                tf.text = 'Password';
                tf.x=370;
                tf.y=155+i*40;
                addChild(tf);
            }
            logInSprite.addChild((arrayForTextIN[i] as TextField));
        }
        var button : Sprite = createButton('Войти');
        button.y=155+i*80;
        button.x=303;
        addChild(button);
        button.addEventListener(MouseEvent.MOUSE_DOWN, button_mouseDownHandler);

        var button_reg : Sprite = createButtonReg('Регистрация');
        button_reg.y=155+(i+1)*72;
        button_reg.x=303;
        addChild(button_reg);

    }


    private function focusOutHandler(event:FocusEvent):void {
        timeLine.append(new TweenLite((event.target as TextField),0.4,{glowFilter:{color:0x3366ff, alpha:0, blurX:30, blurY:30}}));
    }

    private function focusInHandler(event:FocusEvent):void {

        timeLine.append(new TweenLite((event.target as TextField),0.4,{glowFilter:{color:0x3366ff, alpha:1, blurX:30, blurY:30}}));

    }

    private function button_mouseDownHandler(event:MouseEvent):void {
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x+30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:logInSprite.x-30}));
        timeLine.append(new TweenLite(logInSprite,0.1,{x:0}));
    }
}
}
