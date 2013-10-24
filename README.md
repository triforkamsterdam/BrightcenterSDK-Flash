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

