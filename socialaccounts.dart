import 'package:f2/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui' show ImageFilter;
import 'chatScreen.dart';


final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var confirm=0;

class SocialAcc extends StatefulWidget {
  final username;
  final userId;
  final image;
  SocialAcc({this.username,this.userId,this.image});

  @override
  _SocialAccState createState() {
    return _SocialAccState();
  }
}

void PerformConnect(String Username,String UserId) async {
  final FirebaseUser user1 = await _auth.currentUser();
  final curuid = user1.uid;
  await DBRef.once().then((DataSnapshot dataSnapShot) {
    //AT THE OTHER USER END
    var Data=dataSnapShot.value['Users'];
    if(Data[UserId]['Connect']==null){
      DBRef.child('Users').child(curuid).child('Connect').child(UserId).set({
        "Id":UserId,
        "Type":"SentReq"
      });
      DBRef.child('Users').child(UserId).child('Connect').child(curuid).set({
        "Id":curuid,
        "Type":"RecieveReq"
      });
    }
    if(Data[UserId]['Connect'][curuid]==null){
      DBRef.child('Users').child(curuid).child('Connect').child(UserId).set({
        "Id":UserId,
        "Type":"SentReq"
      });
      DBRef.child('Users').child(UserId).child('Connect').child(curuid).set({
        "Id":curuid,
        "Type":"RecieveReq"
      });
    }
    else if(Data[UserId]['Connect'][curuid]["Type"]=="RecieveReq" ){
      DBRef.child('Users').child(curuid).child('Connect').child(UserId).remove();
      DBRef.child('Users').child(UserId).child('Connect').child(curuid).remove();
    }
    else if(Data[UserId]['Connect'][curuid]["Type"]=="SentReq" ){
      DBRef.child('Users').child(curuid).child('Connect').child(UserId).remove();
      DBRef.child('Users').child(UserId).child('Connect').child(curuid).remove();
    }
  });
}

void Connect(String Username,String UserId) async {
  final FirebaseUser user1 = await _auth.currentUser();
  final curuid = user1.uid;
  await DBRef.once().then((DataSnapshot dataSnapShot) {
    //AT THE OTHER USER END
    var Data=dataSnapShot.value['Users'];
    DBRef.child('Users').child(curuid).child('Connected').child(UserId).set({
      "Id":UserId,
    });
    DBRef.child('Users').child(UserId).child('Connected').child(curuid).set({
      "Id":curuid,
    });
    DBRef.child('Users').child(curuid).child('Connect').child(UserId).remove();
    DBRef.child('Users').child(UserId).child('Connect').child(curuid).remove();
  });
//    setState(() {
//      ff=3;
//    });
}

void Disconnect(String Username,String UserId) async {
  final FirebaseUser user1 = await _auth.currentUser();
  final curuid = user1.uid;
  await DBRef.once().then((DataSnapshot dataSnapShot) {
    //AT THE OTHER USER END
    DBRef.child('Users').child(curuid).child('Connected').child(UserId).remove();
    DBRef.child('Users').child(UserId).child('Connected').child(curuid).remove();
  });
//    setState(() {
//      ff=0;
//    });
}



class _SocialAccState extends State<SocialAcc> {
  int ff=0;
  bool loading=false;
  var email='....';

  void confirmDis(context,name){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor:Colors.white.withOpacity(.7),
              shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(30.0)
              ),
              //this right here
              child: Container(
                color:Colors.white.withOpacity(0.0),
                height: 240,
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding:const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text("Dissconnect from ",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight:FontWeight.normal),),
                            SizedBox(height: 3,),
                            Text(' $name ?',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),),
                          ],
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Text("You will have to request to connect again!",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight:FontWeight.normal),),
                            SizedBox(height: 3,),
                            SizedBox(
                              width: 320.0,
                              child: FlatButton(
                                padding:EdgeInsets.all(8.0),
                                shape:RoundedRectangleBorder(
                                  borderRadius:BorderRadius.circular(15.0),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    loading=true;
                                  });
                                  //Disconnect(widget.username, widget.userId);
                                  //Set(widget.username,widget.userId);
                                  await Future.delayed(const Duration(seconds: 2), (){});
                                  //SnackBar(content: Text('Conneceted with ${widget.username}'),);
                                  setState(() {
                                    ff=0;
                                  });
                                  setState(() {
                                    loading=false;
                                  });

                                },
                                child: Padding(
                                  padding:const EdgeInsets.all(4.0),
                                  child: Text( "Disconnect",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight:FontWeight.bold),),
                                ),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 320.0,
                          child: OutlineButton(
                            borderSide: BorderSide(width: 3.0,color:Colors.black),
                            padding:EdgeInsets.all(8.0),
                            shape:RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding:const EdgeInsets.all(4.0),
                              child: Text("Cancel",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight:FontWeight.bold),
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

  void Set(String Username,String UserId) async{
    final FirebaseUser user1 = await _auth.currentUser();
    final curuid = user1.uid;
    await DBRef.once().then((DataSnapshot dataSnapShot) {
      //AT THE OTHER USER END
      var Data = dataSnapShot.value['Users'];
      setState(() {
        email=Data[UserId]['Info']['Email'] ;
      });
      if(Data[curuid]['Connected']!=null){
        if(Data[curuid]['Connected'][UserId]!=null){
          print('1111111');
          setState(() {
            ff=3;
          });
        }
        else if(Data[UserId]['Connect'][curuid]==null){
          print('2222222');
          setState(() {
            ff=0;
          });
        }
        else if(Data[UserId]['Connect'][curuid]['Type']=='RecieveReq'){
          print('3333333');
          setState(() {
            ff=1;
          });
        }
        else if(Data[UserId]['Connect'][curuid]['Type']=='SentReq'){
          print('44444444');
          setState(() {
            ff=2;
          });
        }
        else{
          print('5555555');
          setState(() {
            ff=5;
          });
        }
      }
      else{
        if(Data[UserId]['Connect'][curuid]==null){
          setState(() {
            ff=0;
          });
        }
        else if(Data[UserId]['Connect'][curuid]['Type']=='RecieveReq'){
          setState(() {
            ff=1;
          });
        }
        else if(Data[UserId]['Connect'][curuid]['Type']=='SentReq'){
          setState(() {
            ff=2;
          });
        }
        else{
          setState(() {
            ff=5;
          });
        }
      }
    });
  }

  Widget showInfo(){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.username,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                Text(email,style: TextStyle(color: Colors.white54,fontSize: 14,fontWeight: FontWeight.normal),),
                SizedBox(width: 10,),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close,color: Colors.white70,size: 30,)
            )
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  widget.image==null? 'images/im/user2.png': widget.image,
                  height: MediaQuery.of(context).size.width*.45 ,width: MediaQuery.of(context).size.width*.45,
                )
            ),
            SizedBox(width: 20,),

          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Set(widget.username,widget.userId);
    //print("$ff -----------------------------------------------------------\n ---------------------------------------------------------------------");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              builder:(context){
                return SingleChildScrollView(
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      color: Colors.teal,
                    ),
                    //padding: EdgeInsets.all(10.0),
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.black87,
                        child: showInfo()
                    ),
                  ),
                );
              }
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              ClipOval(
                child: Image.asset(widget.image == null?'images/im/user2.png' : widget.image,height: 100,width: 100,fit: BoxFit.cover,),
              ),
              SizedBox(width: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.username,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          Text(email,style: TextStyle(color: Colors.white54,fontSize: 14,fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 7,),
                  //Spacer(),
                  if(ff==3)//RECEIVED REQUEST
                    Row(
//                    crossAxisAlignment: CrossAxisAlignment.end,
//                    mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //Spacer(),

                        OutlineButton(
                          borderSide: BorderSide(width: 2,color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: Colors.white,
                          textColor: Colors.white70,
                          onPressed: () async{
                            //confirmDis(context,widget.username);
                          },
                          child: loading? SpinKitFadingCircle(size: 20,color: Colors.white70,)
                              :
                          Row(
                            children: <Widget>[
                              Icon(Icons.check_circle_outline,size: 20),
                              SizedBox(width: 3,),
                              Text('Connected'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(uid: widget.userId))
                            );

                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.chat_bubble_outline,size: 20,),
                              SizedBox(width: 3,),
                              Text('Chat'),
                            ],
                          ),
                        )
                      ],
                    )
                  else if(ff==2)//RECEIVED REQUEST
                    Row(
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () async{
                            setState(() {
                              loading=true;
                            });
                            //Connect(widget.username, widget.userId);
                            //Set(widget.username,widget.userId);
                            await Future.delayed(const Duration(seconds: 2), (){});
                            SnackBar(content: Text('Conneceted with ${widget.username}'),);
                            setState(() {
                              ff=3;
                            });
                            setState(() {
                              loading=false;
                            });
                          },
                          child: loading? SpinKitFadingCircle(size: 20,color: Colors.black,) :
                          Row(
                            children: <Widget>[
                              Icon(Icons.check,size: 20),
                              SizedBox(width: 2,),
                              Text('Accept'),
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          borderSide: BorderSide(width: 2.0, color: Colors.white),
                          color: Colors.white,
                          textColor: Colors.white,
                          onPressed: () async{
                            setState(() {
                              loading=true;
                            });
                            //PerformConnect(widget.username, widget.userId);
                            //Set(widget.username,widget.userId);
                            await Future.delayed(const Duration(seconds: 1), (){});
                            setState(() {
                              ff=0;
                            });
                            setState(() {
                              loading=false;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.clear,size: 20,),
                              SizedBox(width: 2,),
                              Text('Ignore'),
                            ],
                          ),
                        )
                      ],
                    )
                  else if(ff==1)//SEND OR SENT REQUEST
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      color: Colors.white54,
                      textColor: Colors.black,
                      onPressed: () async{
                        setState(() {
                          loading=true;
                        });
                        //PerformConnect(widget.username, widget.userId);
                        //Set(widget.username,widget.userId);
                        await Future.delayed(const Duration(seconds: 1), (){});
                        setState(() {
                          ff=0;
                        });
                        setState(() {
                          loading=false;
                        });
                      },
                      child: loading? SpinKitFadingCircle(size: 20,color: Colors.black,) :
                      Row(
                        children: <Widget>[
                          Icon(Icons.alarm_on,size: 20,),
                          SizedBox(width: 2,),
                          Text('Requested'),
                        ],
                      ),
                    )
                  else if(ff==0)//SEND OR SENT REQUEST
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () async{
                          setState(() {
                            loading=true;
                          });
                          PerformConnect(widget.username, widget.userId);
                          //Set(widget.username,widget.userId);
                          setState(() {
                            ff=1;
                          });
                          await Future.delayed(const Duration(seconds: 1), (){});
                          setState(() {
                            loading=false;
                          });
                        },
                        child: loading? SpinKitFadingCircle(size: 20,color: Colors.black,) :
                        Row(
                          children: <Widget>[
                            Icon(Icons.swap_horiz,color: Colors.black,),
                            SizedBox(width: 2,),
                            Text('Connect'),
                          ],
                        ),
                      )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
