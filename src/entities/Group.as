/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/15/13
 * Time: 11:45 AM
 * To change this template use File | Settings | File Templates.
 */
package entities {
public class Group {

    var id:String;
    var name:String;
    var students:Array; //.<Student>

    public function Group() {
    }

    public function getId():String{
        return id;
    }

    public function setName(name:String):void{
        this.name = name;
    }

    public function getName():String{
        return name;
    }

    public function getStudents():Array{ //.<Student>
        return students;
    }

    public function setStudents(students:Array):void{        //.<Student>
        this.students = students;
    }
}
}
