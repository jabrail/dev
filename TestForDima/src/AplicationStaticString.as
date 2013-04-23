/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 04.04.13
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.net.SharedObject;

public class AplicationStaticString {
    public static var MAIN_URL : String = 'http://jabrail.myjino.ru/dima/add'
    public static var SHARED_APP : SharedObject;
    public function AplicationStaticString() {

    }
    public static function init() : void {
        SHARED_APP = SharedObject.getLocal("dima_app");
        if (SHARED_APP.data.MAIN_URL == null)
        {

        }
    }
    public static function urlInput() : void {

    }
}
}
