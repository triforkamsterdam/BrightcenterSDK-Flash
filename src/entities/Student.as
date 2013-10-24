/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/15/13
 * Time: 1:59 PM
 * To change this template use File | Settings | File Templates.
 */
package entities {
public class Student {
    var id:String;
    var firstName:String;
    var lastName:String;
    var lastLogin:Array;

    public function Student() {
    }

    public function getId():String{
        return id;
    }

    public function setFirstName(firstName:String):void{
        this.firstName = firstName;
    }

    public function getFirstName():String{
        return firstName;
    }

    public function setLastName(lastName:String):void{
        this.lastName = lastName;
    }

    public function getLastName():String{
        return lastName;
    }

    public function setLastLogin(lastLogin:Array):void{
        this.lastLogin = lastLogin;
    }

    public function getLastLogin():Array{
        return lastLogin;
    }


}
}
