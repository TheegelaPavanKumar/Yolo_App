import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'jobs.dart';
import 'package:flutter/rendering.dart';
import 'register.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}


class _HomeViewState extends State<HomeView> {

  String job;
  String job_desc;
  String addr;
  String mob;

  Map<String, String> jobData = Map();


  bool isSearching = false;
  TextEditingController textEditingController = TextEditingController();
  String searchString;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            child: TextField(
                              onChanged: (val){
                                setState(() {
                                  searchString = val.toLowerCase();
                                  isSearching = true;
                                });
                              },
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      textEditingController.clear();
                                      isSearching = false;
                                    },
                                  ),
                                  hintText: 'Search Jobs here',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Antra', color: Colors.blueGrey
                                  )
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: (searchString == null || searchString.trim() == '')
                                  ? getJobsSnapshots(context)
                                  : getSearchSnapshots(context),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData) return const Text("Loading....");
                                return new ListView.builder(
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return JobCard(context, snapshot.data.documents[index]);
                                    });
                              }
                          ),
                        )]
                  ))]));
  }


  Stream<QuerySnapshot> getJobsSnapshots(BuildContext context) async* {

    yield* Firestore.instance.collection('Jobs').snapshots();
  }

  Stream<QuerySnapshot> getSearchSnapshots(BuildContext context) async* {

    yield* Firestore.instance.collection('Jobs').where('searchIndex', arrayContains: searchString).snapshots();
  }

  void sendData(DocumentSnapshot job) {
    Navigator.pushReplacementNamed(context, '/jobs', arguments: {
      'Full Name': job['Full Name'], 'Job': job['Job'], 'Job Description': job['Job Description'], 'Mobile': job['Mobile'], 'Address': job['Address'],
      'Requirements': job['Requirements'], 'uid': job['uid'], 'docid': job['docid']
    }
    );
  }


  Widget JobCard(BuildContext context, DocumentSnapshot job) {

    return new Container(
      child:  Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading : CircleAvatar(backgroundImage: NetworkImage(job['imageURL'])),
                title: Align(
                   child: new Text(job['Job'],style: TextStyle(fontSize: 23.0),),
                    alignment: Alignment(-0.8, 0),
                    ),
                subtitle: Align(
                  child: new Text(job['City'] ,style: TextStyle(fontSize: 16.0),),
                  alignment: Alignment(-0.8, 0.6),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                dense: true,
                onTap: () {
                  sendData(job);
                },
              ),
              Divider(
                height: 10.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}