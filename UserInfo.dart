//import 'dart:html';

import 'package:f2/imageselect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f2/Home.dart';
import 'package:f2/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Register.dart';
import 'Auth.dart';
import "UserDetails.dart";
import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "Loading.dart";
import 'package:f2/Database.dart';
import 'package:f2/Register.dart';
import 'dart:ui' show ImageFilter;

import 'User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "UserDetails.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignIn.dart' as Sign;

bool m=true;
bool f=false;
bool o=false;
int selectedIndex = 0;
bool conti=false;
bool loading1=false;

DateTime currentBackPressTime;
final DBRef=Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
var image='images/im/d2.jpg';

Future<bool> onWillPop() {
  Fluttertoast.showToast(
    msg: 'Please complete this step',
    backgroundColor: Colors.white24
  );
  return Future.value(false);
}

void WriteData( ) async{
  final FirebaseUser user1 = await _auth.currentUser();
  final Val = user1.uid;
  print(Val);
  DBRef.collection("Users").document(Val).setData({
      "Id": Val,
      "User":Username,
      "DOB":DOB,
      "PhoneNumber":PhoneNumber.toString(),
      "Gender":Gender,
      "Email":user1.email,
      "Image":image
  });
  DBRef.collection("Users").document('UsersID').updateData({
      Val:Val
  });
}

var result;

class info extends StatefulWidget {
  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  colors: [Colors.lightBlue,Colors.indigo])
              color: Colors.teal,
//              image: DecorationImage(
//                image: AssetImage('images/aa2.jpg'),
//                fit: BoxFit.cover,
//              ),
            ),
            height: MediaQuery.of(context).size.height,
            //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child:Form(
              key: _formKey,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 00.0, horizontal: 40.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'images/titleReg.png',
                          width: 300,
                          //height: 140,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Image.asset(
                          'images/titleSuc.png',
                          width: 200,
                          //height: 140,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Tell us about yourself..',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              //height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap:() async{
                                      setState(() {

                                      });
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                            child: Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                ),
                                                //backgroundColor: Colors.white.withOpacity(.7),
                                                child: ImageSel()
                                            ),
                                          );
                                        }
                                      );
                                      setState(() {
                                        //f=!f;
                                      });
                                    },
                                    child: ClipOval(child: Image.asset(image,width: 100,height: 100,))
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 24,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.black,),
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                          ),
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                          ),

                                          labelText: 'Username',
                                          labelStyle: TextStyle(color: Colors.black38)
                                      ),
                                      validator: (val) => val.isEmpty ? 'Enter the username' : null ,
                                      onChanged: (val) {
                                        setState(() {
                                          Username = val;
                                          temp=Username;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black,),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black,),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),

                                      labelText: 'DOB : dd/mm/yyyy',
                                      labelStyle: TextStyle(color: Colors.black38)
                                  ),
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return 'Required Field';
                                    }
                                    else if(!RegExp(r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$').hasMatch(value)){
                                      return 'Invalid format';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      DOB=val;
                                      temp4=DOB;
                                    });
                                  }
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(20.0),
                                      ),
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black,),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(20.0),
                                      ),
                                    ),

                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(color: Colors.black38)
                                ),
                                validator: (String value){
                                  if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
                                    return 'Invalid number';
                                  }
                                  else if(value.isEmpty){
                                    return 'Required Field';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    PhoneNumber=val ;
                                    temp1=PhoneNumber;
                                  });
                                }
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Image.asset('images/male2.png',scale: 15,),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: m==true? Colors.black : Colors.transparent,
                                      textColor: m!=true? Colors.black38 : Colors.white,
                                      //padding: EdgeInsets.only(right: 8.0),
                                      onPressed: () {
                                        setState(() {
                                          m=true;
                                          f=false;
                                          o=false;
                                          Gender='Male';
                                        });
                                      },
                                      child:  Column(
                                        children: <Widget>[
                                          //Icon(Icons.),
                                          Text(
                                            'Male',
                                            style: new TextStyle(fontSize: 16.0,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Image.asset('images/female2.png',scale: 15,),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: f==true? Colors.black : Colors.transparent,
                                      textColor: f!=true? Colors.black38 : Colors.white,
                                      //padding: EdgeInsets.only(right: 8.0),
                                      onPressed: () {
                                        setState(() {
                                          f=true;
                                          m=false;
                                          o=false;
                                          Gender='Female';
                                        });
                                      },
                                      child:  Text(
                                        'Female',
                                        style: new TextStyle(fontSize: 16.0,),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Image.asset('images/other2.png',scale: 15,),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: o==true? Colors.black : Colors.transparent,
                                      textColor: o!=true? Colors.black38 : Colors.white,
                                      //padding: EdgeInsets.only(right: 8.0),
                                      onPressed: () {
                                        setState(() {
                                          o=true;
                                          f=false;
                                          m=false;
                                          Gender='Other';
                                        });
                                      },
                                      child:  Text(
                                        'Other',
                                        style: new TextStyle(fontSize: 16.0,),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:14.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: FlatButton(
                                  color: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () async {
                                    AuthService(Username: temp,DOB:temp4,PhoneNumber: temp1,Gender: temp2);
                                    setState(() =>loading1=true, );
                                    if(_formKey.currentState.validate()){
                                      await WriteData();
                                      setState(() =>loading1=false, );
                                      Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sliderpage()));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final String Username;
  final String DOB;
  final String Gender;
  final String PhoneNumber;


  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;


      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //WriteData();
      return _userFromFirebaseUser(user);
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());

      return null;
    }
  }

  AuthService({this.Username,this.DOB,this.PhoneNumber,this.Gender});

}
