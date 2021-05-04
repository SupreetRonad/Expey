import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 200,
      child: ListView(
        children: <Widget>[
          for(var i=0;i<20;i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.white54,
              ),
            )
        ],
      ),
    );
  }
}
