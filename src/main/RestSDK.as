/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/14/13
 * Time: 12:34 PM
 * To change this template use File | Settings | File Templates.
 */
package main {
import com.adobe.net.URI;
import com.adobe.protocols.dict.events.ErrorEvent;
import com.adobe.serialization.json.JSON;
import com.adobe.serialization.json.JSONDecoder;
import com.adobe.serialization.json.JSONEncoder;
import com.hurlant.util.Base64;

import entities.AssessmentItemResult;

import entities.Credentials;
import entities.Group;
import entities.User;

import flash.display.Sprite;

import flash.events.Event;

import flash.events.TimerEvent;
import flash.net.URLLoader;

import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.ByteArray;
import flash.utils.Timer;
import flash.utils.getTimer;

import interfaces.RestInterface;

import org.httpclient.HttpClient;
import org.httpclient.HttpRequest;
import org.httpclient.events.HttpDataEvent;
import org.httpclient.events.HttpDataListener;
import org.httpclient.events.HttpResponseEvent;
import org.httpclient.events.HttpStatusEvent;
import org.httpclient.http.Get;
import org.httpclient.http.Post;

public class RestSDK implements RestInterface{

    var credentials:Credentials;
    var user:User;

    private var serverURL:String = "https://nightly-brightcenter.trifork.nl/";
    private var sandboxURL:String = "http://localhost:8080/"

    public function RestSDK() {

    }

    public function setCredentials(credentials:Credentials):void {
        this.credentials = credentials;
    }

    public function getCredentials() {
        return credentials;
    }

    public function setUser(user:User) {
        this.user = user;
    }

    public function getUser():User {
        return this.user;
    }

    /**
     * Function to receive the groups and students of the logged in teacher
     * @param callback a callback function to return the groups
     */
    public function getGroupsOfTeacher(callback:Function):void {
        var client:HttpClient = new HttpClient();
        var listener:HttpDataListener = new HttpDataListener();
        var uri:URI = new URI("https://tst-brightcenter.trifork.nl/api/groups");
        var request:HttpRequest = new Get();
        setAuthorizationHeader(request);
        var groupString:String;
        var groups:Array;
        client.listener.onStatus = function (event:HttpStatusEvent):void {
            // Notified of response (with headers but not content)
        };

        client.listener.onData = function (event:HttpDataEvent):void {
            groupString = event.readUTFBytes();
        };

        client.listener.onComplete = function (event:HttpResponseEvent):void {
            groups = com.adobe.serialization.json.JSON.decode(groupString);
            callback(groups);
        };

        client.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.message;
        };

        client.request(uri, request);
    }

    /**
     * Function to create an assessment result item for a student
     * @param assessmentId the id of the assessment
     * @param studentId the id of the student
     * @param itemId the id of the question
     */
    public function createAssessmentResult(assessmentId:String, studentId:String, itemId:String, result:AssessmentItemResult):void {
        var client:HttpClient = new HttpClient();
        var uri:URI = new URI("https://tst-brightcenter.trifork.nl/api/assessment/" + assessmentId + "/student/" + studentId + "/assessmentItemResult/" + itemId);

        client.listener.onData = function (event:HttpDataEvent):void {
            // Notified with response content in event.bytes as it streams in
        };

        client.listener.onComplete = function (event:HttpResponseEvent):void {
            // Notified when complete (after status and data)
        };

        var request:HttpRequest = new Post();
        var userCredentials:Credentials = getCredentials();
        var cred:String = userCredentials.getUsername() + ":" + userCredentials.getPassword();
        cred = Base64.encode(cred);
        request.addHeader("Authorization", "Basic " + cred);
        var completionStatus:String = result.completionStatus;
        var json:String = "{\"duration\":" + result.duration + ", \"score\":" + result.score + ", \"completionStatus\":\"" + completionStatus + "\"}";
        var jsonData:ByteArray = new ByteArray();
        jsonData.writeUTFBytes(json);
        jsonData.position = 0;

        request.body = jsonData;  //variables;
        request.contentType = "application/json";
        client.request(uri, request);
    }

    /**
     * Function to get the user details of the logged in user
     * @param callback a callback function which contains the user details
     * @return
     */
    public function getUserDetails(callback:Function):User {
        var client:HttpClient = new HttpClient();
        var uri:URI = new URI("https://tst-brightcenter.trifork.nl/api/userDetails");
        var request:HttpRequest = new Get();
        setAuthorizationHeader(request);
        var userDetailsString:String;

        client.listener.onStatus = function (event:HttpStatusEvent):void {
        };

        client.listener.onData = function (event:HttpDataEvent):void {
            userDetailsString = event.readUTFBytes();
        };
        client.listener.onComplete = function (event:HttpResponseEvent):void {
//            user2 = com.adobe.serialization.json.JSON.decode(userDetailsString);
//            callback(user2);
            user = readJSONStringToUser(userDetailsString);
            callback(user);
        };

        client.listener.onError = function (event:ErrorEvent):String {
            var errorMessage:String = event.message;
            return errorMessage;
        };
        client.request(uri, request);
        return user;
    }

    private function readJSONStringToUser(jsonString:String):User {
        var removeQuotes:RegExp = /"/g;
        var removeStartCurlyBracket:RegExp = /{/;
        var removeEndCurlyBracket:RegExp = /}/;
        jsonString = jsonString.replace(removeQuotes, "");
        jsonString = jsonString.replace(removeStartCurlyBracket, "");
        jsonString = jsonString.replace(removeEndCurlyBracket, "");
        var userDetailArray:Array = jsonString.split(",");

        user = new User();
        for (var i:int = 0; i < userDetailArray.length; i++) {
            var jsonValue:Array = userDetailArray[i].split(":");
            if (jsonValue[0].toString() == "role") {
                user.setRole(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "personId") {
                user.setPersonId(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "username") {
                user.setUsername(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "encodedPassword") {
                user.setEncodedPassword(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "firstName") {
                user.setFirstName(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "firstName") {
                user.setLastName(jsonValue[0 + 1].toString());
            }
            if (jsonValue[0].toString() == "email") {
                user.setEmail(jsonValue[0 + 1].toString());
            }
        }
        return user;
    }

    /**
     * Function to get the results of a particular student for an assessment
     * @param assessmentId the id of the assessment
     * @param studentId the id of the student
     * @param callback a callback function which contains the results
     */
    public function getStudentResults(assessmentId:String, studentId:String, callback:Function):void {
        var client:HttpClient = new HttpClient();
        var listener:HttpDataListener = new HttpDataListener();
        var uri:URI = new URI("https://tst-brightcenter.trifork.nl/api/assessment/" + assessmentId + "/students/" + studentId + "/assessmentItemResult");
        var request:HttpRequest = new Get();
        setAuthorizationHeader(request);
        var studentResultsString:String;
        var studentResults:Array;
        client.listener.onStatus = function (event:HttpStatusEvent):void {
            // Notified of response (with headers but not content)
        };

        client.listener.onData = function (event:HttpDataEvent):void {
            // For string data
            studentResultsString = event.readUTFBytes();
        };

        client.listener.onComplete = function (event:HttpResponseEvent):void {
            studentResults = com.adobe.serialization.json.JSON.decode(studentResultsString);
            trace(studentResultsString);
            callback(studentResults);
        };

        client.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.message;
        };

        client.request(uri, request);
    }

    /**
     * Function to set the header in GET requests
     * @param request the request for to set the header
     */
    private function setAuthorizationHeader(request:HttpRequest):void {
        var userCredentials:Credentials = getCredentials();
        var cred:String = userCredentials.getUsername() + ":" + userCredentials.getPassword();
        cred = Base64.encode(cred);
        request.addHeader("Authorization", "Basic " + cred);
    }

}
}

