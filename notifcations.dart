import 'package:f2/alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'social.dart';
import 'connected.dart';
import 'connectrequests.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}
//List<Widget> list = new List<Widget>();
class _NotifyState extends State<Notify> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //list.clear();
    list1.clear();
    //list2.clear();
    list3.clear();
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10) ,bottomRight: Radius.circular(10))
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  TabBar(
                    //controller: _tabController,
                    labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab ,
                    //indicatorWeight: 3,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white38
                    ),
                    tabs: [
                      new Tab(
                        text: 'Alerts',
                        //icon: Icon(Icons.home),
                      ),
                      new Tab(
                        text: 'Social',
                        //icon: Icon(Icons.explore),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: <Widget>[
                    Alerts(),
                    Social()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
