import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/usermanagement.dart';
import 'register.dart';
import 'authentication.dart';
import 'main.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'homepage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String email;
  String password;
  String confirmpassword;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    signUp(email, password, context).then((value) {
      if (value != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
           title: Text("YOLO"),
           centerTitle: true,
          backgroundColor: Colors.indigo[800],
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(35.0, 80.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(fontSize: 65.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo[800]))),
                      validator: (_val) {
                        if (_val.isEmpty) {
                          return "Can't be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo[800]))),
                    obscureText: true,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "This Field Is Required."),
                        MinLengthValidator(6,
                            errorText: "Minimum 6 Characters Required.")
                      ]),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      }
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'CONFIRM PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo[800]))),
                    obscureText: true,
                    validator: (_val) {
                      if (password != confirmpassword) {
                        return "Password Did Not Match";
                      } else {
                        return null;
                      }
                    },
                      onChanged: (value) {
                        setState(() {
                          confirmpassword = value;
                        });
                      }
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.indigoAccent,
                        color: Colors.indigo,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            if(password == confirmpassword) {
                              handleSignup();
                            } else {
                              showErrDialog(context, 'Password not matched');
                            }
                          },
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.indigoAccent,
                        color: Colors.indigo,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                          },
                          child: Center(
                            child: Text(
                              'GO BACK',
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
              )),
          // SizedBox(height: 15.0),
        ]));
  }
}