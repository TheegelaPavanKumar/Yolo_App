import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class crudMethods {


  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    }
    else {
      return false;
    }
  }

  FirebaseUser userData;
  String uID;

  Future<void> addData(empData) async {
    if (isLoggedIn()) {
      userData = await FirebaseAuth.instance.currentUser();
      final uid = userData.uid;

      Firestore.instance.collection("userData").document(uid).collection('empData').add(empData).catchError((e) {
        print(e);
      });
    }
    else {
      print('You need to be logged in');
    }
  }

  Future<void> getUserID() async {
    if (isLoggedIn()) {
      userData = await FirebaseAuth.instance.currentUser();
      uID = userData.uid;
    }
  }

  Future<void> addDataa(jobData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Jobs').add(jobData).catchError((e) {
        print(e);
      });
    }
    else {
      print('You need to be logged in');
    }
  }
}