import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Auth.dart';
import 'Home.dart';

import 'loading.dart';
import 'package:flutter/material.dart';
import 'Register.dart' as Reg;

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

var reg=false;

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [Colors.lightBlue,Colors.indigo])
              color: Colors.teal,
//              image: DecorationImage(
//                image: AssetImage('images/aa2.jpg'),
//                fit: BoxFit.cover,
//              ),
            ),//
            child: DefaultTabController(
              length: 2,
              child: Container(
                //resizeToAvoidBottomInset: true,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      //height: ,
                      child : Column(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.video_library,color: Colors.white,),iconSize: 150,),
                          Image.asset(
                            'images/title1.png',
                          width: 300,
                          //height: 140,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left:50 , right:50, top:00),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        padding: EdgeInsets.all(5),
                        child: new TabBar(
                          labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black45,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                          ),
                          tabs: [
                            new Tab(
                              text: 'Sign in',
                            ),
                            new Tab(
                              text: 'Register',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children : <Widget> [
                          SingleChildScrollView(
                            child: Container(
                            padding: EdgeInsets.fromLTRB(50,0,50,0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.redAccent,
                                        primaryColorDark: Colors.red,
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
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
                                            borderSide: const BorderSide(color: Colors.white,),
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                          ),
                                          labelText: 'Email',
                                          labelStyle: TextStyle(color: Colors.white54)
                                        ),
                                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      obscureText: true,
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
                                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      },
                                    ),
//                                    SizedBox(height: 20.0),
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
                                            if(_formKey.currentState.validate()){
                                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                              if(result == null ) {
                                                setState(() {
                                                    loading=false;
                                                    error = 'Invalid Credential';
                                                  }
                                                );
                                              }
                                              else{
                                                setState(() =>loading=false, );
                                                Navigator.of(context).pop();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Sliderpage()));
                                              }
                                            }
                                            setState(() =>loading=false );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: loading? SpinKitWave(color: Colors.teal, size: 20,):
                                            Text(
                                              "Sign In",
                                              style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                  ],
                                ),
                              ),

                        ),
                          ),
                        Reg.Register()
                        ]
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

