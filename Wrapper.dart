
import 'package:firebase_auth/firebase_auth.dart';

import 'User.dart';
import 'Authenticate.dart';
import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
bool u=false;
void getUser()async{
  final FirebaseUser user1 = await _auth.currentUser();
  if(user1==null){
    u=true;
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    getUser();


    // return either the Home or Authenticate widget
    if (user==null){
      return Authenticate();
    }
    else {
      return Sliderpage();
    }

  }
}