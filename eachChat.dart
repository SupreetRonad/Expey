import 'package:flutter/material.dart';


class EachChat extends StatefulWidget {
  final msg;
  final fromUid;
  final seen;
  final time;
  final uid;
  EachChat({this.msg,this.fromUid,this.seen,this.time,this.uid});
  @override
  _EachChatState createState() => _EachChatState();
}

class _EachChatState extends State<EachChat> {
  var time=null;
  var arr;
  var time2='am';
  int temp;
  @override
  Widget build(BuildContext context) {
    setState((){
      arr=widget.time.split('/**/');
      if(int.parse(arr[0]) > 12 ){
        temp = int.parse(arr[0]) - 12;
        time=temp.toString();
        if(temp>=12){
          time2='am';
        }
        else
          time2='pm';
      }
      else if(int.parse(arr[0]) < 10){
        time=arr[0][1];
      }
      else{
        time=arr[0];
      }
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: widget.fromUid==widget.uid? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.fromUid==widget.uid? Colors.blueAccent.withOpacity(.6) : Colors.blueAccent.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(12.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 10, maxWidth: MediaQuery.of(context).size.width*.7),
                      child: Text(
                        widget.msg,
                        //textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10000,
                        style: TextStyle(color: Colors.white70,fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    widget.fromUid==widget.uid? Icon(
                      widget.seen ? Icons.done_all : Icons.done,
                      color: widget.seen ? Colors.white : Colors.white54,
                      size: 16,
                    )
                        : SizedBox(width: 0,),
                    SizedBox(width: 5,),
                    Text('$time: ${arr[1]} $time2',style: TextStyle(color: Colors.white38,fontSize: 12),),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
