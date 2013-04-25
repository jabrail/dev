/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.04.13
 * Time: 13:19
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class TextFormats {

        public static var textFormat_1 : TextFormat = new TextFormat();
        public static var textFormat_2 : TextFormat = new TextFormat();
        public static var textFormat_3 : TextFormat = new TextFormat();
        public function TextFormats() {
        }
        public static function init_Formats()  : void  {
            textFormat_2.size = 15;
            textFormat_2.color = 0x000000;
            textFormat_3.size = 15;
            textFormat_3.color = 0xFFFFFF;
            textFormat_3.align = TextFormatAlign.CENTER;
            textFormat_1.size = 20;
            textFormat_1.color = 0x000000;
            textFormat_1.align = TextFormatAlign.CENTER;

        }
}
}
