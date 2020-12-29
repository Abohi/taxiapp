import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId,name,photoUrl,email;
  Timestamp age;


  UserModel(
      {this.userId,
        this.name,
        this.photoUrl,this.email,this.age});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? "",
    );
  }
}