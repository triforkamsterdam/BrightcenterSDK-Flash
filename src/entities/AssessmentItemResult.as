/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/15/13
 * Time: 3:08 PM
 * To change this template use File | Settings | File Templates.
 */
package entities {
public class AssessmentItemResult {

    var student:Student;

    private var _attempts:int;
    private var _duration:int;
    private var _score:int;
    private var _completionStatus:String;

    public function AssessmentItemResult() {
    }


    public function get attempts():int {
        return _attempts;
    }

    public function set attempts(value:int):void {
        _attempts = value;
    }

    public function get duration():int {
        return _duration;
    }

    public function set duration(value:int):void {
        _duration = value;
    }

    public function get score():int {
        return _score;
    }

    public function set score(value:int):void {
        _score = value;
    }

    public function get completionStatus():String {
        return _completionStatus;
    }

    public function set completionStatus(value:String):void {
        _completionStatus = value;
    }
}
}
