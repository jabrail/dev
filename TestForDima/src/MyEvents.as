/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 25.04.13
 * Time: 10:46
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.events.EventDispatcher;

public class MyEvents extends EventDispatcher{
    public static const LOG_IN  : String = "logIn"
    public static const REGISTRATION  : String = "reg"
    public static const ADDTEST  : String = "addTest"
    public static const REGISTRATIONCLICK  : String = "clickreg"
    public static const REGCOMPLATE  : String = "regcomplete"
    public function MyEvents() {
    }
}
}
