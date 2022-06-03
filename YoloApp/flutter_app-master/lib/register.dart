import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';
import 'services/crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';

class RegisterPage extends StatefulWidget {

  final String uid;

  RegisterPage({Key key, @required this.uid}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  DateTime choosedate;

  validateform() {}
  var _formkey = GlobalKey<_RegisterPageState>();

  String fname;
  String lname;
  String addr;
  String city;
  String age;
  String dob;
  String mob;
  String uid;

  Future<void> getCurrentUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUid();
  }

  crudMethods crudObj = new crudMethods();

  Map<String, String> empData = Map();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("YOLO"),
          centerTitle: true,
          backgroundColor: Colors.indigo[800],
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Form(
              key: _formkey,
              child: Padding(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                      decoration: InputDecoration(
                          labelText: 'FIRST NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            fname = value;
                          });
                        }
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                      decoration: InputDecoration(
                          labelText: 'LAST NAME ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            lname = value;
                          });
                        }
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'MOBILE NUMBER ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            mob = (value);
                          });
                        }
                    ),
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                      decoration: InputDecoration(
                          labelText: 'CITY ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        }
                    ),
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                        decoration: InputDecoration(
                            labelText: 'ADDRESS ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            addr = value;
                          });
                        }
                    ),
                    TextFormField(
                        validator: (val) => val.length == 0 ? "Enter Age" : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'AGE',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[800]))),
                        onChanged: (value) {
                          setState(() {
                            age = value;
                          });
                        }
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.indigoAccent,
                          color: Colors.indigo[800],
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/homepage');
                              Firestore.instance.collection("userData").document(uid).
                               setData({'FirstName': this.fname, 'LastName': this.lname, 'Mobile': this.mob, 'Address': this.addr,
                                 'City': this.city, 'Age': this.age, 'Dob': this.dob});
                              Firestore.instance.collection("Images").document(uid).
                              setData({'thumbnailUrl': "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",});
                            },
                            child: Center(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePagee()));
                          },
                          child:

                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                )),
            // SizedBox(height: 15.0),
            )]),
        ));
  }
}