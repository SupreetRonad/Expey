import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Private extends StatefulWidget {
  @override
  _PrivateState createState() => _PrivateState();
}

class _PrivateState extends State<Private> {
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
