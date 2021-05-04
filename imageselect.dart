import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UserInfo.dart' ;
//import 'package:custom_radio/custom_radio.dart';
import 'EditInfo5.dart';
//import 'profile.dart';

var tempImage='images/im/d2.jpg';
var TempSelectedIndex=0;
class ImageSel extends StatefulWidget {
  var radioValue='Image';

  @override
  _ImageSelState createState() => _ImageSelState();
}

class _ImageSelState extends State<ImageSel> {

  void changeIndex(int index,String im){
    setState(() {
      selectedIndex = index;
      tempImage=im;
    });
  }

  Widget customRadio(int index,String im){
    TempSelectedIndex=selectedIndex;
    return GestureDetector(
      onTap:() => changeIndex(index,im),
      child: Container(
        
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(13))
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(im,height: MediaQuery.of(context).size.width*.2 ,width: MediaQuery.of(context).size.width*.2,)
          ),
        )

      ),
    );
  }

  Widget Tabs(String S,int i){
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customRadio(i+0,'images/im/${S}1.jpg'),
              customRadio(i+1,'images/im/${S}2.jpg'),
              customRadio(i+2,'images/im/${S}3.jpg'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customRadio(i+3,'images/im/${S}4.jpg'),
              customRadio(i+4,'images/im/${S}5.jpg'),
              customRadio(i+5,'images/im/${S}6.jpg'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customRadio(i+6,'images/im/${S}7.jpg'),
              customRadio(i+7,'images/im/${S}8.jpg'),
              customRadio(i+8,'images/im/${S}9.jpg'),
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            color: Colors.black,
            textColor: Colors.white,
            onPressed: (){
              setState(() {
                conti=true;
              });
              image=tempImage;
              image12=tempImage;
              selectedIndex=TempSelectedIndex;
              //TempSelectedIndex=0;
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          SizedBox(width: 20,),
          OutlineButton(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 2
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            //color: Colors.black,
            //textColor: Colors.white,
            onPressed: (){
              setState(() {
                conti=true;
              });
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 3,
        child: Container(
          //color: Colors.transparent,
            //height: 00,
          width: MediaQuery.of(context).size.width  ,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,5,10,3),
                  child: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Select Avatar',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('for profile pic'),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ClipOval(
                    child: Image.asset(tempImage,height: 200,width: 200,)
                ),
                SizedBox(height: 10,),
                TabBar(
                  //controller: _tabController,
                  labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                  labelColor: Colors.black,
                  //unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab ,
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
//                    indicator: BoxDecoration(
//                        borderRadius: BorderRadius.circular(30),
//                        color: Colors.transparent
//                    ),
                  tabs: [
                    new Tab(
                      //text: 'Private',
                      //icon: Icon(Icons.home),
                      child: Image.asset('images/male2.png',height: 30,width: 30,),
                    ),
                    new Tab(
                      //text: 'Groups',
                      //icon: Icon(Icons.explore),
                      child: Image.asset('images/female2.png',height: 30,width: 30,),
                    ),
                    new Tab(
                      //text: 'Pinned',
                      icon: Icon(Icons.star,size: 30,),
                      //child: Image.asset('images/male2.png',height: 30,width: 30,),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Tabs('b',0),
                      Tabs('g',10),
                      Tabs('s',20),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
