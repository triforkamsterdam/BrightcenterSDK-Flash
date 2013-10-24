/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/15/13
 * Time: 12:57 PM
 * To change this template use File | Settings | File Templates.
 */
package entities {
public class Credentials {

    var username:String;
    var password:String;
    public function Credentials(username:String, password:String) {
        this.username = username;
        this.password = password;
    }

    public function setUsername(username:String):void{
        this.username = username;
    }

    public function getUsername():String{
        return username;
    }

    public function setPassword(password:String):void{
        this.password = password;
    }

    public function getPassword():String{
        return password;
    }

}
}
