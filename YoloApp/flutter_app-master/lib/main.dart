import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/editprofile.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/small_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'opening.dart';
import 'Signup.dart';
import 'register.dart';
import 'homepage.dart';
import 'home_view.dart';
import 'add.dart';
import 'groups.dart';
import 'jobs.dart';
import 'profilepage.dart';
import 'preview.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        'landingpage' : (BuildContext context) => new MyApp(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/register': (BuildContext context) => new RegisterPage(),
        '/homepage': (BuildContext context) => new HomePagee(),
        '/homeview': (BuildContext context) => new HomeView(),
        '/add': (BuildContext context) => new AddPage(),
        '/profile': (BuildContext context) => new ProfilePage(),
        '/opening': (BuildContext context) => new OpeningPage(),
        '/editprofile': (BuildContext context) => new EditProfilePage(),
        '/jobs': (BuildContext context) => new Jobs(),
        '/groups': (BuildContext context) => new NotificationPage(),
        '/preview': (BuildContext context) => new Preview()
      },

      home: new MyHomePage(),
    );
  }
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _email;
  String _password;

  GlobalKey<FormState> formkey = GlobalKey <FormState>();

  void login() {
    signin(_email, _password, context).then((value) {
      if (value != null) {
        print("hello");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePagee(uid: value.uid,),
            ));
      }
    }
    );
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                      child : Center(
                          child:Image.asset('assets/logosignin.png',
                              height: 150,
                              width: 90
                          ),
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
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo[800])
                        )
                    ),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "This Field Is Required"),
                        EmailValidator(errorText: "Invalid Email Address"),
                      ]),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo[800])
                        )
                    ),
                    obscureText: true,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Password Is Required"),
                        MinLengthValidator(6,
                            errorText: "Minimum 6 Characters Required"),
                      ]),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    }
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text('Forgot Password',
                        style: TextStyle(
                            color: Colors.indigo[800],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.indigoAccent,
                        color: Colors.indigo,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            login();
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 23.0,),
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
                          gooogleSignIn().whenComplete(() async {
                            FirebaseUser user = await FirebaseAuth.instance.currentUser();
                            if(user.uid!=null){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => RegisterPage(uid: user.uid)));}
                            else{
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                            }
                          });
                        },
                        child:

                        Center(
                          child: Text('Sign in with Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),


                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New to Yolo ?',
                        style: TextStyle(
                            fontFamily: 'Montserrat'
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text('Signup',
                          style: TextStyle(
                              color: Colors.indigo[800],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}