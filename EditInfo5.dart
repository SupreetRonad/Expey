import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'imageselect.dart';
import 'profile.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final DBRef = Firestore.instance;
String email = '';
String PhoneNumber = '';
String confirmPassword = "";
String _gen = "";
String Username = "";
String DOB = "";
String id='';

void WriteData() async {
  final FirebaseUser user1 = await _auth.currentUser();
  final Val = user1.uid;
  print(Val);
  await DBRef.collection("Users").document(Val).updateData({
    'Info':{
      "Id":Val,
      "User": Username,
      "DOB": DOB,
      "PhoneNumber": PhoneNumber.toString(),
      "Gender": _gen,
      "Email":user1.email,
      "Image":image12
    }
  });
}

bool m;
bool f;
bool o;
var image12=null;

class Edit extends StatefulWidget {
  final String user;
  final String email;
  final String phone;
  final String dob;
  final String gen;
  final String image;
  Edit({this.user,this.email,this.phone,this.dob,this.gen,this.image});
  @override
  _EditState createState() {
    image12=image;
    Username=user;
    if (gen.toUpperCase() == 'MALE') {
      m = true;
      f = false;
      o = false;
      _gen = 'MALE';
    }
    if (gen.toUpperCase() == 'FEMALE') {
      f = true;
      m = false;
      o = false;
      _gen = 'FEMALE';
    }
    if (gen.toUpperCase() == 'OTHER' || gen.toUpperCase() == 'OTHERS') {
      o = true;
      f = false;
      m = false;
      _gen = 'OTHERS';
    }
    return _EditState();
  }
}

class _EditState extends State<Edit> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.white60,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)), //this right here
        child: SingleChildScrollView(
          child: Container(
            //height: 550,
            padding: EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Edit info",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      //height: 100,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5,5,5,0),
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
                                            backgroundColor: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              //backgroundColor: Colors.white.withOpacity(.7),
                                              child: Container(height: MediaQuery.of(context).size.height* .8,child: ImageSel())
                                          ),
                                        );
                                      }
                                  );
                                  setState(() {
                                    //f=!f;
                                  });
                                },
                                child: ClipOval(child: Image.asset(image12 == null? 'images/im/user2.png' : image12,width: 80,height: 80,))
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
                                initialValue: Username,
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
                                    Username= val;
                                    //temp=Username;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: 320,
                      child: TextFormField(
                        initialValue: widget.dob,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'DOB : DD / MM / YYYY',
                          labelStyle: TextStyle(color: Colors.black45)
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Required Field';
                          } else if (!RegExp(
                                  r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$')
                              .hasMatch(value)) {
                            return 'Invalid format';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          DOB = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: 320,
                      child: TextFormField(
                        initialValue: widget.phone,
                        //keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'phone number',
                            labelStyle: TextStyle(color: Colors.black45)
                        ),
                        validator: (String value) {
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Invalid number';
                          } else if (value.isEmpty) {
                            return 'Required Field';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          PhoneNumber = value;
                        },
                      ),
                    ),
                    SizedBox(height:10),
                    new Row(
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
                                  _gen='Male';
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
                                  _gen='Female';
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
                                  _gen='Other';
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
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 4, bottom: 4),
                      child: Text(
                        "Email and password will be allowed to modify in later updates",
                        style: TextStyle(fontSize: 12, color: Colors.black45),
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
                            if (!_formkey.currentState.validate()) {
                              return;
                            }
                            _formkey.currentState.save();
                            _confirm(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Save",
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
                          borderSide: BorderSide(width: 2.0, color: Colors.black),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
                              WriteData();
                              setState(() {});
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
