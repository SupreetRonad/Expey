import 'package:flutter/material.dart';
import 'slidersheet.dart';
import 'infor.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:random_color/random_color.dart';

var flag = 0;
class Upcoming extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    aa(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
//        height: MediaQuery.of(context).size.height,
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage('assets/redbg.jpg'),
//            fit: BoxFit.fill,
//          ),
//        ),
        child: Container(
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage('assets/redbg.jpg'),
//              fit: BoxFit.fill,
//            ),
//          ),
          //buttons
          //SUPREET
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: list

                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
  List<Widget> list = new List<Widget>();
  void aa(context){
    var currentTime = DateTime.now();
    RandomColor _randomColor = RandomColor();

    for(var j in data ) {
      print(j.Moviename);
      var startTime = j.Releasedate;
      if(flag == 0){
        Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
        if (currentTime.isBefore(startTime)) {
          list.add(
            Container(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.height * .7,
                  decoration: new BoxDecoration(
                      color: _color,
                      //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.all(
                        const Radius.circular(30.0),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          j.image,
                          width: 130.0,
                          height: 180.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              j.Moviename,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              j.Genre,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                      )
                    ]),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(j.Descrption),

                        );
                      });
                },
              ),
            ),
          );
        }
      }

    }
    flag = 1;
    print(list);
  }

}

