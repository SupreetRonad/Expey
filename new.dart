
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'infor.dart';
import 'genre.dart';
import 'package:random_color/random_color.dart';
import 'package:swipedetector/swipedetector.dart';

class New extends StatefulWidget {

  @override
  _NewState createState() => _NewState();
}

final navi = [Genre('All'),Genre('action'),Genre('comedy'),Genre('drama'),Genre('romance')];
var navi1=0;
var All=true;
var action = false;
var comdey = false;
var drama =false;
var romance = false;
var gen;

class _NewState extends State<New> {

  var flg=0;
  @override
  Widget build(BuildContext context) {
//    RandomColor _randomColor = RandomColor();
//    Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
    return Container(
      child: navi1!=0 ? Genre('hii') : Container(
      color: Colors.teal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(10)),
      ),
      height: MediaQuery.of(context).size.height * .83976,
      child: Padding(
        padding: const EdgeInsets.only(top:00),
        child: ListView(
            //scrollDirection: Axis.horizontal,
            children:<Widget>[ Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  for (var j in data)
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: InkWell(
                        child: Expanded(
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.95,
                            decoration: new BoxDecoration(
                                color: Colors.teal,
                                //new Color.fromRGBO(255, 0, 0, 0.0),
                                borderRadius: new BorderRadius.all(
                                  const Radius.circular(40.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset(
                                    'images/aa1.jpg',
                                    width: 130.0,
                                    height: 180.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        j.Moviename,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width*0.047,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(
                                        j.Genre,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width*0.035,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${j.Slidervalue.toString()} / 5',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                                )
                              ]),
                            ),
                          ),
                        ),
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          builder:(context)
                          {
                            return SingleChildScrollView(
                              child: Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(16.0),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Spacer(),
                                        Text(
                                          " Close",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black.withOpacity(0.4)),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'images/aa1.jpg',
                                            width: MediaQuery.of(context).size.width * 0.4 ,
                                            height: MediaQuery.of(context).size.width * 0.5,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                          children : <Widget> [
                                            Container(
                                              width: MediaQuery.of(context).size.width * .55,
                                              child:
                                              Column (
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('${j.Moviename} ',style: TextStyle(fontSize: 20.0),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Text('${j.Genre} ',style: TextStyle(fontSize: 20.0),),
                                                ),
                                              ]
                                              ),
                                            ),
                                        ]),
                                      ]
                                    ),
                                    Text('Cast:${j.Cast} ',style: TextStyle(fontSize: 20.0),),
                                    SizedBox(height: 10.0,),
                                    Text('Description:${j.Descrption} ',style: TextStyle(fontSize: 20.0),),
                                  ],
                                ),

                              ),
                            );
                          }
                          );
                        },
                      ),
                    )
                ],

              ),
          ),]
        ),
      ),

        ),
    );
  }
}
