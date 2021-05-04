import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2/Home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'EditInfo5.dart';
import "Auth.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'socialaccounts.dart';
import 'connected.dart';
import 'notifcations.dart';

final DBRef = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
var user;
var email;
var phone;
var dob;
var gen;
bool empty = true;
bool connect = false;

List<Widget> list21 = new List<Widget>();
var image = null;
var uid = null;

class Social extends StatefulWidget {
  @override
  _SocialState createState() {
    return _SocialState();
  }
}

class _SocialState extends State<Social> {
  bool ff = false;
  bool sh = true;
  Future<List> ReadData() async {
    final FirebaseUser user1 = await _auth.currentUser();
    uid = user1.uid;
  }

  Widget Account( docs, index){

    return SocialAcc(username:docs[index]['Info']['User'],userId:docs[index]['Info']['Id'],image: docs[index]['Info']['Image'],);
    //return Text('Hiii');
  }

  @override
  Widget build(BuildContext context) {
    ReadData();
    return Container(
      color: Colors.black87,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Connected()));
            },
            child: Row(
              children: <Widget>[
                ClipOval(
                    child: Icon(
                  Icons.swap_horiz,
                  size: 70,
                  color: Colors.white,
                )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Connected',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'chat or dissconnect',
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                  color: Colors.white54,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(
                'Find Connections',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: DBRef.collection("Users").snapshots(),
              builder: (context, snap) {
                ReadData();
                if (snap.hasData) {
                  var docs = snap.data.documents;
                  print(docs);
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (ctx, index) {
                      print(index);
                      return docs[index]['Info']['Id']==uid ? SizedBox()
                      :
                      Account(docs, index);
                    },
                  );
                }
//                   //print(snap.);
//                   //gg.forEach((index,doc)=>print(doc));
//                   //print(snap.);
// //                  var data = snap.data.snapshot.value['Users'];
// //                  List<Widget> kk = new List<Widget>();
// //                  print(snap.data.snapshot.value['Users']);
// //                  List item = [];
// //                  var dataSnapShot = snap.data.snapshot;
// //                  data.forEach((index, value) {
// //                    print(value["Info"]['Gender']);
// //                    var id = value['Info']['Id'];
// //                    image=dataSnapShot.value['Users'][id]['Info']['Image'];
// //                    if(value['Info']['Id']!=uid){
// //
// //                      if(dataSnapShot.value['Users'][uid]['Connected']!=null){
// //                        if(dataSnapShot.value['Users'][uid]['Connected'][value['Info']['Id']]!=null){
// //
// //                        }
// //                        else{
// //                          list2.add(
// //                              SocialAcc(username: value['Info']['User'],userId: value['Info']['Id'],image: image,)
// //                          );
// //                        }
// //                      }
// //
// //                      else{
// //                        list2.add(
// //                            SocialAcc(username: value['Info']['User'],userId: value['Info']['Id'],image: image,)
// //                        );
// //                      }
// //                      print(e);
// //
// //                    }
// //                  });
// //                  list2.add(
// //                      SizedBox(
// //                        height: 150,
// //                        child: Column(
// //                          children: <Widget>[
// //                            SizedBox(height: 10,),
// //                            Text('click on connect to add as connection',style: TextStyle(color: Colors.white38),),
// //                          ],
// //                        ),
// //                      )
// //                  );
// //
// //                  return ListView(
// //                    children: list2
// //                  );
//                   print('HEY');
//                   print(list2);
//                   return ListView(
//                       children: list2
//                   );
//                 }
                else
                  return Center(child: Text("No data"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
