/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/14/13
 * Time: 12:37 PM
 * To change this template use File | Settings | File Templates.
 */
package interfaces {
import com.adobe.serialization.json.JSON;

import entities.AssessmentItemResult;

import entities.Credentials;

import entities.Group;
import entities.User;

import flash.display.Sprite;

public interface RestInterface {
    function setCredentials(credentials:Credentials):void;        // done
    function getGroupsOfTeacher(callback:Function):void;    // done
    function createAssessmentResult(assessmentId:String, studentId:String, itemId:String, result:AssessmentItemResult):void;
    function getUserDetails(callback:Function):User;        // done
    function getStudentResults(assessmentId:String, studentId:String, callback:Function):void;    // done
}
}
