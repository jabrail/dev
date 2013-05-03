/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 24.04.13
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;

import net.nrftw.iphone.components.Button;
[SWF(width="800", height="600",frameRate="60")]
public class MainView extends Sprite {
    [Embed(source = '/images/fon.png')]
    private var Background:Class;
    private var forms : Forms = new Forms();
    private var tests : TestForDima;
    private var timeLine_1 : TimelineLite = new TimelineLite();
    private var timeLine_2 : TimelineLite = new TimelineLite();
    private var subsellect : SellectSubject = new SellectSubject();
    private var user : User;
    public function MainView() {
        var background : Bitmap = new Background();
        background.width=800;
        background.height=600;
        addChild(background);
        forms.singlIn();
        forms.addEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.addEventListener(MyEvents.REGISTRATION, forms_regHandler);
        addChild(forms);
    }
    private function but() : void {

    }

    private function forms_logInHandler(event:Event):void {
           ServerRelation.logIn(forms.arrayForTextIN[0].text,forms.arrayForTextIN[1].text);
            ServerRelation.eventdisp.addEventListener(MyEvents.LOG_IN, logInHandler);
    }

    private function logInHandler(event:Event):void {

        user = new User(ServerRelation.userArray)
        addChild(subsellect);
        subsellect.init();
        transition(forms.logInContainer,subsellect);
      /*     forms.addTestForm();
        forms.addEventListener(MyEvents.ADDTEST, forms_addTestHandler);
        transition(forms.logInContainer,forms.addTestContainer);*/
    }

    private function forms_regHandler(event:Event):void {
        forms.registration();
        forms.addEventListener(MyEvents.REGISTRATIONCLICK, formsreg_clickregHandler);
        transition(forms.logInContainer,forms.registrationContainer);
    }
    private function transition(obj1: DisplayObject,obj2: DisplayObject) : void{
        obj2.x = 800;
        timeLine_1.append(new TweenLite(obj2,1,{x:0}));
        timeLine_2.append(new TweenLite(obj1,1,{x:-800}));

    }

    private function formsreg_clickregHandler(event:Event):void {
        ServerRelation.addUser(forms.arrayReg);
        ServerRelation.eventdisp.addEventListener(MyEvents.REGCOMPLATE, regcompleteHandler);
    }

    private function regcompleteHandler(event:Event):void {
        forms.singlIn();
        transition(forms.registrationContainer,forms.logInContainer);
    }

    private function forms_addTestHandler(event:Event):void {
        ServerRelation.addTest(forms.testAddArray);
        forms.addTestForm();
    }
}
}
