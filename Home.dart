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
import 'message.dart';
import 'notifcations.dart';

final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var user;
var email;
var phone;
var dob;
var gen;
String dev = "///--///";
bool h=true;
bool e=false;
bool m=false;
bool p=false;


final List page = [
  HomePage(),
  Icon(Icons.explore),
  Notify(),
  subpage("$user$dev$email$dev$phone$dev$dob$dev$gen"),
];

var num=0;
bool showNav = true;

class Sliderpage extends StatefulWidget {
  @override
  _SliderpageState createState() => _SliderpageState();
}

class _SliderpageState extends State<Sliderpage> with SingleTickerProviderStateMixin{
  final AuthService _auth = AuthService();
  int _slidervalue;
  int count = 1;
  int _page = 1;
  final _pageoption = [Upcoming(), New(), Trending()];

  var All = true;
  var action = false;
  var comdey = false;
  var drama = false;
  var romance = false;
  var col = Colors.white;
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4,vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ReadData();

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FlatButton(
          //onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(right:0.0, left: 5, top: 2, bottom: 8),
            child: Card(
              color: Colors.transparent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: IconButton(
                            icon : Icon(Icons.home,size:30,),
                            color: h? Colors.black : Colors.black38,
                            onPressed: (){
                              setState(() {
                                h=true;
                                e=false;
                                m=false;
                                p=false;
                                num=0;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: IconButton(
                            icon : Icon(Icons.explore,size:30,),
                            color: m? Colors.black : Colors.black38,
                            onPressed: (){
                              setState(() {
                                m=true;
                                e=false;
                                h=false;
                                p=false;
                                num=1;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: IconButton(
                            icon : Icon(Icons.notifications,size:30,),
                            color: e? Colors.black : Colors.black38,
                            onPressed: (){
                              setState(() {
                                e=true;
                                h=false;
                                m=false;
                                p=false;
                                num=2;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: IconButton(
                            icon : Icon(Icons.person,size:30,),
                            color: p? Colors.black : Colors.black38,
                            onPressed: (){
                              setState(() {
                                p=true;
                                e=false;
                                m=false;
                                h=false;
                                num=3;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
        ),
        backgroundColor: Colors.teal,
        body: DoubleBackToCloseApp(
          snackBar: SnackBar( content: Text('Press back again to exit'),),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    //height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: page[num],
                  )
                ),
              ),
            ],
          ),
        ),
      );
  }
}


