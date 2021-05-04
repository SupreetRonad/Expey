import 'package:firebase_auth/firebase_auth.dart';
import 'package:f2/Home.dart';
import 'package:f2/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'UserInfo.dart';
import 'package:email_validator/email_validator.dart';
import "UserDetails.dart";
import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import "Loading.dart";
import 'package:f2/Database.dart';
import 'package:f2/Register.dart';

import 'User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "UserDetails.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignIn.dart' as Sign;


final DBRef=FirebaseDatabase.instance.reference();
bool loading=false;
String value='';
String email = '';
String password = '';
String confirmPassword="";
String temp="";
String Username="";
String DOB="";
int i;
String temp1;
String Gender="Male";
String temp2="";
String temp3="";
String temp4="";
String PhoneNumber;
String gnickname;
var user;
var email1;
var phone;
var dob;
var gen;
var res;


class Register extends StatefulWidget {
  String PassValue=temp;

  final Function toggleView;
  Register({ this.toggleView });

  @override

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return
    SingleChildScrollView(
      child: Container(
        //backgroundColor: Colors.brown[100],
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top : 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white,),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),

                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white70)
                      ),
                      validator: (val) {
                        val.isEmpty ? 'Enter an email' : null ;
                        if(!RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)').hasMatch(val)){
                          return 'Invalid email';
                        }
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white70,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white,),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                        ),

                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70)
                    ),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                        SizedBox(height: 10.0),
                  TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white,),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),

                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.white70)
                      ),
                      obscureText: true,
                      validator: (val) =>val!=password ? 'Password not confirmed ${loading=false}' :null,

                      onChanged: (val) {
                        setState(() => confirmPassword = val);
                      }

                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *.8,
                      height: 50,
                      child: FlatButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {
                          setState(() =>loading=true, );
                          //AuthService(Username: temp,DOB:temp4,PhoneNumber: temp1,Gender: temp2);
                          if(_formKey.currentState.validate()){
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            setState(() =>loading=false, );
                            if(result == null ) {
                              setState(() {
                                loading=false;
                                error = 'User Exists';
                              });
                            }
                            else{
                              setState(() =>loading=false, );
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => info()));
                            }
                          }
                          else{
                            setState(() {
                              loading=false;
                              error = 'Invalid Credential';
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: loading? SpinKitWave(color: Colors.teal, size: 20,):
                          Text(
                            "Register",
                            style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}


final FirebaseAuth _auth = FirebaseAuth.instance;

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


  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      loading=false;
      return _userFromFirebaseUser(user);
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (error) {
      print(error.toString());

      return null;
    }
  }

  AuthService({this.Username,this.DOB,this.PhoneNumber,this.Gender});
}



