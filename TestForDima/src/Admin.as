/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 21.05.13
 * Time: 22:23
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.Event;

[SWF(width="800", height="600",frameRate="60")]

public class Admin extends Sprite{
    private var forms : Forms = new Forms();

    public function Admin() {
        forms.addTestForm();
        forms.addEventListener(MyEvents.ADDTEST, forms_addTestHandler);
        addChild(forms);

    }

    private function forms_addTestHandler(event:Event):void {
        ServerRelation.addTest(forms.testAddArray);
        ServerRelation.eventdisp.addEventListener(MyEvents.ADDTEST, addTestHandler);

    }

    private function addTestHandler(event:Event):void {
        forms.addTestForm();
    }
}
}
