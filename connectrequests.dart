import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'socialaccounts.dart';
import 'notifcations.dart';

class Requests extends StatefulWidget {

  @override
  _RequestsState createState() => _RequestsState();
}

final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var user;
var email;
var phone;
var dob;
var gen;
bool empty = true;
bool connect = false;
List<Widget> list1 = new List<Widget>();
var image=null;

class _RequestsState extends State<Requests> {
  @override
  void ReadData() async {
    final FirebaseUser user1 = await _auth.currentUser();
    final uid = user1.uid;
    list1.clear();
    await DBRef.once().then((DataSnapshot dataSnapShot) {
      user = dataSnapShot.value['Users'][uid]['Info']['User'];
      email = user1.email;
      phone = dataSnapShot.value['Users'][uid]['Info']['PhoneNumber'];
      dob = dataSnapShot.value['Users'][uid]['Info']['DOB'];
      gen = dataSnapShot.value['Users'][uid]['Info']['Gender'];
      //image=dataSnapShot.value['Users'][uid]['Info']['Image'];
      dataSnapShot.value['Users'][uid]['Connect'].forEach((key, value) {
        print(value['Id']);
        var id=value['Id'];
        image=dataSnapShot.value['Users'][id]['Info']['Image'];
        //print(value['Connect'][uid]['Type']);
        if(value['Type']=='RecieveReq' ){
          list1.add(
              SocialAcc(username: dataSnapShot.value['Users'][id]['Info']['User'],userId: value['Id'],image: image,)
//              value['Connected'][uid]['id']==uid?
//              SizedBox(height: 0,)
//                  :
//                  SocialAcc(username: value['Info']['User'],userId: value['Info']['Id'],)
          );
        }

      });


    });
    //list.toSet().toList();
    //list1.shuffle();

    setState(() {
      empty=false;
    });
    print(list1);

  }

  Widget build(BuildContext context) {
    //list.clear();
    ReadData();

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
              onPressed: () => Navigator.of(context).pop()
            ),
            SizedBox(width: 10,),
            Text('Connect Requests',style: TextStyle(color: Colors.white),),
          ],
        ),
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
        ),
      ),
      body: Container(
        color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          child: list1.isEmpty?
          Container(
            color: Colors.transparent,
            child: Center(child: Text('No requests',style: TextStyle(color: Colors.white38),)),
          )
              :
          SingleChildScrollView(
            child:Container(
              child: Column(
                children:list1
              ),
            )
          )
      ),
    );
  }
}
