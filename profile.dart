import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'EditInfo5.dart';
import "Auth.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'imageselect.dart';

final DBRef = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
var user = 'MMMMMMMMMM';
var email = "....";
var phone = "....";
var dob = "....";
var gen = "....";
var image1 = "....";
var verified = "....";
var uid;

class subpage extends StatefulWidget {
  @override
  var arr;
  subpage(String str) {
    arr = str.split('///--///');
    print(arr[4]);
  }

  State<StatefulWidget> createState() {
    return _Subpage();
  }
}

class _Subpage extends State<subpage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autoValidate = true;

  void ReadData() async {
    final FirebaseUser user1 = await _auth.currentUser();
    uid = user1.uid;
  }

  void Await() async {
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget Build() {
    return StreamBuilder(
      stream: DBRef.collection("Users").document(uid).snapshots(),
      builder: (context, snap) {
        var dat = snap.data;
        if (snap.hasData) {
          //try{
            // user = dat["User"];
            // email = dat["Email"];
            // phone = dat["PhoneNumber"];
            // dob = dat["DOB"];
            // gen = dat["Gender"];
            // image1 = dat["Image"];
            
            // while(dat==null){
            //   print('WHILE');
            //   dat=snap.data;
            // }
          print('yayayayay ${dat.toString()}');
          print('lalalalla ${dat["Image"]}');
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              color: Colors.blueGrey[900].withOpacity(.6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Image.asset(
                        dat["Image"] == null ? 'images/im/user2.png' : dat["Image"],
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 20.0),
                    child: Column(children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 1.0),
                            child: Text(
                              dat["User"],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          verified != null
                              ? Icon(
                                  Icons.verified_user,
                                  size: 18,
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: 0,
                                )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                        child: Text(
                          dat["Email"],
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white60),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .82,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.insert_invitation,
                            color: Colors.white70,
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Date of Birth',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                dat["DOB"],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .82,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white70,
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone number',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                dat["PhoneNumber"],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .82,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.wc,
                            color: Colors.white70,
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Gender',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                dat["Gender"],
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 150.0,
                      child: OutlineButton(
                        borderSide:
                            BorderSide(width: 3.0, color: Colors.white60),
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Edit(
                                  user: user,
                                  email: email,
                                  phone: phone,
                                  dob: dob,
                                  gen: gen,
                                  image: image1,
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            " Edit",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          //}
          // catch(e){
          //   print(e.toString());
          //   return Column(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(height: 50),
          //       SpinKitRing(color: Colors.white,size: 40,)
          //     ],
          //   );
          // }
        } else {
          return Center(
              child: SpinKitRipple(
            color: Colors.white,
            size: 40,
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ReadData();
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        backgroundColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: user == null
            ? SpinKitThreeBounce(
                color: Colors.white,
                size: 20,
              )
            : Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.all(0.0),
                child: Build(),
              ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _confirm(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ), //this right here
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Confirm changes?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 320.0,
                          child: FlatButton(
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              //WriteData();
                              //ReadData();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 320.0,
                          child: OutlineButton(
                            borderSide:
                                BorderSide(width: 3.0, color: Colors.black),
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}


