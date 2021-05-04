
//import "Register.dart";
import 'SignIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}