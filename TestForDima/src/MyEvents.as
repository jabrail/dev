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
    public static const LOG_IN_FAIL  : String = "logInFail"
    public static const REGISTRATION  : String = "reg"
    public static const ADDTEST  : String = "addTest"
    public static const REGISTRATIONCLICK  : String = "clickreg"
    public static const REGCOMPLATE  : String = "regcomplete"
    public static const BACKSUBJECT  : String = "prevsubject"
    public static const BACKTEST  : String = "prevtest"
    public static const BACKREG  : String = "backtest"
    public static const BACKTESTING  : String = "backtesting"
    public static const CLICKTOTEST  : String = "fsdfgr"
    public function MyEvents() {
    }
}
}
