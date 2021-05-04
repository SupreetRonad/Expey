import 'package:f2/connectrequests.dart';
import 'package:flutter/material.dart';
import 'social.dart' ;
import 'notifcations.dart';

class Alerts extends StatefulWidget {
  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
//    print(social.list);
//    setState(() {
//      social.list.clear();
//    });
    return Container(
      color: Colors.black87,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          FlatButton(
            onPressed: (){
              //list.clear();
              Navigator.push(context,MaterialPageRoute(
                  builder: (context) =>Requests()
              ));
            },
            child: Row(
              children: <Widget>[
                ClipOval(child: Icon(Icons.swap_horiz,size: 70,color: Colors.white,)),
                SizedBox(width: 20,),
                Column(
                  children: <Widget>[
                    Text('Connect requests',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Text('accept or ignore requests',
                      style: TextStyle(fontSize: 14,color: Colors.white54),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios,size: 30,color: Colors.white54,)
              ],
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              SizedBox(width: 20,),
              Text('Notifications',
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
          Expanded(
            child: Container(
              
            ),
          )
        ],
      ),
    );
  }
}
