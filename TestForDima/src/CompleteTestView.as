/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 13.05.13
 * Time: 8:22
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.text.TextField;

public class CompleteTestView extends Sprite {
    private var responsArray : Array;
    private var testArray : Array;
    private var rightResponse : int=0;
    public function CompleteTestView(responseArray : Array,testArray:Array) {
        this.responsArray = responseArray;
        this.testArray= testArray;

    }
    public function countRespons(): int {
    for (var i:int=0;i<responsArray.length;i++)
    {
        for(var k:int = 0;k<testArray.length;k++)
        {
            var vrArray : Array = testArray[k];
        if (vrArray[0]==responsArray[i][1])
        {
            if (vrArray[6]==responsArray[i][2])
            rightResponse++;
        }
        }
    }
        return rightResponse;
    }
    public function outputResult():void {
        var text : TextField = new TextField();
        text.defaultTextFormat = TextFormats.textFormat_3;
        text.width = 500;
        text.text='Вы набрали   '+((rightResponse/testArray.length)*100).toString()+'   процентов';
        addChild(text);
    }
}
}
