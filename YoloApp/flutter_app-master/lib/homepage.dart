import 'package:flutter/material.dart';
import 'groups.dart';
import 'add.dart';
import 'profilepage.dart';
import 'home_view.dart';


class HomePagee extends StatefulWidget {

  final String uid;

  HomePagee({Key key, @required this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageeState();
  }
}

class _HomePageeState extends State<HomePagee> {

  bool isSearching = false;

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    AddPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("YOLO"),
          centerTitle: true,
          backgroundColor: Colors.indigo[800],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
              backgroundColor: Colors.indigo[800],
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text("Add"),
              backgroundColor: Colors.indigo[800],
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications),
              title: new Text("Notifications"),
              backgroundColor: Colors.indigo[800],
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text("Profile"),
              backgroundColor: Colors.indigo[800],
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}