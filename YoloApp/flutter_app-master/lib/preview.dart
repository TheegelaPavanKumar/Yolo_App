import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/groups.dart';
import 'package:flutter_app/homepage.dart';
import 'package:flutter_app/main.dart';
import 'package:firebase_core/firebase_core.dart';


class Preview extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PreviewState();
  }
}

class _PreviewState extends State<Preview> {

  FirebaseUser User;

  FirebaseUser userData;
  Future<void> onPressed() async {
    userData = await FirebaseAuth.instance.currentUser();
    final uid = userData.uid;
  }

  @override
  void initState() {
    super.initState();
    onPressed();
  }

  Map doerData = {};

  @override
  Widget build(BuildContext context) {

    doerData = ModalRoute.of(context).settings.arguments;

    return  Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Details',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePagee(),
                  ));
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      doerData['doername'],
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  Center(
                    child: Text(
                      doerData['doermobnum'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [

                      Container(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(
                            Icons.verified_user,
                            size: 28,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Center(
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ]),
          ),
        ));
  }
}