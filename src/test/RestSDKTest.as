/**
 * Created with IntelliJ IDEA.
 * User: philipp
 * Date: 10/14/13
 * Time: 1:58 PM
 * To change this template use File | Settings | File Templates.
 */
package test {
public class RestSDKTest {

    var  restInterface:RestInterface;
    var restSDK:RestSDK;
    public function RestSDKTest() {
    }

    [Test]
    public function testGetUserDetails():void {

    }

    [Test]
    public function testGetStudentResults():void {
        restSDK.getStudentResults("1","1");
        //restInterface.getStudentResults("1","1");
    }

    [Test]
    public function testCreateAssessmentResult():void {

    }

    [Test]
    public function testGetGroupsOfTeacher():void {


    }
}
}
