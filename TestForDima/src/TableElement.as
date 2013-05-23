/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 03.05.13
 * Time: 19:40
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;

public class TableElement extends Sprite{
    public var index: int = 0;
    public var id: int = 0;
    public function TableElement() {

    }
    public function init(str:String) : void {     // создание списка
        var background : Sprite = new Sprite();
        background.graphics.beginFill(0xffff00,0.4);
        background.graphics.drawRect(0,0,100,100);
        background.x=5;
        background.y=5;

        var tf: TextField = new TextField();
        tf.defaultTextFormat = TextFormats.textFormat_4;
        tf.multiline = true;
        tf.width=100;
        tf.height= 100;
        tf.text = str;
        tf.x=10;
        tf.y=10;

        var arrow : Bitmap = new Asset.Arrow();
        arrow.height=20;
        arrow.width =30;
        arrow.x=750;
        arrow.y=15;

        var hover:Hover = new Hover()
        hover.index = index;
        hover.id = id;
        hover.graphics.beginFill(0x000000,0.01);
        hover.graphics.drawRect(0,0,100,100);

        var mainContainer : Sprite = new Sprite();
        addChild(background);
        addChild(tf);
       // addChild(arrow);
        addChild(hover);
    }
}
}
