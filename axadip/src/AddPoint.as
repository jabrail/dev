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

public class AddPoint extends Sprite{
    public function AddPoint() {


    }
    public function addPoint(month : String ='null', x: String ='null',y: String ='null',z: String ='null',title : String='null',magnituda : String = '',url : String='http://jabrail.myjino.ru/axa/add/add.php/') : void {
        var pointLoader: URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.month = month;
        variables.x= x;
        variables.y= y;
        variables.z= z;
        variables.title= title;
        variables.magnituda = magnituda;
        request.data = variables;
        pointLoader.load(request);
        pointLoader.addEventListener(Event.COMPLETE, pointLoader_completeHandler);
        pointLoader.addEventListener(IOErrorEvent.IO_ERROR, pointLoader_ioErrorHandler);
        pointLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, pointLoader_securityErrorHandler);
    }

    private function pointLoader_completeHandler(event:Event):void {
dispatchEvent(new Event(Event.COMPLETE));
    }

    private function pointLoader_ioErrorHandler(event:IOErrorEvent):void {
          trace('eror')
    }

    private function pointLoader_securityErrorHandler(event:SecurityErrorEvent):void {
               trace('eror')
    }
}
}
