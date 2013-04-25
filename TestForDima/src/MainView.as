/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 24.04.13
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;

import net.nrftw.iphone.components.Button;
[SWF(width="800", height="600",frameRate="60")]
public class MainView extends Sprite {
    [Embed(source = '/images/fon.png')]
    private var Background:Class;
    private var forms : Forms = new Forms();
    public function MainView() {
        var background : Bitmap = new Background();
        background.width=800;
        background.height=600;
        addChild(background);
        forms.singlIn();
        addChild(forms);
    }
    private function but() : void {

    }
}
}
