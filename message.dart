import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'genre.dart';
import 'infor.dart';
import 'SignIn.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'upcoming.dart';
import 'trending.dart';
import 'new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Register.dart' as Reg;
import "Auth.dart";
import 'package:flutter/material.dart';
import "profile.dart";
import "package:firebase_database/firebase_database.dart";
import 'dart:ui' show ImageFilter;
import 'homepage.dart';
import 'private.dart';
import 'groups.dart';
import 'pinned.dart';
import 'connected.dart';
import 'connectedbody.dart';

final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
bool pressed=false;

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            pressed?Padding(
              padding: const EdgeInsets.fromLTRB(0,8,0,8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                elevation: 10,
                color: Colors.white,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10,5,10,5),
                    width: 110,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.people_outline,size: 30,),
                        SizedBox(width: 10,),
                        Text('Group'),
                      ],
                    )
                ),
              ),
            ) :
            SizedBox(height: 0,),
            pressed?Padding(
              padding: const EdgeInsets.fromLTRB(0,8,0,8),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    pressed=!pressed;
                  });
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      builder:(context)
                      {
                        return Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                            color: Colors.black87,
                          ),
                          //padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15,3,3,8),
                                child: Row(
                                  children: <Widget>[
                                    Text('Private chat',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                    Spacer(),
                                    IconButton(
                                      onPressed:() => Navigator.of(context).pop(),
                                      icon: Icon(Icons.close,color: Colors.white,),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Connectedbody()),
                            ],
                          ),
                        );
                      }
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10,5,10,5),
                      width: 110,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.person_outline,size: 30,),
                          SizedBox(width: 10,),
                          Text('Private'),
                        ],
                      )
                  ),
                ),
              ),
            ) :
            SizedBox(height: 0,),
            GestureDetector(
              onTap: (){
                setState(() {
                  pressed=!pressed;
                });
              },
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: pressed?Icon(Icons.close,size: 30,):Icon(Icons.add,size: 30,),
                )
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        body: Container(
          child:Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                  //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10) ,bottomRight: Radius.circular(10))
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
                            onPressed: (){
                                Navigator.of(context).pop();
                            },
                          ),
                          //SizedBox(width: 10,),
                          Text('Chats',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,)),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.menu,color: Colors.white,),
                            onPressed: () {
                              _menu();
                            },
                          )
                        ],
                      ),
                    ),
                    TabBar(
                      //controller: _tabController,
                      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white54,
                      indicatorColor: Colors.black,
                      //indicatorSize: TabBarIndicatorSize.tab ,
                      //indicatorWeight: 3,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white38
                      ),
                      tabs: [
                        new Tab(
                          text: 'Private',
                          //icon: Icon(Icons.home),
                        ),
                        new Tab(
                          text: 'Groups',
                          //icon: Icon(Icons.explore),
                        ),
                        new Tab(
                          text: 'Pinned',
                          //icon: Icon(Icons.message),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //height: 200,
                  child: TabBarView(
                    children: <Widget>[
                      Private(),
                      Groups(),
                      Pinned()
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  void _menu() {
    //ReadData();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.white.withOpacity(.7),
                //context: context,
                //builder: (BuildContext bc) {
                child: Container(
                  //alignment: Alignment.center,
                    height: 370,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * .05,
                          left: MediaQuery.of(context).size.height * .05,
                          top: 5.0,
                          bottom: 5.0),
                      child: Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Text(
                              " Menu",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                        ClipOval(
                          child: Image.asset(
                            'images/aa1.jpg',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(top: 4.0, bottom: 1.0),
//                          child: user == null? SpinKitThreeBounce(
//                            color: Colors.teal,
//                            size: 20,
//                          )
//                              : Text(
//                            '$user',
//                            style: TextStyle(
//                                fontSize: 16.0,
//                                fontWeight: FontWeight.bold,
//                                color: Colors.black),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
//                          child: email == null
//                              ? SizedBox(height: 1.0)
//                              : Text(
//                            '$email',
//                            style: TextStyle(
//                                fontSize: 12.0, color: Colors.black45),
//                          ),
//                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .82,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.black,
                              textColor: Colors.white,
                              padding: EdgeInsets.only(right: 0.0),
                              onPressed: () {
                                //navigateToSubPage(context);
                              },
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.perm_identity,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    "Profile".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .82,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.black,
                              textColor: Colors.white,
                              padding: EdgeInsets.only(right: 8.0),
                              onPressed: () {
                                Navigator.of(context).pop();
                                //_genreMenu(context);
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => ex())
//                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.burst_mode,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Genre".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .82,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.black,
                              textColor: Colors.white,
                              padding: EdgeInsets.only(right: 10.0),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Dialog(
                                          backgroundColor:
                                          Colors.white.withOpacity(.7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0)),
                                          //this right here
                                          child: Container(
                                            color:
                                            Colors.white.withOpacity(0.0),
                                            height: 200,
                                            padding: EdgeInsets.all(10.0),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(12.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Text(
                                                      "Log out?",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        4.0),
                                                    child: SizedBox(
                                                      width: 320.0,
                                                      child: FlatButton(
                                                        padding:
                                                        EdgeInsets.all(8.0),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              15.0),
                                                        ),
                                                        onPressed: () async {
                                                          await _auth.signOut();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
//                                                          user = null;
//                                                          email = null;
//                                                          phone = null;
//                                                          dob = null;
//                                                          gen = null;
                                                          //await _auth.signOut();
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                      SignIn()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(4.0),
                                                          child: Text(
                                                            "Log out",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        4.0),
                                                    child: SizedBox(
                                                      width: 320.0,
                                                      child: OutlineButton(
                                                        borderSide: BorderSide(
                                                            width: 3.0,
                                                            color:
                                                            Colors.black),
                                                        padding:
                                                        EdgeInsets.all(8.0),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              15.0),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(4.0),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                              },
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Log out".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                    ))
              //}
            ),
          );
        });
  }
}
