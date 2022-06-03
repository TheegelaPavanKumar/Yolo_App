import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {

  final String btnText;

  SmallButton({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25.0,
        width: 60.0,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.indigo[800],
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child:GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/editprofile');
          },
          child: Center(
            child: Text(
              "$btnText",
              style: TextStyle(color: Colors.blue, fontSize: 16.0),
            ),
          ),
        )
    );
  }
}