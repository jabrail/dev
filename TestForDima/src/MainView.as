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
    private var tests : TestForDima = new TestForDima();
    private var timeLine_1 : TimelineLite = new TimelineLite();
    private var timeLine_2 : TimelineLite = new TimelineLite();
    private var subsellect : SellectSubject = new SellectSubject();
    private var sellctTest : SellectTest = new SellectTest();
    private var user : User;
    public function MainView() {                               //  Конструктор
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

    private function forms_logInHandler(event:Event):void {      // Событие нажатия кнопки "войти"
        forms.removeEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.removeEventListener(MyEvents.REGISTRATION, forms_regHandler);
           ServerRelation.logIn(forms.arrayForTextIN[0].text,forms.arrayForTextIN[1].text);
            ServerRelation.eventdisp.addEventListener(MyEvents.LOG_IN, logInHandler);
            ServerRelation.eventdisp.addEventListener(MyEvents.LOG_IN_FAIL, forms_logInFailHandler);
    }

    private function logInHandler(event:Event):void {     // Успешное прохождение аутентификации
        forms.removeEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.removeEventListener(MyEvents.REGISTRATION, forms_regHandler);
        user = new User(ServerRelation.userArray)
        addChild(subsellect);
        subsellect.init();
        subsellect.addEventListener(Event.COMPLETE, subsellect_completeHandler);
        subsellect.addEventListener(MyEvents.BACKSUBJECT, subsellect_prevsubjectHandler);
        transition(forms.logInContainer,subsellect);
      /*     forms.addTestForm();
        forms.addEventListener(MyEvents.ADDTEST, forms_addTestHandler);
        transition(forms.logInContainer,forms.addTestContainer);*/
    }

    private function forms_regHandler(event:Event):void {       // Нажатие кнопки регистрации
        forms.removeEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.removeEventListener(MyEvents.REGISTRATION, forms_regHandler);
        forms.registration();
        forms.addEventListener(MyEvents.REGISTRATIONCLICK, formsreg_clickregHandler);
        forms.addEventListener(MyEvents.BACKREG, forms_backtestHandler);
        transition(forms.logInContainer,forms.registrationContainer);
    }
    private function transition(obj1: DisplayObject,obj2: DisplayObject) : void{   // Переходы между окнами
        obj2.x = 400;
        obj2.y = 300;
        obj2.alpha=0;
        obj2.scaleX=0.01;
        obj2.scaleY=0.01;
        timeLine_1.append(new TweenLite(obj1,0.5,{y:300,x:400,alpha:0,scaleX:0,scaleY:0}));
        timeLine_1.append(new TweenLite(obj2,1,{x:0,y:0, alpha:1,scaleX:1,scaleY:1}));


    }

    private function formsreg_clickregHandler(event:Event):void {    // окончание ввода регистрационных данных и нажатие кнопки регистрации
        forms.addEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.addEventListener(MyEvents.REGISTRATION, forms_regHandler);
        ServerRelation.addUser(forms.arrayReg);
        ServerRelation.eventdisp.addEventListener(MyEvents.REGCOMPLATE, regcompleteHandler);
    }

    private function regcompleteHandler(event:Event):void {   // отправка данных на сервер
        forms.singlIn();
        transition(forms.registrationContainer,forms.logInContainer);
    }

    private function forms_addTestHandler(event:Event):void {    //добавление теста
        ServerRelation.addTest(forms.testAddArray);
        forms.addTestForm();
    }

    private function subsellect_completeHandler(event:Event):void {  // оканчание выбора теста
        addChild(sellctTest);
        sellctTest.init();
        sellctTest.addEventListener(Event.COMPLETE, sellctTest_completeHandler);
        sellctTest.addEventListener(MyEvents.BACKTEST, sellctTest_prevtestHandler);
        transition(subsellect,sellctTest);
    }

    private function sellctTest_completeHandler(event:Event):void {   // выбор теста
        tests.init();
        tests.addEventListener(MyEvents.BACKTESTING, tests_backtestingHandler);
        addChild(tests)
        transition(sellctTest,tests);

    }

    private function forms_logInFailHandler(event:Event):void {     // Если не введены не правильные данные при входе
        forms.addEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.addEventListener(MyEvents.REGISTRATION, forms_regHandler);
        forms.notTrueUser();
    }

    private function forms_backtestHandler(event:Event):void {     // нажатие на кнопку назад в окне выбора теста
        forms.addEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.addEventListener(MyEvents.REGISTRATION, forms_regHandler);
        transition(forms.registrationContainer,forms.logInContainer);
    }

    private function subsellect_prevsubjectHandler(event:Event):void {    // нажатие на кнопку назад в окне выбора предмета
        forms.addEventListener(MyEvents.LOG_IN, forms_logInHandler);
        forms.addEventListener(MyEvents.REGISTRATION, forms_regHandler);
        transition(subsellect,forms.logInContainer);
    }

    private function sellctTest_prevtestHandler(event:Event):void {
        transition(sellctTest,subsellect);
    }

    private function tests_backtestingHandler(event:Event):void {   // нажатие на кнопку назад в прохождении теста
        transition(tests,sellctTest);
    }
}
}
