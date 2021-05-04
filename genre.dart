import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'new.dart' as home;
import 'infor.dart';

var _gen;

class Genre extends StatefulWidget {
  Genre(var val) {
    _gen = val;
    print(_gen);
  }
  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  var _gen;

//  _GenreState(var val){
//    _gen=val;
//    print(' $val  ---------------------------------------------------------------------------');
//  }
  @override
  Widget build(BuildContext context) {
    if (!list.isEmpty) list.removeRange(0, list.length - 1);
    aa(context);
    return Container(
      //height: 500,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      child: ListView(children: <Widget>[
//          Container(
////            height: MediaQuery.of(context).size.height*.25,
////            child: ListView(
////              scrollDirection: Axis.horizontal,
////              children: list,
////            ),
////          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 10),
          child: Column(
            children: list,
          ),
        )
      ]),
    );
  }

  List<Widget> list = new List<Widget>();
  List<Widget> list1 = new List<Widget>();

  void aa(context) {
    var currentTime = DateTime.now();
    for (var j in data) {
      if (j.Genre == home.gen) {
        list.add(
          Container(          
            width: MediaQuery.of(context).size.width * 0.98,
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 10,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  height: 200,
                  decoration: new BoxDecoration(
                      color: Colors.white.withOpacity(0),
                      //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.all(
                        const Radius.circular(40.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                j.Moviename,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.047,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                j.Genre,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Rating : 10.0",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    ]),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      builder: (context) {
                        return Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(j.Descrption));
                      });
                },
              ),
            ),
          ),
        );
      }
    }
    list.shuffle();
    //print(list);
  }
}
