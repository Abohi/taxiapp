import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hitchyke/services/auth-exception-handler.dart';
import 'package:hitchyke/services/userServices.dart';
import 'package:hitchyke/app/enums/auth-result-status.dart';

enum Status{EmailNotVerified, BioDataNotSet,OtherBioDataNotSet,Authenticated, Unauthenticated}
enum LoginStatus{EmailNotVerified,WrongPassword,InvalidEmail,UserNotFound,Authenticated, Unauthenticated,Loading,Failure}
class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  UserService _userService = UserService();
  String _name,_roleType;
  File _profilePhoto;
  String get name=>_name;
  String get roleType=>_roleType;
  File get profilePhoto=>_profilePhoto;
  Status _status = Status.Unauthenticated;
  Status get status => _status;

  User _user;
  User get user => _user;

  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user) async{
    if(user == null){
      _status = Status.Unauthenticated;
      notifyListeners();
    }else{
      await user.reload();
      _user = user;
      if(!_user.emailVerified){
        _status = Status.EmailNotVerified;
        notifyListeners();
        return;
      }

      final uid = _user.uid;
      final isBioDataSet = await _userService.isDriverBioDataNotSet(uid);
      if (!isBioDataSet) {
        _status = Status.BioDataNotSet;
        notifyListeners();
        return;
      }
      final isOtherDataSet = await _userService.isDriverOtherBioDataNotSet(uid);
      if(!isOtherDataSet){
        _status = Status.OtherBioDataNotSet;
        notifyListeners();
        return;
      }
      else {
        _status = Status.Authenticated;
        notifyListeners();
      }
      _status = Status.Authenticated;
      notifyListeners();
    }
  }

  Future<AuthResultStatus> loginUser(String email,String password) async{
    AuthResultStatus status;
    try {
       status= await _userService.loginWithEmailAndPassword(email:email, password: password);
      return status;
    } catch (_) {
     return status = AuthResultStatus.failure;
    }
  }

  Future<AuthResultStatus> registerUser(String email,String password) async{
    AuthResultStatus status;
    try {
      status= await _userService.registerWithEmailAndPassword(email:email, pass: password);
      return status;
    } catch (_) {
      return status = AuthResultStatus.failure;
    }
  }

  Future<void>submittedDriverBioData({String name,String phoneNo,String email,String gender,String userType,String address,DateTime dateOfBirth,String maritalStatus,String occupation,String accountName,String accountNumber,
    String bankType,String nextOfKinName,String nextOfKinPhonNo,String nextOfKinGender,String nextOfKinAddress,String nextOfKinRela,String nextOfKinOccu,File profilePhoto}) async{
      if(profilePhoto!=null){
        await _userService.profileSetup(photo: profilePhoto,userId: _user.uid,name: name,gender: gender,phoneNo: phoneNo,email: email,userType: userType,
          address: address,maritalStatus: maritalStatus,occupation: occupation,accountName: accountName,accountNumber: accountNumber,bankType: bankType,
          nextOfKinName: nextOfKinName,nextOfKinPhoneNo: nextOfKinPhonNo,nextOfKinGender: nextOfKinGender,nextOfKinAddress: nextOfKinAddress,nextOfKinOccu: nextOfKinRela,
          nextOfKinRela: nextOfKinRela,age: dateOfBirth,);
      }else{
        await _userService.profileSetupWithoutPhoto(userId: _user.uid,name: name,gender: gender,phoneNo: phoneNo,email: email,userType: userType,
          address: address,maritalStatus: maritalStatus,occupation: occupation,accountName: accountName,accountNumber: accountNumber,bankType: bankType,
          nextOfKinName: nextOfKinName,nextOfKinPhoneNo: nextOfKinPhonNo,nextOfKinGender: nextOfKinGender,nextOfKinAddress: nextOfKinAddress,nextOfKinOccu: nextOfKinRela,
          nextOfKinRela: nextOfKinRela,age: dateOfBirth,);
      }
    _name=name;
    _roleType=roleType;
    _profilePhoto=profilePhoto;
    notifyListeners();
  }
  Future<void>profileVehicleSubmitted({String userType,String manufacturer,String model,String color,String lincese,String otherInfo,DateTime yearOfProduction,DateTime yearOfPurchase,List<File> file})async{

    await _userService.uploadVehicleDetails(user_id:_user.uid,userType: userType,manufacturer: manufacturer,model: model,color: color,lincese: lincese,
        otherInfo: otherInfo,yearOfProduction: yearOfProduction,yearOfPurchase: yearOfPurchase,file: file);
  }



}