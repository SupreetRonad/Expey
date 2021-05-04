import 'package:f2/Home.dart';
import 'package:f2/PrivateChats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:ui' show ImageFilter;

class ChatScreen extends StatefulWidget {
  final uid;
  ChatScreen({this.uid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
var uid;

final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var user;
var email;
var phone;
var dob;
var gen;
var image1;
var verified;
var user1;
var email1;
var phone1;
var dob1;
var gen1;
var image11='images/im/user2.png';
var verified1;
bool type=false;

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = new TextEditingController();
  var c=0;

  void Send(String msg)async{
    final FirebaseUser User = await _auth.currentUser();
    var uid = User.uid;
    var uid1=widget.uid;

    await DBRef.once().then((DataSnapshot dataSnapShot) {
      var i=0;
      var msgId=null;
      DateTime now = DateTime.now();
      var div='///--///';
      var div1='/**/';
      String formattedDate = DateFormat('kk${div1}mm${div1}ss${div1}d${div1}MMM${div1}y').format(now);
      if(dataSnapShot.value['Messages']==null){
        print('Nope');
        DBRef.child('Messages').child('${uid}${uid1}').child("$uid${i}").set({
          'From': uid,
          'Msg': msg,
          'Seen': false,
          'Time':formattedDate
        });
      }
      else{
        print('Done1');
        if(dataSnapShot.value['Messages']['${uid1}${uid}']!=null){
          msgId= '${uid1}${uid}';
        }
        else{
          msgId= '${uid}${uid1}';
        }
        //print(dataSnapShot.value['Messages'][msgId][0]);
        var k=null;
        bool end=true;
        if(dataSnapShot.value['Messages'][msgId]!=null){

          var root=dataSnapShot.value['Messages'];
          while(end && msgId!=null){

            if(root[msgId]['$uid$i']!=null){
              i++;
            }
            else if(root[msgId]['$uid1$i']!=null){
              i++;
            }
            else{
              end=false;
            }

          }
        }

        DBRef.child('Messages').child(msgId).child("$uid${i}").set({
          'From': uid,
          'Msg': msg,
          'Seen': false,
          'Time':formattedDate
        });
        print('Done3');
      }
    });

  }

  Future <void> ReadData1(String uid1) async {
    final FirebaseUser User = await _auth.currentUser();
    uid = User.uid;
    var msgTemp=null;
    print('asdasd1234');
    if(message.text.trim() != ''){
      print('VVVVVVV');
      msgTemp=message.text.trim();
      if(msgTemp!=msg){
        await ReadData(widget.uid);
        msgTemp=msg;
        print(msgTemp);
      }
    }
    setState(() {

    });
  }

  Future <void> ReadData(String uid1) async {
    final FirebaseUser User = await _auth.currentUser();
    uid = User.uid;
    await DBRef.once().then((DataSnapshot dataSnapShot) {
      var data=dataSnapShot.value;
      verified=dataSnapShot.value['Users'][uid]['Verified'];
      user = dataSnapShot.value['Users'][uid]['Info']['User'];
      email = User.email;
      phone = dataSnapShot.value['Users'][uid]['Info']['PhoneNumber'];
      dob = dataSnapShot.value['Users'][uid]['Info']['DOB'];
      gen = dataSnapShot.value['Users'][uid]['Info']['Gender'];
      image1= dataSnapShot.value['Users'][uid]['Info']['Image'];

      verified1=dataSnapShot.value['Users'][uid1]['Verified'];
      user1 = dataSnapShot.value['Users'][uid1]['Info']['User'];
      email1 = dataSnapShot.value['Users'][uid1]['Info']['Email'];
      phone1 = dataSnapShot.value['Users'][uid1]['Info']['PhoneNumber'];
      dob1 = dataSnapShot.value['Users'][uid1]['Info']['DOB'];
      gen1 = dataSnapShot.value['Users'][uid1]['Info']['Gender'];
      image11= dataSnapShot.value['Users'][uid1]['Info']['Image'];


      var k=null;
      bool t=false;



      if(data['Messages']['${uid1}${uid}']!=null) {
        k = '${uid1}${uid}';
      }
      else{
        k = '${uid}${uid1}';
      }

      if(c==0){
        message.text.trim() != '' ? t=true: t=false;
        DBRef.child('Messages').child(k).child('Status').child(uid).set({
          'Type':t,
          'Inchat':true
        });
        c++;
      }

      if(c!=3){if(ss){
        message.text.trim() != '' ? t=true: t=false;
        DBRef.child('Messages').child(k).child('Status').child(uid).set({
          'Type':t,
          'Inchat':true
        });
      }
      else if(c==2){
        DBRef.child('Messages').child(k).child('Status').child(uid).set({
          'Type':false,
          'Inchat': false
        });
      }}

      if(c==3){
        print('EXITTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
        DBRef.child('Messages').child(k).child('Status').child(uid).set({
          'Type':false,
          'Inchat': false
        });
      }
    });
    print('$user1 $gen1');
    setState(() {

    });
  }

  var ss=false;
  var i=true;
  var msg=null;

  Future<bool> onWillPop() {
    c=3;
    //ReadData(widget.uid);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    ReadData(widget.uid);
    while(i){
      //ReadData(widget.uid);
      //check();
      i=false;
    }
    FocusNode myFocusNode;
    print(ss);
    @override
    void initState() {
      super.initState();

      myFocusNode = FocusNode();
    }
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(3,0,3,0),
        child: Card(
          color: Colors.blueGrey[900].withOpacity(.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          elevation: 0,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Focus(

                    onFocusChange: (hasFocus) {
                      setState(() {
                        if(hasFocus) {
                          ss=true;
                        }
                        if(!hasFocus){
                          ss=false;
                          c=2;
                        }
                        ReadData(widget.uid);
                      });
                    },
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: message,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white10,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                          ),
                          //border: InputBorder.none,
                          hintText: 'Enter message...',
                        hintStyle: TextStyle(color: Colors.white38)
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                    ),
                  )
              ),
              //SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                child: IconButton(
                  onPressed: () async{
//                    FocusScopeNode currentFocus = FocusScope.of(context);
//                    if (!currentFocus.hasPrimaryFocus) {
//                      currentFocus.unfocus();
//                    }
                    if(message.text.trim()==''){
                      Fluttertoast.showToast(
                          msg: 'No message entered',
                          backgroundColor: Colors.white24
                      );
                    }
                    else {
                      await Send(message.text.trim());
                    }
                    message.clear();
                  },
                  icon: Icon(Icons.send,color: Colors.blue,size: 27,),
                ),
              )
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          color: Colors.black87,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0,30,0,10),
                color: Colors.white10,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white70,size: 30,),
                      onPressed: (){
                        c=2;
                        ReadData(widget.uid);
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 15,),
                    ClipOval(
                      child: Image.asset(image11,width: 38,height: 38,fit: BoxFit.fill,),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$user1',style: TextStyle(fontSize: 17,color: Colors.white),),
                        SizedBox(height: 5,),
                        //Text(email1,style: TextStyle(fontSize: 12,color: Colors.white54),),
                        StreamBuilder(
                          stream: DBRef.onValue,
                          builder: (context, snap) {
                            //print('XXXXXXXXXXXXXXXXXXXXXXXXXXXX');
                            ReadData(widget.uid);
                            var status=null;
                            List<Widget> list2 = new List<Widget>();
                            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null && snap.data.snapshot.value['Messages']!=null) {
                              var root = snap.data.snapshot.value['Messages'];
                              print(snap.data.snapshot.value['Messages']);
                              var msgId=null;
                              var dataSnapShot = snap.data.snapshot;
                              List<Widget> chatlist = new List<Widget>();

                              if(root['${uid}${uid1}']!=null){
                                msgId='${uid}${uid1}';
                              }
                              else if(root['${uid1}${uid}']!=null){
                                msgId='${uid1}${uid}';
                              }
                              var status1=null;
                              if(msgId!=null){
                                if(root[msgId]['Status']!=null){
                                  if(root[msgId]['Status'][uid1]!=null){
                                    status1=root[msgId]['Status'][uid1]['Inchat']==true? '  Inchat' : null;
                                    status=root[msgId]['Status'][uid1]['Type']==true? '  typing...' : status1;

                                  }
                                }
                              }

                              return status == null? SizedBox() :
                              Row(
                                children: [
                                  status=='  Inchat' ? SpinKitDoubleBounce(color: Colors.green,size: 15,): SizedBox(),
                                  Text(status,style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                ],
                              );
                            }
                            else
                              return SizedBox();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: PrivateChats(uid:uid,uid1: widget.uid)

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
