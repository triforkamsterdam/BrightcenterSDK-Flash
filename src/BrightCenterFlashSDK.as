package {

import com.adobe.serialization.json.JSON;

import entities.AssessmentItemResult;

import entities.Credentials;
import entities.Group;
import entities.User;
import entities.User;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Timer;
import flash.utils.getTimer;

import flashx.textLayout.elements.ListElement;

import interfaces.RestInterface;

import main.RestSDK;

// This is an example class how the BrightCenter SDK can be used
public class BrightCenterFlashSDK extends Sprite {
    var restService:RestInterface = new RestSDK();

    public var username:TextField = new TextField();
    public var usernameLabel:TextField = new TextField();

    var password:TextField = new TextField();
    var passwordLabel:TextField = new TextField();

    var loginButton:Sprite = new Sprite();
    var loginText:TextField = new TextField();

    var user:User;

    public function BrightCenterFlashSDK() {
        paintLoginScreen();
    }

    /**
     * Function to paint the login screen
     */
    public function paintLoginScreen(){
        username.text = "";
        username.border = true;
        username.type = "input";
        username.width = 150;
        username.height = 20;
        username.x = 200;
        username.y = 100;
        usernameLabel.text = "Username";
        usernameLabel.border = true;
        usernameLabel.width = 60;
        usernameLabel.height = 20;
        usernameLabel.x = 140;
        usernameLabel.y = 100;

        password.text = "";
        password.border = true;
        password.type = "input";
        password.displayAsPassword = true;
        password.width = 150;
        password.height = 20;
        password.x = 200;
        password.y = 130;
        passwordLabel.text = "Password";
        passwordLabel.border = true;
        passwordLabel.width = 60;
        passwordLabel.height = 20;
        passwordLabel.x = 140;
        passwordLabel.y = 130;

        loginText.text = "LOGIN";
        loginText.width = 100;
        loginText.height = 20;
        loginText.x = 225;
        loginText.y = 162;
        loginButton.graphics.beginFill(0x00FF00, 1);
        loginButton.graphics.drawRect(220,160,50,20);
        loginButton.graphics.endFill();
        loginButton.buttonMode = true;
        loginButton.addChild(loginText);
        loginButton.addEventListener(MouseEvent.CLICK, login, false,0,false);

        addChild(username);
        addChild(usernameLabel);
        addChild(password);
        addChild(passwordLabel);
        addChild(loginButton);
    }

    /**
     * Login function if the user role is null the login is not correct
     * @param e
     */
    function login(e:MouseEvent):void{
        var credentials:Credentials = new Credentials(username.text, password.text);
        restService.setCredentials(credentials);
        user = restService.getUserDetails(function(user:User):void{
            trace("User role : " +user.getRole());
            if(user.getRole() == null){
                // Login is not correct
            }else{
                // Login is correct
                removeChild(username);
                removeChild(usernameLabel);
                removeChild(password);
                removeChild(passwordLabel);
                removeChild(loginButton);
                // get groups and students and create group list
                showGroupsOfUser();
            }
        });
    }

    /**
     * Function to show the group of the user
     */
    private function showGroupsOfUser():void{
        restService.getGroupsOfTeacher(function(groups:Array):void{
            trace("Groups array is : " + groups[0].name);
            var groupList:Sprite = new Sprite();
            groupList.graphics.beginFill(0x00FF00, 1);
            groupList.graphics.drawRect(0,0,150,300);
            groupList.graphics.endFill();
            var y:int = 0;
            for(var i:int = 0; i<groups.length;i++){
                var groupName:TextField = new TextField();
                groupName.text = groups[i].name;
                groupName.y = y;
                groupName.addEventListener(MouseEvent.CLICK, getStudentsOfGroup(groups[i].students));
                groupList.addChild(groupName);
                y += 20;
            }
            addChild(groupList);
        })

    }

    // to send a parameter on an event listener event we need to specify the return type as function
    /**
     * Function to show the students of a group
     * @param students the students to show
     * @return
     */
    private function getStudentsOfGroup(students):Function{
        return function(e:MouseEvent):void {
            // add to show students in a list
            var studentsList:Sprite = new Sprite();
            studentsList.graphics.beginFill(0x993300, 1);
            studentsList.graphics.drawRect(150,0,150,300);
            studentsList.graphics.endFill();
            var y:int = 0;
            for(var k:int = 0; k<students.length; k++){
                var studentName:TextField = new TextField();
                studentName.text = students[k].firstName + " " + students[k].lastName;
                studentName.y = y;
                studentName.x = 150;
                //studentName.addEventListener(MouseEvent.CLICK, showResultsOfStudent(students[k].id));       // get results of a student
                studentName.addEventListener(MouseEvent.CLICK, postAssessmentResult(students[k].id));     // post result of student
                studentsList.addChild(studentName);
                y += 20;
            }
            addChild(studentsList);
        };
    }

    /**
     * Function to receive the results of a student
     * @param id the id of the student
     * @return
     */
    private function showResultsOfStudent(id:String):Function{
      return function(e:MouseEvent):void{
          restService.getStudentResults("1",id,function(results:Array):void{
              trace("RESULTS ARE : " + results);
          })
      }
    }

    /**
     * Function to post the results of a student
     * @param id the id of the student
     * @return
     */
    private function postAssessmentResult(id:String):Function{
        return function(e:MouseEvent):void{
            trace("POST RESULT FOR STUDENT ID : " +id);
            var result:AssessmentItemResult = new AssessmentItemResult();
            result.attempts = 4;
            result.duration = 70;
            result.score = 1;
            result.completionStatus = "COMPLETED";
            restService.createAssessmentResult("1",id,"1", result);
        }
    }

}
}
