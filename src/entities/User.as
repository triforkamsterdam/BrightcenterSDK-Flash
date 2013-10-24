/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/15/13
 * Time: 2:46 PM
 * To change this template use File | Settings | File Templates.
 */
package entities {
public class User {
    var role:String;
    var personId:String;
    var username:String;
    var encodedPassword:String;
    var email:String;
    var firstName:String;
    var lastName:String;

    public function User() {
    }

    public function setRole(role:String):void{
          this.role = role;
    }

    public function getRole():String{
        return role;
    }

    public function setPersonId(personId:String):void{
        this.personId = personId;
    }

    public function getPersonId():String{
        return personId;
    }

    public function setUsername(username:String):void{
        this.username = username;
    }

    public function getUsername():String{
        return username;
    }

    public function setEncodedPassword(encodedPassword:String):void{
        this.encodedPassword = encodedPassword;
    }

    public function getEncodedPassword():String{
        return encodedPassword;
    }

    public function setEmail(email:String):void{
        this.email = email;
    }

    public function getEmail():String{
        return email;
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
}
}
