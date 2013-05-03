/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 04.04.13
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class ServerRelation extends Sprite{
    public static  var outputArray : Array = new Array();
    public static  var userArray : Array = new Array();
    public static  var subjectArray : Array = new Array();
    public static var eventdisp : EventDispatcher = new EventDispatcher();
    public  function ServerRelation() {

    }

    public static  function getTest() : void {
        var url : String = AplicationStaticString.MAIN_URL+'/main.php/';
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.type= 0;
        variables.prefix= 'rrrr';
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }
    public static function pointLoader_completeHandler(event:Event):void {

        outputArray = null;
        outputArray = new Array();
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.test)
        {

            if (property.attributes()!=null)
            {
                outputArray.push(new Array(property.attribute('id'),property.attribute('quation'),property.attribute('a'),property.attribute('b'),property.attribute('c'),property.attribute('d'),property.attribute('right'),property.attribute('prefix')));
            }
        }

       eventdisp.dispatchEvent(new Event(Event.COMPLETE));
    }
    public static  function pointLoader_ioErrorHandler(event:IOErrorEvent):void {
        trace(event.errorID);
    }

    public static  function pointLoader_securityErrorHandler(event:SecurityErrorEvent):void {
        trace(event.errorID);
    }
    public static function addUser(params: Array) : void {
        var url : String = AplicationStaticString.MAIN_URL+'/add.php';
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.login = params[0].text;
        variables.pass= params[1].text;
        variables.name= params[2].text;
        variables.lastName= params[3].text;
        variables.group= params[4].text;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, addUserComplate);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, addUser_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, addUser_securityErrorHandler);
    }

    public static function logIn(login:String = 'null',pass:String='null') : void {
        var url : String = AplicationStaticString.MAIN_URL+'/main.php';
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.login = login;
        variables.type = 2;
        variables.pass= pass;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, logInComplete);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, addUser_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, addUser_securityErrorHandler);
    }

    public static  function addUserComplate(event:Event):void {

        eventdisp.dispatchEvent(new Event(MyEvents.REGCOMPLATE));
    }
    public static  function addUser_ioErrorHandler(event:IOErrorEvent):void {
        trace(event.errorID);
    }

    public static  function addUser_securityErrorHandler(event:SecurityErrorEvent):void {
        trace(event.errorID);
    }

    public static function logInComplete(event:Event):void {

        userArray = null;
        userArray = new Array();
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.user)
        {

            if (property.attributes()!=null)
            {
                userArray.push(property.attribute('id'));
                userArray.push(property.attribute('name'));
                userArray.push(property.attribute('lastname'));
                userArray.push(property.attribute('group'));
            }
        }

        eventdisp.dispatchEvent(new Event(MyEvents.LOG_IN));
    }
    public static function addTest(params : Array) : void {
        var url : String = AplicationStaticString.MAIN_URL+'/addTest.php';
        var addTest: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.quation = params[0].text;
        variables.a= params[1].text;
        variables.b= params[2].text;
        variables.c= params[3].text;
        variables.d= params[4].text;
        variables.right= params[5].text;
        variables.prefix= params[6].text;
        variables.prefixSubject= params[7].text;
        request.data = variables;
        addTest.load(request);
        addTest.addEventListener(Event.COMPLETE, addTest_completeHandler);
        addTest.addEventListener(IOErrorEvent.IO_ERROR, addTest_ioErrorHandler);
        addTest.addEventListener(SecurityErrorEvent.SECURITY_ERROR, addTest_securityErrorHandler);
    }

    private static function addTest_completeHandler(event:Event):void {
    }

    private static function addTest_ioErrorHandler(event:IOErrorEvent):void {

    }

    private static function addTest_securityErrorHandler(event:SecurityErrorEvent):void {

    }
    public static function addSubject(params : Array) : void {
        var url : String = AplicationStaticString.MAIN_URL+'/addSubject.php';
        var Subject: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.name = params[0];

        request.data = variables;
        Subject.load(request);
        Subject.addEventListener(Event.COMPLETE, Subject_completeHandler);
        Subject.addEventListener(IOErrorEvent.IO_ERROR, Subject_ioErrorHandler);
        Subject.addEventListener(SecurityErrorEvent.SECURITY_ERROR, Subject_securityErrorHandler);
    }

    private static function Subject_completeHandler(event:Event):void {

    }

    private static function Subject_ioErrorHandler(event:IOErrorEvent):void {

    }

    private static function Subject_securityErrorHandler(event:SecurityErrorEvent):void {

    }
    public static function getSubgect():void {
        var url : String = AplicationStaticString.MAIN_URL+'/main.php/';
        var subjectLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.type= 3;
        request.data = variables;
        subjectLoader.load(request);
        subjectLoader.addEventListener(Event.COMPLETE, subjectLoader_completeHandler);
        subjectLoader.addEventListener(IOErrorEvent.IO_ERROR, subjectLoader_ioErrorHandler);
        subjectLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, subjectLoader_securityErrorHandler);

    }

    private static function subjectLoader_completeHandler(event:Event):void {
        subjectArray = null;
        subjectArray = new Array();
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.subject)
        {

            if (property.attributes()!=null)
            {
                subjectArray.push(new Array(property.attribute('id'),property.attribute('name')));
            }
        }

        eventdisp.dispatchEvent(new Event(Event.COMPLETE));
    }

    private static function subjectLoader_ioErrorHandler(event:IOErrorEvent):void {

    }

    private static function subjectLoader_securityErrorHandler(event:SecurityErrorEvent):void {

    }
}
}
