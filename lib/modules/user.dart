import 'package:firebase_auth/firebase_auth.dart';

class User{
  final String userId;
  final String emailId;
  final FirebaseUser userInfo;
  User ({this.userId,this.emailId,this.userInfo});
}

class UserData{
  String userId;
  String productName;
  String serialNum;
  DateTime dateOfInstallation;
  DateTime nextServiceDate;
  String partsServiced;

  UserData({this.userId,this.productName,this.serialNum,this.dateOfInstallation,this.partsServiced,this.nextServiceDate});
}                 