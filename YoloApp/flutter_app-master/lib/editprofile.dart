import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'profilepage.dart';
import 'homepage.dart';
import 'profilepage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  File _image;
  bool uploading = false;
  File file;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  String uid;
  String Firstname;
  String Lastname;
  String mobnum;
  String address;
  String city;
  String upfullname;
  String upcity;
  String upmobile;
  String upaddress;

  FirebaseUser userData;
  Future<void> getDetails() async {
    userData = await FirebaseAuth.instance.currentUser();
    uid = userData.uid;

    DocumentSnapshot details = await Firestore.instance.collection('userData').document(uid).get();
    setState(() {
      Firstname = details.data['FirstName'];
      Lastname = details.data['LastName'];
      mobnum = details.data['Mobile'];
      address = details.data['Address'];
      city = details.data['City'];
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  void checkData(){
    if(upaddress == null) {
      upaddress = address;
    }
    if(upmobile == null) {
      upmobile = mobnum;
    }
    if(upfullname == null) {
      upfullname = Firstname;
    }
    if(upcity == null) {
      upcity = city;
    }
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    saveItemInfo(String downloadUrl)
    {
      final itemsRef = Firestore.instance.collection("Images");
      itemsRef.document(uid).setData({
        "thumbnailUrl" : downloadUrl,
      });
    }

    Future uploadPic() async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot takeSnapshot=await uploadTask.onComplete;
      String downloadUrl = await takeSnapshot.ref.getDownloadURL();
      saveItemInfo(downloadUrl);
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => HomePagee(),
            )
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 25,
                        right: 90,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                              icon: Icon(Icons.edit,color: Colors.white,),
                              onPressed: () {
                                //pickPhotoFromGallery();
                                getImage();
                              }
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Full Name"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                    hintText: Firstname,
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
                  onChanged: (value) {
                      setState(() {
                        upfullname = value;
                      });
                    }
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Mobile Number"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: mobnum,
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
                  onChanged: (value) {
                      setState(() {
                        upmobile = value;
                      });
                    }
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("City"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: city,
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
                  onChanged: (value) {
                      setState(() {
                        upcity = value;
                      });
                    }
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Address"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: address,
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
                  onChanged: (value) {
                      setState(() {
                        upaddress = value;
                      });
                    }
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePagee(),
                          ));
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // ignore: unnecessary_statements
                      //uploading ? null : () => uploadImageAndSaveItemInfo();
                      uploadPic();

                      print(upaddress);
                      checkData();

                      Firestore.instance.collection('userData').document(uid)
                      .updateData({
                         'FirstName': upfullname,
                         'City': upcity,
                         'Mobile': upmobile,
                         'Address': upaddress
                      });

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePagee(),
                          ));
                    },
                    color: Colors.indigo[800],
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}