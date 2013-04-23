/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 14.04.13
 * Time: 10:14
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldType;
[SWF(width="800", height="600",frameRate="60")]
public class Forms extends Sprite{
    private var arrayForText : Array = new Array();
    public function Forms() {
       singlIn();
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
        button.x=250;
        addChild(button);

    }
    private function createButton(text : String) : Sprite {
        var button : Sprite  = new Sprite();
        var button_fon : Sprite  = new Sprite();
        var hover: Sprite = new Sprite();
        var tf: TextField = new TextField();
        tf.defaultTextFormat = TextFormats.textFormat_3;
        tf.height=30;
        tf.width =200;
        tf.text = text;
        button_fon.graphics.beginFill(0xcccccc);
        button_fon.graphics.drawRect(0,0,tf.width,tf.height);
        hover.graphics.beginFill(0xcccccc,0.001);
        hover.graphics.drawRect(0,0,tf.width,tf.height);
        button_fon.addChild(tf);
        button.addChild(button_fon);
        button.addChild(hover);
         return button;
    }
    public function singlIn() : void
    {
        for (var i: int =0;i<2;i++)
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
            addChild((arrayForText[i] as TextField));
        }
        var button : Sprite = createButton('Войти');
        button.y=155+i*40;
        button.x=250;
        addChild(button);

    }

}
}
