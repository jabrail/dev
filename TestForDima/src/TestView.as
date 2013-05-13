/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 04.04.13
 * Time: 13:46
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.core.TweenCore;
import com.greensock.plugins.BlurFilterPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Sprite;
import flash.events.Event;

public class TestView extends Sprite{
    private var timeline : TimelineLite = new TimelineLite();
    private var completeIndex : int =0;
    private var total:int=0;
    public function TestView(arraytest : Array) {
        TweenPlugin.activate([BlurFilterPlugin]);
        total = arraytest.length;
        for (var i:int=0;i<arraytest.length;i++)
       {
           var test:TestElement = new TestElement(arraytest[i]);
           test.x=i*(test.width);
           test.addEventListener(Event.COMPLETE, test_completeHandler);
           addChild(test);
       }
    }

    private function test_completeHandler(event:Event):void {
          completeIndex++;
        if (completeIndex==total)
        dispatchEvent(new Event(Event.COMPLETE));
        timeline.append(new TweenLite((event.target as TestElement), 1, {blurFilter:{blurX:5}}));
        ModalContainer.responses.push(new Array(ModalContainer.currentTest,(event.target as TestElement).id,(event.target as TestElement).varian))
        trace('current test',ModalContainer.currentTest,'id=',(event.target as TestElement).id,'   variant=',(event.target as TestElement).varian);
    }
}
}
