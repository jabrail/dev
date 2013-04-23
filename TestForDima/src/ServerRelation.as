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
    public static var eventdisp : EventDispatcher = new EventDispatcher();
    public  function ServerRelation() {
        addUser();
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
    public static function addUser(login:String = 'null',name : String='null', lastName : String='null',pass:String='null',group:String='null') : void {
        var url : String = AplicationStaticString.MAIN_URL+'/add.php';
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.login = login;
        variables.name= name;
        variables.lastName= lastName;
        variables.pass= pass;
        variables.group= group;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, addUserComplate);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, addUser_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, addUser_securityErrorHandler);
    }
    public static  function addUserComplate(event:Event):void {

        eventdisp.dispatchEvent(new Event(Event.COMPLETE));
    }
    public static  function addUser_ioErrorHandler(event:IOErrorEvent):void {
        trace(event.errorID);
    }

    public static  function addUser_securityErrorHandler(event:SecurityErrorEvent):void {
        trace(event.errorID);
    }
}
}
