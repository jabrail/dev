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
    public function TestView(arraytest : Array) {
       for (var i:int=0;i<arraytest.length;i++)
       {
           var test:TestElement = new TestElement(arraytest[i]);
           test.x=i*(test.width);
           test.addEventListener(Event.COMPLETE, test_completeHandler);
           addChild(test);
       }
    }

    private function test_completeHandler(event:Event):void {
        TweenPlugin.activate([BlurFilterPlugin]);
        timeline.append(new TweenLite((event.target as TestElement), 1, {blurFilter:{blurX:5}}));
        trace('id=',(event.target as TestElement).id,'   variant=',(event.target as TestElement).varian);
    }
}
}
