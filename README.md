BrightCenterSDK-Flash
=====================

This is the Flash SDK of the BrightCenter platform. The SDK includes a source folder (src). This folder contains the
implementation of the SDK. The folders of the implementations are: 

- interfaces
- main
- entities
- test

Furthermore a demo file is included how to use the SDK. The name of this file is BrightCenterFlashSDK.as. This file shows
how to integrate the interface of the interfaces folder.

Using the SDK

To use the SDK you need to add the SDK to your flash project and create an instance of the interface. After that it is
possible to call the interface. Currently the interface offers the following functions

- setCredentials(credentials:Credentials)
- getGroupsOfTeacher(callback:Function)
- createAssessmentResult(assessmentId:String, studentId:String, itemId:String, result:AssessmentItemResult)
- getUserDetails(callback:Function)
- getStudentResults(assessmentId:String, studentId:String, callback:Function)

Functions with a callback function as a parameter are returning values. To see how to use them take a look in the
BrightCenterFlashSDK.as file.

Dependencies

To take use of the Flash SDK 2 libaries need to be added:

- as3crypto
- as3httpclientlib-1_0_6

UPDATE

To use a https connection the TLSEngine in the libary of as3crypto needs to be changed at line 694 from if (firstCert.getCommonName()==_otherIdentity) { to
if (firstCert.getCommonName()==_otherIdentity || wildcardEq(firstCert.getCommonName(),_otherIdentity)) {
and a new function needs to be inserted below

private function wildcardEq(certHostName:String, serverHostName:String):Boolean {
                      if (certHostName.charAt(0)=="*"){
                              var certArray:Array = certHostName.split(".");
                              var serverArray:Array = serverHostName.split(".");
                              return certArray[certArray.length-1]==serverArray[serverArray.length-1] && certArray[certArray.length]==serverArray[serverArray.length];
                      }
                      return false;
                }

Also the DER.as file needs to be changed to support https. At line 153 insert the folowing the code snipped

	// support for type 12
                      case 0x0C: // V_ASN1_UTF8STRING
	ps = new PrintableString(type, len);
	ps.setString(der.readMultiByte(len, "utf-8"));
	return ps;
	// support for type 22
	case 0x16: // V_ASN1_IA5STRING
	ps = new PrintableString(type, len);
	ps.setString(der.readMultiByte(len, "x-IA5"));
	return ps;
