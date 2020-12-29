import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hitchyke/app/enums/auth-result-status.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/services/auth-exception-handler.dart';

class UserService{
   FirebaseAuth _firebaseAuth;
   FirebaseFirestore _firestore;
  User currentUser;
  AuthResultStatus _status;
  UserService(){
    FirebaseFirestore.instance.settings =
        Settings(persistenceEnabled: false);

    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
}


User reloadCurrentUser(){
    User oldUser = _firebaseAuth.currentUser;
    oldUser.reload();
    oldUser.reload();
    User newUser = _firebaseAuth.currentUser;
    // Add newUser to a Stream, maybe merge this Stream with onAuthStateChanged?
    return newUser;
  }


//Login  users
  Future<AuthResultStatus> loginWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;

      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }



  // Register users
  Future<AuthResultStatus> registerWithEmailAndPassword({String email, String pass}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if(userCredential.user!=null){
        await userCredential.user.sendEmailVerification();
        _status = AuthResultStatus.emailNotVerified;
      }else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      print(e.toString());
    }
    return _status;
  }


//Check if driver biodata exist
  Future<bool> isDriverBioDataNotSet(String userId) async {
    bool exist;
    await _firestore
        .collection('Drivers')
        .doc("drivers_profile")
    .collection("biodata")
    .doc(userId)
        .get()
        .then((user) {
      exist = user.exists;
    });

    return exist;
  }

  Future<bool> isDriverOtherBioDataNotSet(String userId) async {
    bool exist;
    await _firestore
        .collection('Drivers')
        .doc("drivers_profile")
        .collection("other_biodata")
        .doc(userId)
        .get()
        .then((user) {
      exist = user.exists;
    });

    return exist;
  }

  //Check if user is signed in
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
  Future<void> profileSetupWithoutPhoto({
    String userId,
    String name,
    String gender,
    String phoneNo,
    String email,
    String userType,
    String address,
    String maritalStatus,
    String occupation,
    String accountName,
    String accountNumber,
    String bankType,
    String nextOfKinName,
    String nextOfKinPhoneNo,
    String nextOfKinGender,
    String nextOfKinAddress,
    String nextOfKinRela,
    String nextOfKinOccu,
    DateTime age}) async {
    await _firestore.collection(userType).doc("drivers_profile").collection("biodata").doc(userId).set({
      'uid': userId,
      'name': name,
      "gender": gender,
      'phoneNo': phoneNo,
      'email': email,
      'age': age,
      "userType": userType,
      'maritalStatus': maritalStatus,
      'occupation': occupation,
      'acctName': accountName,
      "accountNo": accountNumber,
      'bank':bankType,
      'nextOfKinName': nextOfKinName,
      "nextOfKinPhone": nextOfKinPhoneNo,
      'nextOfKinAddress':nextOfKinAddress,
      'nextOfKinOccupation': nextOfKinOccu,
      "nextOfKinRela": nextOfKinRela,
    });
  }
  Future<void> profileSetup({
      File photo,
      String userId,
      String name,
      String gender,
      String phoneNo,
      String email,
      String userType,
      String address,
      String maritalStatus,
      String occupation,
      String accountName,
      String accountNumber,
      String bankType,
      String nextOfKinName,
      String nextOfKinPhoneNo,
      String nextOfKinGender,
      String nextOfKinAddress,
      String nextOfKinRela,
      String nextOfKinOccu,
      DateTime age}) async {
    StorageUploadTask storageUploadTask;
    storageUploadTask = FirebaseStorage.instance
        .ref()
        .child(userType)
        .child(userId)
        .child("profile_photo")
        .child(userId)
        .putFile(photo);

    return await storageUploadTask.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        await _firestore.collection(userType).doc("drivers_profile").collection("biodata").doc(userId).set({
          'uid': userId,
          'photoUrl': url,
          'name': name,
          "gender": gender,
          'phoneNo': phoneNo,
          'email': email,
          'age': age,
          "userType": userType,
          'maritalStatus': maritalStatus,
          'occupation': occupation,
          'acctName': accountName,
          "accountNo": accountNumber,
          'bank':bankType,
          'nextOfKinName': nextOfKinName,
          "nextOfKinPhone": nextOfKinPhoneNo,
          'nextOfKinAddress':nextOfKinAddress,
          'nextOfKinOccupation': nextOfKinOccu,
          "nextOfKinRela": nextOfKinRela,
        });
      });
    });
  }

  Future uploadVehicleDetails({String userType,String user_id,String manufacturer,String model,String color, String lincese,String otherInfo,
  DateTime yearOfProduction,DateTime yearOfPurchase,
   List<File> file}) async {
    List<String> _imageUrls = List();
    try {
      for (int i = 0; i < file.length; i++) {
        final StorageReference storageReference = FirebaseStorage().ref().child(userType).child(user_id).child("vehicles_images").child("vehicle/$i");

        final StorageUploadTask uploadTask = storageReference.putFile(file[i]);

        await uploadTask.onComplete;

        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl); //all all the urls to the list
      }
      //upload the list of imageUrls to firebase as an array
      await _firestore.collection(userType).doc("drivers_profile").collection("other_biodata").doc(user_id).set({
        "vehicle_images": _imageUrls,
        "manufacturer":manufacturer,
        "model":model,
        "color":color,
        "license":lincese,
        "other_info":otherInfo,
        "yearOfProduction":yearOfProduction,
        "yearOfPurchase":yearOfPurchase,
      });
    } catch (e) {
      print(e);
    }
  }
//Get UserDetails Stream
  Stream<UserModel> streamUser({String id,userType}) {
    return _firestore.collection(userType).doc("drivers_profile").collection("biodata").doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(snap.data()));
  }
  //Signout user
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  User getUser() {
    return ( _firebaseAuth.currentUser);
  }
}