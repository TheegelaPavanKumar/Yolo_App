import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/homepage.dart';
import 'package:flutter_app/main.dart';

class OpeningPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser();

    if(user == null) {
      return MyHomePage();
    } else {
      return HomePagee();
    }
  }
}