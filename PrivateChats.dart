import 'package:f2/eachChat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



List<Widget> chatlist1 = new List<Widget>();
final DBRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
var uid=null;
var uid1=null;
class PrivateChats extends StatefulWidget {
  final uid;
  final uid1;
  PrivateChats({this.uid1,this.uid});

  @override
  _PrivateChatsState createState() => _PrivateChatsState();
}

class _PrivateChatsState extends State<PrivateChats> {

//  Future<void> ReadData(String uid1) async {
//    final FirebaseUser user1 = await _auth.currentUser();
//    final uid = user1.uid;
//    chatlist.clear();
//    var msgId=null;
//    await DBRef.once().then((DataSnapshot dataSnapShot) {
//      if(dataSnapShot.value['Messages']!=null){
//        var root=dataSnapShot.value['Messages'];
//        print(root['${uid}${uid1}']);
//        if(root['${uid}${uid1}']!=null){
//          msgId='${uid}${uid1}';
//        }
//        else if(root['${uid1}${uid}']!=null){
//          msgId='${uid1}${uid}';
//        }
//        var i=0;
//        bool end=true;
//        while(end && msgId!=null){
//          if(root[msgId]['msg$i']!=null){
//            print(root[msgId]['msg$i']['Msg']);
//            if(root[msgId]['msg$i']['Seen']==false){
//              if(root[msgId]['msg$i']['From']==uid1){
//                print('99999999999999999999999999999999 ');
//                //DBRef.child('Users').child('Messages').child(msgId).child('Seen').set(true);
//                DBRef.child('Messages').child(msgId).child('msg$i').set({
//                  'From' : uid1,
//                  'Seen' : true,
//                  'Time' : root[msgId]['msg$i']['Time'],
//                  'Msg' : root[msgId]['msg$i']['Msg']
//                });
//                print('Doneeeeeeeeeeee');
//              }
//            }
//            chatlist.add(
//                EachChat(
//                  msg: root[msgId]['msg$i']['Msg'],
//                  seen: root[msgId]['msg$i']['Seen'],
//                  time: root[msgId]['msg$i']['Time'],
//                  fromUid: root[msgId]['msg$i']['From'],
//                  uid: uid,
//                )
//            );
//          }
//          else{
//            print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
//            end=false;
//          }
//          i++;
//        }
//      }
//    });
//    chatlist1=chatlist;
//    print(chatlist);
//  }

  @override
  Widget build(BuildContext context) {
    uid=widget.uid;
    uid1=widget.uid1;
    //ReadData(widget.uid1);
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          StreamBuilder(
            stream: DBRef.onValue,
            builder: (context, snap) {
              List<Widget> list2 = new List<Widget>();
              if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null && snap.data.snapshot.value['Messages']!=null) {
                var root = snap.data.snapshot.value['Messages'];
                print(snap.data.snapshot.value['Messages']);
                List item = [];
                var msgId=null;
                var dataSnapShot = snap.data.snapshot;
                List<Widget> chatlist = new List<Widget>();

                if(root['${uid}${uid1}']!=null){
                  msgId='${uid}${uid1}';
                }
                else if(root['${uid1}${uid}']!=null){
                  msgId='${uid1}${uid}';
                }

                var i=0;
                bool end=true;
                var k=null;
                var j=null;
                while(end && msgId!=null){


                  root[msgId]['$uid$i']!=null ? k='$uid$i' : k=null;
                  if(k!=null){
                    print(root[msgId][k]['Msg']);
                    if(root[msgId][k]['Seen']==false){
                      if(root[msgId][k]['From']==uid1){
                        print('99999999999999999999999999999999 ');
                        //DBRef.child('Users').child('Messages').child(msgId).child('Seen').set(true);
                        DBRef.child('Messages').child(msgId).child(k).set({
                          'From' : uid1,
                          'Seen' : true,
                          'Time' : root[msgId][k]['Time'],
                          'Msg' : root[msgId][k]['Msg']
                        });
                        print('Doneeeeeeeeeeee');
                      }
                    }
                    chatlist.add(
                        EachChat(
                          msg: root[msgId][k]['Msg'],
                          seen: root[msgId][k]['Seen'],
                          time: root[msgId][k]['Time'],
                          fromUid: root[msgId][k]['From'],
                          uid: uid,
                        )
                    );
                  }


                  root[msgId]['$uid1$i']!=null ? j='$uid1$i' : j=null;
                  if(j!=null){
                    print(root[msgId][j]['Msg']);
                    if(root[msgId][j]['Seen']==false){
                      if(root[msgId][j]['From']==uid1){
                        print('99999999999999999999999999999999 ');
                        //DBRef.child('Users').child('Messages').child(msgId).child('Seen').set(true);
                        DBRef.child('Messages').child(msgId).child(j).set({
                          'From' : uid1,
                          'Seen' : true,
                          'Time' : root[msgId][j]['Time'],
                          'Msg' : root[msgId][j]['Msg']
                        });
                        print('Doneeeeeeeeeeee');
                      }
                    }
                    chatlist.add(
                        EachChat(
                          msg: root[msgId][j]['Msg'],
                          seen: root[msgId][j]['Seen'],
                          time: root[msgId][j]['Time'],
                          fromUid: root[msgId][j]['From'],
                          uid: uid,
                        )
                    );
                  }


                  if(k==null && j==null){
                    print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
                    end=false;
                  }

                  i++;
                }
                chatlist.add(
                    SizedBox(
                      height: 80,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 00,),
                        ],
                      ),
                    )
                );

                return Expanded(
                  child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                          children: chatlist
                      ),
                  ),
                );
              }
              else
                return Expanded(
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Enter the message and click send !",
                            style: TextStyle(color: Colors.white38,),
                          ),
                        ],
                      )
                  ),
                );
            },
          ),
          //SizedBox(height: 80,)
        ],
      )


    );
  }
}
