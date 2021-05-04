import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'socialaccounts.dart';
import 'notifcations.dart';

class Connectedbody extends StatefulWidget {

  @override
  _ConnectedbodyState createState() => _ConnectedbodyState();
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
List<Widget> list3 = new List<Widget>();
var image=null;

class _ConnectedbodyState extends State<Connectedbody> {

  @override
  void ReadData() async {
    final FirebaseUser user1 = await _auth.currentUser();
    final uid = user1.uid;
    list3.clear();

    await DBRef.once().then((DataSnapshot dataSnapShot) {
      user = dataSnapShot.value['Users'][uid]['Info']['User'];
      email = user1.email;
      var Data=dataSnapShot.value['Users'];
      phone = dataSnapShot.value['Users'][uid]['Info']['PhoneNumber'];
      dob = dataSnapShot.value['Users'][uid]['Info']['DOB'];
      gen = dataSnapShot.value['Users'][uid]['Info']['Gender'];
      //image = dataSnapShot.value['Users'][uid]['Info']['Image'];
      dataSnapShot.value['Users'][uid]['Connected'].forEach((key, value) {
        print(value['Id']);
        var id = value['Id'];
        image=dataSnapShot.value['Users'][id]['Info']['Image'];
        //print(value['Connect'][uid]['Type']);
        //if (Data[uid]['Connected']!=null) {
        print('PPPPPPPPPPPPPPPPPPPPPPPMMMMMMMMMMMMMMMMMMMMMMMM');
        //if(Data[uid]['Connected'][id]=null){
        print('PPPPPPPPPPPPPPPPPPPPPPPMMMMMMMMMMMMMMMMMMMMMMMM123412434');
        list3.add(
            SocialAcc(username: Data[id]['Info']['User'], userId: id,image: image,)
        );
        //}
        //}
      });
      list3.add(SizedBox(
        height: 65,
        child: Column(
          children: <Widget>[
            Text('find more connections in \n \t Notifications > Social',style: TextStyle(color: Colors.white38),),
          ],
        ),
      ));

    });
    //list.toSet().toList();
    setState(() {
      empty = false;
    });
    print(list3);
    //list3.shuffle();

  }
  var read=0;
  Widget build(BuildContext context) {
    //list.clear();

    if(read < 2){
      read++;
      ReadData();
    }

    return  Container(
        height: MediaQuery.of(context).size.height,
        //color: Colors.black87,
        child: list3.isEmpty ?
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('No connections', style: TextStyle(color: Colors.white38),),
                Text('Connect in Notifications > Social', style: TextStyle(color: Colors.white38),),
              ],
            )
        )
            :
        SingleChildScrollView(
          child: Column(
              children: list3
          ),
        )
    );
  }
}
