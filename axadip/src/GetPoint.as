/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 02.03.13
 * Time: 17:32
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class GetPoint extends Sprite{
    public var outputArray : Array;
    public function GetPoint() {

    }
    public function getPointMonth(month : String ='null',month_2 : String ='null',url : String='http://jabrail.myjino.ru/axa/add/main.php/') : void {
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.date_1 = month;
        variables.date_2 = month_2;
        variables.type= 0;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }
    public function getPointDeep( min : String = '', max : String = '', url : String='http://jabrail.myjino.ru/axa/add/main.php/') : void {
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.type= 1;
        variables.z_max= max;
        variables.z_min= min;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }
    public function getPoinMagnitude(min : String = '', max : String = '', url : String='http://jabrail.myjino.ru/axa/add/main.php/') : void {
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.type= 2;
        variables.m_max= max;
        variables.m_min= min;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }

    public function geAlltPoints(url : String='http://jabrail.myjino.ru/axa/add/main.php/') : void {
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.type= 5;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }


    private function pointLoader_completeHandler(event:Event):void {

        outputArray = null;
        outputArray = new Array();
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.point)
        {

            if (property.attributes()!=null)
            {
               outputArray.push(new Array(property.attribute('x'),property.attribute('y'),property.attribute('z'),property.attribute('month'),property.attribute('magnituda'),property.attribute('title')));
            }
        }

      dispatchEvent(new Event(Event.COMPLETE));
    }

    private function pointLoader_ioErrorHandler(event:IOErrorEvent):void {
        trace(event.errorID);
    }

    private function pointLoader_securityErrorHandler(event:SecurityErrorEvent):void {
        trace(event.errorID);
    }
    public function getArray() : Array {
        return outputArray;
    }
}
}