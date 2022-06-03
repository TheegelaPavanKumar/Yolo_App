import 'package:flutter/material.dart';
import 'small_button.dart';
import 'authentication.dart';
import 'main.dart';
import 'register.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'services/mobile_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  String uid;
  String FullName;
  String Firstname;
  String Lastname;
  String mobnum;
  String imageURL ="https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";

  FirebaseUser userData;
  Future<void> getDetails() async {
    userData = await FirebaseAuth.instance.currentUser();
    final uid = userData.uid;

    DocumentSnapshot details = await Firestore.instance.collection('userData').document(uid).get();
    setState(() {
      Firstname = details.data['FirstName'];
      Lastname = details.data['LastName'];
      mobnum = details.data['Mobile'];
    });

    DocumentSnapshot image = await Firestore.instance.collection('Images').document(uid).get();
    setState(() {
      imageURL = image.data['thumbnailUrl'];
    });

  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                            color: Colors.black38),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          imageURL,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Firstname??'Hello',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        mobnum??'009090',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SmallButton(btnText: "Edit"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading : Icon(Icons.settings,color: Colors.indigo[800],),
                        title: Text("Settings",style: TextStyle(fontSize: 16.0),),
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        onTap: () {},
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading : Icon(Icons.history,color: Colors.indigo[800],),
                        title: Text("My Bookings",style: TextStyle(fontSize: 16.0),),
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        onTap: () {},
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading : Icon(Icons.help,color: Colors.indigo[800],),
                        title: Text("Help & Support",style: TextStyle(fontSize: 16.0),),
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        onTap: () {},
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "App Notification",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Switch(
                            value: turnOnNotification,
                            onChanged: (bool value) {
                              // print("The value: $value");
                              setState(() {
                                turnOnNotification = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Location Tracking",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Switch(
                            value: turnOnLocation,
                            onChanged: (bool value) {
                              // print("The value: $value");
                              setState(() {
                                turnOnLocation = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Other",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Language", style: TextStyle(fontSize: 16.0)),
                        // SizedBox(height: 10.0,),
                        Divider(
                          height: 30.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.indigoAccent,
                    color: Colors.indigo,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        signOutUser().then((value) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false);
                        });
                      },
                      child: Center(
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );

  }
}