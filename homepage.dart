import 'package:f2/message.dart';
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



final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var user;
var email;
var phone;
var dob;
var gen;
String dev = "///--///";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child:Column(
          children: <Widget>[
            //SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10) ,bottomRight: Radius.circular(10))
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,6,8,5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.bubble_chart),
                        SizedBox(width: 10,),
                        Text('Expey',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context) =>Message()
                            ));
                          },
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }

}

